using System;

namespace E_CommerceApp
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        private readonly UserCart _cart = UserCart.Instance;

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteMaster master = Page.Master as SiteMaster;
            master.SetText(_cart.totalItemQuantity, _cart.totalCartPrice);
        }
    }
}