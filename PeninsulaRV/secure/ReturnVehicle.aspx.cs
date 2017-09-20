using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeninsulaRV.secure
{
    public partial class ReturnVehicle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Consignment newConsignment = new Consignment();

                rptStockList.DataSource = newConsignment.GetCurrentConsignments();
                rptStockList.DataBind();
            }
        }

        protected void RemoveVehicle(object sender, CommandEventArgs e)
        {
            Consignment newConsignment = new Consignment();
            newConsignment = newConsignment.GetConsignment(e.CommandArgument.ToString());

            newConsignment.Status = "Inactive";

            newConsignment.UpdateAll();

            Response.Redirect("ReturnVehicle.aspx");
        }
    }
}