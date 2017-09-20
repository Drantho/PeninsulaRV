using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace PeninsulaRV.secure
{
    [Serializable]
    public class Sale
    {
        private Customer buyer, seller;
        private Vehicle saleVehicle;
        private string saleID, optionsList, optionsPriceList, salesman1, salesman2, salesman3, newLienHolderName, newLienHolderAddress, lienHolder;
        private string[] optionsArray;
        private DateTime consignDate, expireDate, saleDate, deliveryDate;
        private bool percentDeal, excessOfDeal, flatFeeDeal, complete, taxExempt;
        private decimal askingPrice, customerPrice, commissionPercent, feeAmount, salePrice, grossProfit, salesTax, optionsPriceTotal, cashWithOrder, deposit;
        private decimal tradeCredit, tradeBalanceOwed, tradeAllowance, totalCredit, totalOwed, salesmanCommissionPercent1, salesmanCommissionPercent2, salesmanCommissionPercent3;
        private decimal salesmanCommission1, salesmanCommission2, salesmanCommission3, documentFee, licenseFee, grandTotalSale, balanceOwed;
        private string[] optionsPriceArray;

        public Customer Buyer
        {
            get { return buyer; }
            set { buyer = value; }
        }
        public Customer Seller
        {
            get { return seller; }
            set { seller = value; }
        }
        public Vehicle SaleVehicle
        {
            get { return saleVehicle; }
            set { saleVehicle = value; }
        }

        public string SaleID
        {
            get { return saleID; }
            set { saleID = value; }
        }
        public string OptionsList
        {
            get { return optionsList; }
            set { optionsList = value; }
        }
        public string OptionsPriceList
        {
            get { return optionsPriceList; }
            set { optionsPriceList = value; }
        }
        public string Salesman1
        {
            get { return salesman1; }
            set { salesman1 = value; }
        }
        public string Salesman2
        {
            get { return salesman2; }
            set { salesman2 = value; }
        }
        public string Salesman3
        {
            get { return salesman3; }
            set { salesman3 = value; }
        }
        public string NewLienHolderName
        {
            get { return newLienHolderName; }
            set { newLienHolderName = value; }
        }
        public string NewLienHolderAddress
        {
            get { return newLienHolderAddress; }
            set { newLienHolderAddress = value; }
        }
        public string LienHolder
        {
            get { return lienHolder; }
            set { lienHolder = value; }
        }

        public string[] OptionsArray
        {
            get{
                optionsArray = optionsList.Split('~');
                return optionsArray;
            }
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
        public DateTime SaleDate
        {
            get { return saleDate; }
            set { saleDate = value; }
        }
        public DateTime DeliveryDate
        {
            get { return deliveryDate; }
            set { deliveryDate = value; }
        }

        public bool PercentDeal
        {
            get { return percentDeal; }
            set { percentDeal = value; }
        }
        public bool ExcessOfDeal
        {
            get { return excessOfDeal; }
            set { excessOfDeal = value; }
        }
        public bool FlatFeeDeal
        {
            get { return flatFeeDeal; }
            set { flatFeeDeal = value; }
        }
        public bool Complete
        {
            get { return complete; }
            set { complete = value; }
        }
        public bool TaxExempt
        {
            get { return taxExempt; }
            set { taxExempt = value; }
        }

        public decimal CustomerPrice
        {
            get { return customerPrice; }
            set { customerPrice = value; }
        }
        public decimal AskingPrice
        {
            get { return askingPrice; }
            set { askingPrice = value; }
        }

        public decimal CommissionPercent
        {
            get { return commissionPercent; }
            set { commissionPercent = value; }
        }
        public decimal FeeAmount
        {
            get { return feeAmount; }
            set { feeAmount = value; }
        }
        public decimal SalePrice
        {
            get { return salePrice; }
            set { salePrice = value; }
        }
        public decimal GrossProfit
        {
            get { return grossProfit; }
            set { grossProfit = value; }
        }
        public decimal SalesTax
        {
            get { return salesTax; }
            set { salesTax = value; }
        }
        public decimal OptionsPriceTotal
        {
            get { return optionsPriceTotal; }
            set { optionsPriceTotal = value; }
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
        public decimal TradeCredit
        {
            get { return tradeCredit; }
            set { tradeCredit = value; }
        }
        public decimal TradeBalanceOwed
        {
            get { return tradeBalanceOwed; }
            set { tradeBalanceOwed = value; }
        }
        public decimal TradeAllowance
        {
            get { return tradeAllowance; }
            set { tradeAllowance = value; }
        }
        public decimal TotalCredit
        {
            get { return totalCredit; }
            set { totalCredit = value; }
        }
        public decimal TotalOwed
        {
            get { return totalOwed; }
            set { totalOwed = value; }
        }
        public decimal SalesmanCommissionPercent1
        {
            get { return salesmanCommissionPercent1; }
            set { salesmanCommissionPercent1 = value; }
        }
        public decimal SalesmanCommissionPercent2
        {
            get { return salesmanCommissionPercent2; }
            set { salesmanCommissionPercent2 = value; }
        }
        public decimal SalesmanCommissionPercent3
        {
            get { return salesmanCommissionPercent3; }
            set { salesmanCommissionPercent3 = value; }
        }
        public decimal SalesmanCommission1
        {
            get { return salesmanCommission1; }
            set { salesmanCommission1 = value; }
        }
        public decimal SalesmanCommission2
        {
            get { return salesmanCommission2; }
            set { salesmanCommission2 = value; }
        }
        public decimal SalesmanCommission3
        {
            get { return salesmanCommission3; }
            set { salesmanCommission3 = value; }
        }
        public decimal DocumentFee
        {
            get { return documentFee; }
            set { documentFee = value; }
        }
        public decimal LicenseFee
        {
            get { return licenseFee; }
            set { licenseFee = value; }
        }
        public decimal GrandTotalSale
        {
            get { return grandTotalSale; }
            set { grandTotalSale = value; }
        }
        public decimal BalanceOwed
        {
            get { return balanceOwed; }
            set { balanceOwed = value; }
        }

        public string[] OptionsPriceArray
        {
            get
            {
                optionsPriceArray = optionsPriceList.Split('~');
                return optionsPriceArray;
            }
        }

        public string AddSaleToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO Sale(SellerRef, VehicleRef, AskingPrice, PercentDeal, ExcessOfDeal, FixedAmountDeal, CustomerPrice, CommissionPercent, FeeAmount, ConsignDate, ExpireDate, LienHolder, BalanceOwed)Values(@SellerRef, @VehicleRef, @AskingPrice, @PercentDeal, @ExcessOfDeal, @FixedAmountDeal, @CustomerPrice, @CommissionPercent, @FeeAmount, @ConsignDate, @ExpireDate, @LienHolder, @BalanceOwed) SELECT Scope_Identity()";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.Add(SetDBNullIfEmpty("@SellerRef", Seller.CustomerID));
            command.Parameters.Add(SetDBNullIfEmpty("@VehicleRef", SaleVehicle.VehicleID));
            command.Parameters.Add(SetDBNullIfEmpty("@AskingPrice", AskingPrice.ToString()));
            command.Parameters.AddWithValue("@PercentDeal", PercentDeal);
            command.Parameters.AddWithValue("@ExcessOfDeal", ExcessOfDeal);
            command.Parameters.AddWithValue("@FixedAmountDeal", FlatFeeDeal);
            command.Parameters.Add(SetDBNullIfEmpty("@CustomerPrice", CustomerPrice.ToString()));
            command.Parameters.Add(SetDBNullIfEmpty("@CommissionPercent", CommissionPercent.ToString()));
            command.Parameters.Add(SetDBNullIfEmpty("@FeeAmount", FeeAmount.ToString()));
            command.Parameters.Add(SetDBNullIfEmpty("@ConsignDate", ConsignDate.ToString()));
            command.Parameters.Add(SetDBNullIfEmpty("@ExpireDate", ExpireDate.ToString()));
            command.Parameters.Add(SetDBNullIfEmpty("@LienHolder", LienHolder.ToString()));
            command.Parameters.Add(SetDBNullIfEmpty("@BalanceOwed", BalanceOwed.ToString()));

            return command.ExecuteScalar().ToString();
            
        }

        public void SellVehicle()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Sale SET";
            query += " BuyerRef = @BuyerRef";
            query += ", OptionsDescription = @OptionsDescription";
            query += ", OptionsPrice = @OptionsPrice";
            query += ", OptionsTotal = @OptionsTotal";
            query += ", Salesman = @Salesman";
            query += ", Salesman2 = @Salesman2";
            query += ", Salesman3 = @Salesman3";
            query += ", newLienHolderName = @newLienHolderName";
            query += ", NewLienHolderAddress = @NewLienHolderAddress";
            query += ", SaleDate = @SaleDate";
            query += ", DeliveryDate = @DeliveryDate";
            query += ", TaxExempt = @TaxExempt";
            query += ", SalePrice = @SalePrice";
            query += ", GrossProfit = @GrossProfit";
            query += ", SalesTax = @SalesTax";
            query += ", CashWithOrder = @CashWithOrder";
            query += ", Deposit = @Deposit";
            query += ", TradeCredit = @TradeCredit";
            query += ", TradeBalanceOwed = @TradeBalanceOwed";
            query += ", TradeAllowance = @TradeAllowance";
            query += ", TotalCredit = @TotalCredit";
            query += ", TotalOwed = @TotalOwed";
            query += ", SalesmanCommissionPercent = @SalesmanCommissionPercent";
            query += ", SalesmanCommissionPercent2 = @SalesmanCommissionPercent2";
            query += ", salesmanCommissionPercent3 = @salesmanCommissionPercent3";
            query += ", Commission = @Commission";
            query += ", salesmanCommission2 = @salesmanCommission2";
            query += ", salesmanCommission3 = @salesmanCommission3";
            query += ", DocumentFee = @DocumentFee";
            query += ", LicenseFee = @LicenseFee";
            query += ", GrandTotalSale = @GrandTotalSale";
            query += " WHERE SaleID = @SaleID";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@BuyerRef", Buyer.CustomerID);
            command.Parameters.AddWithValue("@OptionsDescription", OptionsList);
            command.Parameters.AddWithValue("@OptionsPrice", OptionsPriceList);
            command.Parameters.AddWithValue("@OptionsTotal", OptionsPriceTotal);
            command.Parameters.AddWithValue("@Salesman", Salesman1);
            command.Parameters.AddWithValue("@Salesman2", Salesman2);
            command.Parameters.AddWithValue("@Salesman3", Salesman3);
            command.Parameters.AddWithValue("@newLienHolderName", NewLienHolderName);
            command.Parameters.AddWithValue("@NewLienHolderAddress", NewLienHolderAddress);
            command.Parameters.AddWithValue("@SaleDate", SaleDate);
            command.Parameters.AddWithValue("@DeliveryDate", DeliveryDate);
            command.Parameters.AddWithValue("@TaxExempt", TaxExempt);
            command.Parameters.AddWithValue("@SalePrice", SalePrice);
            command.Parameters.AddWithValue("@GrossProfit", GrossProfit);
            command.Parameters.AddWithValue("@SalesTax", SalesTax);
            command.Parameters.AddWithValue("@CashWithOrder", CashWithOrder);
            command.Parameters.AddWithValue("@Deposit", Deposit);
            command.Parameters.AddWithValue("@TradeCredit", TradeCredit);
            command.Parameters.AddWithValue("@TradeBalanceOwed", TradeBalanceOwed);
            command.Parameters.AddWithValue("@TradeAllowance", TradeAllowance);
            command.Parameters.AddWithValue("@TotalCredit", TotalCredit);
            command.Parameters.AddWithValue("@TotalOwed", TotalOwed);
            command.Parameters.AddWithValue("@SalesmanCommissionPercent", SalesmanCommissionPercent1);
            command.Parameters.AddWithValue("@SalesmanCommissionPercent2", SalesmanCommissionPercent2);
            command.Parameters.AddWithValue("@salesmanCommissionPercent3", SalesmanCommissionPercent3);
            command.Parameters.AddWithValue("@Commission", SalesmanCommission1);
            command.Parameters.AddWithValue("@salesmanCommission2", SalesmanCommission2);
            command.Parameters.AddWithValue("@salesmanCommission3", SalesmanCommission3);
            command.Parameters.AddWithValue("@DocumentFee", DocumentFee);
            command.Parameters.AddWithValue("@LicenseFee", LicenseFee);
            command.Parameters.AddWithValue("@GrandTotalSale", GrandTotalSale);
            command.Parameters.AddWithValue("@SaleID", SaleID);
            
            command.ExecuteNonQuery();

            connection.Close();

            SaleVehicle.UpdateVehicle("sold", "1");
        }

        public void UpdateSale(string field, string value)
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Sale SET " + field + " = @" + field + " WHERE SaleID = @SaleID";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@" + field, value);
            command.Parameters.AddWithValue("@SaleID", SaleID);

            command.ExecuteNonQuery();

            connection.Close();

        }

        public Sale GetSaleInfo(string saleID)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            connection.Open();

            query = "SELECT * FROM Sale WHERE SaleID = @SaleID";

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@SaleID", saleID);

            reader = command.ExecuteReader();

            Sale newSale = new Sale();
            Customer newBuyer, newSeller;
            Vehicle newVehicle;

            newBuyer = new Customer();
            newSeller = new Customer();
            newVehicle = new Vehicle();

            

            while (reader.Read())
            {
                newSale.Buyer = newBuyer;
                newSale.Seller = newSeller;
                newSale.saleVehicle = newVehicle;

                newBuyer = newBuyer.GetCustomer(reader["BuyerRef"].ToString());
                newSeller = newSeller.GetCustomer(reader["SellerRef"].ToString());
                newVehicle = newVehicle.GetVehicle(reader["VehicleRef"].ToString());

                newSale.Seller = newSeller;
                newSale.Buyer = newBuyer;
                newSale.SaleVehicle = newVehicle;

                newSale.SaleID = reader["SaleID"].ToString();

                

                if (!reader.IsDBNull(reader.GetOrdinal("OptionsDescription")))
                {
                    newSale.OptionsList = reader["OptionsDescription"].ToString();
                }
                else
                {
                    newSale.OptionsList = null;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("OptionsPrice")))
                {
                    newSale.OptionsPriceList = reader["OptionsPrice"].ToString();
                }
                else
                {
                    newSale.OptionsPriceList = null;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("Salesman")))
                {
                    newSale.Salesman1 = reader["Salesman"].ToString();
                }
                else
                {
                    newSale.Salesman1 = null;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("Salesman2")))
                {
                    newSale.Salesman2 = reader["Salesman2"].ToString();
                }
                else
                {
                    newSale.Salesman2 = null;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("Salesman3")))
                {
                    newSale.Salesman3 = reader["Salesman3"].ToString();
                }
                else
                {
                    newSale.Salesman3 = null;
                }

                if (!reader.IsDBNull(reader.GetOrdinal("NewLienHolderName")))
                {
                    newSale.NewLienHolderName = reader["NewLienHolderName"].ToString();
                }
                else
                {
                    newSale.NewLienHolderName = null;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("NewLienHolderAddress")))
                {
                    newSale.NewLienHolderAddress = reader["NewLienHolderAddress"].ToString();
                }
                else
                {
                    newSale.NewLienHolderAddress = null;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("ConsignDate")))
                {
                    newSale.ConsignDate = Convert.ToDateTime(reader["ConsignDate"]);
                }
                if (!reader.IsDBNull(reader.GetOrdinal("ExpireDate")))
                {
                    newSale.ExpireDate = Convert.ToDateTime(reader["ExpireDate"]);
                }
                if (!reader.IsDBNull(reader.GetOrdinal("SaleDate")))
                {
                    newSale.SaleDate = Convert.ToDateTime(reader["SaleDate"]);
                }
                if (!reader.IsDBNull(reader.GetOrdinal("DeliveryDate")))
                {
                    newSale.DeliveryDate = Convert.ToDateTime(reader["DeliveryDate"]);
                }
                if (!reader.IsDBNull(reader.GetOrdinal("PercentDeal")))
                {
                    newSale.PercentDeal = Convert.ToBoolean(reader["PercentDeal"]);
                }
                else
                {
                    newSale.PercentDeal = false;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("ExcessOfDeal")))
                {
                    newSale.ExcessOfDeal = Convert.ToBoolean(reader["ExcessOfDeal"]);
                }
                else
                {
                    newSale.ExcessOfDeal = false;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("FixedAmountDeal")))
                {
                    newSale.FlatFeeDeal = Convert.ToBoolean(reader["FixedAmountDeal"]);
                }
                else
                {
                    newSale.FlatFeeDeal = false;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("Complete")))
                {
                    newSale.Complete = Convert.ToBoolean(reader["Complete"]);
                }
                else
                {
                    newSale.Complete = false;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("TaxExempt")))
                {
                    newSale.TaxExempt = Convert.ToBoolean(reader["TaxExempt"]);
                }
                else
                {
                    newSale.TaxExempt = false;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("CustomerPrice")))
                {
                    newSale.CustomerPrice = Convert.ToDecimal(reader["CustomerPrice"]);
                }
                else
                {
                    newSale.CustomerPrice = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("AskingPrice")))
                {
                    newSale.AskingPrice = Convert.ToDecimal(reader["AskingPrice"]);
                }
                else
                {
                    newSale.AskingPrice = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("CommissionPercent")))
                {
                    newSale.CommissionPercent = Convert.ToDecimal(reader["CommissionPercent"]);
                }
                else
                {
                    newSale.CommissionPercent = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("FeeAmount")))
                {
                    newSale.FeeAmount = Convert.ToDecimal(reader["FeeAmount"]);
                }
                else
                {
                    newSale.FeeAmount = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("SalePrice")))
                {
                    newSale.SalePrice = Convert.ToDecimal(reader["SalePrice"]);
                }
                else
                {
                    newSale.SalePrice = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("GrossProfit")))
                {
                    newSale.GrossProfit = Convert.ToDecimal(reader["GrossProfit"]);
                }
                else
                {
                    newSale.GrossProfit = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("SalesTax")))
                {
                    newSale.SalesTax = Convert.ToDecimal(reader["SalesTax"]);
                }
                else
                {
                    newSale.SalesTax = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("OptionsTotal")))
                {
                    newSale.OptionsPriceTotal = Convert.ToDecimal(reader["OptionsTotal"]);
                }
                else
                {
                    newSale.OptionsPriceTotal = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("CashWithOrder")))
                {
                    newSale.CashWithOrder = Convert.ToDecimal(reader["CashWithOrder"]);
                }
                else
                {
                    newSale.CashWithOrder = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("Deposit")))
                {
                    newSale.Deposit = Convert.ToDecimal(reader["Deposit"]);
                }
                else
                {
                    newSale.Deposit = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("TradeCredit")))
                {
                    newSale.TradeCredit = Convert.ToDecimal(reader["TradeCredit"]);
                }
                else
                {
                    newSale.TradeCredit = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("TradeBalanceOwed")))
                {
                    newSale.TradeBalanceOwed = Convert.ToDecimal(reader["TradeBalanceOwed"]);
                }
                else
                {
                    newSale.TradeBalanceOwed = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("TradeAllowance")))
                {
                    newSale.TradeAllowance = Convert.ToDecimal(reader["TradeAllowance"]);
                }
                else
                {
                    newSale.TradeAllowance = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("TradeCredit")))
                {
                    newSale.TotalCredit = Convert.ToDecimal(reader["TradeCredit"]);
                }
                else
                {
                    newSale.TotalCredit = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("TotalOwed")))
                {
                    newSale.TotalOwed = Convert.ToDecimal(reader["TotalOwed"]);
                }
                else
                {
                    newSale.TotalOwed = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("SalesmanCommissionPercent")))
                {
                    newSale.SalesmanCommissionPercent1 = Convert.ToDecimal(reader["SalesmanCommissionPercent"]);
                }
                else
                {
                    newSale.SalesmanCommissionPercent1 = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("SalesmanCommissionPercent2")))
                {
                    newSale.SalesmanCommissionPercent2 = Convert.ToDecimal(reader["SalesmanCommissionPercent2"]);
                }
                else
                {
                    newSale.SalesmanCommissionPercent2 = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("SalesmanCommissionPercent3")))
                {
                    newSale.SalesmanCommissionPercent3 = Convert.ToDecimal(reader["SalesmanCommissionPercent3"]);
                }
                else
                {
                    newSale.SalesmanCommissionPercent3 = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("Commission")))
                {
                    newSale.SalesmanCommission1 = Convert.ToDecimal(reader["Commission"]);
                }
                else
                {
                    newSale.SalesmanCommission1 = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("Commission2")))
                {
                    newSale.SalesmanCommission2 = Convert.ToDecimal(reader["Commission2"]);
                }
                else
                {
                    newSale.SalesmanCommission2 = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("Commission3")))
                {
                    newSale.SalesmanCommission3 = Convert.ToDecimal(reader["Commission3"]);
                }
                else
                {
                    newSale.SalesmanCommission3 = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("DocumentFee")))
                {
                    newSale.DocumentFee = Convert.ToDecimal(reader["DocumentFee"]);
                }
                else
                {
                    newSale.DocumentFee = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("LicenseFee")))
                {
                    newSale.LicenseFee = Convert.ToDecimal(reader["LicenseFee"]);
                }
                else
                {
                    newSale.LicenseFee = 0;
                }                
                if (!reader.IsDBNull(reader.GetOrdinal("GrandTotalSale")))
                {
                    newSale.GrandTotalSale = Convert.ToDecimal(reader["GrandTotalSale"]);
                }
                else
                {
                    newSale.GrandTotalSale = 0;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("LienHolder")))
                {
                    newSale.LienHolder = reader["LienHolder"].ToString();
                }
                else
                {
                    newSale.LienHolder = null;
                }
                if (!reader.IsDBNull(reader.GetOrdinal("BalanceOwed")))
                {
                    newSale.BalanceOwed = Convert.ToDecimal(reader["BalanceOwed"]);
                }
                else
                {
                    newSale.BalanceOwed = 0;
                }

            }

            connection.Close();
            


            return newSale;
        }

        public DataSet GetSaleRecords(string vehicleRef)
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT SaleID, ConsignDate FROM Sale WHERE VehicleRef = @VehicleRef";

            adapter = new SqlDataAdapter(query, connection);

            adapter.SelectCommand.Parameters.AddWithValue("@VehicleRef", vehicleRef);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }

        public DataSet GetCurrentSales()
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM SaleView where active = 1 and sold = 0 ORDER BY VehicleType, ModelYear DESC";

            adapter = new SqlDataAdapter(query, connection);            

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }

        private SqlParameter SetDBNullIfEmpty(string parmName, string parmValue)
        {
            SqlParameter newSQLParameter = new SqlParameter();
            newSQLParameter.ParameterName = parmName;

            if (string.IsNullOrEmpty(parmValue))
            {
                newSQLParameter.Value = DBNull.Value;
            }
            else
            {
                newSQLParameter.Value = parmValue;
            }
            return newSQLParameter;
        }
    }
}