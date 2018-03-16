using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;

namespace E_CommerceApp
{
    public partial class Home : System.Web.UI.Page
    {
        #region Global Variables
        private readonly UserCart _cart = UserCart.Instance;
        private int _userCartId = -1;
        private int _tempId = -1;
        private string _currUser = "-";
        private string _referenceKey = string.Empty;
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

        // Handles image src logic
        protected string RenderImage(object imgUrl)
        {
            string path = imgUrl as string;

            // Get all png and jpg files in current dir only
            var images = Directory.GetFiles(Server.MapPath(path) ?? throw new InvalidOperationException(), "*", SearchOption.TopDirectoryOnly)
                .Where(file => file.EndsWith(".png") || file.EndsWith(".jpg") || file.EndsWith(".jpeg"));

            // Resolve physical paths to server-relative paths
            List<string> files = images.Select(img => path + "/" + Path.GetFileName(img)).ToList();
            return files[0];
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
            _cart.AddItem(productDetails[0].Trim(), Convert.ToDecimal(productDetails[1].Trim()), 3);
            if (!DBOps.RecordExists(_userCartId))
            {
                CartDataSource.Insert();
            }
            else
            {
                CartDataSource.Update();
            }

            Label lbl = (Label)Master?.FindControl("MainLabel");
            if (lbl != null) lbl.Text = 3.ToString();
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
    }
    #endregion
}
