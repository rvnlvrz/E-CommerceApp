using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_CommerceApp
{
    public partial class frm_register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //TextBox card_expiryTextBox = ((TextBox)(FormView1.FindControl("card_expiryTextBox")));
            //card_expiryTextBox.TextMode = TextBoxMode.Date;

            CompareValidator validator = ((CompareValidator)(FormView1.FindControl("CompareEndTodayValidator")));
            validator.ValueToCompare = DateTime.Now.ToShortDateString();
        }

        protected void UserInfoDatabase_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@latest_cart_id"].Value = 0;
        }

        protected void UserInfoDatabase_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            Session["sync"] = "1";
            Session["currUser"] = ((TextBox)FormView1.FindControl("emailTextBox")).Text;
            Response.Redirect("~/Cart.aspx");
        }

        protected void CompareEndTodayValidator_PreRender(object sender, EventArgs e)
        {
            CompareValidator validator = ((CompareValidator)(FormView1.FindControl("CompareEndTodayValidator")));
            validator.ValueToCompare = DateTime.Now.ToShortDateString();
        }
    }
}