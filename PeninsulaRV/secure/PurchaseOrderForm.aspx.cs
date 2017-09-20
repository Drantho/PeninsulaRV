using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PeninsulaRV.secure
{
    public partial class PurchaseOrderForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string saleID = Request.QueryString["SaleID"];

            Offer newOffer = new Offer();
            newOffer = newOffer.GetOffer(saleID);

            if(newOffer.Status == "Sold")
            {
                lblStatus.Text = "Purchase Order";
            }
            else
            {
                lblStatus.Text = "Offer To Sell";
            }
            lblBalanceDue.Text = newOffer.BalanceDue.ToString("C");
            lblCashWithOrder.Text = newOffer.CashWithOrder.ToString("C");
            lblDeposit.Text = newOffer.Deposit.ToString("C");
            lblDocumentFee.Text = newOffer.DocumentFee.ToString("C");
            lblGrandTotal.Text = newOffer.GrandTotal.ToString("C");
            lblLicenseFee.Text = newOffer.LicenseFee.ToString("C");
            
            for (int i=0; i<newOffer.Options.Count; i++)
            {
                lblOptions.Text += "<tr><td>" + newOffer.Options[i].Description + "</td><td class='text-right'>" + newOffer.Options[i].Price.ToString("C") + "</td></tr>";
            }

            foreach(string str in newOffer.Buyer.ListCustomer)
            {
                lblPurchaser.Text += str + "<br>";
            }
            lblPurchaser.Text += newOffer.Buyer.Address + "<br>" + newOffer.Buyer.City + ", " + newOffer.Buyer.State + " " + newOffer.Buyer.Zip + "<br>" + newOffer.Buyer.Phone;
            lblSaleDate.Text = newOffer.SaleDate.ToShortDateString();
            lblSalePrice1.Text = newOffer.SalePrice.ToString("C");
            decimal salePriceAndOptions = newOffer.SalePrice + newOffer.OptionTotal;
            lblSalePriceAndOptions.Text = salePriceAndOptions.ToString("C");
            foreach(Salesman sm in newOffer.Salesmen)
            {
                lblSalesmen.Text += sm.Name + "<br>";
            }
            lblSalesTax.Text = newOffer.SalesTax.ToString("C");
            decimal totalCredit1 = newOffer.TradeCredit + newOffer.Deposit + newOffer.CashWithOrder;
            lblTotalCredit1.Text = totalCredit1.ToString("C");
            decimal totalCredit2 = totalCredit1 * -1;
            lblTotalCredit2.Text = totalCredit2.ToString("C");
            lblTradeCredit.Text = newOffer.TradeCredit.ToString("C");
            lblTradeInfo.Text = newOffer.TradeInfo;
            lblVehicle.Text = newOffer.SaleConsignment.SaleVehicle.ModelYear.ToString() + " " + newOffer.SaleConsignment.SaleVehicle.Make + " " + newOffer.SaleConsignment.SaleVehicle.Model + "<br>";
            lblVehicle.Text += newOffer.SaleConsignment.SaleVehicle.RVType + "<br>";
            lblVehicle.Text += "VIN: " + newOffer.SaleConsignment.SaleVehicle.VIN + "<br>";
            if (newOffer.SaleConsignment.SaleVehicle.Motorized)
            {
                lblVehicle.Text += "Mileage: " + newOffer.SaleConsignment.SaleVehicle.Mileage.ToString();
            }            
        }
    }
}