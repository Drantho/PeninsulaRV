using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeninsulaRV
{
    public partial class Parts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Part part = new Part();
            rptCategories.DataSource = part.Categories();
            rptCategories.DataBind();

            if (!string.IsNullOrEmpty(Request.QueryString["Category"]))
            {
                FillCategory(Request.QueryString["Category"]);
            }
            else
            {
                FillAll();
            }
        }

        private void FillAll()
        {
            Part part = new Part();
            rptParts.DataSource = part.ActiveParts();
            rptParts.DataBind();
        }

        private void FillCategory(string category)
        {
            Part part = new Part();
            rptParts.DataSource = part.CategoryParts(category);
            rptParts.DataBind();
        }
    }
}