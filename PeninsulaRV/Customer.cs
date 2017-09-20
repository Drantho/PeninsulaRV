using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace PeninsulaRV
{
    [Serializable]
    public class Customer
    {
        private string customerID, firstName, lastName, address, city, state, zip, phone, altphone, driversLicense, email;
        private List<string> listCustomer = new List<string>();

        public string CustomerID
        {
            get { return customerID; }
            set { customerID = value; }
        }

        public List<string> ListCustomer
        {
            get
            {
                List<string> customerNames = new List<string>();

                if (FirstName.IndexOf(",") != -1)
                {
                    string[] firstNames = FirstName.Split(',');
                    string[] lastNames = LastName.Split(',');

                    int i = 0;

                    foreach(string str in firstNames)
                    {
                        if (lastNames.Length < firstNames.Length)
                        {
                            customerNames.Add(firstNames[i] + " " + lastNames[0]);
                        }
                        else
                        {
                            customerNames.Add(firstNames[i] + " " + lastNames[i]);
                        }
                        
                        i++;
                    }
                }
                else
                {
                    customerNames.Add(FirstName + " " + LastName);
                }

                return customerNames;
            }
        }

        public string FirstName
        {
            get { return firstName; }
            set { firstName = value; }
        }

        public string LastName
        {
            get { return lastName; }
            set { lastName = value; }
        }

        public string Address
        {
            get { return address; }
            set { address = value; }
        }

        public string City
        {
            get { return city; }
            set { city = value; }
        }

        public string State
        {
            get { return state; }
            set { state = value; }
        }

        public string Zip
        {
            get { return zip; }
            set { zip = value; }
        }

        public string Phone
        {
            get { return phone; }
            set { phone = value; }
        }

        public string AltPhone
        {
            get { return altphone; }
            set { altphone = value; }
        }

        public string DriversLicense
        {
            get { return driversLicense; }
            set { driversLicense = value; }
        }

        public string Email
        {
            get { return email; }
            set { email = value; }
        }

        public string AddCustomerToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO Customer(FirstName, LastName, Address, City, State, Zip, PhoneNumber, AltPhoneNumber, DriversLicense, Email) Values(@FirstName, @LastName, @Address, @City, @State, @Zip, @Phone, @AltPhone, @DriversLicense, @Email) SELECT Scope_Identity()";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.Add(SetDBNullIfEmpty("@FirstName", FirstName));
            command.Parameters.Add(SetDBNullIfEmpty("@LastName", LastName));
            command.Parameters.Add(SetDBNullIfEmpty("@Address", Address));
            command.Parameters.Add(SetDBNullIfEmpty("@City", City));
            command.Parameters.Add(SetDBNullIfEmpty("@State", State));
            command.Parameters.Add(SetDBNullIfEmpty("@Zip", Zip));
            command.Parameters.Add(SetDBNullIfEmpty("@Phone", Phone));
            command.Parameters.Add(SetDBNullIfEmpty("@AltPhone", AltPhone));
            command.Parameters.Add(SetDBNullIfEmpty("@DriversLicense", DriversLicense));
            command.Parameters.Add(SetDBNullIfEmpty("@Email", Email));

            return command.ExecuteScalar().ToString();
            
        }

        private SqlParameter SetDBNullIfEmpty(string parmName, string parmValue)
        {
            SqlParameter newSQLParameter = new SqlParameter();
            newSQLParameter.ParameterName = parmName;

            if (string.IsNullOrEmpty(parmValue))
            {
                newSQLParameter.Value = DBNull.Value;    
            }
            else
            {
                newSQLParameter.Value = parmValue;
            }
            return newSQLParameter;
        }

        public void UpdateCustomer(string field, string value)
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Customer SET " + field + " = @" + field + " WHERE CustomerID = @CustomerID";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@" + field, value);
            command.Parameters.AddWithValue("@CustoerID", CustomerID);

            command.ExecuteNonQuery();

            connection.Close();

        }

        public void UpdateAll()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Customer SET FirstName = @FirstName, LastName = @LastName, Address= @Address, City = @City, State = @State, Zip = @Zip, PhoneNumber = @Phone, AltPhoneNumber = @AltPhone, Email = @Email WHERE CustomerID = @CustomerID";

            connection.Open();

            command = new SqlCommand(query, connection);

            if (string.IsNullOrEmpty(Email))
            {
                Email = "";
            }

            command.Parameters.AddWithValue("@FirstName", FirstName);
            command.Parameters.AddWithValue("@LastName", LastName);
            command.Parameters.AddWithValue("@Address", Address);
            command.Parameters.AddWithValue("@City", City);
            command.Parameters.AddWithValue("@State", State);
            command.Parameters.AddWithValue("@Zip", Zip);
            command.Parameters.AddWithValue("@Phone", Phone);
            command.Parameters.AddWithValue("@AltPhone", AltPhone);
            command.Parameters.AddWithValue("@Email", Email);
            command.Parameters.AddWithValue("@CustomerID", CustomerID);

            command.ExecuteNonQuery();

            connection.Close();
        }

        public Customer GetCustomer(string customerID)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;            

            Customer newCustomer = new Customer();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Customer WHERE CustomerID = @CustomerID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@CustomerID", customerID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                newCustomer.CustomerID = reader["CustomerID"].ToString();
                newCustomer.FirstName = reader["FirstName"].ToString();
                newCustomer.LastName = reader["LastName"].ToString();
                newCustomer.Address = reader["Address"].ToString();
                newCustomer.City = reader["City"].ToString();
                newCustomer.State = reader["State"].ToString();
                newCustomer.Zip = reader["Zip"].ToString();
                newCustomer.DriversLicense = reader["DriversLicense"].ToString();
                newCustomer.Phone = reader["PhoneNumber"].ToString();
                newCustomer.AltPhone = reader["AltPhoneNumber"].ToString();
                newCustomer.Email = reader["Email"].ToString();
            }

            return newCustomer;

        }

        public DataSet GetVehicleList()
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            Customer newCustomer = new Customer();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT VehicleID, Convert(varchar, ModelYear) + ' ' + Make + ' ' + Model + '<br>' + VehicleType + '<br>VIN:' + Vin AS Info FROM Vehicle WHERE CustomerRef = @CustomerRef";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);

            adapter.SelectCommand.Parameters.AddWithValue("@CustomerRef", CustomerID);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }
    }
}