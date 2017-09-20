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
    public partial class SalesByMonth : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {  
        }

        protected void SelectMonth(object sender, EventArgs e)
        {
            pnlSelectMonth.Visible = false;
            pnlForm.Visible = true;

            lblReportHeader.Text = rblMonth.SelectedItem.Text + " " + rblYear.SelectedItem.Value + " Sales Report";

            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            Consignment newConsignment = new Consignment();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "select * from offerview where DatePart(MM, saleDate) = " + rblMonth.SelectedItem.Value + " AND DatePart(yyyy, saleDate) = " + rblYear.SelectedItem.Value + " and OfferStatus = 'Sold' order by OwnerType, Motorized, saledate";

            connection.Open();

            command = new SqlCommand(query, connection);

            reader = command.ExecuteReader();

            plhReport.Controls.Add(new LiteralControl("<table>"));           

            string oldOwnerType = null, newOwnerType = null, oldVehicleType = null, newVehicleType = null;
            decimal salePriceSubTotal = 0, salesTaxSubTotal = 0, salePriceTotal = 0, salesTaxTotal = 0, motorizedTotal = 0;

            int i = 1;

            while (reader.Read())
            {               
                newOwnerType = reader["OwnerType"].ToString();
                newVehicleType = reader["Motorized"].ToString();

                if (reader["Motorized"].ToString() != "Non-Motorized")
                {
                    motorizedTotal += Convert.ToDecimal(reader["SalePrice"]) + Convert.ToDecimal(reader["DocumentFee"]);
                }

                salePriceTotal += Convert.ToDecimal(reader["SalePrice"]) + Convert.ToDecimal(reader["DocumentFee"]);
                salesTaxTotal += Convert.ToDecimal(reader["SalesTax"]);
                

                if (newOwnerType != oldOwnerType)
                {
                    if(i > 1)
                    {
                        plhReport.Controls.Add(new LiteralControl("<tr><td colspan='8'><hr></td></tr>"));
                        plhReport.Controls.Add(new LiteralControl("<tr><th colspan='5' class='text-right'>Subtotal:&nbsp;</th><td class='text-right'>" + salePriceSubTotal.ToString("C") + "</td><td class='text-right'>" + salesTaxSubTotal.ToString("C") + "</td></tr>"));
                    }

                    salePriceSubTotal = 0;
                    salesTaxSubTotal = 0;

                    plhReport.Controls.Add(new LiteralControl("<tr><th colspan='8' class='text-center'><hr>" + newOwnerType + " - " + newVehicleType + "</th></tr>"));

                    plhReport.Controls.Add(new LiteralControl("<tr>"));
                    plhReport.Controls.Add(new LiteralControl("<th>Sale Date</th>"));
                    plhReport.Controls.Add(new LiteralControl("<th>Stock Number</th>"));
                    plhReport.Controls.Add(new LiteralControl("<th>Vehicle</th>"));
                    plhReport.Controls.Add(new LiteralControl("<th>Buyer</th>"));
                    plhReport.Controls.Add(new LiteralControl("<th>Seller</th>"));
                    plhReport.Controls.Add(new LiteralControl("<th class='text-right'>Sale Price</th>"));
                    plhReport.Controls.Add(new LiteralControl("<th class='text-right'>Sales Tax</th>"));
                    plhReport.Controls.Add(new LiteralControl("</tr>"));
                }
                else
                {
                    if (newVehicleType != oldVehicleType)
                    {
                        plhReport.Controls.Add(new LiteralControl("<tr><th colspan='8' class='text-center'><hr>" + newOwnerType + " - " + newVehicleType + "</th></tr>"));

                        plhReport.Controls.Add(new LiteralControl("<tr>"));
                        plhReport.Controls.Add(new LiteralControl("<th>Sale Date</th>"));
                        plhReport.Controls.Add(new LiteralControl("<th>Stock Number</th>"));
                        plhReport.Controls.Add(new LiteralControl("<th>Vehicle</th>"));
                        plhReport.Controls.Add(new LiteralControl("<th>Buyer</th>"));
                        plhReport.Controls.Add(new LiteralControl("<th>Seller</th>"));
                        plhReport.Controls.Add(new LiteralControl("<th class='text-right'>Sale Price</th>"));
                        plhReport.Controls.Add(new LiteralControl("<th class='text-right'>Sales Tax</th>"));
                        plhReport.Controls.Add(new LiteralControl("</tr>"));
                    }
                }

                i++;

                salePriceSubTotal += Convert.ToDecimal(reader["SalePrice"]) + Convert.ToDecimal(reader["DocumentFee"]);
                salesTaxSubTotal += Convert.ToDecimal(reader["SalesTax"]);

                plhReport.Controls.Add(new LiteralControl("<tr>"));
                DateTime saleDate = Convert.ToDateTime(reader["SaleDate"]);
                plhReport.Controls.Add(new LiteralControl("<td>" + saleDate.ToShortDateString() + "</td>"));
                plhReport.Controls.Add(new LiteralControl("<td class='text-center'>" + reader["Stocknumber"] + "</td>"));
                plhReport.Controls.Add(new LiteralControl("<td>" + reader["ModelYear"].ToString() + " " + reader["Make"].ToString() + " " + reader["Model"] + "</td>"));
                plhReport.Controls.Add(new LiteralControl("<td>" + reader["BuyerName"].ToString() + "</td>"));
                plhReport.Controls.Add(new LiteralControl("<td>" + reader["SellerName"].ToString() + "</td>"));
                decimal salePrice = Convert.ToDecimal(reader["SalePrice"]) + Convert.ToDecimal(reader["DocumentFee"]);
                plhReport.Controls.Add(new LiteralControl("<td class='text-right'>" + salePrice.ToString("C") + "</td>"));
                decimal salesTax = Convert.ToDecimal(reader["SalesTax"]);
                plhReport.Controls.Add(new LiteralControl("<td class='text-right'>" + salesTax.ToString("C") + "</td>"));
                plhReport.Controls.Add(new LiteralControl("</tr>"));

                oldOwnerType = newOwnerType;
                oldVehicleType = newVehicleType;
            }
            plhReport.Controls.Add(new LiteralControl("<tr><th colspan='5' class='text-right'>Subtotal:&nbsp;</th><td class='text-right'>" + salePriceSubTotal.ToString("C") + "</td><td class='text-right'>" + salesTaxSubTotal.ToString("C") + "</td></tr>"));
            plhReport.Controls.Add(new LiteralControl("<tr><td colspan='8'><hr></td></tr>"));
            plhReport.Controls.Add(new LiteralControl("<tr><th colspan='5' class='text-right'>Grand Total:&nbsp;</th><td class='text-right'>" + salePriceTotal.ToString("C") + "</td><td class='text-right'>" + salesTaxTotal.ToString("C") + "</td></tr>"));
            plhReport.Controls.Add(new LiteralControl("<tr><th colspan='5' class='text-right'>Motorized Total:&nbsp;</th><td class='text-right'>" + motorizedTotal.ToString("C") + "</td></tr>"));
            plhReport.Controls.Add(new LiteralControl("</table>"));
            reader.Close();
            connection.Close();
        }
    }
}