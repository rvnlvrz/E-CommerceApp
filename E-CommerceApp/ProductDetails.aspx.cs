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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.Count == 0)
                Response.Redirect("Default.aspx");

            _results = Products.Select(DataSourceSelectArguments.Empty) as DataView;
            _result = _results?[0].Row;

            CreateDetails();
            CreateCarousel();
        }

        private void CreateDetails()
        {
            // Set basic page details
            Page.Title = _result?["name"].ToString();
            lblTitle.Text = _result?["name"].ToString();
            Description.InnerText = _result?["description"].ToString();
            SKU.InnerText = _result?["sku"].ToString();
            Price.InnerText = $"{_result?["price"]:C}";

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
                div.Attributes["class"] = (i == 0) ? "carousel-item active" : "carousel-item";
                div.Controls.Add(img);
                InnerCarousel.Controls.Add(div);
            }

            // Generate thumbnail elements
        }
    }
}