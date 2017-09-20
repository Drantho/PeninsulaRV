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
    public partial class SoldVehicles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlConnection connection;
                SqlDataAdapter adapter, adapter2;
                DataSet dataset, dataset2;
                string query, query2;

                connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

                query = "SELECT DISTINCT DatePart(yyyy, SaleDate) AS Year from Offer where DatePart(yyyy, SaleDate) > 1900 ORDER BY Year";

                connection.Open();

                adapter = new SqlDataAdapter(query, connection);

                dataset = new DataSet();

                adapter.Fill(dataset);

                rblYear.DataSource = dataset;
                rblYear.DataTextField = "Year";
                rblYear.DataValueField = "Year";
                rblYear.DataBind();

                query2 = "SELECT TOP 15 * FROM OfferView ORDER BY OfferID DESC";
                
                adapter2 = new SqlDataAdapter(query2, connection);

                dataset2 = new DataSet();

                adapter2.Fill(dataset2);

                rptRecent.DataSource = dataset2;
                rptRecent.DataBind();

                connection.Close();
            }
        }

        protected void SelectMonth(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM OfferView WHERE DatePart(yyyy, SaleDate) = " + rblYear.SelectedItem.Value + " AND DatePart(MM, SaleDate) = " + rblMonth.SelectedItem.Value + " ORDER BY SaleDate";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);

            dataset = new DataSet();

            adapter.Fill(dataset);

            rptMonthList.DataSource = dataset;
            rptMonthList.DataBind();
            connection.Close();

            pnlSelectMonth.Visible = false;
            pnlMonthList.Visible = true;
            
        }

        protected void SelectMonthOffer(object sender, CommandEventArgs e)
        {
            SelectSale(e.CommandArgument.ToString());
            pnlMonthList.Visible = false;
            pnlSelectMonth.Visible = false;      
        }

        protected void SelectSale(string saleID)
        {
            Offer newOffer = new Offer();
            newOffer = newOffer.GetOffer(saleID);

            ViewState["Offer"] = newOffer;

            ShowSale(newOffer);
            
        }

        private void ShowSale(Offer offer)
        {
            pnlReview.Visible = true;

            hlkPurchaseOrder.NavigateUrl = "PurchaseOrderForm?SaleID=" + offer.OfferID;
            hlkUnitPage.NavigateUrl = "http://www.peninsularv.net/unit?StockNumber=" + offer.saleConsignment.saleVehicle.Stocknumber;
            hlkImpliedWarranty.NavigateUrl = "ImpliedWarrantyStatement.aspx?SaleID=" + offer.OfferID;

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
            lblDealerCost.Text = offer.DealerCost.ToString("C");
            txtReviewDealerCost.Text = offer.DealerCost.ToString();
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

        }

        protected void Search(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM OfferView WHERE Make LIKE @Make OR Model LIKE @Model OR VIN LIKE @VIN OR BuyerName LIKE @BuyerName OR SellerName LIKE @SellerName ORDER BY SaleDate";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);
            adapter.SelectCommand.Parameters.AddWithValue("@Make", "%" + txtSearch.Text + "%");
            adapter.SelectCommand.Parameters.AddWithValue("@Model", "%" + txtSearch.Text + "%");
            adapter.SelectCommand.Parameters.AddWithValue("@VIN", "%" + txtSearch.Text + "%");
            adapter.SelectCommand.Parameters.AddWithValue("@BuyerName", "%" + txtSearch.Text + "%");
            adapter.SelectCommand.Parameters.AddWithValue("@SellerName", "%" + txtSearch.Text + "%");

            dataset = new DataSet();

            adapter.Fill(dataset);

            rptMonthList.DataSource = dataset;
            rptMonthList.DataBind();
            connection.Close();

            pnlSelectMonth.Visible = false;
            pnlMonthList.Visible = true;
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

            if (newOffer.Status == "Offer")
            {
                newOffer.SaleConsignment.Status = "Active";
            }
            else
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
            foreach (ListItem li in cblReviewSalesmen.Items)
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

            foreach (Salesman sm in newOffer.Salesmen)
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

            for (int i = 1; i <= 6; i++)
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
        protected void UpdateDealerCost(object sender, CommandEventArgs e)
        {
            Offer newOffer = new Offer();
            newOffer = ViewState["Offer"] as Offer;

            newOffer.DealerCost = Convert.ToDecimal(txtReviewDealerCost.Text);
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