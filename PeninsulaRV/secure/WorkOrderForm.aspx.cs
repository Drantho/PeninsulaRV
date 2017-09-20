using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeninsulaRV.secure
{
    public partial class WorkOrderForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["OrderNumber"])){
                //Response.Redirect("workorder.aspx");
            }
            else
            {
                FillForm();
            }
        }

        private void FillForm()
        {
            WorkOrderInfo newWorkOrderInfo = new WorkOrderInfo();
            newWorkOrderInfo = newWorkOrderInfo.GetWorkOrderInfo(Request.QueryString["OrderNumber"]);
            DateTime ordered = new DateTime();

            ordered = Convert.ToDateTime(newWorkOrderInfo.DateOrdered);
            lblOrder.Text += "<strong>Order ID:</strong> " + newWorkOrderInfo.OrderNumber + "<br>";
            lblOrder.Text += "<strong>Order Date:</strong> " + ordered.ToString("d") + "<br>";
            lblOrder.Text += "<strong>Taken By:</strong> " + newWorkOrderInfo.TakenBy + "<br>";

            lblCustomer.Text += newWorkOrderInfo.CustomerName + "<br>";
            lblCustomer.Text += newWorkOrderInfo.CustomerAddress + "<br>";
            lblCustomer.Text += newWorkOrderInfo.CustomerCity + ", " + newWorkOrderInfo.CustomerState + "  " + newWorkOrderInfo.CustomerZip + "<br>";
            lblCustomer.Text += newWorkOrderInfo.CustomerPhone + "<br>";
            lblCustomer.Text += newWorkOrderInfo.CustomerAltPhone + "<br>";

            lblVehicle.Text += newWorkOrderInfo.VehicleInfo + "<br>";
            lblVehicle.Text += newWorkOrderInfo.VehicleType + "<br>";
            lblVehicle.Text += "VIN: " + newWorkOrderInfo.VehicleVin + "<br>";

            if (newWorkOrderInfo.VehicleType == "Class A Motorhome" || newWorkOrderInfo.VehicleType == "Class B Motorhome" || newWorkOrderInfo.VehicleType == "Class C Motorhome" || newWorkOrderInfo.VehicleType == "Automobile")
            {
                lblVehicle.Text += "Mileage: " + newWorkOrderInfo.Mileage + "<br>";
            }

            rptJob.DataSource = newWorkOrderInfo.GetJobRecords();
            rptJob.DataBind();

            rptMaterial.DataSource = newWorkOrderInfo.GetMaterialRecords();
            rptMaterial.DataBind();

            rptMiscellaneous.DataSource = newWorkOrderInfo.GetMiscellaneousRecords();
            rptMiscellaneous.DataBind();

            lblTotals.Text += "<table>";
            lblTotals.Text += "<tr>";
            lblTotals.Text += "<td><strong>Labor</strong></td><td style='text-align: right'>" + newWorkOrderInfo.JobTotal.ToString("c") + "</td>";
            lblTotals.Text += "</tr>";
            lblTotals.Text += "<tr>";
            lblTotals.Text += "<td><strong>Materials</strong></td><td style='text-align: right'>" + newWorkOrderInfo.MaterialTotal.ToString("c") + "</td>";
            lblTotals.Text += "</tr>";
            lblTotals.Text += "<tr>";
            lblTotals.Text += "<td><strong>Miscellaneous</strong></td><td style='text-align: right'>" + newWorkOrderInfo.MiscellaneousTotal.ToString("c") + "</td>";
            lblTotals.Text += "</tr>";
            lblTotals.Text += "<tr>";
            lblTotals.Text += "<td><strong>Subtotal</strong></td><td style='text-align: right'>" + newWorkOrderInfo.SubTotal.ToString("c") + "</td>";
            lblTotals.Text += "</tr>";
            lblTotals.Text += "<tr>";
            lblTotals.Text += "<td><strong>Sales Tax</strong></td><td style='text-align: right'>" + newWorkOrderInfo.SalesTax.ToString("c") + "</td>";
            lblTotals.Text += "</tr>";
            lblTotals.Text += "<tr>";
            lblTotals.Text += "<td><strong>Invoice Total</strong></td><td style='text-align: right'>" + newWorkOrderInfo.GrandTotal.ToString("c") + "</td>";
            lblTotals.Text += "</tr>";
            lblTotals.Text += "</table>";

        }
    }
}