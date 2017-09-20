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
    public partial class WorkOrder : System.Web.UI.Page
    {        
        protected void Page_Load(object sender, EventArgs e)
        {
            SetRecentList();

            if (!string.IsNullOrEmpty(hdnOrderNumber.Value))
            {
                FillReview();
            }
            else
            {
                if (!string.IsNullOrEmpty(Request.QueryString["OrderNumber"]))
                {
                    hdnOrderNumber.Value = Request.QueryString["OrderNumber"];
                    FillReview();
                    pnlReview.Visible = true;
                    pnlSelectCustomer.Visible = false;
                }
                else
                {
                    if (!Page.IsPostBack)
                    {

                        SqlConnection connection;
                        SqlDataAdapter adapter, adapter2;
                        DataSet dataset, dataset2;
                        string query, query2;

                        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

                        query = "SELECT CustomerID, ISNULL(LastName, ' ') + ', ' + ISNULL(FirstName, ' ') + '<br>' + ISNULL(Address, ' ') + '<br>' + ISNULL(City, ' ') + ', ' + ISNULL(State, ' ') + ' ' + ISNULL(Zip, ' ') + '<br>' + ISNULL(PhoneNumber, ' ') + ' ' + ISNULL(AltPhoneNumber, ' ') As Info FROM Customer ORDER BY LastName, FirstName";

                        connection.Open();

                        adapter = new SqlDataAdapter(query, connection);

                        dataset = new DataSet();

                        adapter.Fill(dataset);

                        rblCustomerList.DataSource = dataset;
                        rblCustomerList.DataValueField = "CustomerID";
                        rblCustomerList.DataTextField = "Info";
                        rblCustomerList.DataBind();

                        query2 = "select top 35 * from WorkOrderView order by ordernumber desc";
                        adapter2 = new SqlDataAdapter(query2, connection);

                        dataset2 = new DataSet();

                        adapter2.Fill(dataset2);

                        rptRecentOrders.DataSource = dataset2;
                        rptRecentOrders.DataBind();

                        connection.Close();
                    }


                }
            }
            
            
        }

        private void SetRecentList()
        {
            SqlConnection connection;
            SqlDataAdapter adapter2;
            DataSet dataset2;
            string query2;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);
                        
            connection.Open();
            
            query2 = "select top 15 * from WorkOrderView order by ordernumber desc";
            adapter2 = new SqlDataAdapter(query2, connection);

            dataset2 = new DataSet();

            adapter2.Fill(dataset2);

            rptRecentOrders.DataSource = dataset2;
            rptRecentOrders.DataBind();

            connection.Close();
        }
        
        protected void SelectCustomer(object sender, EventArgs e)
        {
            hdnCustomerID.Value = rblCustomerList.SelectedItem.Value;

            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT VehicleID, CONVERT(varchar(10), ModelYear) + ' ' + Make + ' ' + Model + '<br>' + vehicletype +'<br>VIN: ' + VIN AS Info  FROM Vehicle WHERE CustomerRef = " + hdnCustomerID.Value;

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);

            dataset = new DataSet();

            adapter.Fill(dataset);

            rblVehicleList.DataSource = dataset;
            rblVehicleList.DataValueField = "VehicleID";
            rblVehicleList.DataTextField = "Info";
            rblVehicleList.DataBind();

            connection.Close();

            pnlVehicle.Visible = true;
            pnlSelectCustomer.Visible = false;

            fillUpdateCustomer();


        }

        protected void SelectVehicle(object sender, EventArgs e)
        {
            hdnVehicleID.Value = rblVehicleList.SelectedItem.Value;

            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT OrderNumber, 'Order Number: ' + CONVERT(varchar(10), OrderNumber) + '<br>Date Ordered: ' + CONVERT(varchar(255), DateOrdered) + '<br>Order Taken By: ' + OrderTakenBy As Info  FROM WorkOrder WHERE CustomerRef = " + hdnCustomerID.Value + " and vehicleref = " + hdnVehicleID.Value;

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);

            dataset = new DataSet();

            adapter.Fill(dataset);

            rblWorkOrderList.DataSource = dataset;
            rblWorkOrderList.DataValueField = "OrderNumber";
            rblWorkOrderList.DataTextField = "Info";
            rblWorkOrderList.DataBind();

            connection.Close();

            pnlVehicle.Visible = false;
            pnlWorkOder.Visible = true;

            fillUpdateVehicle();

        }

        protected void AddCustomer(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlCommand command;
            string query, result;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "Insert into Customer(FirstName, LastName, Address, City, State, Zip, PhoneNumber, AltPhoneNumber) Values(@FirstName, @LastName, @Address, @City, @State, @Zip, @Phone, @AltPhone) Select Scope_Identity()";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@FirstName", FirstName.Text);
            command.Parameters.AddWithValue("@LastName", LastName.Text);
            command.Parameters.AddWithValue("@Address", Address.Text);
            command.Parameters.AddWithValue("@City", City.Text);
            command.Parameters.AddWithValue("@State", State.Text);
            command.Parameters.AddWithValue("@Zip", Zip.Text);
            command.Parameters.AddWithValue("@Phone", Phone.Text);
            command.Parameters.AddWithValue("@AltPhone", AltPhone.Text);

            result = command.ExecuteScalar().ToString();

            hdnCustomerID.Value = result;

            connection.Close();

            pnlVehicle.Visible = true;
            pnlSelectCustomer.Visible = false;

            fillUpdateCustomer();

        }

        protected void AddVehicle(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlCommand command;
            string query, result;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "Insert into Vehicle(ModelYear, Make, Model, VIN, VehicleType, Mileage, CustomerRef) Values(@ModelYear, @Make, @Model, @VIN, @VehicleType, @Mileage, @CustomerRef) Select Scope_Identity()";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@ModelYear", ModelYear.Text);
            command.Parameters.AddWithValue("@Make", Make.Text);
            command.Parameters.AddWithValue("@Model", Model.Text);
            command.Parameters.AddWithValue("@VIN", VIN.Text);
            command.Parameters.AddWithValue("@Mileage", Mileage.Text);
            command.Parameters.AddWithValue("@VehicleType", rblVehicleType.SelectedItem.Text);
            command.Parameters.AddWithValue("@CustomerRef", hdnCustomerID.Value);
            result = command.ExecuteScalar().ToString();

            hdnVehicleID.Value = result;

            connection.Close();

            pnlVehicle.Visible = false;
            pnlWorkOder.Visible = true;

            fillUpdateVehicle();
        }

        protected void SelectRecentWorkOrder(object sender, CommandEventArgs e)
        {
            hdnOrderNumber.Value = e.CommandArgument.ToString();
            FillReview();
            pnlWorkOder.Visible = false;
            pnlSelectCustomer.Visible = false;
            pnlReview.Visible = true;
        }

        protected void SelectWorkOrder(object sender, EventArgs e)
        {
            hdnOrderNumber.Value = rblWorkOrderList.SelectedItem.Value;
            FillReview();
            pnlWorkOder.Visible = false;
            pnlReview.Visible = true;
        }

        protected void AddWorkOrder(object sender, EventArgs e)
        {
            string orderNumber;

            WorkOrderInfo workOrderInfo = new WorkOrderInfo();
            workOrderInfo.CustomerRef = Convert.ToInt32(hdnCustomerID.Value);
            workOrderInfo.VehicleRef = Convert.ToInt32(hdnVehicleID.Value);
            workOrderInfo.TakenBy = TakenBy.Text;
            workOrderInfo.Mileage = Convert.ToInt32(OrderMileage.Text);
            workOrderInfo.ExemptMaterial = MaterialExempt.Checked;
            workOrderInfo.ExemptLabor = LaborExempt.Checked;
            workOrderInfo.DateOrdered = Convert.ToDateTime(DateOrdered.Text);


            orderNumber = workOrderInfo.AddWorkOrderToDatabase();

            hdnOrderNumber.Value = orderNumber;

            decimal jobTotal = 0;

            for (int i = 1; i <= 6; i++)
            {
                TextBox jobDescription, jobRate, jobHours = new TextBox();

                jobDescription = pnlWorkOder.FindControl("Job" + i) as TextBox;
                jobRate = pnlWorkOder.FindControl("Rate" + i) as TextBox;
                jobHours = pnlWorkOder.FindControl("hours" + i) as TextBox;

                Job job = new Job();


                if (!string.IsNullOrEmpty(jobDescription.Text))
                {
                    job.WorkOrderRef = Convert.ToInt32(hdnOrderNumber.Value);
                    job.JobDescription = jobDescription.Text;
                    job.JobRate = Convert.ToDecimal(jobRate.Text);
                    job.JobHours = Convert.ToDecimal(jobHours.Text);
                    job.AddJobToDatabase();
                    jobTotal += job.JobAmount;
                }
                else
                {
                    break;
                }
            }

            decimal materialTotal = 0;

            for (int j = 1; j <= 6; j++)
            {
                TextBox materialDescription, materialQuantity, materialPrice = new TextBox();

                materialDescription = pnlWorkOder.FindControl("Material" + j) as TextBox;
                materialQuantity = pnlWorkOder.FindControl("Quantity" + j) as TextBox;
                materialPrice = pnlWorkOder.FindControl("MaterialPrice" + j) as TextBox;

                Material material = new Material();

                if (!string.IsNullOrEmpty(materialDescription.Text))
                {
                    material.WorkOrderRef = Convert.ToInt32(hdnOrderNumber.Value);
                    material.MaterialDescription = materialDescription.Text;
                    material.MaterialQuantity = Convert.ToDecimal(materialQuantity.Text);
                    material.MaterialPrice = Convert.ToDecimal(materialPrice.Text);
                    material.AddMaterialToDatabase();
                    materialTotal += material.MaterialAmount;
                }
                else
                {
                    break;
                }
            }

            decimal miscellaneousTotal = 0;

            for (int k = 1; k <= 6; k++)
            {
                TextBox miscellaneousDescription, miscellaneousPrice = new TextBox();

                miscellaneousDescription = pnlWorkOder.FindControl("Miscellaneous" + k) as TextBox;
                miscellaneousPrice = pnlWorkOder.FindControl("MiscellaneousPrice" + k) as TextBox;

                Miscellaneous miscellaneous = new Miscellaneous();

                if (!string.IsNullOrEmpty(miscellaneousDescription.Text))
                {
                    miscellaneous.WorkOrderRef = Convert.ToInt32(hdnOrderNumber.Value);
                    miscellaneous.MiscellaneousDescription = miscellaneousDescription.Text;
                    miscellaneous.MiscellaneousAmount = Convert.ToDecimal(miscellaneousPrice.Text);
                    miscellaneous.AddMiscellaneousToDatabase();
                    miscellaneousTotal += miscellaneous.MiscellaneousAmount;
                }
                else
                {
                    break;
                }
            }

            workOrderInfo.OrderNumber = orderNumber;
            workOrderInfo.JobTotal = jobTotal;
            workOrderInfo.MaterialTotal = materialTotal;
            workOrderInfo.MiscellaneousTotal = miscellaneousTotal;

            workOrderInfo.UpdateWOrkOrder();

            pnlWorkOder.Visible = false;
            pnlReview.Visible = true;

            FillReview();

        }

        private void FillReview()
        {            
            WorkOrderInfo workOderInfo = new WorkOrderInfo();
            DataSet jobSet, materialSet, miscellaneousSet;

            workOderInfo = workOderInfo.GetWorkOrderInfo(hdnOrderNumber.Value.ToString());
            plhReview.Controls.Add(new LiteralControl("<div class='row'><div class='col-sm-6'>"));

            plhReview.Controls.Add(new LiteralControl("<h1>" + workOderInfo.CustomerName + "<br>" + workOderInfo.VehicleInfo + "</h1>"));
            plhReview.Controls.Add(new LiteralControl("<table>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Order Number:</strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.OrderNumber + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Date Ordered:</strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.DateOrdered.ToString("d") + "</td>"));            
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Mileage:</strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.Mileage + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Order Taken By:</strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.TakenBy + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td colspan=2><hr></td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Materials Tax Exempt:</strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.ExemptMaterial.ToString() + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Labor Tax Exempt:</strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.ExemptLabor.ToString() + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td colspan=2><hr></td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Job Total: </strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.JobTotal.ToString("C") + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Material Total: </strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.MaterialTotal.ToString("C") + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Miscellaneous Total: </strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.MiscellaneousTotal.ToString("C") + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Subtotal: </strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.SubTotal.ToString("C") + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Sales Tax: </strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.SalesTax.ToString("C") + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td><strong>Grand Total: </strong></td>"));
            plhReview.Controls.Add(new LiteralControl("<td align='right'>" + workOderInfo.GrandTotal.ToString("C") + "</td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));

            plhReview.Controls.Add(new LiteralControl("</table>"));
            plhReview.Controls.Add(new LiteralControl("</div>"));
            plhReview.Controls.Add(new LiteralControl("<div class='col-sm-6'>"));
            plhReview.Controls.Add(new LiteralControl("<a href='workorderform?OrderNumber=" + workOderInfo.OrderNumber + "' target='_blank'><h3><span class='glyphicon glyphicon-print' aria-hidden='true'></span> Printable Version</h3></a>"));
            plhReview.Controls.Add(new LiteralControl("</div>"));
            plhReview.Controls.Add(new LiteralControl("</div>"));


            plhReview.Controls.Add(new LiteralControl("<table>"));

            jobSet = workOderInfo.GetJobRecords();
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td colspan=6><h3><a href=\"javascript: toggleDiv('trAddJob'); \"><span class=\"glyphicon glyphicon-plus\"></span></span>Jobs</a></h3></td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<th>Job ID</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>OrderRef</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Description</th>"));            
            plhReview.Controls.Add(new LiteralControl("<th>Rate</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Hours</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Amount</th>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));

            foreach (DataTable table in jobSet.Tables)
            {
                foreach (DataRow row in table.Rows)
                {
                   plhReview.Controls.Add(new LiteralControl("<tr>"));
                   plhReview.Controls.Add(new LiteralControl("<td valign='top'><a data-toggle='modal' data-target='#jobModal" + row["JobID"] + "'><span class='glyphicon glyphicon-remove-circle' aria-hidden='true'></span></a> " + row["JobID"].ToString() + "</td>"));


                    plhReview.Controls.Add(new LiteralControl("<div id='jobModal" + row["JobID"] + "' class='modal fade' role='dialog'><div class='modal-dialog'><div class='modal-content'><div class='modal-header'><button type='button' class='close' data-dismiss='modal'>&times;</button><h4 class='modal-title'>Confirm Delete</h4></div><div class='modal-body'><p>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Job ID:</strong> " + row["JobID"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Description:</strong> " + row["JobDescription"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Rate:</strong> " + row["JobRate"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Hours:</strong> " + row["JobHours"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Amount:</strong> " + row["JobAmount"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("</p>"));

                    plhReview.Controls.Add(new LiteralControl("</div><div class='modal-footer'>"));

                    LinkButton deleteJob = new LinkButton();
                    deleteJob.CommandArgument = row["JobID"].ToString();
                    deleteJob.Command += new CommandEventHandler(DeleteJob);
                    deleteJob.Text = "Delete";
                    deleteJob.CssClass = "redButton";

                    plhReview.Controls.Add(new LiteralControl("<span class='redbutton'>"));
                    plhReview.Controls.Add(deleteJob);
                    plhReview.Controls.Add(new LiteralControl("</span>"));

                    plhReview.Controls.Add(new LiteralControl(" <button type='button' class='btn btn-default' data-dismiss='modal' data-target='#jobModal" + row["JobID"] + "'>Cancel</button></div></div></div></div>"));

                    plhReview.Controls.Add(new LiteralControl("</td>"));

                   plhReview.Controls.Add(new LiteralControl("<td valign='top'>" + row["WorkOrderRef"].ToString() + "</td>"));
                   plhReview.Controls.Add(new LiteralControl("<td valign='top'><a href=\"javascript: toggleDiv('divJobDescription" + row["JobID"] + "'); \"><span class=\"glyphicon glyphicon-edit\"></span></a>" + row["JobDescription"].ToString()));
                    plhReview.Controls.Add(new LiteralControl("<div id='divJobDescription" + row["JobID"] + "' style='display: none'>"));

                    TextBox jobDescription = new TextBox();
                    jobDescription.ID = "jobDescription" + row["JobID"];
                    jobDescription.Text = row["JobDescription"].ToString();
                    jobDescription.CssClass = "form-control";
                    jobDescription.TextMode = TextBoxMode.MultiLine;
                    plhReview.Controls.Add(jobDescription);

                    LinkButton updateJob = new LinkButton();
                    updateJob.Text = "Update Job";
                    updateJob.Command += new CommandEventHandler(UpdateJob);
                    updateJob.CommandArgument = row["JobID"].ToString();
                    plhReview.Controls.Add(updateJob);

                    plhReview.Controls.Add(new LiteralControl("</div></td>"));

                    plhReview.Controls.Add(new LiteralControl("<td valign='top'><a href=\"javascript: toggleDiv('divJobRate" + row["JobID"] + "'); \"><span class=\"glyphicon glyphicon-edit\"></span></a>" + row["JobRate"].ToString()));
                    plhReview.Controls.Add(new LiteralControl("<div id='divJobRate" + row["JobID"] + "' style='display: none'>"));

                    TextBox jobRate = new TextBox();
                    jobRate.ID = "jobRate" + row["JobID"];
                    jobRate.Text = row["JobRate"].ToString();
                    jobRate.CssClass = "form-control";
                    plhReview.Controls.Add(jobRate);

                    LinkButton updateJob3 = new LinkButton();
                    updateJob3.CommandArgument = row["JobID"].ToString();
                    updateJob3.Text = "update job";
                    updateJob3.Command += new CommandEventHandler(UpdateJob);
                    plhReview.Controls.Add(updateJob3);

                    plhReview.Controls.Add(new LiteralControl("</div></td>"));

                    plhReview.Controls.Add(new LiteralControl("<td valign='top'><a href=\"javascript: toggleDiv('divJobHours" + row["JobID"] + "'); \"><span class=\"glyphicon glyphicon-edit\"></span></a>" + row["JobHours"].ToString()));
                    plhReview.Controls.Add(new LiteralControl("<div id='divJobHours" + row["JobID"] + "' style='display: none'>"));
                    
                    TextBox jobHours = new TextBox();
                    jobHours.ID = "jobHours" + row["JobID"];
                    jobHours.Text = row["JobHours"].ToString();
                    jobHours.CssClass = "form-control";
                    plhReview.Controls.Add(jobHours);

                    LinkButton updateJob2 = new LinkButton();
                    updateJob2.CommandArgument = row["JobID"].ToString();
                    updateJob2.Text = "update job";
                    updateJob2.Command += new CommandEventHandler(UpdateJob);
                    plhReview.Controls.Add(updateJob2);

                    plhReview.Controls.Add(new LiteralControl("</div></td>"));
                    
                    plhReview.Controls.Add(new LiteralControl("<td valign='top' align='right'>" + row["JobAmount"] + "</td>"));
                   plhReview.Controls.Add(new LiteralControl("</tr>"));
                    
                }
            }

            plhReview.Controls.Add(new LiteralControl("<tr id='trAddJob' style='display: none'>"));
            plhReview.Controls.Add(new LiteralControl("<td colspan='2'><br>"));

            Button addJob = new Button();
            addJob.Text = "Add New Job";
            addJob.Click += new EventHandler(AddJob);
            addJob.CssClass = "btn btn-default";
            plhReview.Controls.Add(addJob);
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("<td>"));
            plhReview.Controls.Add(new LiteralControl("<label for='addJobDescription'>Description</label>"));
            TextBox addJobDescription = new TextBox();
            addJobDescription.ID = "addJobDescription";
            addJobDescription.CssClass = "form-control";
            addJobDescription.TextMode = TextBoxMode.MultiLine;
            plhReview.Controls.Add(addJobDescription);
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("<td>"));
            plhReview.Controls.Add(new LiteralControl("<label for='addJobRate'>Rate</label>"));
            TextBox addJobRate = new TextBox();
            addJobRate.ID = "addJobRate";
            addJobRate.CssClass = "form-control";
            addJobRate.Text = "99.50";
            plhReview.Controls.Add(addJobRate);
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("<td>"));
            plhReview.Controls.Add(new LiteralControl("<label for='addJobHours'>Hours</label>"));
            TextBox addJobHours = new TextBox();
            addJobHours.ID = "addJobHours";
            addJobHours.CssClass = "form-control";
            plhReview.Controls.Add(addJobHours);
            plhReview.Controls.Add(new LiteralControl("</td>"));            

            plhReview.Controls.Add(new LiteralControl("</tr>"));

            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<th colspan='5'>Job Total: </th><th align='right'>" + workOderInfo.JobTotal.ToString("C") + "</th>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            
            materialSet = workOderInfo.GetMaterialRecords();

            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td colspan=6><h3><a href=\"javascript: toggleDiv('trAddMaterial'); \"><span class=\"glyphicon glyphicon-plus\">Materials</h3></td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<th>Material ID</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Order Ref</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Description</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Quantity</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Price Ea.</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Amount</th>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));

            foreach (DataTable table in materialSet.Tables)
            {
                foreach (DataRow row in table.Rows)
                {
                    plhReview.Controls.Add(new LiteralControl("<tr>"));
                    plhReview.Controls.Add(new LiteralControl("<td valign='top'><a data-toggle='modal' data-target='#materialModal" + row["MaterialID"] + "'><span class='glyphicon glyphicon-remove-circle' aria-hidden='true'></span></a> " + row["MaterialID"].ToString() + "</td>"));
                    
                    plhReview.Controls.Add(new LiteralControl("<div id='materialModal" + row["MaterialID"] + "' class='modal fade' role='dialog'><div class='modal-dialog'><div class='modal-content'><div class='modal-header'><button type='button' class='close' data-dismiss='modal'>&times;</button><h4 class='modal-title'>Confirm Delete</h4></div><div class='modal-body'><p>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Material ID:</strong> " + row["MaterialID"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Description:</strong> " + row["MaterialDescription"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Quantity:</strong> " + row["MaterialQuantity"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Price:</strong> " + row["MaterialPrice"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Amount:</strong> " + row["MaterialAmount"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("</p>"));

                    plhReview.Controls.Add(new LiteralControl("</div><div class='modal-footer'>"));

                    LinkButton deleteMaterial = new LinkButton();
                    deleteMaterial.CommandArgument = row["MaterialID"].ToString();
                    deleteMaterial.Command += new CommandEventHandler(DeleteMaterial);
                    deleteMaterial.Text = "Delete";
                    deleteMaterial.CssClass = "redButton";

                    plhReview.Controls.Add(new LiteralControl("<span class='redbutton'>"));
                    plhReview.Controls.Add(deleteMaterial);
                    plhReview.Controls.Add(new LiteralControl("</span>"));

                    plhReview.Controls.Add(new LiteralControl(" <button type='button' class='btn btn-default' data-dismiss='modal' data-target='#materialModal" + row["MaterialID"] + "'>Cancel</button></div></div></div></div>"));

                    plhReview.Controls.Add(new LiteralControl("</td>"));
                    
                    plhReview.Controls.Add(new LiteralControl("<td valign='top'>" + row["WorkOrderRef"].ToString() + "</td>"));
                    plhReview.Controls.Add(new LiteralControl("<td valign='top'><a href=\"javascript: toggleDiv('divMaterialDescription" + row["MaterialID"] + "'); \"><span class=\"glyphicon glyphicon-edit\"></span></a>" + row["MaterialDescription"].ToString()));
                    plhReview.Controls.Add(new LiteralControl("<div id='divMaterialDescription" + row["MaterialID"] + "' style='display: none'>"));

                    TextBox materialDescription = new TextBox();
                    materialDescription.ID = "materialDescription" + row["MaterialID"];
                    materialDescription.Text = row["materialDescription"].ToString();
                    materialDescription.CssClass = "form-control";
                    materialDescription.TextMode = TextBoxMode.MultiLine;
                    plhReview.Controls.Add(materialDescription);

                    LinkButton updateMaterial = new LinkButton();
                    updateMaterial.Text = "Update Material";
                    updateMaterial.Command += new CommandEventHandler(UpdateMaterial);
                    updateMaterial.CommandArgument = row["MaterialID"].ToString();
                    plhReview.Controls.Add(updateMaterial);
                    
                    plhReview.Controls.Add(new LiteralControl("</div></td>"));
                    plhReview.Controls.Add(new LiteralControl("<td valign='top'><a href=\"javascript: toggleDiv('divMaterialQuantity" + row["MaterialID"] + "'); \"><span class=\"glyphicon glyphicon-edit\"></span></a>" + row["MaterialQuantity"].ToString()));
                    plhReview.Controls.Add(new LiteralControl("<div id='divMaterialQuantity" + row["MaterialID"] + "' style='display: none'>"));

                    TextBox materialQuantity = new TextBox();
                    materialQuantity.ID = "materialQuantity" + row["MaterialID"];
                    materialQuantity.Text = row["materialQuantity"].ToString();
                    materialQuantity.CssClass = "form-control";
                    plhReview.Controls.Add(materialQuantity);

                    LinkButton updateMaterial2 = new LinkButton();
                    updateMaterial2.Text = "Update Material";
                    updateMaterial2.Command += new CommandEventHandler(UpdateMaterial);
                    updateMaterial2.CommandArgument = row["MaterialID"].ToString();
                    plhReview.Controls.Add(updateMaterial2);

                    plhReview.Controls.Add(new LiteralControl("</div></td>"));
                    plhReview.Controls.Add(new LiteralControl("<td valign='top'><a href=\"javascript: toggleDiv('divMaterialPrice" + row["MaterialID"] + "'); \"><span class=\"glyphicon glyphicon-edit\"></span></a>" + row["MaterialPrice"].ToString()));
                    plhReview.Controls.Add(new LiteralControl("<div id='divMaterialPrice" + row["MaterialID"] + "' style='display: none'>"));

                    TextBox materialPrice = new TextBox();
                    materialPrice.ID = "materialPrice" + row["MaterialID"];
                    materialPrice.Text = row["materialPrice"].ToString();
                    materialPrice.CssClass = "form-control";
                    plhReview.Controls.Add(materialPrice);

                    LinkButton updateMaterial3 = new LinkButton();
                    updateMaterial3.Text = "Update Material";
                    updateMaterial3.Command += new CommandEventHandler(UpdateMaterial);
                    updateMaterial3.CommandArgument = row["MaterialID"].ToString();
                    plhReview.Controls.Add(updateMaterial3);

                    plhReview.Controls.Add(new LiteralControl("</div></td>"));
                    plhReview.Controls.Add(new LiteralControl("<td valign='top' align='right'>" + row["MaterialAmount"].ToString() + "</td>"));
                    plhReview.Controls.Add(new LiteralControl("</tr>"));
                    
                }
            }
            
            plhReview.Controls.Add(new LiteralControl("<tr id='trAddMaterial' style='display: none'>"));
            plhReview.Controls.Add(new LiteralControl("<td colspan='2'><br>"));

            Button addMaterial = new Button();
            addMaterial.Text = "Add New Material";
            addMaterial.Click += new EventHandler(AddMaterial);
            addMaterial.CssClass = "btn btn-default";
            plhReview.Controls.Add(addMaterial);
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("<td>"));
            plhReview.Controls.Add(new LiteralControl("<label for='addMaterialDescription'>Description</label>"));
            TextBox addMaterialDescription = new TextBox();
            addMaterialDescription.ID = "addMaterialDescription";
            addMaterialDescription.CssClass = "form-control";
            addMaterialDescription.TextMode = TextBoxMode.MultiLine;
            plhReview.Controls.Add(addMaterialDescription);
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("<td>"));
            plhReview.Controls.Add(new LiteralControl("<label for='addMaterialQuantity'>Quantity</label>"));
            TextBox addMaterialQuantity = new TextBox();
            addMaterialQuantity.ID = "addMaterialQuantity";
            addMaterialQuantity.CssClass = "form-control";            
            plhReview.Controls.Add(addMaterialQuantity);
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("<td>"));
            plhReview.Controls.Add(new LiteralControl("<label for='addMaterialPrice'>Price</label>"));
            TextBox addMaterialPrice = new TextBox();
            addMaterialPrice.ID = "addMaterialPrice";
            addMaterialPrice.CssClass = "form-control";
            plhReview.Controls.Add(addMaterialPrice);
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("</tr>"));

            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<th colspan='5'>Material Total: </th><th align='right'>" + workOderInfo.MaterialTotal.ToString("C") + "</th>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            
            miscellaneousSet = workOderInfo.GetMiscellaneousRecords();

            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<td colspan=6><h3><a href=\"javascript: toggleDiv('trAddMiscellaneous'); \"><span class=\"glyphicon glyphicon-plus\">Miscellaneous</h3></td>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<th>Miscellaneous ID</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Order Ref</th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Description</th>"));
            plhReview.Controls.Add(new LiteralControl("<th></th>"));
            plhReview.Controls.Add(new LiteralControl("<th></th>"));
            plhReview.Controls.Add(new LiteralControl("<th>Amount</th>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));

            foreach (DataTable table in miscellaneousSet.Tables)
            {
                foreach (DataRow row in table.Rows)
                {
                    plhReview.Controls.Add(new LiteralControl("<tr>"));
                    plhReview.Controls.Add(new LiteralControl("<td valign='top'><a data-toggle='modal' data-target='#miscellaneousModal" + row["MiscellaneousID"] + "'><span class='glyphicon glyphicon-remove-circle' aria-hidden='true'></span></a> " + row["MiscellaneousID"].ToString() + "</td>"));
                    
                    plhReview.Controls.Add(new LiteralControl("<div id='miscellaneousModal" + row["MiscellaneousID"] + "' class='modal fade' role='dialog'><div class='modal-dialog'><div class='modal-content'><div class='modal-header'><button type='button' class='close' data-dismiss='modal'>&times;</button><h4 class='modal-title'>Confirm Delete</h4></div><div class='modal-body'><p>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Material ID:</strong> " + row["MiscellaneousID"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Description:</strong> " + row["MiscellaneousDescription"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("<strong>Amount:</strong> " + row["MiscellaneousAmount"] + "<br>"));
                    plhReview.Controls.Add(new LiteralControl("</p>"));

                    plhReview.Controls.Add(new LiteralControl("</div><div class='modal-footer'>"));

                    LinkButton deleteMiscellaneous = new LinkButton();
                    deleteMiscellaneous.CommandArgument = row["miscellaneousID"].ToString();
                    deleteMiscellaneous.Command += new CommandEventHandler(DeleteMiscellaneous);
                    deleteMiscellaneous.Text = "Delete";
                    deleteMiscellaneous.CssClass = "redButton";

                    plhReview.Controls.Add(new LiteralControl("<span class='redbutton'>"));
                    plhReview.Controls.Add(deleteMiscellaneous);
                    plhReview.Controls.Add(new LiteralControl("</span>"));

                    plhReview.Controls.Add(new LiteralControl(" <button type='button' class='btn btn-default' data-dismiss='modal' data-target='#miscellaneousModal" + row["MiscellaneousID"] + "'>Cancel</button></div></div></div></div>"));

                    plhReview.Controls.Add(new LiteralControl("</td>"));
                    
                    plhReview.Controls.Add(new LiteralControl("<td valign='top'>" + row["WorkOrderRef"].ToString() + "</td>"));
                    plhReview.Controls.Add(new LiteralControl("<td valign='top'><a href=\"javascript: toggleDiv('divMiscellaneousDescription" + row["MiscellaneousID"] + "'); \"><span class=\"glyphicon glyphicon-edit\"></span></a>" + row["MiscellaneousDescription"].ToString()));
                    plhReview.Controls.Add(new LiteralControl("<div id='divMiscellaneousDescription" + row["MiscellaneousID"] + "' style='display: none'>"));

                    TextBox miscellaneousDescription = new TextBox();
                    miscellaneousDescription.ID = "miscellaneousDescription" + row["MiscellaneousID"];
                    miscellaneousDescription.Text = row["miscellaneousDescription"].ToString();
                    miscellaneousDescription.CssClass = "form-control";
                    miscellaneousDescription.TextMode = TextBoxMode.MultiLine;
                    plhReview.Controls.Add(miscellaneousDescription);

                    LinkButton updateMiscellaneous = new LinkButton();
                    updateMiscellaneous.Text = "Update Miscellaneous";
                    updateMiscellaneous.Command += new CommandEventHandler(UpdateMiscellaneous);
                    updateMiscellaneous.CommandArgument = row["MiscellaneousID"].ToString();
                    plhReview.Controls.Add(updateMiscellaneous);

                    plhReview.Controls.Add(new LiteralControl("</div></td>"));
                    plhReview.Controls.Add(new LiteralControl("<td valign='top'></td>"));
                    plhReview.Controls.Add(new LiteralControl("<td valign='top'></td>"));
                    plhReview.Controls.Add(new LiteralControl("<td valign='top' align='right'><a href=\"javascript: toggleDiv('divMiscellaneousAmount" + row["MiscellaneousID"] + "'); \"><span class=\"glyphicon glyphicon-edit\"></span></a>" + row["Miscellaneousamount"].ToString()));
                    plhReview.Controls.Add(new LiteralControl("<div id='divMiscellaneousAmount" + row["MiscellaneousID"] + "' style='display: none'>"));

                    TextBox miscellaneousAmount = new TextBox();
                    miscellaneousAmount.ID = "miscellaneousAmount" + row["MiscellaneousID"];
                    miscellaneousAmount.Text = row["miscellaneousAmount"].ToString();
                    miscellaneousAmount.CssClass = "form-control";
                    plhReview.Controls.Add(miscellaneousAmount);

                    LinkButton updateMiscellaneous2 = new LinkButton();
                    updateMiscellaneous2.Text = "Update Miscellaneous";
                    updateMiscellaneous2.Command += new CommandEventHandler(UpdateMiscellaneous);
                    updateMiscellaneous2.CommandArgument = row["MiscellaneousID"].ToString();
                    plhReview.Controls.Add(updateMiscellaneous2);

                    plhReview.Controls.Add(new LiteralControl("</div></td>"));
                    plhReview.Controls.Add(new LiteralControl("</tr>"));

                }
            }
            
            plhReview.Controls.Add(new LiteralControl("<tr id='trAddMiscellaneous' style='display: none'>"));
            plhReview.Controls.Add(new LiteralControl("<td colspan='2'><br>"));

            Button addMiscellaneous = new Button();
            addMiscellaneous.Text = "Add New Miscellaneous";
            addMiscellaneous.Click += new EventHandler(AddMiscellaneous);
            addMiscellaneous.CssClass = "btn btn-default";
            plhReview.Controls.Add(addMiscellaneous);
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("<td>"));
            plhReview.Controls.Add(new LiteralControl("<label for='addMiscellaneousDescription '>Description</label>"));
            TextBox addMiscellaneousDescription = new TextBox();
            addMiscellaneousDescription.ID = "addMiscellaneousDescription";
            addMiscellaneousDescription.CssClass = "form-control";
            addMiscellaneousDescription.TextMode = TextBoxMode.MultiLine;
            plhReview.Controls.Add(addMiscellaneousDescription);
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("<td>"));
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("<td>"));
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("<td>"));
            plhReview.Controls.Add(new LiteralControl("<label for='addMiscellaneousAmount'>Amount</label>"));
            TextBox addMiscellaneousAmount = new TextBox();
            addMiscellaneousAmount.ID = "addMiscellaneousAmount";
            addMiscellaneousAmount.CssClass = "form-control";
            plhReview.Controls.Add(addMiscellaneousAmount);
            plhReview.Controls.Add(new LiteralControl("</td>"));

            plhReview.Controls.Add(new LiteralControl("</tr>"));

            plhReview.Controls.Add(new LiteralControl("<tr>"));
            plhReview.Controls.Add(new LiteralControl("<th colspan='5'>Miscellaneous Total: </th><th align='right'>" + workOderInfo.MiscellaneousTotal.ToString("C") + "</th>"));
            plhReview.Controls.Add(new LiteralControl("</tr>"));
            
            plhReview.Controls.Add(new LiteralControl("</table>"));

        }

        private void UpdateJob(object sender, CommandEventArgs e)
        {
            TextBox jobRate = new TextBox();
            TextBox jobHours = new TextBox();
            TextBox jobDescription = new TextBox();

            jobRate = plhReview.FindControl("jobRate" + e.CommandArgument) as TextBox;
            jobHours = plhReview.FindControl("jobHours" + e.CommandArgument) as TextBox;
            jobDescription = plhReview.FindControl("jobDescription" + e.CommandArgument) as TextBox;

            Job newJob = new Job();

            newJob.JobID = e.CommandArgument.ToString();
            newJob.JobRate = Convert.ToDecimal(jobRate.Text);
            newJob.JobHours = Convert.ToDecimal(jobHours.Text);
            newJob.JobDescription = jobDescription.Text;

            newJob.UpdateJobDatabase();

            Response.Redirect("WorkOrder.aspx?OrderNumber=" + hdnOrderNumber.Value);
            
        }

        private void UpdateMaterial(object sender, CommandEventArgs e)
        {
            TextBox materialQuantity = new TextBox();
            TextBox materialPrice = new TextBox();
            TextBox materialDescription = new TextBox();

            materialQuantity = plhReview.FindControl("materialQuantity" + e.CommandArgument) as TextBox;
            materialPrice = plhReview.FindControl("materialPrice" + e.CommandArgument) as TextBox;
            materialDescription = plhReview.FindControl("materialDescription" + e.CommandArgument) as TextBox;

            Material newMaterial = new Material();

            newMaterial.MaterialID = e.CommandArgument.ToString();
            newMaterial.MaterialQuantity = Convert.ToDecimal(materialQuantity.Text);
            newMaterial.MaterialPrice = Convert.ToDecimal(materialPrice.Text);
            newMaterial.MaterialDescription = materialDescription.Text;

            newMaterial.UpdateMaterialDatabase();
            
            Response.Redirect("WorkOrder.aspx?OrderNumber=" + hdnOrderNumber.Value);

        }

        private void UpdateMiscellaneous(object sender, CommandEventArgs e)
        {            
            TextBox miscellaneousAmount = new TextBox();
            TextBox miscellaneousDescription = new TextBox();

            miscellaneousAmount = plhReview.FindControl("miscellaneousAmount" + e.CommandArgument) as TextBox;
            miscellaneousDescription = plhReview.FindControl("miscellaneousDescription" + e.CommandArgument) as TextBox;

            Miscellaneous newMiscellaneous = new Miscellaneous();

            newMiscellaneous.MiscellaneousID = e.CommandArgument.ToString();
            newMiscellaneous.MiscellaneousAmount= Convert.ToDecimal(miscellaneousAmount.Text);
            newMiscellaneous.MiscellaneousDescription = miscellaneousDescription.Text;

            newMiscellaneous.UpdateMiscellaneousDatabase();

            Response.Redirect("WorkOrder.aspx?OrderNumber=" + hdnOrderNumber.Value);

        }

        protected void AddJob(object sender, EventArgs e)
        {
            TextBox jobDescription = new TextBox();
            TextBox jobRate = new TextBox();
            TextBox jobHours = new TextBox();

            jobDescription = plhReview.FindControl("addJobDescription") as TextBox;
            jobRate = plhReview.FindControl("addJobRate") as TextBox;
            jobHours = plhReview.FindControl("addJobHours") as TextBox;

            Job newJob = new Job();

            newJob.JobDescription = jobDescription.Text;
            newJob.JobRate = Convert.ToDecimal(jobRate.Text);
            newJob.JobHours = Convert.ToDecimal(jobHours.Text);
            newJob.WorkOrderRef = Convert.ToInt32(hdnOrderNumber.Value);

            newJob.AddJobToDatabase();

            Response.Redirect("WorkOrder.aspx?OrderNumber=" + hdnOrderNumber.Value);
        }

        protected void AddMaterial(object sender, EventArgs e)
        {
            TextBox materialDescription = new TextBox();
            TextBox materialQuantity = new TextBox();
            TextBox materialPrice = new TextBox();

            materialDescription = plhReview.FindControl("addMaterialDescription") as TextBox;
            materialQuantity = plhReview.FindControl("addMaterialQuantity") as TextBox;
            materialPrice = plhReview.FindControl("addMaterialPrice") as TextBox;

            Material newMaterial = new Material();

            newMaterial.MaterialDescription = materialDescription.Text;
            newMaterial.MaterialQuantity = Convert.ToDecimal(materialQuantity.Text);
            newMaterial.MaterialPrice = Convert.ToDecimal(materialPrice.Text);
            newMaterial.WorkOrderRef = Convert.ToInt32(hdnOrderNumber.Value);

            newMaterial.AddMaterialToDatabase();

            Response.Redirect("WorkOrder.aspx?OrderNumber=" + hdnOrderNumber.Value);
        }

        protected void AddMiscellaneous(object sender, EventArgs e)
        {
            TextBox miscellaneousDescription = new TextBox();            
            TextBox miscellaneousAmount = new TextBox();

            miscellaneousDescription = plhReview.FindControl("addMiscellaneousDescription") as TextBox;
            miscellaneousAmount = plhReview.FindControl("addMiscellaneousAmount") as TextBox;

            Miscellaneous newMiscellaneous = new Miscellaneous();

            newMiscellaneous.MiscellaneousDescription = miscellaneousDescription.Text;
            newMiscellaneous.MiscellaneousAmount = Convert.ToDecimal(miscellaneousAmount.Text);
            newMiscellaneous.WorkOrderRef = Convert.ToInt32(hdnOrderNumber.Value);

            newMiscellaneous.AddMiscellaneousToDatabase();

            Response.Redirect("WorkOrder.aspx?OrderNumber=" + hdnOrderNumber.Value);
        }

        protected void DeleteJob(object sender, CommandEventArgs e)
        {
            Job newJob = new Job();
            newJob.JobID = e.CommandArgument.ToString();
            newJob.DeleteJobDatabase();
            Response.Redirect("WorkOrder.aspx?OrderNumber=" + hdnOrderNumber.Value);
        }

        protected void DeleteMaterial(object sender, CommandEventArgs e)
        {
            Material newMaterial = new Material();
            newMaterial.MaterialID = e.CommandArgument.ToString();
            newMaterial.DeleteMaterialDatabase();
            Response.Redirect("WorkOrder.aspx?OrderNumber=" + hdnOrderNumber.Value);
        }

        protected void DeleteMiscellaneous(object sender, CommandEventArgs e)
        {
            Miscellaneous newMiscellaneous = new Miscellaneous();
            newMiscellaneous.MiscellaneousID = e.CommandArgument.ToString();
            newMiscellaneous.DeleteMiscellaneousDatabase();
            Response.Redirect("WorkOrder.aspx?OrderNumber=" + hdnOrderNumber.Value);
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