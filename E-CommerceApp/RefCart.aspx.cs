using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_CommerceApp
{
    public partial class FrmViewRefCart : Page
    {
        #region Global Variables
        private string _refKey = "";
        private readonly UserCart _cart = UserCart.Instance;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["refNum"] != null)
            {
                _refKey = (string)Session["refNum"];
            }

            lvw_items.DataSource = DBOps.BuildUserCart(_refKey);
            lvw_totals.DataSource = DBOps.BuildUserCartTotals(_refKey);
            lvw_items.DataBind();
            lvw_totals.DataBind();

            SiteMaster master = Page.Master as SiteMaster;
            master.UpdateTotalCounters();
        }

        protected void btn_goRefCart_Click(object sender, EventArgs e)
        {
            Session["refNum"] = tbx_refNum.Text;
            Response.Redirect("~/RefCart.aspx");
        }

        protected void lvw_items_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DataPager dp = (DataPager)lvw_items.FindControl("DataPager1");
            dp.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            lvw_items.DataSource = DBOps.BuildUserCart(_refKey);
            lvw_items.DataBind();
        }

        // Handles image src logic
        protected string RenderImage(object sku)
        {
            ProductsDataSource.SelectParameters[0].DefaultValue = sku.ToString();
            var result = ProductsDataSource.Select(DataSourceSelectArguments.Empty) as DataView;
            Debug.Assert(result != null, nameof(result) + " != null");
            string path = result[0]["img_url"].ToString();

            // Get all png and jpg files in current dir only
            var images = Directory.GetFiles(Server.MapPath(path) ?? throw new InvalidOperationException(), "*", SearchOption.TopDirectoryOnly)
                .Where(file => file.EndsWith(".png") || file.EndsWith(".jpg") || file.EndsWith(".jpeg"));

            // Resolve physical paths to server-relative paths
            List<string> files = images.Select(img => path + "/" + Path.GetFileName(img)).ToList();
            return files[0];
        }
    }
}