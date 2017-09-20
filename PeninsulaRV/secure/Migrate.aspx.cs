using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PeninsulaRV.secure
{
    public partial class Migrate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SqlConnection connection;
                SqlDataAdapter adapter;
                DataSet dataset;
                string query;

                Vehicle newVehicle = new Vehicle();

                connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

                query = "SELECT SaleID FROM SaleView order by saleid";

                connection.Open();

                adapter = new SqlDataAdapter(query, connection);

                dataset = new DataSet();

                adapter.Fill(dataset);

                cblSaleInfo.DataSource = dataset;
                cblSaleInfo.DataTextField = "SaleID";
                cblSaleInfo.DataValueField = "SaleID";
                cblSaleInfo.DataBind();

                connection.Close();
            }

        }
        protected void MigrateData(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM SaleView where SaleID = 0";

            foreach (ListItem li in cblSaleInfo.Items)
            {
                if (li.Selected == true)
                {
                    query += " OR SaleID = " + li.Value;
                }
            }

            connection.Open();

            command = new SqlCommand(query, connection);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                Consignment newConsignment = new Consignment();
                newConsignment.AskingPrice = Convert.ToDecimal(reader["AskingPrice"]);
                if (reader["BalanceOwed"] != System.DBNull.Value)
                {
                    newConsignment.BalanceOwed = Convert.ToDecimal(reader["BalanceOwed"]);
                }
                else
                {
                    newConsignment.BalanceOwed = 0;
                }

                newConsignment.ConsignDate = Convert.ToDateTime(reader["ConsignDate"]);
                newConsignment.CustomerRef = reader["SellerRef"].ToString();

                if (reader["ExcessOfDeal"].ToString() == "1")
                {
                    newConsignment.DealCalc = Convert.ToDecimal(reader["CustomerPrice"]);
                    newConsignment.DealType = "Excess of Deal";
                }
                else
                {
                    if (reader["FixedAmountDeal"].ToString() == "1")
                    {
                        newConsignment.DealCalc = Convert.ToDecimal(reader["FeeAmount"]);
                        newConsignment.DealType = "Flat Fee Deal";
                    }
                    else
                    {
                        if (reader["CommissionPercent"] != DBNull.Value)
                        {
                            newConsignment.DealCalc = Convert.ToDecimal(reader["CommissionPercent"]);
                            newConsignment.DealType = "Percent Deal";
                        }
                        else
                        {
                            newConsignment.DealCalc = 10;
                            newConsignment.DealType = "Percent Deal";
                        }

                    }
                }

                if (!string.IsNullOrEmpty(reader["LienHolderName"].ToString()))
                {
                    newConsignment.LienHolder = reader["LienHolderName"].ToString();
                }
                else
                {
                    newConsignment.LienHolder = "None";
                }
                if (reader["MinimumPrice"] != DBNull.Value)
                {
                    newConsignment.MinimumPrice = Convert.ToDecimal(reader["MinimumPrice"]);
                }
                else
                {
                    newConsignment.MinimumPrice = 0;
                }
                if(reader["active"] != DBNull.Value)
                {
                    if (reader["active"].ToString() == "1")
                    {
                        newConsignment.Status = "Active";
                    }
                    else
                    {
                        newConsignment.Status = "Inactive";
                    }
                }                
                else
                {
                    newConsignment.Status = "Inactive";
                }
                if(reader["sold"] != DBNull.Value)
                {
                    if (Convert.ToInt16(reader["sold"]) == 1)
                    {
                        newConsignment.Status = "Sold";
                    }
                }
                

                DateTime startDate, endDate;

                startDate = Convert.ToDateTime(reader["ConsignDate"]);
                endDate = Convert.ToDateTime(reader["ExpireDate"]);

                newConsignment.Term = Convert.ToInt32((endDate - startDate).TotalDays);

                newConsignment.VehicleRef = reader["VehicleRef"].ToString();

                newConsignment.ConsignmentID = newConsignment.AddConsignmentToDatabase();

                if (newConsignment.Status == "Sold")
                {
                    Offer newOffer = new Offer();

                    newOffer.BuyerRef = reader["BuyerRef"].ToString();
                    if (reader["cashwithorder"] != System.DBNull.Value)
                    {
                        newOffer.CashWithOrder = Convert.ToDecimal(reader["CashWithOrder"]);
                    }
                    else
                    {
                        newOffer.CashWithOrder = 0;
                    }

                    newOffer.ConsignmentRef = newConsignment.ConsignmentID;
                    if (reader["DealerCost"] != System.DBNull.Value)
                    {
                        newOffer.DealerCost = Convert.ToDecimal(reader["DealerCost"]);
                    }
                    else
                    {
                        newOffer.DealerCost = 0;
                    }
                    if (reader["deposit"] != System.DBNull.Value)
                    {
                        newOffer.Deposit = Convert.ToDecimal(reader["Deposit"]);
                    }
                    else
                    {
                        newOffer.Deposit = 0;
                    }
                    if (reader["documentfee"] != System.DBNull.Value)
                    {
                        newOffer.DocumentFee = Convert.ToDecimal(reader["DocumentFee"]);
                    }
                    else
                    {
                        newOffer.DocumentFee = 0;
                    }
                    if (reader["taxexempt"] != DBNull.Value)
                    {
                        if (reader["TaxExempt"].ToString() == "1")
                        {
                            newOffer.ExemptReason = "Exempt";
                        }
                        else
                        {
                            newOffer.ExemptReason = "Taxable";
                        }
                    }
                    else
                    {
                        newOffer.ExemptReason = "Taxable";
                    }

                    if (reader["licensefee"] != DBNull.Value)
                    {
                        newOffer.LicenseFee = Convert.ToDecimal(reader["LicenseFee"]);
                    }
                    else
                    {
                        newOffer.LicenseFee = 0;
                    }
                    if (reader["NewLienHolderName"] != DBNull.Value)
                    {
                        newOffer.NewLienHolder = reader["NewLienHolderName"].ToString();
                    }
                    else
                    {
                        newOffer.NewLienHolder = "None";
                    }
                    if (reader["SaleDate"] != DBNull.Value)
                    {
                        newOffer.SaleDate = Convert.ToDateTime(reader["SaleDate"]);
                    }
                    else
                    {
                        string newDate = "1/1/1900";
                        newOffer.SaleDate = Convert.ToDateTime(newDate);
                    }
                    if (reader["SalePrice"] != DBNull.Value)
                    {
                        newOffer.SalePrice = Convert.ToDecimal(reader["SalePrice"]);
                    }
                    else
                    {
                        newOffer.SalePrice = 0;
                    }

                    List<string> listSalesman = new List<string>();

                    if (reader["Salesman"] != System.DBNull.Value)
                    {
                        listSalesman.Add(reader["salesman"].ToString());
                    }
                    if (reader["Salesman2"] != System.DBNull.Value)
                    {
                        listSalesman.Add(reader["salesman2"].ToString());
                    }

                    //newOffer.Salesmen = listSalesman.ToArray();

                    List<decimal> listSalesmanCommissionPercent = new List<decimal>();
                    if (reader["SalesmanCommissionPercent"] != System.DBNull.Value)
                    {
                        listSalesmanCommissionPercent.Add(Convert.ToDecimal(reader["SalesmanCommissionPercent"]));
                    }
                    if (reader["SalesmanCommissionPercent2"] != System.DBNull.Value)
                    {
                        listSalesmanCommissionPercent.Add(Convert.ToDecimal(reader["SalesmanCommissionPercent2"]));
                    }

                    //newOffer.SalesmanCommissionPercent = listSalesmanCommissionPercent.ToArray();

                    if (reader["sellerPaidFee"] != System.DBNull.Value)
                    {
                        newOffer.SellerPaidFee = Convert.ToDecimal(reader["SellerPaidFee"]);
                    }
                    else
                    {
                        newOffer.SellerPaidFee = 0;
                    }

                    newOffer.Status = "Sold";
                    if (reader["TaxExempt"] != DBNull.Value)
                    {
                        newOffer.TaxExempt = (reader["TaxExempt"].ToString() == "1");
                    }
                    else
                    {
                        newOffer.TaxExempt = false;
                    }

                    if (reader["TradeCredit"] != System.DBNull.Value)
                    {
                        newOffer.TradeCredit = Convert.ToDecimal(reader["TradeCredit"]);
                        newOffer.TradeInfo = "Trade";
                        newOffer.TradeTaxCredit = Convert.ToDecimal(reader["TradeCredit"]);
                    }
                    else
                    {
                        newOffer.TradeCredit = 0;
                        newOffer.TradeInfo = "None";
                        newOffer.TradeTaxCredit = 0;
                    }


                    newOffer.AddOfferToDatabase();
                }
                lblResult.Text = "Data migrated successfully";
                cblSaleInfo.Visible = false;
            }
        }
    }
}