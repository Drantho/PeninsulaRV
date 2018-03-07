using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace PeninsulaRV
{
    public class PartSale
    {
        public string PartSaleID { get; set; }
        public string PartRef { get; set; }
        public string CustomerRef { get; set; }
        public DateTime SaleDate { get; set; }
        public decimal Price { get; set; }
        public decimal Quantity { get; set; }
        public string Notes { get; set; }

        public Customer Buyer { get; set; }

        public Part Part { get; set; }

        public PartSale() { }

        public PartSale(string partSaleID)
        {
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM PartSale WHERE PartSaleID = @PartSaleID";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@PartSaleID", partSaleID);

            connection.Open();

            reader = command.ExecuteReader();
            while (reader.Read())
            {
                PartSaleID = partSaleID;
                PartRef = reader["PartRef"].ToString();
                CustomerRef = reader["CustomerRef"].ToString();
                SaleDate = Convert.ToDateTime(reader["SaleDate"]);
                Price = Convert.ToDecimal(reader["Price"]);
                Quantity = Convert.ToDecimal(reader["Quantity"]);
                Notes = reader["Notes"].ToString();
            }
            reader.Close();
            connection.Close();

            Customer customer = new Customer();
            Buyer = customer.GetCustomer(CustomerRef);

            Part part = new Part(PartRef);
            Part = part;
        }

        public void AddPartSaleToDatabase()
        {
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            string query = "INSERT INTO PartSale(PartRef, CustomerRef, SaleDate, Price, Quantity, Notes) VALUES(@PartRef, @CustomerRef, @SaleDate, @Price, @Quantity, @Notes)";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@PartRef", PartRef);
            command.Parameters.AddWithValue("@CustomerRef", CustomerRef);
            command.Parameters.AddWithValue("@SaleDate", SaleDate.ToShortDateString());
            command.Parameters.AddWithValue("@Price", Price.ToString());
            command.Parameters.AddWithValue("@Quantity", Quantity.ToString());
            command.Parameters.AddWithValue("@Notes", Notes);

            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();

            Part.Quantity -= Quantity;
            Part.UpdatePart();

        }

        public List<PartSale> SoldParts()
        {
            List<PartSale> list = new List<PartSale>();

            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM PartSaleView ORDER BY SaleDate";

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                PartSale partSale = new PartSale();
                partSale.PartSaleID = reader["PartSaleID"].ToString();
                partSale.PartRef = reader["PartID"].ToString();
                partSale.CustomerRef = reader["CustomerID"].ToString();
                partSale.SaleDate = Convert.ToDateTime(reader["SaleDate"]);
                partSale.Price = Convert.ToDecimal(reader["Price"]);
                partSale.Quantity = Convert.ToDecimal(reader["Quantity"]);
                partSale.Notes = reader["Notes"].ToString();
                partSale.Part.PartID = reader["PartID"].ToString();
                partSale.Part.Name = reader["Name"].ToString();
                partSale.Part.Category = reader["Category"].ToString();
                partSale.Part.Active = Convert.ToBoolean(reader["Active"]);
                partSale.Part.Description = reader["Description"].ToString();
                partSale.Part.KeyWords = Part.StringToList(reader["Keywords"].ToString());
                partSale.Part.ListDate = Convert.ToDateTime(reader["ListDate"]);
                partSale.Part.Location = reader["Location"].ToString();
                partSale.Part.Notes = reader["Notes"].ToString();
                partSale.Part.Quantity = Convert.ToDecimal(reader["QuantityAvailable"]);
                partSale.Part.Specs = Part.StringToDict(reader["Specs"].ToString());
                partSale.Buyer.Address = reader["Address"].ToString();
                partSale.Buyer.AltPhone = reader["AltPhone"].ToString();
                partSale.Buyer.City = reader["City"].ToString();
                partSale.Buyer.CustomerID = reader["CustomerID"].ToString();
                partSale.Buyer.FirstName = reader["FirstName"].ToString();
                partSale.Buyer.LastName = reader["LastName"].ToString();
                partSale.Buyer.Phone = reader["Phone"].ToString();
                partSale.Buyer.State = reader["State"].ToString();
                partSale.Buyer.Zip = reader["Zip"].ToString();
            }

            reader.Close();
            connection.Close();

            return list;
        }

        public void UpdatePartSale(PartSale oldPartSale)
        {
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            string query = "UPDATE PartSale SET SaleDate = @SaleDate,  Price = @Price, Quantity = @Quantity, Notes = @Notes WHERE PartSaleID = @PartSaleID";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@PartRef", PartRef);
            command.Parameters.AddWithValue("@CustomerRef", CustomerRef);
            command.Parameters.AddWithValue("@SaleDate", SaleDate.ToShortDateString());
            command.Parameters.AddWithValue("@Price", Price.ToString());
            command.Parameters.AddWithValue("@Quantity", Quantity.ToString());
            command.Parameters.AddWithValue("@Notes", Notes);
            command.Parameters.AddWithValue("@PartSaleID", PartSaleID);

            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();

            Part.Quantity = Part.Quantity - (Quantity - oldPartSale.Quantity);
        }
    }
}