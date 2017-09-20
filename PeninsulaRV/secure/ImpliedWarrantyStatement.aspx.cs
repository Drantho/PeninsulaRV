using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeninsulaRV.secure
{
    public partial class ImpliedWarrantyStatement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["SaleID"]))
            {
                Offer newOffer = new Offer();
                newOffer = newOffer.GetOffer(Request.QueryString["SaleID"]);

                foreach (string name in newOffer.Buyer.ListCustomer)
                {
                    lblCustomerName.Text += "<br><br><div class='row'>";
                    lblCustomerName.Text += "<div class='col -xs-12'>";
                    lblCustomerName.Text += "_____________________________________________________________________________________<br><br>";
                    lblCustomerName.Text += "</div>";
                    lblCustomerName.Text += "</div>";

                    lblCustomerName.Text += "<div class='row'>";
                    lblCustomerName.Text += "<div class='col-xs-6'>";
                    lblCustomerName.Text += "<span class='lineLabel'>" + name + "</span>";
                    lblCustomerName.Text += "</div>";
                    lblCustomerName.Text += "</div>";
                }

                lblVehicle.Text = newOffer.SaleConsignment.saleVehicle.ModelYear.ToString() + " " + newOffer.SaleConsignment.saleVehicle.Make + " " + newOffer.SaleConsignment.saleVehicle.Model + "<br>" + newOffer.SaleConsignment.saleVehicle.RVType + "<br>VIN: " + newOffer.SaleConsignment.saleVehicle.VIN;

                DateTime today = new DateTime();

                today = DateTime.Now;

                lblDate.Text = today.ToLongDateString() + ".";
            }
            else
            {
                lblVehicle.Text += "Model Year: ____________________________________________________________________<br>";
                lblVehicle.Text += "Make: ________________________________________________________________________<br>";
                lblVehicle.Text += "Model: ________________________________________________________________________<br>";
                lblVehicle.Text += "VIN: __________________________________________________________________________<br>";

                lblDate.Text += "______________________________________________";

                lblCustomerName.Text += "<br><br><div class='row'>";
                lblCustomerName.Text += "<div class='col -xs-12'>";
                lblCustomerName.Text += "_____________________________________________________________________________________<br><br>";
                lblCustomerName.Text += "</div>";
                lblCustomerName.Text += "</div>";

                lblCustomerName.Text += "<div class='row'>";
                lblCustomerName.Text += "<div class='col-xs-6'>";
                lblCustomerName.Text += "<span class='lineLabel'>Customer Name</span>";
                lblCustomerName.Text += "</div>";
                lblCustomerName.Text += "<div class='col-xs-6'>";
                lblCustomerName.Text += "<span class='lineLabel'>Customer Signature</span><br><br>";
                lblCustomerName.Text += "</div>";
                lblCustomerName.Text += "</div>";

                lblCustomerName.Text += "<div class='row'>";
                lblCustomerName.Text += "<div class='col -xs-12'>";
                lblCustomerName.Text += "_____________________________________________________________________________________<br><br>";
                lblCustomerName.Text += "</div>";
                lblCustomerName.Text += "</div>";

                lblCustomerName.Text += "<div class='row'>";
                lblCustomerName.Text += "<div class='col-xs-6'>";
                lblCustomerName.Text += "<span class='lineLabel'>Customer Name</span>";
                lblCustomerName.Text += "</div>";
                lblCustomerName.Text += "<div class='col-xs-6'>";
                lblCustomerName.Text += "<span class='lineLabel'>Customer Signature</span>";
                lblCustomerName.Text += "</div>";
                lblCustomerName.Text += "</div>";
                
            }

            
        }
    }
}