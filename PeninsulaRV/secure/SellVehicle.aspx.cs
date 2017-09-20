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
    public partial class SellVehicle : System.Web.UI.Page
    {
        const decimal motorizedTaxRate = 0.087M;
        const decimal nonMotorizedTaxRate = 0.084M;
        const decimal motorizedLicenseFee = 170.75M;
        const decimal nonMotorizedLicenseFee = 79.75M;

        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet dataset = new DataSet();
            Consignment newConsignment = new Consignment();

            dataset = newConsignment.GetCurrentConsignments();

            rptStockList.DataSource = dataset;
            rptStockList.DataBind();

            DataSet dataset2 = new DataSet();
            Offer newOfer = new Offer();

            dataset2 = newOfer.GetCurrentOffers();

            rptOffer.DataSource = dataset2;
            rptOffer.DataBind();

            if (!IsPostBack)
            {
                fillCustomerList();                
            }
            
        }

        private void fillCustomerList()
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT CustomerID, LastName + ', ' + FirstName + '<br>' + Address + '<br>' + City + ', ' + State + ' ' + Zip + '<br>' + PhoneNumber + ' ' + AltPhoneNumber As Info FROM Customer ORDER BY LastName, FirstName";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);

            dataset = new DataSet();

            adapter.Fill(dataset);

            rblCustomerList.DataSource = dataset;
            rblCustomerList.DataValueField = "CustomerID";
            rblCustomerList.DataTextField = "Info";
            rblCustomerList.DataBind();   

            connection.Close();
        }        

        protected void SelectVehicle(object sender, CommandEventArgs e)
        {
            pnlSelectVehicle.Visible = false;
            pnlSelectBuyer.Visible = true;

            Consignment newConsignment = new Consignment();

            newConsignment = newConsignment.GetConsignment(e.CommandArgument.ToString());

            ViewState["Consignment"] = newConsignment;

            hdnConsignmentID.Value = e.CommandArgument.ToString();
            hdnVehicleID.Value = newConsignment.SaleVehicle.VehicleID.ToString();

            txtSalePrice.Text = newConsignment.AskingPrice.ToString();          

            if (newConsignment.SaleVehicle.Motorized)
            {
                txtLicenseFee.Text = motorizedLicenseFee.ToString();
            }
            else
            {
                txtLicenseFee.Text = nonMotorizedLicenseFee.ToString();
            }

            DateTime today;

            today = DateTime.Now;

            txtSaleDate.Text = today.ToString("yyyy-MM-dd");
        }
        
        protected void SelectBuyer(object sender, EventArgs e)
        {
            pnlSelectBuyer.Visible = false;
            pnlSaleInfo.Visible = true;

            Customer buyer = new Customer();

            buyer = buyer.GetCustomer(rblCustomerList.SelectedItem.Value);

            //Sale newSale = new Sale();

            //newSale = ViewState["SelectedSale"] as Sale;
            
            //ViewState["SelectedSale"] = newSale;

            hdnBuyerID.Value = rblCustomerList.SelectedItem.Value;
        }

        protected void AddNewCustomer(object sender, EventArgs e)
        {
            Customer newCustomer = new Customer();
            newCustomer.FirstName = FirstName.Text;
            newCustomer.LastName = LastName.Text;
            newCustomer.Address = Address.Text;
            newCustomer.City = City.Text;
            newCustomer.State = State.Text;
            newCustomer.Zip = Zip.Text;
            newCustomer.Phone = Phone.Text;
            newCustomer.AltPhone = AltPhone.Text;

            newCustomer.CustomerID = newCustomer.AddCustomerToDatabase();

            hdnBuyerID.Value = newCustomer.CustomerID;

            pnlSaleInfo.Visible = true;
            pnlSelectBuyer.Visible = false;

        }
        
        protected void UpdateVehicle(object sender, EventArgs e)
        {

        }
        
        protected void AddSale(object sender, EventArgs e)
        {
            Offer newOffer = new Offer();
            
            newOffer.SaleConsignment = ViewState["Consignment"] as Consignment;
            newOffer.BuyerRef = hdnBuyerID.Value;
            newOffer.CashWithOrder = Convert.ToDecimal(txtCashWithOrder.Text);
            newOffer.ConsignmentRef = hdnConsignmentID.Value;
            newOffer.DealerCost = Convert.ToDecimal(txtDealerCost.Text);
            newOffer.Deposit = Convert.ToDecimal(txtDeposit.Text);
            newOffer.DocumentFee = Convert.ToDecimal(txtDocumentFee.Text);            
            newOffer.LicenseFee = Convert.ToDecimal(txtLicenseFee.Text);
            newOffer.NewLienHolder = txtLienHolder.Text;
            newOffer.SaleDate = Convert.ToDateTime(txtSaleDate.Text);
            newOffer.SalePrice = Convert.ToDecimal(txtSalePrice.Text);
            newOffer.Status = rblOffer.SelectedItem.Text;
            if (newOffer.Status == "Sold")
            {
                newOffer.SaleConsignment.Status = "Sold";
                newOffer.SaleConsignment.UpdateConsignment("Status", newOffer.SaleConsignment.Status);
            }
            newOffer.TaxExempt = rblTaxExempt.SelectedItem.Text == "Yes";
            if (newOffer.TaxExempt)
            {
                newOffer.ExemptReason = rblExemptReason.SelectedItem.Text;
            }
            else
            {
                newOffer.ExemptReason = "Taxable";
            }
            if (rblTrade.Items[1].Selected)
            {
                newOffer.TradeCredit = Convert.ToDecimal(txtTradeValue.Text);
                newOffer.TradeInfo = txtTradeModelYear.Text + " " + txtTradeMake.Text + " " + txtTradeModel.Text + " " + txtTradeVIN.Text;
                newOffer.TradeTaxCredit = Convert.ToDecimal(txtTradeTaxCredit.Text);
            }
            else
            {
                newOffer.TradeCredit = 0;
                newOffer.TradeInfo = "None";
                newOffer.TradeTaxCredit = 0;
            }
            

            newOffer.OfferID = newOffer.AddOfferToDatabase();

            newOffer = newOffer.GetOffer(newOffer.OfferID);

            List<Salesman> salesmen = new List<Salesman>();
            int splitWays = 0;
            foreach (ListItem li in cblSalesman.Items)
            {
                if (li.Selected)
                {
                    splitWays++;
                }
            }
            List<Salesman> listSalesman = new List<Salesman>();
            foreach (ListItem li in cblSalesman.Items)
            {
                if (li.Selected)
                {
                    Salesman newSalesman = new Salesman();
                    newSalesman.OfferRef = newOffer.OfferID;
                    newSalesman.Name = li.Text;
                    newSalesman.CommissionPercent = 25 / splitWays;                    
                    newSalesman.SalesmanID = newSalesman.AddSalesmanToDatabase();
                    listSalesman.Add(newSalesman);
                }
            }
            newOffer.Salesmen = listSalesman;

            List<SaleOption> listOption = new List<SaleOption>();
            for (var i = 1; i <= 6; i++)
            {
                TextBox txtDescription = new TextBox();
                TextBox txtPrice = new TextBox();

                txtDescription = pnlSaleInfo.FindControl("txtOptionDescription" + i) as TextBox;
                txtPrice = pnlSaleInfo.FindControl("txtOptionPrice" + i) as TextBox;

                if (!string.IsNullOrEmpty(txtDescription.Text))
                {
                    SaleOption newOption = new SaleOption();
                    newOption.Description = txtDescription.Text;
                    newOption.Price = Convert.ToDecimal(txtPrice.Text);
                    newOption.OfferRef = newOffer.OfferID;
                    newOption.AddOptionToDatabase();
                    listOption.Add(newOption);
                }
                else
                {
                    break;
                }
            }
            newOffer.Options = listOption;

            newOffer.Buyer = newOffer.Buyer.GetCustomer(hdnBuyerID.Value);

            newOffer = newOffer.GetOffer(newOffer.OfferID);

            ShowSale(newOffer);

            ViewState["Offer"] = newOffer;
        }

        private void ShowSale(Offer offer)
        {
            pnlReview.Visible = true;
            pnlSaleInfo.Visible = false;

            hlkPurchaseOrder.NavigateUrl = "PurchaseOrderForm?SaleID=" + offer.OfferID;
            hlkUnitPage.NavigateUrl = "http://www.peninsularv.net/unit?StockNumber=" + offer.saleConsignment.saleVehicle.Stocknumber;

            lblVehicleID.Text = offer.saleConsignment.SaleVehicle.VehicleID;            
            lblStocknumber.Text = offer.saleConsignment.SaleVehicle.Stocknumber;
            txtReviewStocknumber.Text = offer.saleConsignment.SaleVehicle.Stocknumber;
            lblModelYear.Text = offer.saleConsignment.SaleVehicle.ModelYear.ToString();
            txtReviewModelYear.Text = offer.saleConsignment.SaleVehicle.ModelYear.ToString();
            lblMake.Text = offer.saleConsignment.SaleVehicle.Make;
            txtReviewMake.Text = offer.saleConsignment.SaleVehicle.Make;
            lblModel.Text = offer.saleConsignment.SaleVehicle.Model;
            txtReviewModel.Text = offer.saleConsignment.SaleVehicle.Model;
            lblVIN.Text = offer.saleConsignment.SaleVehicle.VIN;
            txtReviewVIN.Text = offer.saleConsignment.SaleVehicle.VIN;
            lblMileage.Text = offer.saleConsignment.SaleVehicle.Mileage.ToString();
            txtReviewMileage.Text = offer.saleConsignment.SaleVehicle.Mileage.ToString();
            lblVehicleType.Text = offer.saleConsignment.SaleVehicle.RVType;
            rblReviewVehicleType.Items.FindByText(offer.saleConsignment.SaleVehicle.RVType).Selected = true;
           
            lblCustomerID.Text = offer.Buyer.CustomerID;
            lblFirstName.Text = offer.Buyer.FirstName;
            txtReviewFirstName.Text = offer.Buyer.FirstName;
            lblLastName.Text = offer.Buyer.LastName;
            txtReviewLastName.Text = offer.Buyer.LastName;
            lblAddress.Text = offer.Buyer.Address;
            txtReviewAddress.Text = offer.Buyer.Address;
            lblCity.Text = offer.Buyer.City;
            txtReviewCity.Text = offer.Buyer.City;
            lblState.Text = offer.Buyer.State;
            txtReviewState.Text = offer.Buyer.State;
            lblZip.Text = offer.Buyer.Zip;
            txtReviewZip.Text = offer.Buyer.Zip;
            lblPhone.Text = offer.Buyer.Phone;
            txtReviewPhone.Text = offer.Buyer.Phone;
            lblAltPhone.Text = offer.Buyer.AltPhone;
            txtReviewAltPhone.Text = offer.Buyer.AltPhone;

            lblSaleID.Text = offer.OfferID;
            lblSaleStatus.Text = offer.Status;
            rblReviewSaleStatus.Items.FindByText(offer.Status).Selected = true;
            lblSaleDate.Text = offer.SaleDate.ToLongDateString();
            txtReviewSaleDate.Text = offer.SaleDate.ToShortDateString();
            lblSalesman.Text = "";
            foreach (Salesman newSalesman in offer.Salesmen)
            {
                lblSalesman.Text += "<li>" + newSalesman.Name + "</li>";
                cblReviewSalesmen.Items.FindByText(newSalesman.Name).Selected = true;
            }
            lblSalePrice.Text = offer.SalePrice.ToString("C");
            txtReviewSalePrice.Text = offer.SalePrice.ToString();
            lblOptions.Text = "";
            int i = 1;
            foreach (SaleOption option in offer.Options)
            {
                TextBox txtOptionDescription = new TextBox();
                TextBox txtOptionPrice = new TextBox();

                txtOptionDescription = pnlReview.FindControl("txtReviewOptionDescription" + i) as TextBox;
                txtOptionPrice = pnlReview.FindControl("txtReviewOptionPrice" + i) as TextBox;

                txtOptionDescription.Text = option.Description;
                txtOptionPrice.Text = option.Price.ToString();

                lblOptions.Text += "<li>" + option.Description + ": " + option.Price.ToString("C") + "</li>";
                i++;
            }
            lblOptionsTotal.Text = offer.OptionTotal.ToString("C");
            lblDocumentFee.Text = offer.DocumentFee.ToString("C");
            txtReviewDocumentFee.Text = offer.DocumentFee.ToString();
            lblTaxStatus.Text = offer.ExemptReason;
            txtReviewTaxStatus.Text = offer.ExemptReason;
            lblTaxID.Text = "ToDo";
            lblSalesTax.Text = offer.SalesTax.ToString("C");
            lblLicenseFee.Text = offer.LicenseFee.ToString("C");
            txtReviewLicenseFee.Text = offer.LicenseFee.ToString();
            lblGrandTotal.Text = offer.GrandTotal.ToString("C");
            lblTrade.Text = offer.TradeInfo;
            txtReviewTradeInfo.Text = offer.TradeInfo;
            lblTradeValue.Text = offer.TradeCredit.ToString("C");
            txtReviewTradeValue.Text = offer.TradeCredit.ToString();
            lblTaxCredit.Text = offer.TradeTaxCredit.ToString("C");
            txtReviewTradeTaxCredit.Text = offer.TradeTaxCredit.ToString();
            lblCashWithOrder.Text = offer.CashWithOrder.ToString("C");
            txtReviewCashWithOrder.Text = offer.CashWithOrder.ToString();
            lblDeposit.Text = offer.Deposit.ToString("C");
            txtReviewDeposit.Text = offer.Deposit.ToString();
            lblBalanceDue.Text = offer.BalanceDue.ToString("C");

            hlkImpliedWarranty.NavigateUrl = "impliedwarrantystatement.aspx?SaleID=" + offer.OfferID;

        }

        protected void SelectOffer(object sender, CommandEventArgs e)
        {
            pnlSelectVehicle.Visible = false;
            pnlReview.Visible = true;

            Offer newOffer = new Offer();

            newOffer = newOffer.GetOffer(e.CommandArgument.ToString());

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }

        protected void UpdateStocknumber(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.SaleConsignment.SaleVehicle.Stocknumber = txtReviewStocknumber.Text;

            newOffer.SaleConsignment.SaleVehicle.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateModelYear(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.SaleConsignment.SaleVehicle.ModelYear = Convert.ToInt16(txtReviewModelYear.Text);

            newOffer.SaleConsignment.SaleVehicle.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateMake(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.SaleConsignment.SaleVehicle.Make = txtReviewMake.Text;

            newOffer.SaleConsignment.SaleVehicle.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateModel(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.SaleConsignment.SaleVehicle.Model = txtReviewModel.Text;

            newOffer.SaleConsignment.SaleVehicle.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateVIN(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.SaleConsignment.SaleVehicle.VIN = txtReviewVIN.Text;

            newOffer.SaleConsignment.SaleVehicle.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateMileage(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.SaleConsignment.SaleVehicle.Mileage = Convert.ToInt16(txtReviewMileage.Text);

            newOffer.SaleConsignment.SaleVehicle.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateVehicleType(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.SaleConsignment.SaleVehicle.RVType = rblReviewVehicleType.SelectedItem.Text;

            newOffer.SaleConsignment.SaleVehicle.UpdateAll();

            newOffer = newOffer.GetOffer(newOffer.OfferID);

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateFirstName(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.Buyer.FirstName = txtReviewFirstName.Text;
            newOffer.Buyer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateLastName(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.Buyer.LastName = txtReviewLastName.Text;
            newOffer.Buyer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateAddress(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.Buyer.Address = txtReviewAddress.Text;
            newOffer.Buyer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateCity(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.Buyer.City = txtReviewCity.Text;
            newOffer.Buyer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateState(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.Buyer.State = txtReviewState.Text;
            newOffer.Buyer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateZip(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.Buyer.Zip = txtReviewZip.Text;
            newOffer.Buyer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdatePhone(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.Buyer.Phone = txtReviewPhone.Text;
            newOffer.Buyer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateAltPhone(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.Buyer.AltPhone = txtReviewAltPhone.Text;
            newOffer.Buyer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);

        }
        protected void UpdateSaleStatus(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.Status = rblReviewSaleStatus.SelectedItem.Text;
            newOffer.UpdateAll();
            
            if( newOffer.Status == "Offer")
            {
                newOffer.SaleConsignment.Status = "Active";
            }else
            {
                newOffer.SaleConsignment.Status = "Sold";
            }

            newOffer.SaleConsignment.UpdateAll();
            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateSaleDate(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.SaleDate = Convert.ToDateTime(txtReviewSaleDate.Text);
            newOffer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateSalesmen(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.DeleteAllSalesmen();

            newOffer.Salesmen.Clear();

            int splitWays = 0;
            foreach(ListItem li in cblReviewSalesmen.Items)
            {
                if (li.Selected)
                {
                    splitWays++;
                    Salesman newSalesman = new Salesman();

                    newSalesman.Name = li.Text;
                    newSalesman.OfferRef = newOffer.OfferID;

                    newOffer.Salesmen.Add(newSalesman);
                }                
            }

            foreach(Salesman sm in newOffer.Salesmen)
            {
                sm.CommissionPercent = 25 / splitWays;
                sm.AddSalesmanToDatabase();
            }


            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateSalePrice(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.SalePrice = Convert.ToDecimal(txtReviewSalePrice.Text);
            newOffer.UpdateAll();

            newOffer = newOffer.GetOffer(newOffer.OfferID);

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateOptions(object sender, CommandEventArgs e)//TODO
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.DeleteAllOptions();

            for(int i =1; i<=6; i++)
            {
                TextBox txtReviewOptionDescription = new TextBox();
                txtReviewOptionDescription = pnlReview.FindControl("txtReviewOptionDescription" + i) as TextBox;

                if (!String.IsNullOrEmpty(txtReviewOptionDescription.Text))
                {
                    TextBox txtReviewOptionPrice = new TextBox();
                    txtReviewOptionPrice = pnlReview.FindControl("txtReviewOptionPrice" + i) as TextBox;

                    SaleOption newSaleOption = new SaleOption();
                    newSaleOption.Description = txtReviewOptionDescription.Text;
                    newSaleOption.Price = Convert.ToDecimal(txtReviewOptionPrice.Text);
                    newSaleOption.OfferRef = newOffer.OfferID;

                    newSaleOption.AddOptionToDatabase();

                    newOffer.Options.Add(newSaleOption);
                }
                else
                {
                    break;
                }

            }

            newOffer = newOffer.GetOffer(newOffer.OfferID);

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateDocumentFee(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.DocumentFee = Convert.ToDecimal(txtReviewDocumentFee.Text);
            newOffer.UpdateAll();

            newOffer = newOffer.GetOffer(newOffer.OfferID);
            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }        
        protected void UpdateTaxStatus(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.ExemptReason = txtReviewTaxStatus.Text;
            newOffer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateTaxExemptID(object sender, CommandEventArgs e)//TODO
        {
            //TODO
        }
        protected void UpdateLicenseFee(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.LicenseFee = Convert.ToDecimal(txtReviewLicenseFee.Text);
            newOffer.UpdateAll();

            newOffer = newOffer.GetOffer(newOffer.OfferID);
            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateTradeInfo(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.TradeInfo = txtReviewTradeInfo.Text;
            newOffer.UpdateAll();

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateTradeValue(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.TradeCredit = Convert.ToDecimal(txtReviewTradeValue.Text);
            newOffer.UpdateAll();

            newOffer = newOffer.GetOffer(newOffer.OfferID);
            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateTradeTaxCredit(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.TradeTaxCredit = Convert.ToDecimal(txtReviewTradeTaxCredit.Text);
            newOffer.UpdateAll();

            newOffer = newOffer.GetOffer(newOffer.OfferID);
            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateCashWithOrder(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.CashWithOrder = Convert.ToDecimal(txtReviewCashWithOrder.Text);
            newOffer.UpdateAll();

            newOffer = newOffer.GetOffer(newOffer.OfferID);
            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
        protected void UpdateDeposit(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.Deposit = Convert.ToDecimal(txtReviewDeposit.Text);
            newOffer.UpdateAll();

            newOffer = newOffer.GetOffer(newOffer.OfferID);
            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
        }
    }
}