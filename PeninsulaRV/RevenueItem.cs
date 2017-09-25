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
    public class RevenueItem
    {
        public string RevenueItemID { get; set; }
        public string MonthlyRevenueRef { get; set; }
        public string Title { get; set; }
        public decimal Amount { get; set; }
        public string Notes { get; set; }

        public void AddRevenueItemToDatabase()
        {
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            string query = "INSERT INTO RevenueItem(MonthlyRevenueRef, Title, Amount, Notes) VALUES(@MonthlyRevenueRef, @Title, @Amount, @Notes)";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@MonthlyRevenueRef", MonthlyRevenueRef);
            command.Parameters.AddWithValue("@Title", Title);
            command.Parameters.AddWithValue("@Amount", Amount);
            command.Parameters.AddWithValue("@Notes", Notes);

            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
        }        

        public RevenueItem GetRevenueItem(string revenueItemID)
        {
            RevenueItem revenueItem = new RevenueItem();
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM RevenueItem WHERE RevenueItemID = @RevenueItemID";

            connection = currentConnection.CurrentConnection;

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@RevenueItemID", revenueItemID);

            connection.Open();

            reader = command.ExecuteReader();
            while (reader.Read())
            {
                revenueItem.RevenueItemID = revenueItemID;
                revenueItem.Title = reader["Title"].ToString();
                revenueItem.Amount = Convert.ToDecimal(reader["Amount"]);
                revenueItem.Notes = reader["Notes"].ToString();
            }
            connection.Close();
            return revenueItem;
            
        }

        public void UpdateRevenueItem()
        {
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            string query = "UPDATE RevenueItem SET Title = @Title, Amount = @Amount WHERE RevenueItemID = @RevenueItemID";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Title", Title);
            command.Parameters.AddWithValue("@Amount", Amount);
            command.Parameters.AddWithValue("@RevenueItemID", RevenueItemID);

            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
        }
    }
}