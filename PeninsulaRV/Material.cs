using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PeninsulaRV
{
    public class Material
    {
        private int workOrderRef;
        private string materialDescription, materialID;
        private decimal materialQuantity, materialPrice;

        public string MaterialID
        {
            get { return materialID; }
            set { materialID = value; }
        }

        public int WorkOrderRef
        {
            get { return workOrderRef; }
            set { workOrderRef = value; }
        }

        public string MaterialDescription
        {
            get { return materialDescription; }
            set { materialDescription = value; }
        }

        public decimal MaterialQuantity
        {
            get { return materialQuantity; }
            set { materialQuantity = value; }
        }

        public decimal MaterialPrice
        {
            get { return materialPrice; }
            set { materialPrice = value; }
        }

        public decimal MaterialAmount
        {
            get { return materialPrice * materialQuantity; }
        }

        public string AddMaterialToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, result;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO Material(WorkOrderRef, MaterialDescription, MaterialQuantity, MaterialPrice, MaterialAmount) Values(@WorkOrderRef, @MaterialDescription, @MaterialQuantity, @MaterialPrice, @MaterialAmount) Select Scope_Identity()";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@WorkOrderRef", WorkOrderRef);
            command.Parameters.AddWithValue("@MaterialDescription", MaterialDescription);
            command.Parameters.AddWithValue("@MaterialQuantity", MaterialQuantity);
            command.Parameters.AddWithValue("@MaterialPrice", MaterialPrice);
            command.Parameters.AddWithValue("@MaterialAmount", MaterialAmount);            

            result = command.ExecuteScalar().ToString();

            connection.Close();

            return result;
        }

        public void UpdateMaterialDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Material SET MaterialQuantity = @MaterialQuantity, MaterialPrice = @MaterialPrice, MaterialAmount = @MaterialAmount, MaterialDescription = @MaterialDescription WHERE MaterialID = @MaterialID";

            connection.Open();
            command = new SqlCommand(query, connection);            
            command.Parameters.AddWithValue("@MaterialQuantity", MaterialQuantity);
            command.Parameters.AddWithValue("@MaterialPrice", MaterialPrice);
            command.Parameters.AddWithValue("@MaterialAmount", MaterialAmount);
            command.Parameters.AddWithValue("@MaterialDescription", MaterialDescription);
            command.Parameters.AddWithValue("@MaterialID", MaterialID);

            command.ExecuteNonQuery();

            connection.Close();

        }

        public Material GetMaterialRow(string materialID)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;
            Material material = new Material();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Material WHERE MaterialID = @MaterialID";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@MaterialID", MaterialID);

            material.MaterialID = materialID;

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                material.MaterialQuantity = Convert.ToDecimal(reader["MaterialQuantity"]);
                material.MaterialPrice = Convert.ToDecimal(reader["MaterialPrice"]);
                material.MaterialDescription = reader["MaterialDescription"].ToString();
            }

            connection.Close();

            return material;

        }

        public void DeleteMaterialDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "DELETE FROM Material WHERE MaterialID = @MaterialID";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@MaterialID", MaterialID);

            command.ExecuteNonQuery();

            connection.Close();

        }
    }
}