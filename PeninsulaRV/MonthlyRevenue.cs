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
    public class MonthlyRevenue        
    {
        public decimal TaxRate
        {
            get
            {
                return 0.084M;
            }
        }
        public string MonthlyRevenueID { get; set; }
        public int Month { get; set; }
        public int Year { get; set; }
        public decimal BankDeposits { get; set; }
        public decimal OutOfState{ get; set; }
        public decimal Consignments { get; set; }
        public decimal Wholesale { get; set; }
        public decimal MinusTaxFree {
            get
            {
                decimal minusTaxFree = BankDeposits;

                foreach(RevenueItem item in CurrentRevenueItems)
                {
                    minusTaxFree -= item.Amount;
                }
                minusTaxFree -= OutOfState;
                minusTaxFree -= Wholesale;
                return minusTaxFree;
            }
        }
        public decimal TaxesBackedOut
        {
            get
            {
                return MinusTaxFree / (1 +TaxRate);
            }
        }
        public decimal RetailingTotal
        {
            get
            {
                return TaxesBackedOut + OutOfState + Consignments;
            }
        }
        public decimal Motorized { get; set; }
        public decimal Use { get; set; }
        public string Notes { get; set; }

        public string AddMonthlyRevenueToDatabase()
        {
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            string query = "INSERT INTO MonthlyRevenue(Month, Year, BankDeposits, OutOfState, Wholesale, Consignment, Motorized, StoreUse, Notes) VALUES(@Month, @Year, @BankDeposits, @OutOfState, @Wholesale, @Consignment, @Motorized, @StoreUse, @Notes) SELECT SCOPE_IDENTITY()";
            string result;

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Month", Month);
            command.Parameters.AddWithValue("@Year", Year);
            command.Parameters.AddWithValue("@BankDeposits", BankDeposits);
            command.Parameters.AddWithValue("@OutOfState", OutOfState);
            command.Parameters.AddWithValue("@Wholesale", Wholesale);
            command.Parameters.AddWithValue("@Consignment", Consignments);
            command.Parameters.AddWithValue("@Motorized", Motorized);
            command.Parameters.AddWithValue("@StoreUse", Use);
            command.Parameters.AddWithValue("@Notes", Notes);

            connection.Open();
            result = command.ExecuteScalar().ToString();
            connection.Close();

            return result;
        }

        public void UpdateMonthlyRevenue()
        {
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            string query = "UPDATE MonthlyRevenue SET Month = @Month, Year = @Year, BankDeposits = @BankDeposits, OutOfState = @OutOfState, Wholesale = @Wholesale, Consignments = @Consignments, Motorized = @Motorized, StoreUse = @Use, Notes = @Notes WHERE MonthlyRevenueID = MonthlyRevenueID";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Month", Month);
            command.Parameters.AddWithValue("@Year", Year);
            command.Parameters.AddWithValue("@BankDeposits", BankDeposits);
            command.Parameters.AddWithValue("@OutOfState", OutOfState);
            command.Parameters.AddWithValue("@Wholesale", Wholesale);
            command.Parameters.AddWithValue("@Consignments", Consignments);
            command.Parameters.AddWithValue("@Motorized", Motorized);
            command.Parameters.AddWithValue("@Use", Use);
            command.Parameters.AddWithValue("@Notes", Notes);
            command.Parameters.AddWithValue("@MonthlyRevenueIDs", MonthlyRevenueID);

            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
        }

        public void SetMonthlyRevenue()
        {
            MonthlyRevenue monthlyRevenue = new MonthlyRevenue();
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT TOP 1 * FROM MonthlyRevenue WHERE Year = @Year AND Month = @Month";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Month", Month);
            command.Parameters.AddWithValue("@Year", Year);

            connection.Open();
            reader = command.ExecuteReader();

            while (reader.Read())
            {
                MonthlyRevenueID = reader["MonthlyRevenueID"].ToString();
                Month = Convert.ToInt16(reader["Month"]);
                Year = Convert.ToInt16(reader["Year"]);
                BankDeposits = Convert.ToDecimal(reader["BankDeposits"]);
                OutOfState = Convert.ToDecimal(reader["OutOfState"]);
                Wholesale = Convert.ToDecimal(reader["Wholesale"]);
                Consignments = Convert.ToDecimal(reader["Consignment"]);
                Motorized = Convert.ToDecimal(reader["Motorized"]);
                Use = Convert.ToDecimal(reader["StoreUse"]);
                Notes = reader["Notes"].ToString();

            }
            reader.Close();
            connection.Close();
        }

        public List<MonthlyRevenue> AllMonthlyRevenues()
        {
            List<MonthlyRevenue> list = new List<MonthlyRevenue>();
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM MonthlyRevenue ORDER BY Year, Month";

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();
            while (reader.Read())
            {
                MonthlyRevenue item = new MonthlyRevenue();
                item.BankDeposits = Convert.ToDecimal(reader["BankDeposits"]);
                item.Consignments = Convert.ToDecimal(reader["Consignmet"]);
                item.Month = Convert.ToInt16(reader["Month"]);
                item.MonthlyRevenueID = reader["MonthlyRevenueID"].ToString();
                item.Motorized = Convert.ToDecimal(reader["Motorized"]);
                item.Notes = reader["Notes"].ToString();
                item.OutOfState = Convert.ToDecimal(reader["OutOfState"]);
                item.Use = Convert.ToDecimal(reader["StoreUse"]);
                item.Wholesale = Convert.ToDecimal(reader["Wholesale"]);
                item.Year = Convert.ToInt16(reader["Year"]);

                list.Add(item);
            }
            reader.Close();
            connection.Close();
            return list;


        }

        public List<int> Months()
        {
            List<int> list = new List<int>();
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT DISTINCT Month FROM MonthlyRevenue ORDER BY Month";

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();
            while (reader.Read())
            {
                int month = Convert.ToInt16(reader["Month"]);
                list.Add(month);
            }
            reader.Close();
            connection.Close();

            return list;
        }

        public List<int> Years()
        {
            List<int> list = new List<int>();
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT DISTINCT Year FROM MonthlyRevenue ORDER BY Year";

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();
            while (reader.Read())
            {
                int year = Convert.ToInt16(reader["Year"]);
                list.Add(year);
            }
            reader.Close();
            connection.Close();

            return list;
        }

        public List<RevenueItem> CurrentRevenueItems
        {
            get
            {
                List<RevenueItem> list = new List<RevenueItem>();
                MyConnection currentConnection = new MyConnection();
                SqlConnection connection = currentConnection.CurrentConnection;
                SqlCommand command;
                SqlDataReader reader;
                string query;

                query = "SELECT * FROM RevenueItem WHERE MonthlyRevenueRef = @MonthlyRevenueRef";
                command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@MonthlyRevenueRef", MonthlyRevenueID);

                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    RevenueItem item = new RevenueItem();
                    item.RevenueItemID = reader["RevenueItemID"].ToString();
                    item.MonthlyRevenueRef = MonthlyRevenueID;
                    item.Title = reader["Title"].ToString();
                    item.Notes = reader["Notes"].ToString();
                    item.Amount = Convert.ToDecimal(reader["Amount"]);

                    list.Add(item);
                }
                connection.Close();
                return list;
            }
        }
    }
}