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
    public partial class ConsignmentAgreement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = "Consignment Agreement";        

            if (!Page.IsPostBack)
            {

                if (String.IsNullOrEmpty(Request.QueryString["SaleID"]))
                {
                    SqlConnection connection;
                    SqlDataAdapter adapter, adapter2;
                    DataSet dataset, dataset2;
                    string query;

                    connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

                    query = "SELECT CustomerID, LastName + ', ' + IsNull(FirstName, '') + '<br>' + IsNull(Address, '') + '<br>' + IsNull(City, '') + ', ' + IsNull(State, '') + ' ' + IsNull(Zip, '') + '<br>' + IsNull(PhoneNumber, '') + ' ' + IsNull(AltPhoneNumber, '') As Info FROM Customer ORDER BY LastName, FirstName";

                    connection.Open();

                    adapter = new SqlDataAdapter(query, connection);

                    dataset = new DataSet();

                    adapter.Fill(dataset);

                    rblCustomerList.DataSource = dataset;
                    rblCustomerList.DataTextField = "Info";
                    rblCustomerList.DataValueField = "CustomerID";
                    rblCustomerList.DataBind();

                    query = "SELECT Sale.SaleID, Vehicle.ModelYear, Vehicle.Make, Vehicle.Model, Vehicle.Model, Vehicle.VehicleType, Customer.LastName, Customer.FirstName, Customer.PhoneNumber, Customer.AltPhoneNumber FROM Sale INNER JOIN Vehicle ON Sale.VehicleRef = Vehicle.VehicleID INNER JOIN Customer ON Sale.SellerRef = Customer.CustomerID WHERE Vehicle.Sale = 1 AND Vehicle.Sold = 0 AND Vehicle.Active = 1 ORDER BY Vehicle.VehicleType, Vehicle.ModelYear DESC";

                    adapter2 = new SqlDataAdapter(query, connection);

                    dataset2 = new DataSet();

                    adapter2.Fill(dataset2);

                    rptCurrentConsignments.DataSource = dataset2;
                    rptCurrentConsignments.DataBind();

                    connection.Close();

                    Vehicle newVehicle = new Vehicle();

                    txtStocknumber.Text = newVehicle.GetNextStocknumber();
                }
                else
                {
                    GetConsignment(Request.QueryString["SaleID"]);
                }

                
            }
            else
            {
                
            }
            
        }

        protected void SelectCustomer(object sender, EventArgs e)
        {
            hdnCustomerID.Value = rblCustomerList.SelectedItem.Value;
            pnlCustomer.Visible = false;
            pnlVehicle.Visible = true;
            FillVehicle();

            Customer newCustomer = new Customer();
            newCustomer = newCustomer.GetCustomer(hdnCustomerID.Value);

            ViewState["Customer"] = newCustomer;

            fillUpdateCustomer();

        }

        protected void AddCustomer(object sender, EventArgs e)
        {
            lblVehicleMessage.Text = "No vehicles entered yet.";
            btnSelectVehicle.Visible = false;
            pnlCustomer.Visible = false;
            pnlVehicle.Visible = true;

            Customer newCustomer = new Customer();
            newCustomer.FirstName = txtFirstName.Text;
            newCustomer.LastName = txtLastName.Text;
            newCustomer.Address = txtAddress.Text;
            newCustomer.City = txtCity.Text;
            newCustomer.State = txtState.Text;
            newCustomer.Zip = txtZip.Text;
            newCustomer.Phone = txtPhone.Text;
            newCustomer.AltPhone = txtAltPhone.Text;

            hdnCustomerID.Value = newCustomer.AddCustomerToDatabase();

            ViewState["Customer"] = newCustomer;

            fillUpdateCustomer();

        }

        private void FillVehicle()
        {
            Customer newCustomer = new Customer();
            newCustomer.CustomerID = hdnCustomerID.Value;

            rblVehicleList.DataSource = newCustomer.GetVehicleList();
            rblVehicleList.DataTextField = "Info";
            rblVehicleList.DataValueField = "VehicleID";
            rblVehicleList.DataBind();
        }

        protected void SelectVehicle(object sender, EventArgs e)
        {
            
            hdnVehicleID.Value = rblVehicleList.SelectedItem.Value;
            pnlVehicle.Visible = false;
            pnlConsignment.Visible = true;
            FillConsignment();

            Vehicle newVehicle = new Vehicle();

            newVehicle = newVehicle.GetVehicle(hdnVehicleID.Value);
            
            newVehicle.UpdateVehicle("Sold", "0");
            newVehicle.UpdateVehicle("Active", "1");
            newVehicle.UpdateVehicle("Sale", "1");
            newVehicle.UpdateVehicle("Stocknumber", txtStocknumber.Text);

            ViewState["Vehicle"] = newVehicle;

            fillUpdateVehicle();


        }

        protected void AddVehicle(object sender, EventArgs e)
        {
            Vehicle newVehicle = new Vehicle();
            Customer owner = new Customer();

            owner.CustomerID = hdnCustomerID.Value;

            newVehicle.Owner = owner;
            newVehicle.ModelYear = Convert.ToInt32(txtModelYear.Text);
            newVehicle.Make = txtMake.Text;
            newVehicle.Model = txtModel.Text;
            newVehicle.RVType = rblVehicleType.SelectedItem.Text;
            newVehicle.VIN = txtVIN.Text;
            newVehicle.Mileage = Convert.ToInt32(txtMileage.Text);
            newVehicle.VehicleID = newVehicle.AddVehicleToDatabase();
            newVehicle.Stocknumber = txtStocknumber.Text;
            newVehicle.Sold = false;
            newVehicle.Active = true;
            newVehicle.ForSale = true;

            newVehicle.VehicleID = newVehicle.AddVehicleToDatabase();
            hdnVehicleID.Value = newVehicle.VehicleID;

            pnlVehicle.Visible = false;
            pnlConsignment.Visible = true;

            ViewState["Vehicle"] = newVehicle;

            fillUpdateVehicle();

        }

        private void FillConsignment()
        {
            Sale newSale = new Sale();
            rblConsignments.DataSource = newSale.GetSaleRecords(hdnVehicleID.Value);
            rblConsignments.DataTextField = "ConsignDate";
            rblConsignments.DataValueField = "SaleID";
            rblConsignments.DataBind();
        }

        protected void SelectConsignment(object sender, EventArgs e)
        {
            hdnSaleID.Value = rblConsignments.SelectedItem.Value;

            hlkPrint.NavigateUrl = "ConsignmentAgreementForm.aspx?SaleID=" + hdnSaleID.Value;

            Sale newSale = new Sale();

            newSale = newSale.GetSaleInfo(hdnSaleID.Value);

            ViewState["Sale"] = newSale;

            FillReview();    
        }        

        protected void AddConsignment(object sender, EventArgs e)
        {

            Vehicle newVehicle = new Vehicle();
            newVehicle = ViewState["Vehicle"] as Vehicle;

            Customer newCustomer = new Customer();
            newCustomer = ViewState["Customer"] as Customer;

            DateTime consignDate, expireDate;
            int days;

            consignDate = DateTime.Now;
            days = Convert.ToInt32(txtTerm.Text);
            expireDate = consignDate.AddDays(days);

            Sale newSale = new Sale();

            newSale.SaleVehicle = newVehicle;

            newSale.Seller = newCustomer;

            newSale.AskingPrice = Convert.ToDecimal(txtAskingPrice.Text);
            newSale.CustomerPrice = Convert.ToDecimal(txtCustomerPrice.Text);
            newSale.FeeAmount = Convert.ToDecimal(txtFlatFee.Text);
            newSale.CommissionPercent = Convert.ToDecimal(txtPercent.Text);
            newSale.PercentDeal = rblDealType.Items[0].Selected;
            newSale.ExcessOfDeal = rblDealType.Items[1].Selected;
            newSale.FlatFeeDeal = rblDealType.Items[2].Selected;
            newSale.ConsignDate = consignDate;
            newSale.ExpireDate = expireDate;
            newSale.LienHolder = txtLienHolder.Text;
            newSale.BalanceOwed = Convert.ToDecimal(txtBalanceOwed.Text);

            hdnSaleID.Value = newSale.AddSaleToDatabase();
            hlkPrint.NavigateUrl = "ConsignmentAgreementForm.aspx?SaleID=" + hdnSaleID.Value;
            ViewState["Sale"] = newSale;

            FillReview();
        }

        protected void SelectCurrentConsignment(object sender, CommandEventArgs e)
        {
            GetConsignment(e.CommandArgument.ToString());
        }

        private void GetConsignment(string saleID)
        {
            Sale newSale = new Sale();

            newSale = newSale.GetSaleInfo(saleID);

            ViewState["Customer"] = newSale.Seller;
            ViewState["Vehicle"] = newSale.SaleVehicle;
            ViewState["Sale"] = newSale;

            hlkPrint.NavigateUrl = "ConsignmentAgreementForm.aspx?SaleID=" + saleID;
            
            FillReview();

            pnlCustomer.Visible = false;
        }

        private void FillReview()
        {
            pnlConsignment.Visible = false;
            pnlReview.Visible = true;

            Customer newCustomer = new Customer();
            Vehicle newVehicle = new Vehicle();
            Sale newSale = new Sale();

            newCustomer = ViewState["Customer"] as Customer;
            newVehicle = ViewState["Vehicle"] as Vehicle;
            newSale = ViewState["Sale"] as Sale;

            lblSaleReviewCustomerID.Text = newCustomer.CustomerID;
            lblSaleReviewFirstName.Text = newCustomer.FirstName;          
            lblSaleReviewLastName.Text = newCustomer.LastName;
            lblSaleReviewAddress.Text = newCustomer.Address;
            lblSaleReviewCity.Text = newCustomer.City;
            lblSaleReviewState.Text = newCustomer.State;
            lblSaleReviewZip.Text = newCustomer.Zip;
            lblSaleReviewPhone.Text = newCustomer.Phone;
            lblSaleReviewAltPhone.Text = newCustomer.AltPhone;

            lblSaleReviewVehicleID.Text = newVehicle.VehicleID;
            lblSaleReviewModelYear.Text = newVehicle.ModelYear.ToString();
            lblSaleReviewMake.Text = newVehicle.Make;
            lblSaleReviewModel.Text = newVehicle.Model;
            lblSaleReviewVIN.Text = newVehicle.VIN;
            lblSaleReviewStocknumber.Text = newVehicle.Stocknumber;
            lblSaleReviewDescription.Text = newVehicle.Description;
            lblSaleReviewRvType.Text = newVehicle.RVType;
            lblSaleReviewMileage.Text = newVehicle.Mileage.ToString();

            lblSaleReviewSaleID.Text = newSale.SaleID;
            lblSaleReviewAskingPrice.Text = newSale.AskingPrice.ToString("c");

            lblSaleReviewPercentDeal.Visible = newSale.PercentDeal;
            lblSaleReviewExcessOfDeal.Visible = newSale.ExcessOfDeal;
            lblSaleReviewFlatFeeDeal.Visible = newSale.FlatFeeDeal;

            lblSaleReviewPercent.Visible = newSale.PercentDeal;
            lblSaleReviewCustomerPrice.Visible = newSale.ExcessOfDeal;
            lblSaleReviewFeeAmount.Visible = newSale.FlatFeeDeal;

            lblSaleReviewPercent.Text = newSale.CommissionPercent.ToString();
            lblSaleReviewCustomerPrice.Text = newSale.CustomerPrice.ToString("c");
            lblSaleReviewFeeAmount.Text = newSale.FeeAmount.ToString("c");

            lblSaleReviewConsignDate.Text = newSale.ConsignDate.ToShortDateString();
            lblSaleReviewExpireDate.Text = newSale.ExpireDate.ToShortDateString();


            if (String.IsNullOrEmpty(newSale.LienHolder))
            {
                lblSaleReviewLienHolder.Text = "None";
            }
            else
            {
                lblSaleReviewLienHolder.Text = newSale.LienHolder;
            }
            
            lblSaleReviewBalanceOwed.Text = newSale.BalanceOwed.ToString("c");
            
            txtEditFirstName.Text = newCustomer.FirstName;
            txtEditLastName.Text = newCustomer.LastName;
            txtEditAddress.Text = newCustomer.Address;
            txtEditCity.Text = newCustomer.City;
            txtEditState.Text = newCustomer.State;
            txtEditZip.Text = newCustomer.Zip;
            txtEditPhone.Text = newCustomer.Phone;
            txtEditAltPhone.Text = newCustomer.AltPhone;

            txtEditModelYear.Text = newVehicle.ModelYear.ToString();
            txtEditMake.Text = newVehicle.Make;
            txtEditModel.Text = newVehicle.Model;
            txtEditVIN.Text = newVehicle.VIN;
            txtEditStockNumber.Text = newVehicle.Stocknumber;
            txtEditDescription.Text = newVehicle.Description;
            
            rblEditVehicleType.Items.FindByValue(newVehicle.RVType).Selected = true;
            
            txtEditMileage.Text = newVehicle.Mileage.ToString();

            txtEditAskingPrice.Text = newSale.AskingPrice.ToString();

            txtEditConsignDate.Text = newSale.ConsignDate.ToShortDateString();
            txtEditExpireDate.Text = newSale.ExpireDate.ToShortDateString();

            rblEditDealType.Items[0].Selected = newSale.PercentDeal;
            rblEditDealType.Items[1].Selected = newSale.ExcessOfDeal;
            rblEditDealType.Items[2].Selected = newSale.FlatFeeDeal;

            if (newSale.PercentDeal)
            {
                txtEditCommissionCalc.Text = newSale.CommissionPercent.ToString();
            }
            if (newSale.ExcessOfDeal)
            {
                txtEditCommissionCalc.Text = newSale.CustomerPrice.ToString();
            }
            if (newSale.FlatFeeDeal)
            {
                txtEditCommissionCalc.Text = newSale.FeeAmount.ToString();
            }


            if (String.IsNullOrEmpty(newSale.LienHolder))
            {
                txtEditLienHolder.Text = "None";
            }
            else
            {
                txtEditLienHolder.Text = newSale.LienHolder;
            }

            txtEditBalanceOwed.Text = newSale.BalanceOwed.ToString("c");
            
        }

        protected void UpdateVehicle(object sender, CommandEventArgs e)
        {
            Sale newSale = new Sale();

            newSale = ViewState["Sale"] as Sale;

            Vehicle newVehicle = new Vehicle();
            newVehicle = ViewState["Vehicle"] as Vehicle;

            if (e.CommandArgument.ToString() == "VehicleType")
            {
                newVehicle.UpdateVehicle("VehicleType", rblEditVehicleType.SelectedItem.Text);
            }
            else
            {
                TextBox newTextBox = new TextBox();

                newTextBox = pnlReview.FindControl("txtEdit" + e.CommandArgument) as TextBox;

                newVehicle.UpdateVehicle(e.CommandArgument.ToString(), newTextBox.Text);
            }
            
            Response.Redirect("ConsignmentAgreement.aspx?SaleID=" + newSale.SaleID);
        }

        protected void UpdateCustomer(object sender, CommandEventArgs e)
        {
            Sale newSale = new Sale();

            newSale = ViewState["Sale"] as Sale;

            Customer newCustomer = new Customer();
            newCustomer = ViewState["Customer"] as Customer;

            TextBox newTextBox = new TextBox();

            newTextBox = pnlReview.FindControl("txtEdit" + e.CommandArgument) as TextBox;

            newCustomer.UpdateCustomer(e.CommandArgument.ToString(), newTextBox.Text);
           
            Response.Redirect("ConsignmentAgreement.aspx?SaleID=" + newSale.SaleID);
        }

        protected void Updatesale(object sender, CommandEventArgs e)
        {
            Sale newSale = new Sale();

            newSale = ViewState["Sale"] as Sale;
            
            if(e.CommandArgument.ToString() == "DealType")
            {
                newSale.UpdateSale("DealType", rblEditDealType.SelectedItem.Value);
            }
            else
            {
                if (e.CommandArgument.ToString() == "CommissionCalc")
                {
                    if (rblEditDealType.Items[0].Selected)
                    {
                        newSale.UpdateSale("CommissionPercent", txtEditCommissionCalc.Text);
                    }
                    if (rblEditDealType.Items[1].Selected)
                    {
                        newSale.UpdateSale("CustomerPrice", txtEditCommissionCalc.Text);
                    }
                    if (rblEditDealType.Items[2].Selected)
                    {
                        newSale.UpdateSale("FeeAmount", txtEditCommissionCalc.Text);
                    }
                }
            }

            TextBox newTextBox = new TextBox();

            newTextBox = pnlReview.FindControl("txtEdit" + e.CommandArgument) as TextBox;

            newSale.UpdateSale(e.CommandArgument.ToString(), newTextBox.Text);

            Response.Redirect("ConsignmentAgreement.aspx?SaleID=" + newSale.SaleID);
        }

        protected void UpdateCustomer(object sender, EventArgs e)
        {
            Customer newCustomer = new Customer();
            newCustomer.CustomerID = hdnCustomerID.Value;

            newCustomer.FirstName = txtUpdateFirstName.Text;
            newCustomer.LastName = txtUpdateLastName.Text;
            newCustomer.Address = txtUpdateAddress.Text;
            newCustomer.City = txtUpdateCity.Text;
            newCustomer.State = txtUpdateState.Text;
            newCustomer.Zip = txtUpdateZip.Text;
            newCustomer.Phone = txtUpdatePhone.Text;
            newCustomer.AltPhone = txtUpdateAltPhone.Text;

            newCustomer.UpdateAll();
        }

        private void fillUpdateCustomer()
        {
            Customer newCustomer = new Customer();
            newCustomer.CustomerID = hdnCustomerID.Value;

            newCustomer = newCustomer.GetCustomer(hdnCustomerID.Value);

            txtUpdateFirstName.Text = newCustomer.FirstName;
            txtUpdateLastName.Text = newCustomer.LastName;
            txtUpdateAddress.Text = newCustomer.Address;
            txtUpdateCity.Text = newCustomer.City;
            txtUpdateState.Text = newCustomer.State;
            txtUpdateZip.Text = newCustomer.Zip;
            txtUpdatePhone.Text = newCustomer.Phone;
            txtUpdateAltPhone.Text = newCustomer.AltPhone;

        }

        protected void UpdateVehicle(object sender, EventArgs e)
        {
            Vehicle newVehicle = new Vehicle();
            newVehicle.VehicleID = hdnVehicleID.Value;

            newVehicle.Stocknumber = txtUpdateStockNumber.Text;
            newVehicle.ModelYear = Convert.ToInt32(txtUpdateModelYear.Text);
            newVehicle.Make = txtUpdateMake.Text;
            newVehicle.Model = txtUpdateModel.Text;
            newVehicle.VIN = txtUpdateVIN.Text;
            newVehicle.RVType = rblUpdateVehicleType.SelectedItem.Text;
            newVehicle.Mileage = Convert.ToInt32(txtUpdateMileage.Text);

            newVehicle.UpdateAll();
        }

        private void fillUpdateVehicle()
        {
            Vehicle newVehicle = new Vehicle();
            newVehicle.VehicleID = hdnVehicleID.Value;

            newVehicle = newVehicle.GetVehicle(hdnVehicleID.Value);

            txtUpdateStockNumber.Text = newVehicle.Stocknumber;
            txtUpdateModelYear.Text = newVehicle.ModelYear.ToString();
            txtUpdateMake.Text = newVehicle.Make;
            txtUpdateModel.Text = newVehicle.Model;
            txtUpdateVIN.Text = newVehicle.VIN;
            txtUpdateMileage.Text = newVehicle.Mileage.ToString();

            try
            {
                rblUpdateVehicleType.Items.FindByValue(newVehicle.RVType).Selected = true;
            }
            catch
            {

            }


        }
    }
}