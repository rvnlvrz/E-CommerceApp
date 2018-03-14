using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_CommerceApp
{
    public partial class Frm_Confirm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["refkey"] != null)
            {
                LBL_refNum.Text += ((string)(Session["refkey"]));
            }
            else
            {
                Response.Redirect("~/Home.aspx");
            }
        }

        protected void Btn_finalize_Click(object sender, EventArgs e)
        {
            Session.Remove("refKey");
            Response.Redirect("~/Products.aspx");
        }
    }
}