using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PeninsulaRV
{
    public class Miscellaneous
    {
        private int workOrderRef;
        private string miscellaneousDescription, miscellaneousID;
        private decimal miscellaneousAmount;

        public int WorkOrderRef
        {
            get { return workOrderRef; }
            set { workOrderRef = value; }
        }

        public string MiscellaneousID
        {
            get { return miscellaneousID; }
            set { miscellaneousID = value; }
        }

        public string MiscellaneousDescription
        {
            get { return miscellaneousDescription; }
            set { miscellaneousDescription = value; }
        }

        public decimal MiscellaneousAmount
        {
            get { return miscellaneousAmount; }
            set { miscellaneousAmount = value; }
        }
        
        public string AddMiscellaneousToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, result;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO Miscellaneous(WorkOrderRef, MiscellaneousDescription, MiscellaneousAmount) Values(@WorkOrderRef, @MiscellaneousDescription, @MiscellaneousAmount) Select Scope_Identity()";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@WorkOrderRef", WorkOrderRef);
            command.Parameters.AddWithValue("@MiscellaneousDescription", MiscellaneousDescription);            
            command.Parameters.AddWithValue("@MiscellaneousAmount", MiscellaneousAmount);            

            result = command.ExecuteScalar().ToString();

            connection.Close();

            return result;
        }

        public void UpdateMiscellaneousDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Miscellaneous SET MiscellaneousDescription = @MiscellaneousDescription, MiscellaneousAmount = @MiscellaneousAmount WHERE MiscellaneousID = @MiscellaneousID";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@MiscellaneousAmount", MiscellaneousAmount);
            command.Parameters.AddWithValue("@MiscellaneousDescription", MiscellaneousDescription);
            command.Parameters.AddWithValue("@MiscellaneousID", MiscellaneousID);

            command.ExecuteNonQuery();

            connection.Close();

        }

        public Miscellaneous GetMiscellaneousRow(string miscellaneousID)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;
            Miscellaneous miscellaneous = new Miscellaneous();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Miscellaneous WHERE MiscellaneousID = @MiscellaneousID";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@MiscellaneousID", MiscellaneousID);

            miscellaneous.MiscellaneousID = MiscellaneousID;

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                miscellaneous.MiscellaneousAmount = Convert.ToDecimal(reader["MiscellaneousAmount"]);                
                miscellaneous.MiscellaneousDescription = reader["MiscellaneousDescription"].ToString();
            }

            connection.Close();

            return miscellaneous;

        }

        public void DeleteMiscellaneousDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "DELETE FROM Miscellaneous WHERE MiscellaneousID = @MiscellaneousID";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@MiscellaneousID", MiscellaneousID);

            command.ExecuteNonQuery();

            connection.Close();

        }
    }
}