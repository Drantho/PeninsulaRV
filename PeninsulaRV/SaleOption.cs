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
    public class SaleOption
    {
        private string optionID, offerRef, description;
        private decimal price;

        public string OptionID
        {
            get { return optionID; }
            set { optionID = value; }
        }
        public string OfferRef
        {
            get { return offerRef; }
            set { offerRef = value; }
        }
        public string Description
        {
            get { return description; }
            set { description = value; }
        }
        public decimal Price
        {
            get { return price; }
            set { price = value; }
        }

        public SaleOption GetOption()
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            SaleOption newOfferOption = new SaleOption();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM SaleOption WHERE SaleOptionID = @SaleOptionID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OfferOptionID", OptionID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                newOfferOption.OfferRef = reader["OfferRef"].ToString();
                newOfferOption.Description = reader["Description"].ToString();
                newOfferOption.Price = Convert.ToDecimal(reader["Price"]);
            }

            reader.Close();

            connection.Close();
            
            return newOfferOption;
        }

        public string AddOptionToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, optionID;

            Customer Owner = new Customer();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO SaleOption(OfferRef, Description, Price) Values(@OfferRef, @Description, @Price) SELECT Scope_Identity()";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@OfferRef", OfferRef);
            command.Parameters.AddWithValue("@Description", Description);
            command.Parameters.AddWithValue("@Price", Price);

            optionID = command.ExecuteScalar().ToString();

            connection.Close();

            return optionID;
        }

        public bool CompareSalesOption(SaleOption option1 = null, SaleOption option2 = null)
        {
            if(option1.Description != option2.Description)
            {
                return false;
            }
            else
            {
                if(option1.Price != option2.Price)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }

        public void UpdateAll()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE SaleOption SET  Description = @Description, Price = @Price WHERE OptionID = @OptionID";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@Description", Description);
            command.Parameters.AddWithValue("@Price", Price);
            command.Parameters.AddWithValue("@OptionID", OptionID);

            command.ExecuteNonQuery();

            connection.Close();
        }

        public void DeleteOption()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "DELETE FROM Option WHERE OptionID = @OptionID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OptionID", OptionID);

            command.ExecuteNonQuery();

            connection.Close();

        }
    }
}