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
    public partial class SalesmanCommission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!string.IsNullOrEmpty(Request.QueryString["SaleID"]))
            {
                if(ViewState["selectedOffer"] == null)
                {
                    FillSale(Request.QueryString["SaleID"]);
                    pnlSelectMonth.Visible = false;
                    pnlSales.Visible = false;
                    pnlSaleInfo.Visible = true;
                }
                
                
            }
        }

        protected void SelectMonth(object sender, EventArgs e)
        {
            pnlSelectMonth.Visible = false;
            pnlSales.Visible = true;

            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataSet;
            string query;
            
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM OfferView WHERE DatePart(MM, SaleDate) = @Month AND DatePart(YYYY, SaleDate) = @Year ";
            adapter = new SqlDataAdapter(query, connection);
            adapter.SelectCommand.Parameters.AddWithValue("@Year", rblYear.SelectedValue);
            adapter.SelectCommand.Parameters.AddWithValue("@Month", rblMonth.SelectedValue);
            connection.Open();

            dataSet = new DataSet();

            adapter.Fill(dataSet);
            rptSales.DataSource = dataSet;
            rptSales.DataBind();

            connection.Close();
            
        }
        

        protected void SelectSale(object sender, CommandEventArgs e) {
            FillSale(e.CommandArgument.ToString());
        }

        protected void FillSale(string selectedaleID){
            Offer selectedOffer = new Offer(selectedaleID);

            ViewState["selectedOffer"] = selectedOffer;

            pnlSales.Visible = false;
            pnlSaleInfo.Visible = true;

            lblBuyerAddress.Text = selectedOffer.Buyer.Address + "<br>" + selectedOffer.Buyer.City + ", " + selectedOffer.Buyer.State + " " + selectedOffer.Buyer.Zip;
            lblBuyerID.Text = selectedOffer.Buyer.CustomerID;
            lblBuyerName.Text = selectedOffer.Buyer.LastName + ", " + selectedOffer.Buyer.FirstName;
            lblBuyerPhone.Text = selectedOffer.Buyer.Phone + ", " + selectedOffer.Buyer.AltPhone;
            lblCommissionCalc.Text = selectedOffer.SaleConsignment.DealCalc.ToString();
            lblConsignDate.Text = selectedOffer.SaleConsignment.ConsignDate.ToShortDateString();
            lblConsignmentID.Text = selectedOffer.SaleConsignment.ConsignmentID;
            lblDealerCommission.Text = selectedOffer.GrossProfit.ToString("C");
            lblDealerCost.Text = selectedOffer.DealerCost.ToString("C");
            lblDealType.Text = selectedOffer.saleConsignment.DealType;
            lblDocumentFee.Text = selectedOffer.DocumentFee.ToString("C");
            lblGrandTotal.Text += selectedOffer.GrandTotal.ToString("C");
            lblLicenseFee.Text = selectedOffer.LicenseFee.ToString("C");
            lblMake.Text = selectedOffer.SaleConsignment.SaleVehicle.Make;
            lblModel.Text = selectedOffer.SaleConsignment.SaleVehicle.Model;
            lblModelYear.Text = selectedOffer.SaleConsignment.SaleVehicle.ModelYear.ToString();
            lblOfferID.Text = selectedOffer.OfferID;
            lblOptionsPrice.Text = selectedOffer.OptionTotal.ToString("C");
            lblSaleDate.Text = selectedOffer.SaleDate.ToShortDateString();
            lblSalePrice.Text = selectedOffer.SalePrice.ToString("C");
            lblSalesmen.Text = "";
            foreach (Salesman salesMan in selectedOffer.GetSalesmen())
            {
                lblSalesmen.Text += salesMan.Name + " - Commission Percent: " + salesMan.CommissionPercent.ToString() + "<br>";
                decimal salesmanCommission = (salesMan.CommissionPercent * (selectedOffer.GrossProfit - selectedOffer.DealerCost))/100;
                lblSalesmenCommissions.Text += salesmanCommission.ToString("C") + " ";

                lblEditSalesmen.Text += salesMan.Name + " ";
                cblSalesmen.Items.FindByText(salesMan.Name).Selected = true;
            }
            lblSaleStatus.Text = selectedOffer.Status;
            lblSalesTax.Text = selectedOffer.SalesTax.ToString("C");
            lblSellerAddress.Text = selectedOffer.SaleConsignment.Seller.Address + "<br>" + selectedOffer.SaleConsignment.Seller.City + ", " + selectedOffer.SaleConsignment.Seller.State + " " + selectedOffer.SaleConsignment.Seller.Zip;
            lblSellerID.Text = selectedOffer.SaleConsignment.Seller.CustomerID;
            lblSellerName.Text = selectedOffer.SaleConsignment.Seller.LastName + ", " + selectedOffer.SaleConsignment.Seller.FirstName;
            lblSellerPhone.Text = selectedOffer.SaleConsignment.Seller.Phone + ", " + selectedOffer.SaleConsignment.Seller.AltPhone;
            lblStockNumber.Text = selectedOffer.saleConsignment.SaleVehicle.Stocknumber;
            lblVehicleID.Text = selectedOffer.SaleConsignment.SaleVehicle.VehicleID;
            lblVehicleType.Text = selectedOffer.SaleConsignment.SaleVehicle.RVType;
            lblVIN.Text = selectedOffer.SaleConsignment.SaleVehicle.VIN;

            lblEditCommissionCalc.Text = "Commission Calc: ";
            try
            {
                lblEditCommissionCalc.Text += selectedOffer.SaleConsignment.DealCalc.ToString();
            }catch{}
            try
                {
                    txtEditCommissionCalc.Text = selectedOffer.SaleConsignment.DealCalc.ToString();
            }catch{}
            lblEditDealerCost.Text = "Dealer Cost: ";
            try
            {
                lblEditDealerCost.Text += selectedOffer.DealerCost.ToString("C");
            }catch{}
            try
            {
                txtDealerCost.Text = selectedOffer.DealerCost.ToString();
            }catch{}
            lblEditDealType.Text = "Deal Type: ";
            try
            {
                lblEditDealType.Text += selectedOffer.SaleConsignment.dealType;
            }catch{}
            try
            {
                rblDealType.Items.FindByValue(selectedOffer.SaleConsignment.DealType).Selected = true;
            }catch{}
            lblEditSaleDate.Text = "Sale Date: ";
            try
            {
                lblEditSaleDate.Text += selectedOffer.SaleDate.ToShortDateString();
            }catch{}
            try
            {
                txtSaleDate.Text = selectedOffer.SaleDate.ToString("yyyy-MM-dd");
            }catch{}
            lblEditStatus.Text = "Status: ";
            try
            {
                lblEditStatus.Text += selectedOffer.Status;
            }catch{ }
            try
            {
                rblStatus.Items.FindByText(selectedOffer.Status).Selected = true;
            }catch{}           
        }

        protected void UpdateCommissionCalc(object sender, CommandEventArgs e)
        {
            Offer selectedOffer = ViewState["selectedOffer"] as Offer;
            selectedOffer.SaleConsignment.DealCalc = Convert.ToDecimal(txtEditCommissionCalc.Text);
            selectedOffer.saleConsignment.UpdateAll();
            //Response.Redirect("SalesmanCommission.aspx?SaleID=" + selectedOffer.OfferID);
            FillSale(selectedOffer.OfferID);
        }

        protected void UpdateDealerCost(object sender, CommandEventArgs e)
        {
            Offer selectedOffer = ViewState["selectedOffer"] as Offer;
            selectedOffer.DealerCost = Convert.ToDecimal(txtDealerCost.Text);
            selectedOffer.UpdateAll();

            //selectedOffer.UpdateOffer("DealerCost", selectedOffer.DealerCost.ToString());
            ViewState["selectedOffer"] = selectedOffer;
            //Response.Redirect("SalesmanCommission.aspx?SaleID=" + selectedOffer.OfferID);
            FillSale(selectedOffer.OfferID);
        }

        protected void UpdateDealType(object sender, CommandEventArgs e)
        {
            Offer selectedOffer = ViewState["selectedOffer"] as Offer;
            selectedOffer.SaleConsignment.DealType = rblDealType.SelectedItem.Text;
            selectedOffer.saleConsignment.UpdateConsignment("DealType", selectedOffer.SaleConsignment.DealType);

            ViewState["selectedOffer"] = selectedOffer;
            //Response.Redirect("SalesmanCommission.aspx?SaleID=" + selectedOffer.OfferID);
            FillSale(selectedOffer.OfferID);
        }

        protected void UpdateSaleDate(object sender, CommandEventArgs e)
        {
            Offer selectedOffer = ViewState["selectedOffer"] as Offer;
            selectedOffer.SaleDate = Convert.ToDateTime(txtSaleDate.Text);
            selectedOffer.UpdateOffer("SaleDate", selectedOffer.SaleDate.ToString());

            ViewState["selectedOffer"] = selectedOffer;
            //Response.Redirect("SalesmanCommission.aspx?SaleID=" + selectedOffer.OfferID);
            FillSale(selectedOffer.OfferID);
        }

        protected void UpdateStatus(object sender, CommandEventArgs e)
        {
            Offer selectedOffer = ViewState["selectedOffer"] as Offer;
            selectedOffer.Status = rblStatus.SelectedItem.Text;
            selectedOffer.UpdateOffer("Status", selectedOffer.Status);

            ViewState["selectedOffer"] = selectedOffer;
            //Response.Redirect("SalesmanCommission.aspx?SaleID=" + selectedOffer.OfferID);
            FillSale(selectedOffer.OfferID);
        }

        private Offer GetSelectedOffer()
        {
            Offer selectedOffer =  ViewState["selectedOffer"] as Offer;

            return selectedOffer;
        }
    }
}