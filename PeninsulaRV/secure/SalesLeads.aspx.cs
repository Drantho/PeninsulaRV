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
    public partial class SalesLeads : System.Web.UI.Page
    {
        string viewerName = System.Web.HttpContext.Current.User.Identity.Name.ToString();

        protected void Page_Load(object sender, EventArgs e)
        {          
            lblHeader.Text = "User: " + viewerName;

            Lead newLead = new Lead();

            rptLeads.DataSource = newLead.GetSalesmanLeads(viewerName);
            rptLeads.DataBind();

            if (!IsPostBack)
            {
                SqlConnection connection;
                SqlDataAdapter adapter;
                DataSet dataset;
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

                connection.Close();
            }

        }

        protected void AddLead(object sender, EventArgs e)
        {
            Customer newCustomer = new Customer();
            if (rblCustomerList.SelectedItem == null)
            {

                newCustomer.FirstName = txtFirstName.Text;
                newCustomer.LastName = txtLastName.Text;
                newCustomer.Phone = txtPhoneNumber.Text;
                newCustomer.AltPhone = txtAltPhone.Text;
                newCustomer.Email = txtEmail.Text;

                newCustomer.CustomerID = newCustomer.AddCustomerToDatabase();

            }
            else
            {
                newCustomer = newCustomer.GetCustomer(rblCustomerList.SelectedItem.Value);
            }

            Lead newLead = new Lead();
            DateTime nowDate = DateTime.Now;
            newLead.CustomerRef = newCustomer.CustomerID;
            newLead.LeadDate = nowDate;
            if (!string.IsNullOrEmpty(txtMaxPrice.Text))
            {
                newLead.MaxPrice = Convert.ToDecimal(txtMaxPrice.Text);
            }
            else
            {
                newLead.MaxPrice = 100000000;
            }
            
            newLead.MinPrice = Convert.ToDecimal(txtMinimumPrice.Text);
            newLead.Notes = txtNotes.Text;
            newLead.Salesman = viewerName;
            newLead.Status = "Active";
            newLead.VehicleMakes = StringToList(txtMakes.Text);
            newLead.VehicleModels = StringToList(txtModels.Text);

            List<string> list = new List<string>();
            foreach(ListItem itm in cblVehicleTypes.Items)
            {
                if (itm.Selected)
                {
                    list.Add(itm.Text);
                }
            }
            newLead.VehicleTypes = list;

            List<int> listYears = new List<int>();
            listYears.Add(Convert.ToInt16(ddlMinYear.SelectedItem.Text));
            listYears.Add(Convert.ToInt16(ddlMaxYear.SelectedItem.Text));

            newLead.VehicleYears = listYears;

            newLead.AddLeadToDatabase();

            Response.Redirect("SalesLeads.aspx");
        }

        private List<string> StringToList(string str)
        {
            List<string> list = new List<string>();

            list = str.Split(',').ToList<string>();

            return list;
        }

        private List<int> IntStringToList(string str)
        {
            List<int> list = new List<int>();
            try
            {
                list = str.Split(',').Select(int.Parse).ToList();
            }
            catch
            {
                list = null;
            }
            
            return list;
        }

        protected void btnGetResults(object sender, CommandEventArgs e)
        {
            GetResults(e.CommandArgument.ToString());
        }

        protected void GetResults(string leadID)
        {
            pnlAddReviewLeads.Visible = false;
            pnlLeadResults.Visible = true;

            Lead newLead = new Lead();
            newLead = newLead.GetLead(leadID);

            ViewState["Lead"] = newLead;

            SqlConnection connection;
            SqlDataReader reader;
            SqlCommand command;
            string query;
            
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM ConsignmentVehicleView WHERE Status = 'Active ' and(";

            if (newLead.VehicleMakes.Count > 0)
            {
                query += " (";

                for (int i = 0; i < newLead.VehicleMakes.Count; i++)
                {
                    if (i == 0)
                    {
                        query += " make like '%" + newLead.VehicleMakes[i] + "%' ";
                    }
                    else
                    {
                        query += " or make like '%" + newLead.VehicleMakes[i] + "%' ";
                    }
                }
            }

            query += ")";

            if (newLead.VehicleModels.Count > 0)
            {
                query += " or (";

                for (int i = 0; i < newLead.VehicleModels.Count; i++)
                {
                    if (i == 0)
                    {
                        query += " model like '%" + newLead.VehicleModels[i] + "%' ";
                    }
                    else
                    {
                        query += " or model like '%" + newLead.VehicleModels[i] + "%' ";
                    }

                }
                query += ")";
            }

            if (newLead.VehicleTypes.Count > 0)
            {
                query += " or (";

                for (int i = 0; i < newLead.VehicleModels.Count; i++)
                {
                    if (i == 0)
                    {
                        query += " vehicletype = '" + newLead.VehicleTypes[i] + "' ";
                    }
                    else
                    {
                        query += " or vehicletype = '" + newLead.VehicleTypes[i] + "' ";
                    }

                }
                query += ")";
            }

            if (newLead.VehicleYears.Count > 0)
            {
                query += " or (";

                query += "modelyear >= " + newLead.VehicleYears[0].ToString() + " and modelyear <= " + newLead.VehicleYears[1].ToString();
                
                query += ")";
            }

            if (newLead.MaxPrice > 0)
            {
                query += " or (";

                query += "askingprice >= " + newLead.MinPrice.ToString() + " and askingprice <= " + newLead.MaxPrice.ToString();

                query += ")";
            }

            query += ")";

            List<string>[] lists = new List<string>[5];

            for (int i = 0; i< lists.Length; i++)
            {
                List<string> list = new List<string>();
                lists[i] = list;
            }

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();

            bool loop = true;

            while (reader.Read() && loop)
            {

                int matches = 0;
                string matchedString = "";

                foreach (string str in newLead.VehicleTypes)
                {
                    //plhResults.Controls.Add(new LiteralControl(str + " ?= " + reader["VehicleType"].ToString() + "<br>"));
                    if (str == reader["VehicleType"].ToString())
                    {
                        matches += 1;
                        matchedString += "<li> <span class='glyphicon glyphicon-ok' style='color: green' aria-hidden='true'></span> " + reader["VehicleType"] + "</li>";

                        bool makeFound = false;
                        foreach (string str1 in newLead.VehicleMakes)
                        {
                            string testString = str1.TrimStart(' ');
                            //plhResults.Controls.Add(new LiteralControl(str1 + " ?= " + reader["Make"].ToString() + "<br>"));
                            if (testString.ToLower().IndexOf(reader["Make"].ToString().ToLower()) != -1 || reader["Make"].ToString().ToLower().IndexOf(testString.ToLower()) != -1)//(str == reader["Make"].ToString())
                            {
                                matches += 1;
                                matchedString += "<li> <span class='glyphicon glyphicon-ok' style='color: green' aria-hidden='true'></span> " + reader["Make"] + "</li>";
                                makeFound = true;
                            }                            
                        }
                        if (!makeFound)
                        {
                            matchedString += "<li> <span class='glyphicon glyphicon-remove' style='color: red' aria-hidden='true'></span> " + reader["Make"] + "</li>";
                        }

                        bool modelFound = false;
                        foreach (string str2 in newLead.VehicleModels)
                        {
                            string testString = str2.TrimStart(' ');
                            //plhResults.Controls.Add(new LiteralControl(str2 + " ?= " + reader["Model"].ToString() + "<br>"));
                            if (testString.ToLower().IndexOf(reader["Model"].ToString().ToLower()) != -1 || reader["Model"].ToString().ToLower().IndexOf(testString.ToLower()) != -1)//(str == reader["Make"].ToString())
                            {
                                matches += 1;
                                matchedString += "<li> <span class='glyphicon glyphicon-ok' style='color: green' aria-hidden='true'></span> " + reader["Model"] + "</li>";
                                modelFound = true;
                            }                            
                        }
                        if (!modelFound)
                        {
                            matchedString += "<li> <span class='glyphicon glyphicon-remove' style='color: red' aria-hidden='true'></span> " + reader["Model"] + "</li>";
                        }

                        if (newLead.MinPrice <= Convert.ToDecimal(reader["AskingPrice"]) && newLead.MaxPrice >= Convert.ToDecimal(reader["AskingPrice"]))
                        {
                            matches += 1;
                            matchedString += "<li> <span class='glyphicon glyphicon-ok' style='color: green' aria-hidden='true'></span> " + reader["AskingPrice"] + "</li>";
                        }
                        else
                        {
                            matchedString += "<li> <span class='glyphicon glyphicon-remove' style='color: red' aria-hidden='true'></span> " + reader["AskingPrice"] + "</li>";
                        }

                        if (newLead.VehicleYears[0] <= Convert.ToInt16(reader["ModelYear"]) && newLead.VehicleYears[1] >= Convert.ToInt16(reader["ModelYear"]))
                        {
                            matches += 1;
                            matchedString += "<li> <span class='glyphicon glyphicon-ok' style='color: green' aria-hidden='true'></span> " + reader["ModelYear"] + "</li>";
                        }
                        else
                        {
                            matchedString += "<li> <span class='glyphicon glyphicon-remove' style='color: red' aria-hidden='true'></span> " + reader["ModelYear"] + "</li>";
                        }

                        //plhResults.Controls.Add(new LiteralControl("<h1>" + reader["Stocknumber"].ToString() + " - Match count: " + matches + "  Matches: " + matchedString + "</h1>"));
                        lists[matches - 1].Add("<h4>Stock Number: " + reader["Stocknumber"].ToString() + "</h4><ul>" + matchedString + "</ul>");
                    }
                }
            }
            
            for (int i=lists.Length - 1; i>=0; i--)
            {
                foreach(string str in lists[i])
                {
                    try
                    {
                        PlaceHolder newPlaceHolder = new PlaceHolder();
                        newPlaceHolder = pnlLeadResults.FindControl("plhResults" + (5 - i)) as PlaceHolder;
                        newPlaceHolder.Controls.Add(new LiteralControl(str));
                    }
                    catch
                    {

                    }
                                  
                }
            }

            connection.Close();
            
            lblLeadID.Text = newLead.LeadID.ToString();
            lblDate.Text = newLead.LeadDate.ToShortDateString();
            lblCustomerName.Text = newLead.LeadCustomer.LastName + ", " + newLead.LeadCustomer.FirstName;
            lblPhone.Text = newLead.LeadCustomer.Phone + "<br>" + newLead.LeadCustomer.AltPhone;
            lblStatus.Text = newLead.Status;

            lblVehicleTypes.Text = "";
            foreach (string str in newLead.VehicleTypes)
            {
                lblVehicleTypes.Text += str + " ";
            }

            lblMakes.Text = "";
            foreach (string str1 in newLead.VehicleMakes)
            {
                lblMakes.Text += str1 + " ";
            }

            lblModels.Text = "";
            foreach (string str2 in newLead.VehicleModels)
            {
                lblModels.Text += str2 + " ";
            }

            lblYearRange.Text = newLead.VehicleYears[0].ToString() + " - " + newLead.VehicleYears[1].ToString();
            lblPriceRange.Text = "Price range: " + newLead.MinPrice.ToString("c") + " - " + newLead.MaxPrice.ToString("c");
            lblNotes.Text = "Notes: " + newLead.Notes;
        }

        protected void UpdateStatus(object sender, CommandEventArgs e)
        {
            Lead newLead = new Lead();
            newLead = ViewState["Lead"] as Lead;

            newLead.Status = rblLeadStatus.SelectedItem.Text;

            newLead.UpdateStatus();

            ViewState["Lead"] = newLead;

            GetResults(newLead.LeadID);           
        }
        
    }
}