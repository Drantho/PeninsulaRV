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
    public class Consignment
    {
        public string consignmentID, vehicleRef, customerRef, dealType, lienHolder, status, owneType;
        public int term;
        public decimal askingPrice, minimumPrice, dealCalc, balanceOwed;
        public DateTime consignDate, expireDate;
        public Vehicle saleVehicle;
        public Customer seller;

        public string ConsignmentID {
            get { return consignmentID; }
            set { consignmentID = value; }
        }
        public string VehicleRef
        {
            get { return vehicleRef; }
            set { vehicleRef = value; }
        }
        public string CustomerRef
        {
            get { return customerRef; }
            set { customerRef = value; }
        }
        public string DealType
        {
            get { return dealType; }
            set { dealType = value; }
        }
        public string LienHolder
        {
            get { return lienHolder; }
            set { lienHolder = value; }
        }
        public string Status
        {
            get { return status; }
            set { status = value; }
        }
        public string OwnerType
        {
            get { return owneType; }
            set { owneType = value; }
        }
        public int Term
        {
            get { return term; }
            set { term = value; }
        }
        public decimal AskingPrice
        {
            get { return askingPrice; }
            set { askingPrice = value; }
        }
        public decimal MinimumPrice
        {
            get { return minimumPrice; }
            set { minimumPrice = value; }
        }
        public decimal DealCalc
        {
            get { return dealCalc; }
            set { dealCalc = value; }
        }
        public decimal BalanceOwed
        {
            get { return balanceOwed; }
            set { balanceOwed = value; }
        }
        public DateTime ConsignDate
        {
            get { return consignDate; }
            set { consignDate = value; }
        }
        public DateTime ExpireDate
        {
            get { return expireDate; }
            set { expireDate = value; }
        }
        public Vehicle SaleVehicle
        {
            get { return saleVehicle; }
            set { saleVehicle = value; }
        }
        public Customer Seller
        {
            get { return seller; }
            set { seller = value; }
        }

        public Consignment GetConsignment(string consignmentID)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            Consignment newConsignment = new Consignment();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM ConsignmentView WHERE ConsignmentID = @ConsignmentID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@ConsignmentID", consignmentID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                newConsignment.ConsignmentID = reader["ConsignmentID"].ToString();
                newConsignment.VehicleRef = reader["VehicleRef"].ToString();
                newConsignment.CustomerRef = reader["CustomerRef"].ToString();
                newConsignment.DealType = reader["DealType"].ToString();
                newConsignment.LienHolder = reader["LienHolder"].ToString();
                newConsignment.Status = reader["Status"].ToString();
                newConsignment.Term = Convert.ToInt16(reader["Term"]);
                newConsignment.AskingPrice = Convert.ToDecimal(reader["AskingPrice"]);
                newConsignment.MinimumPrice = Convert.ToDecimal(reader["MinimumPrice"]);
                newConsignment.DealCalc = Convert.ToDecimal(reader["DealCalc"]);
                newConsignment.BalanceOwed = Convert.ToDecimal(reader["BalanceOwed"]);
                newConsignment.ConsignDate = Convert.ToDateTime(reader["ConsignDate"]);
                newConsignment.ExpireDate = Convert.ToDateTime(reader["ExpireDate"]);
                newConsignment.OwnerType = reader["OwnerType"].ToString();
            }

            Customer newCustomer = new Customer();
            newCustomer = newCustomer.GetCustomer(newConsignment.CustomerRef);

            newConsignment.Seller = newCustomer;

            Vehicle newVehicle = new Vehicle();
            newVehicle = newVehicle.GetVehicle(newConsignment.VehicleRef);

            newConsignment.SaleVehicle = newVehicle;

            return newConsignment;
        }

        public string AddConsignmentToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, strID;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO Consignment(VehicleRef, CustomerRef, ConsignDate, Term, AskingPrice, MinimumPrice, DealType, DealCalc, BalanceOwed, LienHolder, Status) Values(@VehicleRef, @CustomerRef, @ConsignDate, @Term, @AskingPrice, @MinimumPrice, @DealType, @DealCalc, @BalanceOwed, @LienHolder, @Status) SELECT Scope_Identity()";

            connection.Open();

            command = new SqlCommand(query, connection);
            
            command.Parameters.AddWithValue("@VehicleRef", VehicleRef);
            command.Parameters.AddWithValue("@CustomerRef", CustomerRef);
            command.Parameters.AddWithValue("@ConsignDate", ConsignDate);
            command.Parameters.AddWithValue("@Term", Term);
            command.Parameters.AddWithValue("@AskingPrice", AskingPrice);
            command.Parameters.AddWithValue("@MinimumPrice", MinimumPrice);
            command.Parameters.AddWithValue("@DealType", DealType);
            command.Parameters.AddWithValue("@DealCalc", DealCalc);
            command.Parameters.AddWithValue("@BalanceOwed", BalanceOwed);
            command.Parameters.AddWithValue("@LienHolder", LienHolder);
            command.Parameters.AddWithValue("@Status", Status);

            strID = command.ExecuteScalar().ToString();

            connection.Close();

            return strID;

        }

        public void UpdateAll()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Consignment SET VehicleRef = @VehicleRef, CustomerRef = @CustomerRef, ConsignDate = @ConsignDate, Term = @Term, AskingPrice = @AskingPrice, MinimumPrice = @MinimumPrice, DealType = @DealType, DealCalc = @DealCalc, BalanceOwed = @BalanceOwed, LienHolder = @LienHolder, Status = @Status where ConsignmentID = @ConsignmentID";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@VehicleRef", VehicleRef);
            command.Parameters.AddWithValue("@CustomerRef", CustomerRef);
            command.Parameters.AddWithValue("@ConsignDate", ConsignDate);
            command.Parameters.AddWithValue("@Term", Term);
            command.Parameters.AddWithValue("@AskingPrice", AskingPrice);
            command.Parameters.AddWithValue("@MinimumPrice", MinimumPrice);
            command.Parameters.AddWithValue("@DealType", DealType);
            command.Parameters.AddWithValue("@DealCalc", DealCalc);
            command.Parameters.AddWithValue("@LienHolder", LienHolder);
            command.Parameters.AddWithValue("@Status", Status);
            command.Parameters.AddWithValue("@BalanceOwed", BalanceOwed);
            command.Parameters.AddWithValue("@ConsignmentID", ConsignmentID);

            command.ExecuteNonQuery();

            connection.Close();
        }

        public void UpdateConsignment(string field, string value)
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Consignment SET " + field + " = @" + field + " WHERE ConsignmentID = @ConsignmentID";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@" + field, value);
            command.Parameters.AddWithValue("@ConsignmentID", ConsignmentID);

            command.ExecuteNonQuery();

            connection.Close();

        }

        public DataSet GetCurrentConsignments()
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT  Customer.firstname, customer.lastname, customer.city, customer.state, customer.address, customer.phonenumber, customer.altphonenumber, Consignment.ConsignmentID, Vehicle.VehicleType, Vehicle.VehicleID, Vehicle.StockNumber, Consignment.Status As ConsignmentStatus, Vehicle.Make, Vehicle.Model, Vehicle.ModelYear, Vehicle.VIN, Vehicle.Mileage, Consignment.AskingPrice, IsNull(Offer.Status, 'No Offers') As OfferStatus, Offer.SaleDate, Salesman.Name As Salesman  FROM Consignment  INNER JOIN Vehicle  ON Consignment.VehicleRef = Vehicle.VehicleID  INNER JOIN Customer  ON Consignment.CustomerRef = Customer.CustomerID   left outer JOIN     Offer ON       Offer.OfferID =          (          SELECT  TOP 1 OfferID           FROM    Offer          WHERE   ConsignmentRef = Consignment.ConsignmentID          ORDER BY SaleDate DESC          )  left outer JOIN     Salesman ON       Salesman.OfferRef =          (          SELECT  TOP 1 OfferRef           FROM    Salesman          WHERE   OfferRef = Offer.OfferID          )           WHERE Consignment.Status = 'Active'  ORDER BY VehicleType, ModelYear DESC";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }
    }
}