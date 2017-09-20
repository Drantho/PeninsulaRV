using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PeninsulaRV
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            SqlDataReader reader;
            SqlCommand command;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT *, ROW_NUMBER() OVER(ORDER BY stocknumber ASC) AS Row# FROM Consignment INNER JOIN  Vehicle ON Consignment.VehicleRef = Vehicle.VehicleID WHERE Status = 'Active' AND Featured = 1";

            connection.Open();

            command = new SqlCommand(query, connection);
            reader = command.ExecuteReader();



            plhFeatured1.Controls.Add(new LiteralControl("<ol class='carousel-indicators'>"));
            while (reader.Read())
            {
                plhFeatured1.Controls.Add(new LiteralControl("<li data-target='#myCarousel' data-slide-to='" + (Convert.ToInt16(reader["row#"]) - 1) + "'"));
                
                if (reader["row#"].ToString() == "1")
                {
                    plhFeatured1.Controls.Add(new LiteralControl("class='active'"));
                }
                plhFeatured1.Controls.Add(new LiteralControl("></li>"));
            }
            plhFeatured1.Controls.Add(new LiteralControl("</ol>"));

            plhFeatured1.Controls.Add(new LiteralControl("<div class='carousel-inner' role='listbox'>"));
            reader.Close();

            command = new SqlCommand(query, connection);
            reader = command.ExecuteReader();
            
            while (reader.Read())
            {
                plhFeatured1.Controls.Add(new LiteralControl("<div class='item"));
                if(reader["row#"].ToString() == "1")
                {
                    plhFeatured1.Controls.Add(new LiteralControl(" active"));
                }
                plhFeatured1.Controls.Add(new LiteralControl("'>"));
                
                    
                plhFeatured1.Controls.Add(new LiteralControl("<img src='images/inventory/" + reader["stocknumber"] + "-full1.jpg' alt='Image coming soon' >"));
                plhFeatured1.Controls.Add(new LiteralControl("<div class='carousel-caption'>"));
                plhFeatured1.Controls.Add(new LiteralControl("<a href='unit.aspx?StockNumber=" + reader["StockNumber"] + "'><h3 style='color: white'>" + reader["ModelYear"] + " " + reader["make"] + " " + reader["model"] + "</h3></a>"));
                plhFeatured1.Controls.Add(new LiteralControl("</div>"));
                plhFeatured1.Controls.Add(new LiteralControl("</div>"));
            }
            plhFeatured1.Controls.Add(new LiteralControl("</div>"));
            reader.Close();

            query = "SELECT TOP 12 * FROM Consignment INNER JOIN Vehicle ON Consignment.VehicleRef = Vehicle.VehicleID WHERE Status = 'Active' order by stocknumber desc";
            adapter = new SqlDataAdapter(query, connection);
            dataset = new DataSet();

            adapter.Fill(dataset);

            rptRecent.DataSource = dataset;
            rptRecent.DataBind();

            connection.Close();
        }
    }
}