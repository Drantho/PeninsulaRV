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
    public class PostSale
    {
        private string postSaleID, stepName, note;
        private DateTime completeDate, dueDate;
        private int stepNumber, offerRef;
        private decimal stepCost;
        private bool complete;

        public string PostSaleID
        {
            get { return postSaleID; }
            set { postSaleID = value; }
        }
        public string StepName
        {
            get { return getStepName(); }

        }
        public string Note
        {
            get { return note; }
            set { note = value; }
        }
        public DateTime CompleteDate
        {
            get { return completeDate; }
            set { completeDate = value; }
        }
        public DateTime DueDate
        {
            get { return dueDate; }
            set { dueDate = value; }
        }
        public int StepNumber
        {
            get { return stepNumber; }
            set { stepNumber = value; }
        }
        public int OfferRef
        {
            get { return offerRef; }
            set { offerRef = value; }
        }
        public decimal StepCost
        {
            get { return stepCost; }
            set { stepCost = value; }
        }
        public bool Complete
        {
            get { return complete; }
            set { complete = value; }
        }
        public Offer LinkedOffer
        {
            get
            {
                Offer newOffer = new Offer();
                newOffer = newOffer.GetOffer(OfferRef.ToString());
                return newOffer;
            }
        }

        public PostSale() { }

        public PostSale(string _postSaleID)
        {
            SqlConnection connection = Connection();
            SqlCommand command;
            SqlDataReader reader;
            string query;

            query = "SELECT * FROM PostSale WHERE PostSaleID = @PostSaleID";
            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@PostSaleID", _postSaleID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                PostSaleID = _postSaleID;
                Note = reader["Notes"].ToString();
                CompleteDate = Convert.ToDateTime(reader["CompleteDate"]);
                DueDate = Convert.ToDateTime(reader["DueDate"]);
                StepNumber = Convert.ToInt16(reader["StepNumber"]);
                OfferRef = Convert.ToInt16(reader["OfferRef"]);
                StepCost = Convert.ToDecimal(reader["StepCost"]);
                Complete = Convert.ToBoolean(reader["Complete"]);
            }
            reader.Close();
            connection.Close();

        }

        public void AddPostSaleToDatabase() {
            SqlConnection connection = Connection();
            SqlCommand command;
            string query;

            query = "INSERT INTO PostSale(StepName, Notes, CompleteDate, DueDate, StepNumber, OfferRef, StepCost, Complete) VALUES(@StepName, @Notes, @CompleteDate, @DueDate, @StepNumber, @OfferRef, @StepCost, @Complete)";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@StepName", StepName);
            command.Parameters.AddWithValue("@Notes", Note);
            command.Parameters.AddWithValue("@CompleteDate", CompleteDate);
            command.Parameters.AddWithValue("@DueDate", DueDate);
            command.Parameters.AddWithValue("@StepNumber", StepNumber);
            command.Parameters.AddWithValue("@OfferRef", OfferRef);
            command.Parameters.AddWithValue("@StepCost", StepCost);
            command.Parameters.AddWithValue("@Complete", Complete.ToString());

            foreach (SqlParameter parameter in command.Parameters)
            {
                if (parameter.Value == null)
                {
                    parameter.Value = DBNull.Value;
                }
            }

            command.ExecuteNonQuery();
            connection.Close();
        }

        private string getStepName()
        {
            switch (StepNumber)
            {
                case 1:
                    return "Deposit Sale";
                case 2:
                    return "Pay Lienholder"; 
                case 3:
                    return "Negotiate Commission";
                case 4:
                    return "Get Ownder Payoff";
                case 5:
                    return "Pay Owner";
                case 6:
                    return "Transfer Funds";
                case 7:
                    return "License Vehicle";
                case 8:
                    return "Send Licensing";
                case 9:
                    return "Set Salesman Commission";
                default:
                    return "Not Set";
            }
        }

        public DataSet GetStepsByOffer(string _offerID)
        {
            SqlConnection connection = Connection();
            DataSet dataset;
            SqlDataAdapter adapter;
            string query;

            query = "SELECT * FROM PostSale WHERE OfferRef = @OfferRef ORDER BY StepNumber";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);
            adapter.SelectCommand.Parameters.AddWithValue("@OfferRef", _offerID);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;

        }

        public DataSet GetAllIncompleteByStep(int _stepNumber)
        {
            SqlConnection connection = Connection();
            DataSet dataset;
            SqlDataAdapter adapter;
            string query;

            query = "SELECT * FROM PostSale WHERE StepNumber = @StepNumber AND Complete = 'false' ORDER BY PostSaleID";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);
            adapter.SelectCommand.Parameters.AddWithValue("@StepNumber", _stepNumber);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }

        public DataSet GetAllIncomplete()
        {
            SqlConnection connection = Connection();
            DataSet dataset;
            SqlDataAdapter adapter;
            string query;

            query = "SELECT * FROM PostSale WHERE Complete = 'false' ORDER BY OfferRef, PostSaleID";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }

        public DataSet GetStepCountByOffer(string saleMonth, string saleYear) {
            SqlConnection connection = Connection();
            DataSet dataset;
            SqlDataAdapter adapter;
            string query;

            query = "SELECT  OfferView.OfferID,  OfferView.ConsignmentRef,  OfferView.OwnerType,  OfferView.BuyerRef,  OfferView.BuyerName,  OfferView.BuyerCity,  OfferView.BuyerState,  OfferView.BuyerZip,  OfferView.BuyerPhoneNumber,  OfferView.BuyerAltPhoneNumber,  OfferView.SellerName,  OfferView.SellerCity,  OfferView.SellerState, OfferView.SellerZip,  OfferView.SellerPhoneNumber,  OfferView.SellerAltPhoneNumber,  OfferView.VehicleID,  OfferView.Stocknumber,  OfferView.ModelYear,  OfferView.Make,  OfferView.Model,  OfferView.VehicleType,  OfferView.Motorized,  OfferView.VIN,  OfferView.Mileage,  OfferView.TradeInfo,  OfferView.ExemptReason,  OfferView.NewLienHolder,  OfferView.OfferStatus,  OfferView.SalePrice,  OfferView.DocumentFee,  OfferView.LicenseFee,  OfferView.TradeCredit,  OfferView.TradeTaxCredit,  OfferView.CashWithOrder,  OfferView.Deposit,  OfferView.SellerPaidFee,  OfferView.DealerCost,  OfferView.TaxExempt,  OfferView.SaleDate,  OfferView.OptionsPrice,  OfferView.SubTotal,  OfferView.SalesTax,  OfferView.GrandTotal,  OfferView.BalanceDue,  OfferView.TaxRate,  OfferView.DealType,  OfferView.DealCalc,  OfferView.Commission,  OfferView.SellerDue,  count(postsaleid) AS PostSaleSteps  FROM OfferView  LEFT OUTER JOIN PostSale  ON OfferView.OfferID = PostSale.OfferRef  WHERE DATEPART(mm, SaleDate)  = @SaleMonth AND DATEPART(yyyy, SaleDate) = @SaleYear AND OfferView.OfferStatus = 'Sold' GROUP BY  OfferView.OfferID,  OfferView.ConsignmentRef,  OfferView.OwnerType,  OfferView.BuyerRef,  OfferView.BuyerName,  OfferView.BuyerCity,  OfferView.BuyerState,  OfferView.BuyerZip,  OfferView.BuyerPhoneNumber,  OfferView.BuyerAltPhoneNumber,  OfferView.SellerName,  OfferView.SellerCity,  OfferView.SellerState,  OfferView.SellerZip,  OfferView.SellerPhoneNumber,  OfferView.SellerAltPhoneNumber,  OfferView.VehicleID,  OfferView.Stocknumber,  OfferView.ModelYear,  OfferView.Make,  OfferView.Model,  OfferView.VehicleType,  OfferView.Motorized,  OfferView.VIN,  OfferView.Mileage,  OfferView.TradeInfo,  OfferView.ExemptReason,  OfferView.NewLienHolder,  OfferView.OfferStatus,  OfferView.SalePrice,  OfferView.DocumentFee,  OfferView.LicenseFee,  OfferView.TradeCredit,  OfferView.TradeTaxCredit,  OfferView.CashWithOrder,  OfferView.Deposit,  OfferView.SellerPaidFee,  OfferView.DealerCost,  OfferView.TaxExempt, OfferView.SaleDate,  OfferView.OptionsPrice,  OfferView.SubTotal,  OfferView.SalesTax,  OfferView.GrandTotal,  OfferView.BalanceDue,  OfferView.TaxRate,  OfferView.DealType,  OfferView.DealCalc,  OfferView.Commission,  OfferView.SellerDue";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);
            adapter.SelectCommand.Parameters.AddWithValue("@SaleMonth", saleMonth);
            adapter.SelectCommand.Parameters.AddWithValue("@SaleYear", saleYear);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }

        public void UpdatePostSale()
        {
            SqlConnection connection = Connection();
            SqlCommand command;
            string query;

            query = "UPDATE PostSale SET Notes = @Notes, CompleteDate = @CompleteDate, DueDate = @DueDate, StepCost = @StepCost, Complete = @Complete WHERE PostSaleID = @PostSaleID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Notes", Note);
            command.Parameters.AddWithValue("@CompleteDate", CompleteDate);
            command.Parameters.AddWithValue("@DueDate", DueDate);
            command.Parameters.AddWithValue("@StepCost", StepCost);
            command.Parameters.AddWithValue("@Complete", Complete);
            command.Parameters.AddWithValue("@PostSaleID", PostSaleID);

            foreach (SqlParameter parameter in command.Parameters)
            {
                if (parameter.Value == null)
                {
                    parameter.Value = DBNull.Value;
                }
            }

            command.ExecuteNonQuery();

            connection.Close();

        }

        private SqlConnection Connection() {

            SqlConnection connection;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            return connection;
        }
    }
}