using System;
using System.Web.UI.WebControls;

namespace E_CommerceApp
{
    public partial class FrmViewRefCart : System.Web.UI.Page
    {
        #region Global Variables
        private string _refKey;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["refNum"] != null))
            {
                _refKey = ((string)(Session["refNum"]));
            }
            else
            {
                Response.Redirect(@"~/Home.aspx");
            }

            lvw_items.DataSource = DBOps.BuildUserCart(_refKey);
            lvw_totals.DataSource = DBOps.BuildUserCartTotals(_refKey);
            lvw_items.DataBind();
            lvw_totals.DataBind();
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
    }
}