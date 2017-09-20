using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace PeninsulaRV.secure
{
    public partial class StockList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet dataSet = new DataSet();

            Consignment newConsignment = new Consignment();

            dataSet = newConsignment.GetCurrentConsignments();

            DateTime now = new DateTime();

            now = DateTime.Now;

            decimal price;

            plhStockList.Controls.Add(new LiteralControl("<center><h2>Stock List " + now.ToLongDateString() + "</h2></center>"));

            plhStockList.Controls.Add(new LiteralControl("<table style='width: 100%'>"));
            plhStockList.Controls.Add(new LiteralControl("<tr>"));
            plhStockList.Controls.Add(new LiteralControl("<th>Type</th>"));
            plhStockList.Controls.Add(new LiteralControl("<th>Stock Number</th>"));
            plhStockList.Controls.Add(new LiteralControl("<th>Year</th>"));
            plhStockList.Controls.Add(new LiteralControl("<th>Make</th>"));
            plhStockList.Controls.Add(new LiteralControl("<th>Model</th>"));
            plhStockList.Controls.Add(new LiteralControl("<th>Mileage</th>"));
            plhStockList.Controls.Add(new LiteralControl("<th style='text-align: right'>Price</th>"));
            plhStockList.Controls.Add(new LiteralControl("<th>Offers</th>"));
            plhStockList.Controls.Add(new LiteralControl("<th>Sale Date</th>"));
            plhStockList.Controls.Add(new LiteralControl("<th>Salesman</th>"));
            plhStockList.Controls.Add(new LiteralControl("</tr>"));

            foreach (DataTable table in dataSet.Tables)
            {
                foreach (DataRow row in table.Rows)
                {
                    plhStockList.Controls.Add(new LiteralControl("<tr>"));
                    plhStockList.Controls.Add(new LiteralControl("<td>" + row["vehicletype"] + "</td>"));
                    plhStockList.Controls.Add(new LiteralControl("<td>" + row["stocknumber"] + "</td>"));
                    plhStockList.Controls.Add(new LiteralControl("<td>" + row["modelyear"] + "</td>"));
                    plhStockList.Controls.Add(new LiteralControl("<td>" + row["make"] + "</td>"));
                    plhStockList.Controls.Add(new LiteralControl("<td>" + row["model"] + "</td>"));

                    if (row["mileage"].ToString() == "0")
                    {
                        plhStockList.Controls.Add(new LiteralControl("<td>N/A</td>"));
                    }
                    else
                    {
                        plhStockList.Controls.Add(new LiteralControl("<td>" + row["mileage"] + "</td>"));
                    }
                    price = Convert.ToDecimal(row["AskingPrice"]);
                    plhStockList.Controls.Add(new LiteralControl("<td style='text-align: right'>" + price.ToString("c") + "</td>"));
                    plhStockList.Controls.Add(new LiteralControl("<td>" + row["OfferStatus"] + "</td>"));

                    DateTime saleDate = new DateTime();
                    try
                    {
                        saleDate = Convert.ToDateTime(row["saledate"]);
                        plhStockList.Controls.Add(new LiteralControl("<td>" + saleDate.ToShortDateString() + "</td>"));
                    }
                    catch
                    {
                        plhStockList.Controls.Add(new LiteralControl("<td>n/a</td>"));
                    }
                    
                    
                    plhStockList.Controls.Add(new LiteralControl("<td>" + row["Salesman"] + "</td>"));
                }
            }
            plhStockList.Controls.Add(new LiteralControl("</table>"));
        }
    }
}