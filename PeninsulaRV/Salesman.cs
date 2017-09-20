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
    public class Salesman
    {
        private string salesmanID, offerRef, name;
        private decimal commissionPercent;

        public string SalesmanID
        {
            get { return salesmanID; }
            set { salesmanID = value; }
        }

        public string OfferRef
        {
            get { return offerRef; }
            set { offerRef = value; }
        }

        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        public decimal CommissionPercent
        {
            get { return commissionPercent; }
            set { commissionPercent = value; }
        }

        public Salesman GetSalesman(string salesmanID)
        {
            Salesman newSalesman = new Salesman();

            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Salesman WHERE SalesmanID = @SalesmanID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@SalesmanID", SalesmanID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                newSalesman.SalesmanID = salesmanID;
                newSalesman.OfferRef = reader["OfferRef"].ToString();
                newSalesman.Name = reader["Name"].ToString();
                newSalesman.CommissionPercent = Convert.ToDecimal(reader["CommissionPercent"]);
            }

            connection.Close();

            return newSalesman;
        }
        
        public string AddSalesmanToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, salesmanID;

            Salesman newSalesman = new Salesman();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO Salesman(OfferRef, Name, CommissionPercent) VALUES(@OfferRef, @Name, @CommissionPercent) SELECT Scope_Identity()";            

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OfferRef", OfferRef);
            command.Parameters.AddWithValue("@Name", Name);
            command.Parameters.AddWithValue("@CommissionPercent", CommissionPercent);
            salesmanID = command.ExecuteScalar().ToString();

            connection.Close();

            return salesmanID;
        }        

        public void DeleteSalesman()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "DELETE FROM Salesman WHERE SalesmanID = @SalesmanID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@SalesmanID", SalesmanID);

            command.ExecuteNonQuery();

            connection.Close();

        }

        

        public void UpdateSalesman()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Salesman SET CommissionPercent = @CommissionPercent WHERE SalesmanID = @SalesmanID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@SalesmanID", SalesmanID);
            command.Parameters.AddWithValue("@CommissionPercent", CommissionPercent);

            command.ExecuteNonQuery();

            connection.Close();

        }
    }
}