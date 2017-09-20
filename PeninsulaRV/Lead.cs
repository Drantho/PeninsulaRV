using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PeninsulaRV
{
    [Serializable]
    public class Lead
    {
        private List<string> vehicleTypes;
        private List<string> vehicleMakes;
        private List<string> vehicleModels;
        private List<int> vehicleYears;
        private decimal minPrice, maxPrice;
        private string customerRef;
        private DateTime leadDate;
        private string leadID, salesman, notes, status;
        private Customer customer;
        
        public string LeadID
        {
            get { return leadID; }
            set { leadID = value; }
        }
        public List<string> VehicleTypes
        {
            get { return vehicleTypes; }
            set { vehicleTypes = value; }
        }
        public List<string> VehicleMakes
        {
            get { return vehicleMakes; }
            set { vehicleMakes = value; }
        }
        public List<string> VehicleModels
        {
            get { return vehicleModels; }
            set { vehicleModels = value; }
        }
        public List<int> VehicleYears
        {
            get { return vehicleYears; }
            set { vehicleYears = value; }
        }
        public Decimal MinPrice
        {
            get { return minPrice; }
            set { minPrice = value; }
        }
        public Decimal MaxPrice
        {
            get { return maxPrice; }
            set { maxPrice = value; }
        }
        public string CustomerRef
        {
            get { return customerRef; }
            set { customerRef = value; }
        }
        public DateTime LeadDate
        {
            get { return leadDate; }
            set { leadDate = value; }
        }
        public string Salesman
        {
            get { return salesman; }
            set { salesman = value; }
        }
        public string Notes
        {
            get { return notes; }
            set { notes = value; }
        }
        public string Status
        {
            get { return status; }
            set { status = value; }
        }
        public Customer LeadCustomer
        {
            get { return customer; }
            set { customer = value; }
        }

        public string AddLeadToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, strID;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO Lead(VehicleTypes, VehicleMakes, VehicleModels, VehicleYears, VehicleMinPrice, VehicleMaxPrice, CustomerRef, LeadDate, Salesman, Notes, Status) Values(@VehicleTypes, @VehicleMakes, @VehicleModels, @VehicleYears, @MinPrice, @MaxPrice, @CustomerRef, @LeadDate, @Salesman, @Notes, @Status) SELECT Scope_Identity()";

            connection.Open();

            command = new SqlCommand(query, connection);
            
            command.Parameters.AddWithValue("@VehicleTypes", ListToString(VehicleTypes));
            command.Parameters.AddWithValue("@VehicleMakes", ListToString(VehicleMakes));
            command.Parameters.AddWithValue("@VehicleModels", ListToString(VehicleModels));
            command.Parameters.AddWithValue("@VehicleYears", IntListToString(VehicleYears));
            command.Parameters.AddWithValue("@MinPrice", MinPrice);
            command.Parameters.AddWithValue("@MaxPrice", MaxPrice);
            command.Parameters.AddWithValue("@CustomerRef", CustomerRef);
            command.Parameters.AddWithValue("@LeadDate", LeadDate);
            command.Parameters.AddWithValue("@Salesman", Salesman);
            command.Parameters.AddWithValue("@Notes", Notes);
            command.Parameters.AddWithValue("@Status", "Active");

            strID = command.ExecuteScalar().ToString();

            connection.Close();

            return strID;
        }

        private string ListToString(List<string> list)
        {
            string result = "";
            foreach(string str in list)
            {
                result += "," + str;
            }

            result = result.Substring(1);
            return result;
        }

        private string IntListToString(List<int> list)
        {
            string result = "";
            foreach (int i in list)
            {
                result += "," + i.ToString();
            }
            result = result.Substring(1);
            return result;
        }

        public Lead GetLead(string LeadID)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            Lead newLead = new Lead();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Lead WHERE LeadID = @LeadID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@LeadID", LeadID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                newLead.LeadDate = Convert.ToDateTime(reader["LeadDate"]);
                newLead.LeadID = reader["LeadID"].ToString();
                newLead.CustomerRef = reader["CustomerRef"].ToString();
                newLead.MaxPrice = Convert.ToDecimal(reader["VehicleMaxPrice"]);
                newLead.MinPrice = Convert.ToDecimal(reader["VehicleMinPrice"]);
                newLead.Notes = reader["Notes"].ToString();
                newLead.Salesman = reader["Salesman"].ToString();
                newLead.VehicleMakes = StringToList(reader["VehicleMakes"].ToString());
                newLead.VehicleModels = StringToList(reader["VehicleModels"].ToString());
                newLead.VehicleTypes = StringToList(reader["VehicleTypes"].ToString());
                newLead.VehicleYears = IntStringToList(reader["VehicleYears"].ToString());
                newLead.Status = reader["Status"].ToString();                
            }

            Customer newCustomer = new Customer();
            newCustomer = newCustomer.GetCustomer(newLead.CustomerRef);

            newLead.LeadCustomer = newCustomer;
            
            return newLead;
        }

        private List<string> StringToList(string str)
        {
            List<string> result = new List<string>();

            result = str.Split(',').ToList();

            return result;

        }

        private List<int> IntStringToList(string str)
        {
            List<int> result = new List<int>();

            result = str.Split(',').Select(int.Parse).ToList();

            return result;

        }

        public DataSet GetSalesmanLeads(string salesman)
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Lead INNER JOIN Customer ON Lead.CustomerRef = Customer.CustomerID where Salesman = @Salesman";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);
            adapter.SelectCommand.Parameters.AddWithValue("@Salesman", salesman);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }

        public void UpdateStatus()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Lead SET Status = @Status WHERE LeadID = @LeadID";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@Status", Status);
            command.Parameters.AddWithValue("@LeadID", LeadID);

            command.ExecuteNonQuery();

            connection.Close();
        }
    }
}