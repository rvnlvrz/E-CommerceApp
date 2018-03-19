using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_CommerceApp
{
    public partial class ProductListControl : System.Web.UI.UserControl
    {
        #region Global Variables
        private readonly UserCart _cart = UserCart.Instance;
        private int _userCartId = -1;
        private int _tempId = -1;
        private string _currUser = "-";
        private string _referenceKey = string.Empty;
        private int _itemQuant = 0;
        private string _itemSKU = string.Empty;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currUser"] != null)
            {
                _currUser = (string)(Session["currUser"]);
                _tempId = DBOps.GetLatestEntry(DBOps.GetUserID(_currUser));

                if (_tempId == 0)
                {
                    if (DBOps.GetLatestEntry() < 1)
                    {
                        _userCartId = DBOps.GetLatestEntry() + 2;
                    }
                    else if (DBOps.GetLatestEntry() > 0)
                    {
                        _userCartId = DBOps.GetLatestEntry() + 1;
                    }
                }
                else
                {
                    _userCartId = _tempId;
                }
            }
            else
            {
                if (DBOps.GetLatestEntry() > 0)
                {
                    _userCartId = DBOps.GetLatestEntry() + 1;
                }
                else
                {
                    _userCartId = DBOps.GetLatestEntry() + 2;
                }
            }


            if (Session["prevID"] == null)
            {
                Session["prevID"] = _userCartId;
            }
            else
            {
                _userCartId = Convert.ToInt32(Session["prevID"]);
            }

            _cart.cartID = _userCartId;


            Random rand = new Random();
            _referenceKey = rand.Next(99999999).ToString() + _userCartId;

            if (Session["refkey"] == null)
            {
                Session["refkey"] = _referenceKey;
            }
            else
            {
                _referenceKey = (string)Session["refkey"];
            }
        }

        #region Data Source methods
        protected void ProductList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (((_currUser != "-") && (_tempId != 0)))
            {
                _cart.cartID = _userCartId;
                _cart.cartOwner = _currUser;
                string[] items = DBOps.GetCartItems(_userCartId);
                _cart.lastInsertedItem = items[0];
                _cart.lastInsertedPrice = items[1];
                _cart.lastInsertedQuant = items[2];
                _cart.totalItemQuantity = (Convert.ToInt32(items[3]));
                _cart.totalCartPrice = (Convert.ToDecimal(items[4]));
            }
            else if (((_currUser != "-") && (_tempId == 0)))
            {
                _cart.cartID = _userCartId;
                userInfoDataSource.Update();
            }
            else
            {
                _cart.cartID = _userCartId;
            }

            string[] productDetails = ((String)e.CommandArgument).Split(',');
            _cart.AddItem(productDetails[0].Trim(), Convert.ToDecimal(productDetails[1].Trim()), 1);

            _itemSKU = productDetails[0].Trim();

            bool CanBeAdded = _cart.ItemCanBeAdded(_itemSKU, 1, _userCartId);
            int productQuant = DBOps.GetProductQuantity(_itemSKU);

            if (!DBOps.RecordExists(_userCartId))
            {
                if (CanBeAdded)
                {
                    CartDataSource.Insert();
                    _itemQuant = productQuant - 1;
                    ProductsDataSource.Update();
                }
            }
            else
            {
                if (CanBeAdded && productQuant > 0)
                {
                    _itemQuant = productQuant - 1;
                    CartDataSource.Update();
                    ProductsDataSource.Update();
                }
                else if (productQuant == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "notif",
                       "alert('ITEM NOT ADDED. This product is currently out of stock. Try again later.')", true);
                }
                else if (!CanBeAdded)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "notif",
                        string.Format("alert('ITEM NOT ADDED. You either have the maximum number of it in your cart or adding the specified amount of {0} will exceed the limit of 99.')",
                        1), true);
                }
            }

            SiteMaster master = Page.Master as SiteMaster;
            master.UpdateTotalCounters();

        }

        protected void CartDataSource_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@original_Id"].Value = _userCartId;
            e.Command.Parameters["@customer"].Value = _currUser;
            e.Command.Parameters["@items"].Value = _cart.lastInsertedItem;
            e.Command.Parameters["@prices"].Value = _cart.lastInsertedPrice;
            e.Command.Parameters["@quants"].Value = _cart.lastInsertedQuant;
            e.Command.Parameters["@totalCount"].Value = _cart.totalItemQuantity;
            e.Command.Parameters["@totalPrice"].Value = _cart.totalCartPrice;
            SiteMaster master = Page.Master as SiteMaster;
            master.UpdateTotalCounters();
        }

        protected void CartDataSource_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@customer"].Value = _currUser;
            e.Command.Parameters["@items"].Value = _cart.lastInsertedItem;
            e.Command.Parameters["@prices"].Value = _cart.lastInsertedPrice;
            e.Command.Parameters["@quants"].Value = _cart.lastInsertedQuant;
            e.Command.Parameters["@totalCount"].Value = _cart.totalItemQuantity;
            e.Command.Parameters["@totalPrice"].Value = _cart.totalCartPrice;
            e.Command.Parameters["@reference_key"].Value = _referenceKey;
            SiteMaster master = Page.Master as SiteMaster;
            master.UpdateTotalCounters();
        }

        protected void CartDataSource_Deleting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@original_Id"].Value = DBOps.GetLatestEntry();
        }

        protected void userInfoDataSource_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@Id"].Value = DBOps.GetUserID(_currUser);
            e.Command.Parameters["@latest_cart_id"].Value = _userCartId;
        }

        protected void ProductsDataSource_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@sku"].Value = _itemSKU;
            e.Command.Parameters["@qty"].Value = _itemQuant;
        }
    }
    #endregion
}