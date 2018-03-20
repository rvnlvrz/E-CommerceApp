using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace E_CommerceApp
{
    public partial class ProductDetails1 : Page
    {
        private DataView _results;
        private DataRow _result;

        #region Global Variables
        private readonly UserCart _cart = UserCart.Instance;
        private int _userCartId = -1;
        private int _tempId = -1;
        private string _currUser = "-";
        private string _referenceKey = string.Empty;
        private int _itemQuant;
        private string _itemSku = string.Empty;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.Count == 0)
                Response.Redirect("Default.aspx");

            _results = Products.Select(DataSourceSelectArguments.Empty) as DataView;
            _result = _results?[0].Row;

            CreateDetails();
            CreateCarousel();

            #region Cart ID Logic
            if (Session["currUser"] != null)
            {
                _currUser = (string)Session["currUser"];
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
            #endregion
        }

        protected bool IsAvailable()
        {
            int count = int.Parse(_result["qty"].ToString());

            if (count == 0) return false;
            return true;
        }

        #region Product Details Logic
        private void CreateDetails()
        {
            // Set basic page details
            Page.Title = _result["name"].ToString();
            lblTitle.Text = _result["name"].ToString();
            Description.InnerText = _result["description"].ToString();
            SKU.InnerText = _result["sku"].ToString();
            Price.InnerText = $"{_result["price"]:C}";

            // Determine availability status (Shows actual count when stock <= 10)
            string status;
            int n = 0;
            string qty = _results?[0]["qty"].ToString();

            if (qty != null)
                n = int.Parse(qty);

            if (n == 0)
                status = "Not Available";
            else if (n <= 10)
                status = $"Only {n} in Stock";
            else
                status = "Available";

            Availability.InnerText = status;
        }

        private void CreateCarousel()
        {
            // Get product images directory from database table
            string path = _result["img_url"].ToString();

            // Get all png and jpg files in current dir only
            var images = Directory.GetFiles(Server.MapPath(path), "*", SearchOption.TopDirectoryOnly)
                 .Where(file => file.EndsWith(".png") || file.EndsWith(".jpg") || file.EndsWith(".jpeg"));

            // Resolve physical paths to server-relative paths
            List<string> files = images.Select(img => path + "/" + Path.GetFileName(img)).ToList();

            // Generate carousel elements
            for (int i = 0; i < files.Count; i++)
            {
                var div = new HtmlGenericControl("div");
                var img = new Image { ImageUrl = files.ElementAt(i), CssClass = "d-block" };
                div.Attributes["class"] = i == 0 ? "carousel-item active" : "carousel-item";
                div.Controls.Add(img);
                InnerCarousel.Controls.Add(div);
            }

            // Generate thumbnail elements
            for (int i = 0; i < files.Count; i++)
            {
                var div = new HtmlGenericControl("div");
                div.Attributes["class"] = i == 0 ? "carousel-item active" : "carousel-item";

                for (int j = 0; j < 4 && i < files.Count; j++)
                {
                    var innerDiv = new HtmlGenericControl("div");
                    innerDiv.Attributes["data-target"] = "#carousel";
                    innerDiv.Attributes["data-slide-to"] = i.ToString();
                    innerDiv.Attributes["class"] = "thumb";

                    var img = new Image
                    {
                        ImageUrl = files.ElementAt(i)
                    };

                    innerDiv.Controls.Add(img);
                    div.Controls.Add(innerDiv);
                    i++;
                }

                SmallCarousel.Controls.Add(div);
            }
        }
        #endregion

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (_currUser != "-" && _tempId != 0)
            {
                _cart.cartID = _userCartId;
                _cart.cartOwner = _currUser;
                string[] items = DBOps.GetCartItems(_userCartId);
                _cart.lastInsertedItem = items[0];
                _cart.lastInsertedPrice = items[1];
                _cart.lastInsertedQuant = items[2];
                _cart.totalItemQuantity = Convert.ToInt32(items[3]);
                _cart.totalCartPrice = Convert.ToDecimal(items[4]);
            }
            else if (_currUser != "-" && _tempId == 0)
            {
                _cart.cartID = _userCartId;
                userInfoDataSource.Update();
            }
            else
            {
                _cart.cartID = _userCartId;
            }

            _itemSku = _result?["sku"].ToString();
            int productQuant = DBOps.GetProductQuantity(_itemSku);

            if(Session[_itemSku] == null)
            {
                Session[_itemSku] = productQuant;
            }

            int t_itemStock = DBOps.GetProductQuantity(_itemSku);
            int t_cartQuantity = Convert.ToInt32(tbxQty.Text);
            bool proceed = t_itemStock >= t_cartQuantity;

            _cart.AddItem(_result?["sku"].ToString(), Convert.ToDecimal($"{_result?["price"]}"), Convert.ToInt32(tbxQty.Text));
            if (!DBOps.RecordExists(_userCartId))
            {
                if (proceed)
                {
                    CartDataSource.Insert();
                    _itemQuant = productQuant - Convert.ToInt32(tbxQty.Text);
                    Products.Update();
                }
                else if (productQuant == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "notif",
                       "alert('ITEM NOT ADDED. This product is currently out of stock. Try again later.')", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "notif",
                        $"alert('ITEM NOT ADDED. You either have the maximum number of it in your cart or adding the specified amount of {tbxQty.Text} will exceed the limit of 99.')", true);
                }
            }
            else
            {
                if (proceed)
                {
                    CartDataSource.Update();
                    _itemQuant = productQuant - Convert.ToInt32(tbxQty.Text);
                    Products.Update();
                }
                else if (productQuant == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "notif",
                       "alert('ITEM NOT ADDED. This product is currently out of stock. Try again later.')", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "notif",
                        $"alert('ITEM NOT ADDED. You either have the maximum number of it in your cart or adding the specified amount of {tbxQty.Text} will exceed the limit of 99.')", true);
                }
            }

            string[] totals = DBOps.GetUserCartTotals(_cart.cartID);

            SiteMaster master = Page.Master as SiteMaster;
            master.UpdateTotalCounters();

        }

        protected void CartDataSource_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@Id"].Value = _userCartId;
            e.Command.Parameters["@customer"].Value = _currUser;
            e.Command.Parameters["@items"].Value = _cart.lastInsertedItem;
            e.Command.Parameters["@prices"].Value = _cart.lastInsertedPrice;
            e.Command.Parameters["@quants"].Value = _cart.lastInsertedQuant;
            e.Command.Parameters["@totalCount"].Value = _cart.totalItemQuantity;
            e.Command.Parameters["@totalPrice"].Value = _cart.totalCartPrice;
            e.Command.Parameters["@reference_key"].Value = _referenceKey;
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
            e.Command.Parameters["@Id"].Value = DBOps.GetLatestEntry();
        }

        protected void userInfoDataSource_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@Id"].Value = DBOps.GetUserID(_currUser);
            e.Command.Parameters["@latest_cart_id"].Value = _userCartId;
        }

        protected void tbxQty_TextChanged(object sender, EventArgs e)
        {
            int currValue = Convert.ToInt32(tbxQty.Text);
            if (currValue > 99)
            {
                tbxQty.Text = "99";
            }
            else if (currValue <= 0)
            {
                tbxQty.Text = "1";
            }
        }

        protected void Products_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@sku"].Value = _itemSku;
            e.Command.Parameters["@qty"].Value = _itemQuant;
        }
    }
}