using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_CommerceApp
{
    public partial class frm_login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["currUser"] != null)
            {
                Response.Redirect(@"~/Home");
            }
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            string username, password;
            bool grantLogin = false;

            if (Page.IsValid)
            {
                DBOps.GetLoginDetails(tbx_mail.Text, out username, out password);

                if (username == string.Empty)
                {
                    grantLogin = false;
                }
                else
                {
                    if (tbx_password.Text == password)
                    {
                        grantLogin = true;
                    }
                }
            }

            if (grantLogin)
            {
                // used to be "loginRedirect" which indicates that the user was
                // redirected from the cart page. This is because previously, 
                // only authenticated users are permitted to purchase anything
                // from the web store.
                if (Session["prevID"] != null)
                {
                    HttpCookie httpCookie = Request.Cookies["cartID"];

                    // user has no cart previously assigned to him? Assign this one
                    if (DBOps.GetLatestEntry(DBOps.GetUserID(tbx_mail.Text)) == 0)
                    {
                        //DBOps.reassignUserCart(tbx_mail.Text, ((Convert.ToInt32(httpCookie.Value.ToString()))));
                        DBOps.ReassignUserCart(tbx_mail.Text, Convert.ToInt32(Session["prevID"]));
                        DBOps.RegisterCart(tbx_mail.Text);
                    }

                    // else, we sync carts.

                    // Delete the cookie used to store the cart ID generated before
                    // We delete it because the user has this cart ID assigned to him in the database
                    // and can be easily retrieved from the said DB.
                    if (Request.Cookies["cartID"] != null)
                    {
                        HttpCookie myCookie = new HttpCookie("cartID");
                        myCookie.Expires = DateTime.Now.AddDays(-5);
                        Response.Cookies.Add(myCookie);
                    }

                    Session["currUser"] = tbx_mail.Text;


                    Session["sync"] = 1;
                    Session.Remove("loginRedirect");

                    // force any page that relies on this to take the user's cart ID
                    //Session.Remove("prevID");

                    Response.Redirect(@"~/Cart.aspx");
                }
                else
                {
                    Session["currUser"] = tbx_mail.Text;
                    Response.Redirect(@"~/Home");
                }
            }
        }
    }
}