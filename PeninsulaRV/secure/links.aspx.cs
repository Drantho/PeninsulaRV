using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeninsulaRV.secure
{
    public partial class links : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string viewerName = System.Web.HttpContext.Current.User.Identity.Name.ToString();

            if(viewerName == "nerzerwer@gmail.com" || viewerName == "hmitchlds@gmail.com")
            {
                pnlSupervisor.Visible = true;
                pnlTechnician.Visible = true;
            }
            if (viewerName == "tech60rgs@gmail.com")
            {
                pnlTechnician.Visible = true;
            }
        }
    }
}