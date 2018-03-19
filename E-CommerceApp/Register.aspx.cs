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

        }

        protected void UserInfoDatabase_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@latest_cart_id"].Value = 0;
        }

        protected void UserInfoDatabase_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            Response.Redirect("~/Home.aspx");
        }
    }
}