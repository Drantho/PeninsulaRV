using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeninsulaRV.secure
{
    public partial class ConsignmentAgreementForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int saleID = Convert.ToInt32(Request.QueryString["SaleID"]);
                GetSaleInfo(saleID);
                
            }
            catch
            {
                Response.Write("<h1>Failed</h1>");
            }

        }

        private void GetSaleInfo(int saleID)
        {
            //Sale newSale = new Sale();
            //newSale = newSale.GetSaleInfo(saleID.ToString());

            Consignment newConsignment = new Consignment();
            newConsignment = newConsignment.GetConsignment(saleID.ToString());

            lblVehicleInfo.Text = newConsignment.saleVehicle.ModelYear.ToString() + " " + newConsignment.saleVehicle.Make.ToString() + " " + newConsignment.saleVehicle.Model.ToString() + "<br>";
            lblVehicleInfo.Text += newConsignment.saleVehicle.RVType.ToString() + "<br>";
            lblVehicleInfo.Text += "VIN:" + newConsignment.saleVehicle.VIN.ToString() + "<br>";
            if(newConsignment.saleVehicle.Mileage != 0)
            {
                lblVehicleInfo.Text += "Mileage:" + newConsignment.saleVehicle.Mileage.ToString() + "<br>";
            }
            if(String.IsNullOrEmpty(newConsignment.LienHolder) || newConsignment.LienHolder == "none")
            {
                lblLegalOwner.Text = "Legal owner same as registered owner.";
                lblShortSale.Visible = false;
            }
            else
            {
                lblLegalOwner.Text = "Legal owner: " + newConsignment.LienHolder + "<br>";
                lblLegalOwner.Text += "Balance owed approximately: " + newConsignment.BalanceOwed.ToString("c") + "<br>";
            }
            if (newConsignment.DealType == "Excess of Deal" || newConsignment.DealType == "Excess Of Deal")
            {
                lblCommissionType.Text = "Consignor will accept " + newConsignment.DealCalc.ToString("c") + ", less any balance owing, as above, in full payment for vehicle.";
            }
            if (newConsignment.DealType == "Percent Deal")
            {
                lblCommissionType.Text = "Consignor will pay " + newConsignment.DealCalc.ToString() + "% of the sale price to dealer upon sale.";
            }
            if (newConsignment.DealType == "Flat Fee Deal")
            {
                lblCommissionType.Text = "Consignor will pay a flat fee of " + newConsignment.DealCalc.ToString("C") + " to dealer upon sale.";
            }

            lblCommissionType.Text += "<br>Peninsula RV will set the asking price of vehicle to " + newConsignment.AskingPrice.ToString("C");

            lblDays.Text = (newConsignment.Term).ToString();

            lblExpireDate.Text = newConsignment.ExpireDate.ToShortDateString();

            string[] firstNameArray = CustomerName(newConsignment.Seller.FirstName);
            string[] lastNameArray = CustomerName(newConsignment.Seller.LastName);

            lblConsignorName1.Text = firstNameArray[0] + " " + lastNameArray[0];
            lblConsignorInfoName.Text = lblConsignorName1.Text;

            if (String.IsNullOrEmpty(firstNameArray[1]) && String.IsNullOrEmpty(lastNameArray[1])){
                lblSginature2.Visible = false;
            }
            else
            {
                if (String.IsNullOrEmpty(lastNameArray[1]))
                {
                    lblConsignorName2.Text += firstNameArray[1] + " " + lastNameArray[0];
                }
                else
                {
                    lblConsignorName2.Text = firstNameArray[1] + " " + lastNameArray[1];
                }
                lblConsignorInfoName.Text += "<br>" + lblConsignorName2.Text;
            }

            lblConsignorInfoAddress.Text = newConsignment.Seller.Address + "<br>";
            lblConsignorInfoAddress.Text += newConsignment.Seller.City + ", " + newConsignment.Seller.State + " " + newConsignment.Seller.Zip + "<br>";
            lblConsignorInfoPhone.Text = "Phone: " + newConsignment.Seller.Phone + "<br>";
            lblConsignorInfoPhone.Text += "Alt Phone: " + newConsignment.Seller.AltPhone + "<br>";
        }

        private string[] CustomerName(string name)
        {
            string[] nameArray = new string[2];

            

            if (name.IndexOf(",") != -1)
            {
                nameArray = name.Split(',');
            }
            else
            {
                if (name.IndexOf("&") != -1)
                {
                    nameArray = name.Split('&');
                }
                else
                {
                    if (name.IndexOf(" and ") != -1)
                    {
                        name = name.Replace(" and ", ",");
                        nameArray = name.Split(',');
                    }
                    else
                    {
                        nameArray[0] = name;
                    }
                }
                
            }
            return nameArray;

        }
    }
}