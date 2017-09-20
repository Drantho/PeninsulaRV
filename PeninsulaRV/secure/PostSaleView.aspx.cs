using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace PeninsulaRV.secure
{
    public partial class PostSaleView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlConnection connection = Connection();
                SqlDataAdapter adapter;
                DataSet dataset;
                string query;

                query = "SELECT DISTINCT DATEPART(yy, SaleDate) AS Year FROM OfferView WHERE OfferStatus = 'SOLD'";

                connection.Open();

                adapter = new SqlDataAdapter(query, connection);

                dataset = new DataSet();

                adapter.Fill(dataset);
                rblYear.DataSource = dataset;
                rblYear.DataTextField = "Year";
                rblYear.DataValueField = "Year";
                rblYear.DataBind();

                connection.Close();
            }            
        }

        protected void SelectMonth(object sender, EventArgs e)
        {
            PostSale newPostSaleList = new PostSale();
            rptOfferList.DataSource = newPostSaleList.GetStepCountByOffer(rblMonth.SelectedItem.Value, rblYear.SelectedItem.Value);
            rptOfferList.DataBind();
        }

        protected void SelectVehicle(object sender, CommandEventArgs e)
        {
            Offer selectedOffer = new Offer();
            selectedOffer = selectedOffer.GetOffer(e.CommandArgument.ToString());

            ViewState["selectedOffer"] = selectedOffer;

            FillSaleInfo(selectedOffer);            

            lblTest.Text = e.CommandArgument.ToString();

            List<PostSale> postSaleList = new List<PostSale>();

            for(int i=0; i<9; i++)
            {
                PostSale newPostSale = new PostSale();
                newPostSale.StepNumber = i + 1;
                postSaleList.Add(newPostSale);
            }            

            PostSale postSale = new PostSale();
            DataSet dataSet = postSale.GetStepsByOffer(e.CommandArgument.ToString());

            foreach (DataTable table in dataSet.Tables)
            {
                for(int i=0;i<table.Rows.Count; i++)
                {
                    postSaleList[i].Note = table.Rows[i]["Note"].ToString();
                    postSaleList[i].StepCost = Convert.ToDecimal(table.Rows[i]["StepCost"]);
                    postSaleList[i].CompleteDate = Convert.ToDateTime(table.Rows[i]["CompleteDate"]);
                }
            }

            ViewState["PostSaleList"] = postSaleList;



            FillStep1(postSaleList[0]);
        }

        private void FillSaleInfo(Offer selectedOffer)
        {
            lblSaleInfo.Text += "<strong> Sale ID: </strong >" + selectedOffer.OfferID + "<br />";

            lblSaleInfo.Text += "<strong> Vehicle ID: </strong >" + selectedOffer.saleConsignment.SaleVehicle.VehicleID + "<br />";

            lblSaleInfo.Text += "<strong> Stock Number: </strong >" + selectedOffer.saleConsignment.SaleVehicle.Stocknumber + "<br />";

            lblSaleInfo.Text += "<strong> Year: </strong>" + selectedOffer.saleConsignment.SaleVehicle.ModelYear.ToString() + "<br />";

            lblSaleInfo.Text += "<strong> Make: </strong>" + selectedOffer.saleConsignment.SaleVehicle.Make + "<br />";

            lblSaleInfo.Text += "<strong> Model: </strong>" + selectedOffer.saleConsignment.SaleVehicle.Model + "<br />";

            lblSaleInfo.Text += "<strong> Type: </strong>" + selectedOffer.saleConsignment.SaleVehicle.RVType + "<br />";

            lblSaleInfo.Text += "<strong> VIN: </strong>" + selectedOffer.saleConsignment.SaleVehicle.VIN + "<br />";

            lblSaleInfo.Text += "<h2> Seller </h2>";

            lblSaleInfo.Text += "<strong> Customer ID: </strong >" + selectedOffer.saleConsignment.CustomerRef + "<br />";

            lblSaleInfo.Text += "<strong> Name: </strong>" + selectedOffer.saleConsignment.Seller.FirstName + " " + selectedOffer.saleConsignment.Seller.LastName + "<br />";

            lblSaleInfo.Text += "<strong> Address: </strong><br />" + selectedOffer.saleConsignment.Seller.Address + "<br>" + selectedOffer.saleConsignment.Seller.City + ", " + selectedOffer.saleConsignment.Seller.State + " " + selectedOffer.saleConsignment.Seller.Zip + "<br />";

            lblSaleInfo.Text += "<strong> Phone: </strong>" + selectedOffer.saleConsignment.Seller.Phone + " " + selectedOffer.saleConsignment.Seller.AltPhone +  "<br />";

            lblSaleInfo.Text += "<h2> Buyer </h2>";

            lblSaleInfo.Text += "<strong> Customer ID: </strong >" + selectedOffer.buyer.CustomerID + "<br />";

            lblSaleInfo.Text += "<strong> Name: </strong>" + selectedOffer.buyer.FirstName + " " + selectedOffer.buyer.LastName + "<br />";

            lblSaleInfo.Text += "<strong> Address: </strong><br />" + selectedOffer.buyer.Address + "<br>" + selectedOffer.buyer.City + ", " + selectedOffer.buyer.State + " " + selectedOffer.buyer.Zip + "<br />";

            lblSaleInfo.Text += "<strong> Phone: </strong>" + selectedOffer.buyer.Phone + " " + selectedOffer.buyer.AltPhone + "<br />";

            lblSaleInfo.Text += "<h2> Sale Info </h2>";

            lblSaleInfo.Text += "<strong> Sale ID: </strong>" + selectedOffer.OfferID + "<br />";

            lblSaleInfo.Text += "<strong> Sale Date: </strong>" + selectedOffer.SaleDate.ToShortDateString() + "<br />";

            lblSaleInfo.Text += "<strong> Sale Price: </strong>" + selectedOffer.SalePrice.ToString("C") + "<br />";

            lblSaleInfo.Text += "<strong> Options: </strong><br>";

            foreach(SaleOption saleOption in selectedOffer.Options)
            {
                lblSaleInfo.Text += saleOption.Description + " " + saleOption.Price.ToString("C") + "<br>";
            }

            lblSaleInfo.Text += "<strong> Trade: </strong>" + selectedOffer.TradeInfo + "<br />";
            lblSaleInfo.Text += "<strong> Trade Credit: </strong>" + selectedOffer.TradeCredit.ToString("C") + "<br />";
            lblSaleInfo.Text += "<strong> Trade Tax Credit: </strong>" + selectedOffer.TradeTaxCredit.ToString("C") + "<br />";

            lblSaleInfo.Text += "<strong> Taxable: </strong >" + selectedOffer.TaxExempt.ToString() + "<br />";

            lblSaleInfo.Text += "<strong> Document Fee: </strong>" + selectedOffer.DocumentFee.ToString("C") + "<br />";

            lblSaleInfo.Text += "<strong> License Fee: </strong>" + selectedOffer.LicenseFee.ToString("C") + "<br />";

            lblSaleInfo.Text += "<strong> Sales Tax: </strong>" + selectedOffer.SalesTax.ToString("C") + "<br />";

            lblSaleInfo.Text += "<strong> Grand Total: </strong>" + selectedOffer.GrandTotal.ToString("C") + "<br />";
        }

        private void FillStep1(PostSale postSale)
        {
            Offer selectedOffer = new Offer();
            selectedOffer = ViewState["selectedOffer"] as Offer;

            DateTime beginDate = new DateTime(2000, 1, 1);

            if (postSale.CompleteDate > beginDate)
            {
                lblDepositDate.Text = postSale.CompleteDate.ToShortDateString();
            }
            else
            {
                lblDepositDate.Text = "Not set";
            }
            
            lblDepositAmount.Text = selectedOffer.GrandTotal.ToString("C");
            lblDepositNotes.Text = postSale.Note;
            txtDepositNotes.Text = postSale.Note;
        }

        private void FillStep2(PostSale postSale)
        {
            Offer selectedOffer = new Offer();
            selectedOffer = ViewState["selectedOffer"] as Offer;

            DateTime dueDate = selectedOffer.SaleDate.AddDays(2);

            DateTime beginDate = new DateTime(2000, 1, 1);

            if (postSale.CompleteDate > beginDate)
            {
                lblLienholderPaid.Text = postSale.CompleteDate.ToShortDateString();

            }
            else
            {
                lblLienholderPaid.Text = "Not set";
            }

            lblLienHolder.Text = selectedOffer.NewLienHolder;
            lblPayoff.Text = selectedOffer.saleConsignment.BalanceOwed.ToString("C");
        }

        private SqlConnection Connection()
        {

            SqlConnection connection;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            return connection;
        }
    }
}