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
    public partial class SalesBySalesman : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SelectMonth(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            Consignment newConsignment = new Consignment();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT OfferID, SaleDate, BuyerName, SellerName, Convert(varchar(255), ModelYear) + ' ' + Make + ' ' + Model + ' ' + VehicleType AS VehicleInfo, SalesmanCommission, SUM(SalesmanCommission) AS MonthCommission FROM SalesmanCommissionView WHERE OfferStatus = 'Sold' AND datepart(yyyy, saledate) = " + rblYear.SelectedItem.Value + " and datepart(mm, saledate) = " + rblMonth.SelectedItem.Value + " and Name = '" + rblSalesman.SelectedItem.Text + "' Group By OfferID, SaleDate, SellerName, BuyerName, ModelYear, Make, Model, VehicleType, SalesmanCommission";

            connection.Open();

            command = new SqlCommand(query, connection);

            reader = command.ExecuteReader();

            decimal monthCommission = 0;

            lblMonth.Text = rblMonth.SelectedItem.Text + " " + rblYear.SelectedValue;
            lblsalesmanName.Text = rblSalesman.SelectedItem.Text;

            while (reader.Read())
            {
                plhReport.Controls.Add(new LiteralControl("<a href='salesmancommission.aspx?SaleID=" + reader["OfferID"].ToString() + "' target='_blank'>"));
                plhReport.Controls.Add(new LiteralControl("<div class='row'>"));
                plhReport.Controls.Add(new LiteralControl("<div class='col-xs-2'>"));
                DateTime saleDate = Convert.ToDateTime(reader["SaleDate"]);
                plhReport.Controls.Add(new LiteralControl(saleDate.ToShortDateString()));
                plhReport.Controls.Add(new LiteralControl("</div>"));
                plhReport.Controls.Add(new LiteralControl("<div class='col-xs-2'>"));
                plhReport.Controls.Add(new LiteralControl(reader["SellerName"].ToString()));
                plhReport.Controls.Add(new LiteralControl("</div>"));
                plhReport.Controls.Add(new LiteralControl("<div class='col-xs-2'>"));
                plhReport.Controls.Add(new LiteralControl(reader["BuyerName"].ToString()));
                plhReport.Controls.Add(new LiteralControl("</div>"));
                plhReport.Controls.Add(new LiteralControl("<div class='col-xs-2'>"));
                plhReport.Controls.Add(new LiteralControl(reader["VehicleInfo"].ToString()));
                plhReport.Controls.Add(new LiteralControl("</div>"));
                plhReport.Controls.Add(new LiteralControl("<div class='col-xs-2 text-right'>"));
                decimal salesmanCommission = Convert.ToDecimal(reader["SalesmanCommission"]);
                monthCommission += salesmanCommission;
                plhReport.Controls.Add(new LiteralControl(salesmanCommission.ToString("c")));
                plhReport.Controls.Add(new LiteralControl("</div>"));
                plhReport.Controls.Add(new LiteralControl("</div>"));
                plhReport.Controls.Add(new LiteralControl("</a>"));
            }
            connection.Close();

            lblMonthCommission.Text = monthCommission.ToString("c");

            pnlReport.Visible = true;
            pnlSelectMonth.Visible = false;
        }
    }
}