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
    public partial class SaleView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            plhMonth.Controls.Clear();
            if (Convert.ToString(ViewState["Generated"]) == "true")
            {
                GenerateControls();
            }

            if (!Page.IsPostBack)
            {
                SqlConnection connection;
                SqlDataAdapter adapter;
                DataSet dataset;
                string query;

                connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

                query = "select distinct datepart(yyyy, saledate) As  Year from saleview where saledate <> ''";

                connection.Open();
                adapter = new SqlDataAdapter(query, connection);

                dataset = new DataSet();

                adapter.Fill(dataset);

                rblYear.DataSource = dataset;
                rblYear.DataTextField = "Year";
                rblYear.DataValueField = "Year";
                rblYear.DataBind();

                connection.Close();
                
            }
            
        }

        protected void GetMonthInfo(object sender, EventArgs e)
        {
            if (Convert.ToString(ViewState["Generated"]) != "true")
            {
                GenerateControls();
                ViewState["Generated"] = "true";
            }
        }

        protected void GenerateControls()
        {
            plhMonth.Controls.Clear();

            SqlConnection connection;
            SqlDataReader reader;
            SqlCommand command;            
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "select * from saleview where datepart(mm, saledate) = " + rblMonth.SelectedItem.Value + "  and datepart(yyyy, saledate) = " + rblYear.SelectedItem.Value + " Order By saledate";

            connection.Open();
            command = new SqlCommand(query, connection);
            reader = command.ExecuteReader();

            while (reader.Read()) {
                plhMonth.Controls.Add(new LiteralControl("<h3>" + reader["modelyear"] + " " + reader["make"] + " " + reader["model"] + "</h3>"));

                plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><strong>Sale ID:</strong> "));
                plhMonth.Controls.Add(new LiteralControl(reader["SaleID"].ToString()));
                plhMonth.Controls.Add(new LiteralControl("</div>"));
                plhMonth.Controls.Add(new LiteralControl("</div>"));

                plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><strong>Seller:</strong> "));
                plhMonth.Controls.Add(new LiteralControl(reader["SellerFirstName"].ToString() + " " + reader["sellerlastname"]));
                plhMonth.Controls.Add(new LiteralControl("</div>"));
                plhMonth.Controls.Add(new LiteralControl("</div>"));

                plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><strong>Buyer:</strong> "));
                plhMonth.Controls.Add(new LiteralControl(reader["BuyerFirstName"].ToString() + " " + reader["BuyerLastName"]));
                plhMonth.Controls.Add(new LiteralControl("</div>"));
                plhMonth.Controls.Add(new LiteralControl("</div>"));

                plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><strong>Date Sold:</strong> "));

                DateTime dateSold = new DateTime();

                dateSold = Convert.ToDateTime(reader["saleDate"]);

                plhMonth.Controls.Add(new LiteralControl(dateSold.ToString("d")));
                plhMonth.Controls.Add(new LiteralControl("</div>"));
                plhMonth.Controls.Add(new LiteralControl("</div>"));

                plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><strong>Sale Price:</strong> "));
                plhMonth.Controls.Add(new LiteralControl(reader["SalePrice"].ToString()));
                plhMonth.Controls.Add(new LiteralControl("</div>"));
                plhMonth.Controls.Add(new LiteralControl("</div>"));

                plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><strong>Gross Profit:</strong> "));
                plhMonth.Controls.Add(new LiteralControl(reader["GrossProfit"].ToString()));
                plhMonth.Controls.Add(new LiteralControl("</div>"));
                plhMonth.Controls.Add(new LiteralControl("</div>"));

                plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><strong>Dealer Cost:</strong> "));
                plhMonth.Controls.Add(new LiteralControl(reader["DealerCost"].ToString()));
                plhMonth.Controls.Add(new LiteralControl("</div>"));
                plhMonth.Controls.Add(new LiteralControl("</div>"));

                plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><a href=\"javascript: toggleDiv('divSalesman" + reader["SaleID"] + "'); \"><span class=\"glyphicon glyphicon-edit\"></span></a><strong>Salesman:</strong> "));
                plhMonth.Controls.Add(new LiteralControl(reader["Salesman"].ToString()));


                plhMonth.Controls.Add(new LiteralControl("<div id='divSalesman" + reader["SaleID"] + "' style='display: none'>"));
                TextBox salesMan1 = new TextBox();
                TextBox salesman2 = new TextBox();
                TextBox salesman3 = new TextBox();

                salesMan1.ID = "txtSalesman1-" + reader["SaleID"];
                salesMan1.CssClass = "form-control";
                salesMan1.Text = reader["Salesman"].ToString();
                plhMonth.Controls.Add(new LiteralControl("<label for='txtSalesman1-" + reader["SaleID"] + "'>Salesman 1:</label>"));
                plhMonth.Controls.Add(salesMan1);

                salesman2.ID = "txtSalesman2-" + reader["SaleID"];
                salesman2.CssClass = "form-control";
                salesman2.Text = reader["Salesman2"].ToString();
                plhMonth.Controls.Add(new LiteralControl("<label for='txtSalesman2-" + reader["SaleID"] + "'>Salesman 2:</label>"));
                plhMonth.Controls.Add(salesman2);

                salesman3.ID = "txtSalesman3-" + reader["SaleID"];
                salesman3.CssClass = "form-control";
                salesman3.Text = reader["Salesman3"].ToString();
                plhMonth.Controls.Add(new LiteralControl("<label for='txtSalesman3-" + reader["SaleID"] + "'>Salesman 3:</label>"));
                plhMonth.Controls.Add(salesman3);

                LinkButton updateSalesman = new LinkButton();
                updateSalesman.Text = "Update Salesmen";
                updateSalesman.Command += new CommandEventHandler(UpdateSalesmen);
                updateSalesman.CommandArgument = reader["SaleID"].ToString();
                plhMonth.Controls.Add(updateSalesman);
                plhMonth.Controls.Add(new LiteralControl("</div>"));


                plhMonth.Controls.Add(new LiteralControl("</div>"));
                plhMonth.Controls.Add(new LiteralControl("</div>"));

                plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><a href=\"javascript: toggleDiv('divCommission" + reader["SaleID"] + "'); \"><span class=\"glyphicon glyphicon-edit\"></span></a><strong>Commission:</strong> "));
                plhMonth.Controls.Add(new LiteralControl(reader["Commission"].ToString()));

                plhMonth.Controls.Add(new LiteralControl("<div id='divCommission" + reader["SaleID"] + "' style='display: none'>"));
                TextBox commission1 = new TextBox();
                TextBox commission2 = new TextBox();
                TextBox commission3 = new TextBox();

                commission1.ID = "txtcommission-" + reader["SaleID"];
                commission1.CssClass = "form-control";
                commission1.Text = reader["commission"].ToString();
                plhMonth.Controls.Add(new LiteralControl("<label for='txtcommission1-" + reader["SaleID"] + "'>Commission 1:</label>"));
                plhMonth.Controls.Add(commission1);

                commission2.ID = "txtcommission2-" + reader["SaleID"];
                commission2.CssClass = "form-control";
                commission2.Text = reader["commission2"].ToString();
                plhMonth.Controls.Add(new LiteralControl("<label for='txtcommission2-" + reader["SaleID"] + "'>Commission 2:</label>"));
                plhMonth.Controls.Add(commission2);

                commission3.ID = "txtCommission3-" + reader["SaleID"];
                commission3.CssClass = "form-control";
                commission3.Text = reader["commission3"].ToString();
                plhMonth.Controls.Add(new LiteralControl("<label for='txtcommission3-" + reader["SaleID"] + "'>Commission 3:</label>"));
                plhMonth.Controls.Add(commission3);

                LinkButton updateCommission = new LinkButton();
                updateCommission.Text = "Update Commissions";
                updateCommission.Command += new CommandEventHandler(UpdateCommission);
                updateCommission.CommandArgument = reader["SaleID"].ToString();
                plhMonth.Controls.Add(updateCommission);
                plhMonth.Controls.Add(new LiteralControl("</div>"));
                
                plhMonth.Controls.Add(new LiteralControl("</div>"));
                plhMonth.Controls.Add(new LiteralControl("</div>"));

                if(!(reader.IsDBNull(35) || reader["salesman2"].ToString() == "" ))
                {
                    plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                    plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><strong>Salesman:</strong> "));
                    plhMonth.Controls.Add(new LiteralControl(reader["Salesman2"].ToString()));
                    plhMonth.Controls.Add(new LiteralControl("</div>"));
                    plhMonth.Controls.Add(new LiteralControl("</div>"));

                    plhMonth.Controls.Add(new LiteralControl("<div class='row'>"));
                    plhMonth.Controls.Add(new LiteralControl("<div class='col-sm-12'><strong>Commission:</strong> "));
                    plhMonth.Controls.Add(new LiteralControl(reader["Commission2"].ToString()));
                    plhMonth.Controls.Add(new LiteralControl("</div>"));
                    plhMonth.Controls.Add(new LiteralControl("</div>"));
                }
            }

            connection.Close();

            pnlMonthSelect.Visible = false;
            pnlMonthView.Visible = true;
        }

        protected void UpdateSalesmen(object sender, CommandEventArgs e)
        {
            TextBox salesman1 = new TextBox();
            TextBox salesman2 = new TextBox();
            TextBox salesman3 = new TextBox();

            salesman1 = plhMonth.FindControl("txtSalesman1-" + e.CommandArgument) as TextBox;
            salesman2 = plhMonth.FindControl("txtSalesman2-" + e.CommandArgument) as TextBox;
            salesman3 = plhMonth.FindControl("txtSalesman3-" + e.CommandArgument) as TextBox;

            SqlConnection connection;
            SqlCommand command;            
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            connection.Open();

            query = "UPDATE Sale set Salesman = @Salesman, Salesman2 = @Salesman2, Salesman3 = @Salesman3 where SaleID = @SaleID";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Salesman", salesman1.Text);
            command.Parameters.AddWithValue("@Salesman2", salesman2.Text);
            command.Parameters.AddWithValue("@Salesman3", salesman3.Text);
            command.Parameters.AddWithValue("@SaleID", e.CommandArgument);

            try
            {
                command.ExecuteNonQuery();
            }
            catch (Exception exc)
            {
                Response.Write(exc.Message.ToString());
            }

            connection.Close();
            plhMonth.Controls.Clear();
            GenerateControls();
        }

        protected void UpdateCommission(object sender, CommandEventArgs e)
        {
            TextBox commission1 = new TextBox();
            TextBox commission2 = new TextBox();
            TextBox commission3 = new TextBox();

            commission1 = plhMonth.FindControl("txtCommission-" + e.CommandArgument) as TextBox;
            commission2 = plhMonth.FindControl("txtCommission2-" + e.CommandArgument) as TextBox;
            commission3 = plhMonth.FindControl("txtCommission3-" + e.CommandArgument) as TextBox;

            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            connection.Open();

            query = "UPDATE Sale set Commission = @Commission, Commission2 = @Commission2, Commission3 = @Commission3 where SaleID = @SaleID";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Commission", commission1.Text);
            command.Parameters.AddWithValue("@Commission2", commission2.Text);
            command.Parameters.AddWithValue("@Commission3", commission3.Text);
            command.Parameters.AddWithValue("@SaleID", e.CommandArgument);

            try
            {
                command.ExecuteNonQuery();
            }
            catch (Exception exc)
            {
                Response.Write(exc.Message.ToString());
            }

            connection.Close();
            plhMonth.Controls.Clear();
            GenerateControls();
        }


    }
}