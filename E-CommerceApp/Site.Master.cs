using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_CommerceApp
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void SetText(params object[] values)
        {
            LBL_Counter.Text = string.Format("Cart ({0} | {1:C})", values[0], values[1]);
        }
    }
}