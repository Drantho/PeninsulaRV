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
    public partial class ConsignmentAgreement2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = "Consignment Agreement";

            if (!Page.IsPostBack)
            {

                if (String.IsNullOrEmpty(Request.QueryString["SaleID"]))
                {
                    SqlConnection connection;
                    SqlDataAdapter adapter;
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


                    Consignment newConsignment = new Consignment();

                    dataset2 = new DataSet();

                    dataset2 = newConsignment.GetCurrentConsignments();
                    
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

            newCustomer.CustomerID = newCustomer.AddCustomerToDatabase();
            hdnCustomerID.Value = newCustomer.CustomerID;

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
            //newVehicle.VehicleID = newVehicle.AddVehicleToDatabase();
            newVehicle.Stocknumber = txtStocknumber.Text;
            newVehicle.Description = txtDescription.Text;
            newVehicle.Sold = false;
            newVehicle.Active = true;
            newVehicle.ForSale = true;

            newVehicle.VehicleID = newVehicle.AddVehicleToDatabase();
            hdnVehicleID.Value = newVehicle.VehicleID;

            pnlVehicle.Visible = false;
            pnlConsignment.Visible = true;

            ViewState["Vehicle"] = newVehicle;
            
        }

        private void FillConsignment()
        {

            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            Consignment newConsignment = new Consignment();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM ConsignmentVehicleView WHERE customerref = @CustomerRef and VehicleRef = @VehicleRef";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);
            adapter.SelectCommand.Parameters.AddWithValue("@CustomerRef", hdnCustomerID.Value);
            adapter.SelectCommand.Parameters.AddWithValue("@VehicleRef", hdnVehicleID.Value);

            dataset = new DataSet();

            adapter.Fill(dataset);

            rblConsignments.DataSource = dataset;
            rblConsignments.DataTextField = "ConsignDate";
            rblConsignments.DataValueField = "ConsignmentID";
            rblConsignments.DataBind();

            connection.Close();
        }

        protected void SelectConsignment(object sender, EventArgs e)
        {
            hdnSaleID.Value = rblConsignments.SelectedItem.Value;

            hlkPrint.NavigateUrl = "ConsignmentAgreementForm.aspx?SaleID=" + hdnSaleID.Value;
            



            Consignment newConsignment = new Consignment();

            newConsignment = newConsignment.GetConsignment(rblConsignments.SelectedItem.Value);

            ViewState["Customer"] = newConsignment.Seller;
            ViewState["Vehicle"] = newConsignment.saleVehicle;
            ViewState["Consignment"] = newConsignment;

            hlkPrint.NavigateUrl = "ConsignmentAgreementForm.aspx?SaleID=" + rblConsignments.SelectedItem.Value;

            FillReview();

            pnlCustomer.Visible = false;
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

            //Sale newSale = new Sale();

            Consignment newConsignment = new Consignment();

            newConsignment.SaleVehicle = newVehicle;

            newConsignment.Seller = newCustomer;

            newConsignment.AskingPrice = Convert.ToDecimal(txtAskingPrice.Text);
            newConsignment.CustomerRef = newCustomer.CustomerID;
            newConsignment.ConsignDate = consignDate;
            newConsignment.ExpireDate = expireDate;
            newConsignment.LienHolder = txtLienHolder.Text;
            newConsignment.BalanceOwed = Convert.ToDecimal(txtBalanceOwed.Text);
            newConsignment.Status = "Active";
            newConsignment.VehicleRef = newConsignment.SaleVehicle.VehicleID;
            newConsignment.CustomerRef = newConsignment.Seller.CustomerID;
            newConsignment.DealType = rblDealType.SelectedItem.Text;
            newConsignment.DealCalc = Convert.ToDecimal(txtDealCalc.Text);
            newConsignment.Term = Convert.ToInt16(txtTerm.Text);

            hdnSaleID.Value = newConsignment.AddConsignmentToDatabase();
            hlkPrint.NavigateUrl = "ConsignmentAgreementForm.aspx?SaleID=" + hdnSaleID.Value;
            ViewState["Consignment"] = newConsignment;

            FillReview();
        }

        protected void SelectCurrentConsignment(object sender, CommandEventArgs e)
        {
            GetConsignment(e.CommandArgument.ToString());
        }

        private void GetConsignment(string saleID)
        {
            Consignment newConsignment = new Consignment();

            newConsignment = newConsignment.GetConsignment(saleID);

            ViewState["Customer"] = newConsignment.Seller;
            ViewState["Vehicle"] = newConsignment.saleVehicle;
            ViewState["Consignment"] = newConsignment;

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
            Consignment newConsignmnet = new Consignment();

            newCustomer = ViewState["Customer"] as Customer;
            newVehicle = ViewState["Vehicle"] as Vehicle;
            newConsignmnet = ViewState["Consignment"] as Consignment;
            
            if (newConsignmnet == null)
            {
                newConsignmnet = newConsignmnet.GetConsignment(rblConsignments.SelectedItem.Value);
            }

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

            lblSaleReviewSaleID.Text = newConsignmnet.ConsignmentID;
            lblSaleReviewAskingPrice.Text = newConsignmnet.AskingPrice.ToString("c");            

            lblSaleReviewBalanceOwed.Text = newConsignmnet.BalanceOwed.ToString("c");

            lblSaleReviewDealType.Text = newConsignmnet.DealType;
            lblSaleReviewConsignDate.Text = newConsignmnet.ConsignDate.ToShortDateString();
            lblSaleReviewExpireDate.Text = newConsignmnet.ExpireDate.ToShortDateString();

            lblDealCalc.Text = newConsignmnet.DealCalc.ToString();
            lblSaleReviewTerm.Text = newConsignmnet.Term.ToString();

            if (newConsignmnet.DealType == "Percent Deal")
            {
                rblEditDealType.Items[0].Selected = true;
            }
            if (newConsignmnet.DealType == "Excess of Deal")
            {
                rblEditDealType.Items[1].Selected = true;
            }
            if (newConsignmnet.DealType == "Flat Fee Deal")
            {
                rblEditDealType.Items[2].Selected = true;
            }

            chkFeatured.Checked = newVehicle.Featured;

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

            txtEditAskingPrice.Text = newConsignmnet.AskingPrice.ToString();

            txtEditConsignDate.Text = newConsignmnet.ConsignDate.ToShortDateString();
            txtEditTerm.Text = newConsignmnet.Term.ToString();
            
            if (String.IsNullOrEmpty(newConsignmnet.LienHolder))
            {
                txtEditLienHolder.Text = "None";
            }
            else
            {
                txtEditLienHolder.Text = newConsignmnet.LienHolder;
            }

            txtEditBalanceOwed.Text = newConsignmnet.BalanceOwed.ToString("c");
            txtEditDealCalc.Text = newConsignmnet.DealCalc.ToString();
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
            Consignment newConsignment = new Consignment();

            newConsignment = ViewState["Consignment"] as Consignment;

            if (e.CommandArgument.ToString() == "DealType")
            {
                newConsignment.UpdateConsignment("DealType", rblEditDealType.SelectedItem.Value);
            }
            else
            {
                TextBox newTextBox = new TextBox();

                newTextBox = pnlReview.FindControl("txtEdit" + e.CommandArgument) as TextBox;

                newConsignment.UpdateConsignment(e.CommandArgument.ToString(), newTextBox.Text);
            }            
            
            Response.Redirect("ConsignmentAgreement.aspx?SaleID=" + newConsignment.ConsignmentID);
            
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
            Consignment newConsignment = new Consignment();

            newConsignment = ViewState["Consignment"] as Consignment;

            Vehicle newVehicle = new Vehicle();
            newVehicle.VehicleID = newConsignment.saleVehicle.VehicleID;

            newVehicle.Stocknumber = txtEditStockNumber.Text;
            newVehicle.ModelYear = Convert.ToInt32(txtEditModelYear.Text);
            newVehicle.Make = txtEditMake.Text;
            newVehicle.Model = txtEditModel.Text;
            newVehicle.VIN = txtEditVIN.Text;
            newVehicle.RVType = rblEditVehicleType.SelectedItem.Text;
            newVehicle.Mileage = Convert.ToInt32(txtEditMileage.Text);
            newVehicle.Featured = chkFeatured.Checked;

            newVehicle.UpdateAll();
            newConsignment = newConsignment.GetConsignment(newConsignment.ConsignmentID);

            Response.Redirect("ConsignmentAgreement.aspx?SaleID=" + newConsignment.ConsignmentID);
        }

        
    }
}