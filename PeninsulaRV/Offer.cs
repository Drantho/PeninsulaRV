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
    public class Offer
    {
        private string offerID, consignmentRef, buyerRef, tradeInfo, exemptReason, newLienHolder, status;
        private decimal salePrice, documentFee, optionTotal, licenseFee, salesTax, subTotal, grandTotal, balanceDue, tradeCredit, tradeTaxCredit, cashWithOrder, deposit, sellerPaidFee, dealerCost, grossProfit, sellerDue;
        private string salesmanCommissionPercent, salesmanCommission;
        private bool taxExempt;
        private DateTime saleDate;
        private List<SaleOption> options;
        private List<Salesman> salesmen;

        public Customer buyer = new Customer();
        public Consignment saleConsignment = new Consignment();

        public string OfferID
        {
            get { return offerID; }
            set { offerID = value; }
        }
        public string ConsignmentRef
        {
            get { return consignmentRef; }
            set { consignmentRef = value; }
        }
        public string BuyerRef
        {
            get { return buyerRef; }
            set { buyerRef = value; }
        }
        public string TradeInfo
        {
            get { return tradeInfo; }
            set { tradeInfo = value; }
        }
        public string ExemptReason
        {
            get { return exemptReason; }
            set { exemptReason = value; }
        }
        public string NewLienHolder
        {
            get { return newLienHolder; }
            set { newLienHolder = value; }
        }
        public string Status
        {
            get { return status; }
            set { status = value; }
        }
        public decimal SalePrice
        {
            get { return salePrice; }
            set { salePrice = value; }
        }
        public decimal DocumentFee
        {
            get { return documentFee; }
            set { documentFee = value; }
        }
        public decimal OptionTotal
        {
            get { return optionTotal; }
            set { optionTotal = value; }
        }
        public decimal LicenseFee
        {
            get { return licenseFee; }
            set { licenseFee = value; }
        }
        public decimal SalesTax
        {
            get { return salesTax; }
            set { salesTax = value; }
        }
        public decimal SubTotal
        {
            get { return subTotal; }
            set { subTotal = value; }
        }
        public decimal GrandTotal
        {
            get { return grandTotal; }
            set { grandTotal = value; }
        }
        public decimal BalanceDue
        {
            get { return balanceDue; }
            set { balanceDue = value; }
        }
        public decimal TradeCredit
        {
            get { return tradeCredit; }
            set { tradeCredit = value; }
        }
        public decimal TradeTaxCredit
        {
            get { return tradeTaxCredit; }
            set { tradeTaxCredit = value; }
        }
        public decimal CashWithOrder
        {
            get { return cashWithOrder; }
            set { cashWithOrder = value; }
        }
        public decimal Deposit
        {
            get { return deposit; }
            set { deposit = value; }
        }
        public decimal SellerPaidFee
        {
            get { return sellerPaidFee; }
            set { sellerPaidFee = value; }
        }
        public decimal DealerCost
        {
            get { return dealerCost; }
            set { dealerCost = value; }
        }        
        public decimal GrossProfit
        {
            get { return grossProfit; }
            set { grossProfit = value; }
        }
        public decimal SellerDue
        {
            get { return sellerDue; }
            set { sellerDue = value; }
        }
        public bool TaxExempt
        {
            get { return taxExempt; }
            set { taxExempt = value; }
        }
        public DateTime SaleDate
        {
            get { return saleDate; }
            set { saleDate = value; }
        }
        public Customer Buyer
        {
            get { return buyer; }
            set { buyer = value; }
        }
        public Consignment SaleConsignment
        {
            get { return saleConsignment; }
            set { saleConsignment = value; }
        }
        public List<SaleOption> Options
        {
            get { return options; }
            set { options = value; }
        }
        public List<Salesman> Salesmen
        {
            get { return salesmen; }
            set { salesmen = value; }
        }

        public Offer() { }

        public Offer (string offerID)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;
            
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM OfferView WHERE OfferID = @OfferID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OfferID", offerID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                OfferID = reader["OfferID"].ToString();
                SaleDate = Convert.ToDateTime(reader["SaleDate"]);
                ConsignmentRef = reader["ConsignmentRef"].ToString();
                BuyerRef = reader["BuyerRef"].ToString();
                TradeInfo = reader["TradeInfo"].ToString();
                ExemptReason = reader["ExemptReason"].ToString();
                NewLienHolder = reader["NewLienHolder"].ToString();
                Status = reader["OfferStatus"].ToString();
                SalePrice = Convert.ToDecimal(reader["SalePrice"]);
                OptionTotal = Convert.ToDecimal(reader["OptionsPrice"]);
                DocumentFee = Convert.ToDecimal(reader["DocumentFee"]);
                LicenseFee = Convert.ToDecimal(reader["LicenseFee"]);
                SalesTax = Convert.ToDecimal(reader["SalesTax"]);
                SubTotal = Convert.ToDecimal(reader["SubTotal"]);
                GrandTotal = Convert.ToDecimal(reader["GrandTotal"]);
                BalanceDue = Convert.ToDecimal(reader["BalanceDue"]);
                TradeCredit = Convert.ToDecimal(reader["TradeCredit"]);
                TradeTaxCredit = Convert.ToDecimal(reader["TradeTaxCredit"]);
                CashWithOrder = Convert.ToDecimal(reader["CashWithOrder"]);
                Deposit = Convert.ToDecimal(reader["Deposit"]);
                SellerPaidFee = Convert.ToDecimal(reader["SellerPaidFee"]);
                DealerCost = Convert.ToDecimal(reader["DealerCost"]);
                GrossProfit = Convert.ToDecimal(reader["Commission"]);
                SellerDue = Convert.ToDecimal(reader["SellerDue"]);

            }

            Customer newCustomer = new Customer();

            newCustomer = newCustomer.GetCustomer(this.BuyerRef);

            this.Buyer = newCustomer;

            Consignment newConsignment = new Consignment();
            newConsignment = newConsignment.GetConsignment(this.ConsignmentRef);

            this.Salesmen = GetSalesmen();
            this.Options = GetOptions();

            this.SaleConsignment = newConsignment;
        }

        public Offer GetOffer(string offerID)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            Offer newOffer = new Offer();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM OfferView WHERE OfferID = @OfferID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OfferID", offerID);

            reader = command.ExecuteReader();            

            while (reader.Read())
            {
                newOffer.OfferID = reader["OfferID"].ToString();
                this.OfferID = reader["OfferID"].ToString();
                newOffer.SaleDate = Convert.ToDateTime(reader["SaleDate"]);
                newOffer.ConsignmentRef = reader["ConsignmentRef"].ToString();
                newOffer.BuyerRef = reader["BuyerRef"].ToString();
                newOffer.TradeInfo = reader["TradeInfo"].ToString();
                newOffer.ExemptReason = reader["ExemptReason"].ToString();
                newOffer.NewLienHolder = reader["NewLienHolder"].ToString();
                newOffer.Status = reader["OfferStatus"].ToString();
                newOffer.SalePrice = Convert.ToDecimal(reader["SalePrice"]);
                newOffer.OptionTotal = Convert.ToDecimal(reader["OptionsPrice"]);
                newOffer.DocumentFee = Convert.ToDecimal(reader["DocumentFee"]);
                newOffer.LicenseFee = Convert.ToDecimal(reader["LicenseFee"]);
                newOffer.SalesTax = Convert.ToDecimal(reader["SalesTax"]);
                newOffer.SubTotal = Convert.ToDecimal(reader["SubTotal"]);
                newOffer.GrandTotal = Convert.ToDecimal(reader["GrandTotal"]);
                newOffer.BalanceDue = Convert.ToDecimal(reader["BalanceDue"]);
                newOffer.TradeCredit = Convert.ToDecimal(reader["TradeCredit"]);
                newOffer.TradeTaxCredit = Convert.ToDecimal(reader["TradeTaxCredit"]);
                newOffer.CashWithOrder = Convert.ToDecimal(reader["CashWithOrder"]);
                newOffer.Deposit = Convert.ToDecimal(reader["Deposit"]);
                newOffer.SellerPaidFee = Convert.ToDecimal(reader["SellerPaidFee"]);
                newOffer.DealerCost = Convert.ToDecimal(reader["DealerCost"]);
                newOffer.GrossProfit = Convert.ToDecimal(reader["Commission"]);
                newOffer.SellerDue = Convert.ToDecimal(reader["SellerDue"]);

            }

            Customer newCustomer = new Customer();

            newCustomer = newCustomer.GetCustomer(newOffer.BuyerRef);

            newOffer.Buyer = newCustomer;

            Consignment newConsignment = new Consignment();
            newConsignment = newConsignment.GetConsignment(newOffer.ConsignmentRef);
            
            newOffer.Salesmen = GetSalesmen();
            newOffer.Options = GetOptions();

            newOffer.SaleConsignment = newConsignment;

            return newOffer;
        }

        public string AddOfferToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, strID;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);
            
            query = "INSERT INTO Offer(ConsignmentRef, Buyerref, SalePrice, SaleDate, DocumentFee, LicenseFee, TradeInfo, TradeCredit, TradeTaxCredit, TaxExempt, ExemptReason, CashWithOrder, Deposit, SellerPaidFee, DealerCost, NewLienHolder, Status)";
            query += "Values(@ConsignmentRef, @Buyerref, @SalePrice, @SaleDate, @DocumentFee, @LicenseFee, @TradeInfo, @TradeCredit, @TradeTaxCredit, @TaxExempt, @ExemptReason, @CashWithOrder, @Deposit, @SellerPaidFee, @DealerCost, @NewLienHolder, @Status)";
            query += "SELECT Scope_Identity()";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@ConsignmentRef", ConsignmentRef);
            command.Parameters.AddWithValue("@BuyerRef", BuyerRef);
            command.Parameters.AddWithValue("@SalePrice", SalePrice);
            command.Parameters.AddWithValue("@SaleDate", SaleDate);
            command.Parameters.AddWithValue("@DocumentFee", DocumentFee);
            command.Parameters.AddWithValue("@LicenseFee", LicenseFee);
            command.Parameters.AddWithValue("@TradeInfo", TradeInfo);
            command.Parameters.AddWithValue("@TradeCredit", TradeCredit);
            command.Parameters.AddWithValue("@TradeTaxCredit", TradeTaxCredit);
            command.Parameters.AddWithValue("@TaxExempt", TaxExempt);
            command.Parameters.AddWithValue("@ExemptReason", ExemptReason);
            command.Parameters.AddWithValue("@CashWithOrder", CashWithOrder);
            command.Parameters.AddWithValue("@Deposit", Deposit);
            command.Parameters.AddWithValue("@SellerPaidFee", SellerPaidFee);
            command.Parameters.AddWithValue("@DealerCost", DealerCost);
            command.Parameters.AddWithValue("@NewLienHolder", NewLienHolder);
            command.Parameters.AddWithValue("@Status", Status);

            strID =  command.ExecuteScalar().ToString();

            //foreach(SaleOption saleOption in Options)
            //{
                //saleOption.AddOptionToDatabase();
            //}

            //foreach (Salesman newSalesman in Salesmen)
            //{
                //newSalesman.AddSalesmanToDatabase();
            //}

            connection.Close();

            return strID;
            
        }        

        private void SetSalesman()
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;
            List<string> listSalesman = new List<string>();
            List<decimal> listSalesmanCommissionPercent = new List<decimal>();
            List<decimal> listSalesmanCommission = new List<decimal>();

            Offer newOffer = new Offer();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Salesman WHERE OfferRef = @OfferRef";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OfferRef", OfferID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {                
                listSalesman.Add(reader["Name"].ToString());
                listSalesmanCommissionPercent.Add(Convert.ToDecimal(reader["CommissionPercent"]));
            }

            reader.Close();
            connection.Close();            

        }

        private void AddSalesmanToDatabase(string str, decimal dec)
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO Salesman(OfferRef, Name, CommissionPercent)VALUES(@OfferRef, @Name, @CommissionPercent)";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@OfferRef", OfferID);
            command.Parameters.AddWithValue("@Name", str);
            command.Parameters.AddWithValue("@CommissionPercent", dec);

            command.ExecuteNonQuery();

            connection.Close();
        }        

        public void UpdateAll()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);
            
            query = "UPDATE Offer SET  SalePrice = @SalePrice, SaleDate = @SaleDate, DocumentFee = @DocumentFee, LicenseFee = @LicenseFee, TradeInfo = @TradeInfo, TradeCredit = @TradeCredit, TradeTaxCredit = @TradeTaxCredit, TaxExempt = @TaxExempt, ExemptReason = @ExemptReason, CashWithOrder = @CashWithOrder, Deposit = @Deposit, SellerPaidFee = @SellerPaidFee, DealerCost = @DealerCost, NewLienHolder = @NewLienHolder, Status = @Status where OfferID = @OfferID";

            connection.Open();

            command = new SqlCommand(query, connection);
            
            command.Parameters.AddWithValue("@SalePrice", SalePrice);
            command.Parameters.AddWithValue("@SaleDate", SaleDate);
            command.Parameters.AddWithValue("@DocumentFee", DocumentFee);
            command.Parameters.AddWithValue("@LicenseFee", LicenseFee);
            command.Parameters.AddWithValue("@TradeInfo", TradeInfo);
            command.Parameters.AddWithValue("@TradeCredit", TradeCredit);
            command.Parameters.AddWithValue("@TradeTaxCredit", TradeTaxCredit);
            command.Parameters.AddWithValue("@TaxExempt", TaxExempt);
            command.Parameters.AddWithValue("@ExemptReason", ExemptReason);
            command.Parameters.AddWithValue("@CashWithOrder", CashWithOrder);
            command.Parameters.AddWithValue("@Deposit", Deposit);
            command.Parameters.AddWithValue("@SellerPaidFee", SellerPaidFee);
            command.Parameters.AddWithValue("@DealerCost", DealerCost);
            //command.Parameters.AddWithValue("@Salesman", GetStringString(Salesman));
            //command.Parameters.AddWithValue("@SalesmanCommissionPercent", GetString(decSalesmanCommissionPercent));
            command.Parameters.AddWithValue("@NewLienHolder", NewLienHolder);
            command.Parameters.AddWithValue("@Status", Status);
            command.Parameters.AddWithValue("@OfferID", OfferID);

            command.ExecuteNonQuery();

            connection.Close();
        }

        public void UpdateOffer(string field, string value)
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Offer SET " + field + " = @" + field + " WHERE offerID = @OfferID";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@" + field, value);
            command.Parameters.AddWithValue("@OfferID", OfferID);

            command.ExecuteNonQuery();

            connection.Close();

        }

        public DataSet GetCurrentOffers()
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Offerview where offerstatus = 'offer'";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }

        public List<Offer> OffersByMonth(int month, int year) {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            List<string> offerIDs = new List<string>();
            List<Offer> offers = new List<Offer>();
                 
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT OfferID FROM OfferView WHERE DatePart(MM, SaleDate) = @Month AND DatePart(YYYY, SaleDate) = @Year ";
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Month", month);
            command.Parameters.AddWithValue("@Year", year);

            connection.Open();

            reader = command.ExecuteReader();
            while (reader.Read())
            {
                offerIDs.Add(reader["OfferID"].ToString());
            }
            reader.Close();
            connection.Close();

            foreach(string offerID in offerIDs)
            {
                Offer newOffer = new Offer(offerID);
                offers.Add(newOffer);
            }
            return offers;            
        }

        public List<Salesman> GetSalesmen()
        {
            List<Salesman> offerSalesmen = new List<PeninsulaRV.Salesman>();

            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;
            
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Salesman WHERE OfferRef = @OfferRef";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OfferRef", OfferID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                Salesman newSalesman = new Salesman();
                newSalesman.SalesmanID = reader["SalesmanID"].ToString();
                newSalesman.Name = reader["Name"].ToString();
                newSalesman.OfferRef = reader["OfferRef"].ToString();
                newSalesman.CommissionPercent = Convert.ToDecimal(reader["CommissionPercent"]);

                offerSalesmen.Add(newSalesman);
            }

            connection.Close();

            return offerSalesmen;
        }

        public List<SaleOption> GetOptions()
        {
            List<SaleOption> options = new List<SaleOption>();

            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM SaleOption WHERE OfferRef = @OfferRef";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OfferRef", OfferID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                SaleOption newSaleoption = new SaleOption();
                newSaleoption.OptionID = reader["OptionID"].ToString();
                newSaleoption.OfferRef = reader["OfferRef"].ToString();
                newSaleoption.Description = reader["Description"].ToString();
                newSaleoption.Price = Convert.ToDecimal(reader["Price"]);

                options.Add(newSaleoption);
            }

            connection.Close();

            return options;
        }

        public void DeleteAllSalesmen()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "DELETE FROM Salesman WHERE OfferRef = @OfferRef";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OfferRef", OfferID);

            command.ExecuteNonQuery();

            connection.Close();
        }

        public void DeleteAllOptions()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "DELETE FROM SaleOption WHERE OfferRef = @OfferRef";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OfferRef", OfferID);

            command.ExecuteNonQuery();

            connection.Close();
        }
    }
}