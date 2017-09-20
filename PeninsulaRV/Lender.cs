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
    public class Lender
    {
        public string LenderID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string IDType { get; set; }
        public string IDNumber { get; set; }
        public string Notes { get; set; }

        public Lender() { }

        public Lender(string lenderID)
        {
            SqlConnection connection = CurrentConnection();
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM Lender WHERE LenderID = @LenderID";
            Lender newLender = new Lender();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@LenderID", lenderID);

            connection.Open();
            reader = command.ExecuteReader();

            while (reader.Read())
            {
                newLender.LenderID = lenderID;
                newLender.Name = reader["Name"].ToString();
                newLender.Address = reader["Address"].ToString();
                newLender.City = reader["City"].ToString();
                newLender.State = reader["State"].ToString();
                newLender.Zip = reader["Zip"].ToString();
                newLender.Phone = reader["Phone"].ToString();
                newLender.Fax = reader["Fax"].ToString();
                newLender.IDType = reader["IDType"].ToString();
                newLender.IDNumber = reader["IDNumber"].ToString();
                newLender.Notes = reader["Notes"].ToString();
            }
            connection.Close();
        }

        public List<Lender> AllLenders()
        {
            SqlConnection connection = CurrentConnection();
            SqlCommand command;
            SqlDataReader reader;
            List<Lender> allLenders = new List<Lender>();
            string query = "SELECT * FROM Lender ORDER BY Name";

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                Lender newLender = new Lender();
                newLender.LenderID = reader["LenderID"].ToString();
                newLender.Name = reader["Name"].ToString();
                newLender.Address = reader["Address"].ToString();
                newLender.City = reader["City"].ToString();
                newLender.State = reader["State"].ToString();
                newLender.Zip = reader["Zip"].ToString();
                newLender.Phone = reader["Phone"].ToString();
                newLender.Fax = reader["Fax"].ToString();
                newLender.IDType = reader["IDType"].ToString();
                newLender.IDNumber = reader["IDNumber"].ToString();
                newLender.Notes = reader["Notes"].ToString();
                allLenders.Add(newLender);
            }
            return allLenders;
        }

        public void AddLenderToDatabase()
        {
            SqlConnection connection = CurrentConnection();
            SqlCommand command;
            string query = "INSERT INTO Lender(Name, Address, City, State, Zip, Phone, Fax, IDType, IDNumber, Notes) VALUES(@Name, @Address, @City, @State, @Zip, @Phone, @Fax, @IDType, @IDNumber, @Notes)";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Name", Name);
            command.Parameters.AddWithValue("@Address", Address);
            command.Parameters.AddWithValue("@City", City);
            command.Parameters.AddWithValue("@State", State);
            command.Parameters.AddWithValue("@Zip", Zip);
            command.Parameters.AddWithValue("@Phone", Phone);
            command.Parameters.AddWithValue("@Fax", Fax);
            command.Parameters.AddWithValue("@IDType", IDType);
            command.Parameters.AddWithValue("@IDNumber", IDNumber);
            command.Parameters.AddWithValue("@Notes", Notes);

            foreach(SqlParameter parameter in command.Parameters)
            {
                if(parameter.Value == null){
                    parameter.Value = DBNull.Value;
                }
            }
            
            connection.Open();

            command.ExecuteNonQuery();

            connection.Close();
        }

        private SqlConnection CurrentConnection() {
            SqlConnection connection;
            
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            return connection;
        }
    }
}