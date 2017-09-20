using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace PeninsulaRV
{
    public partial class Unit : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlDataReader reader;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            //query = "SELECT vehicle.vehicleid, vehicle.stocknumber, vehicle.modelyear, vehicle.make, vehicle.model, vehicle.vehicletype, vehicle.vin, vehicle.mileage, vehicle.description, sale.askingprice FROM Vehicle inner join sale on sale.vehicleref = vehicle.vehicleid WHERE vehicle.stocknumber = @stocknumber";
            query = "SELECT * FROM ConsignmentVehicleView WHERE stocknumber = @stocknumber";

            connection.Open();

            string stocknumber;

            stocknumber = Request.QueryString["StockNumber"];

            if (string.IsNullOrEmpty(stocknumber))
            {
                stocknumber = "0000";
            }

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@stocknumber", stocknumber);

            reader = command.ExecuteReader();

            decimal askingPrice;

            while (reader.Read())
            {
                askingPrice = Convert.ToDecimal(reader["askingprice"]);
                plhDetails.Controls.Add(new LiteralControl("<strong>Stock Number:</strong> " + reader["stocknumber"] + "<br>"));
                plhDetails.Controls.Add(new LiteralControl("<strong>Year:</strong> " + reader["modelyear"] + "<br>"));
                plhDetails.Controls.Add(new LiteralControl("<strong>Make:</strong> " + reader["make"] + "<br>"));
                plhDetails.Controls.Add(new LiteralControl("<strong>Model:</strong> " + reader["model"] + "<br>"));
                plhDetails.Controls.Add(new LiteralControl("<strong>Type:</strong> " + reader["vehicletype"] + "<br>"));
                plhDetails.Controls.Add(new LiteralControl("<strong>VIN:</strong> " + reader["vin"] + "<br>"));
                if (reader["vehicletype"].ToString() == "Class A Motorhome" || reader["vehicletype"].ToString() == "Class B Motorhome" || reader["vehicletype"].ToString() == "Class C Motorhome" || reader["vehicletype"].ToString() == "Automobile")
                {
                    plhDetails.Controls.Add(new LiteralControl("<strong>Mileage:</strong> " + reader["mileage"] + "<br>"));
                }
                plhDetails.Controls.Add(new LiteralControl("<strong>Asking Price:</strong> " + askingPrice.ToString("C") + "<br>"));
                plhDetails.Controls.Add(new LiteralControl("<strong>Description:</strong> " + reader["description"] + "<br>"));

            }

            connection.Close();

            int i = 1;
            plhFeatured1.Controls.Add(new LiteralControl("<div class='col-md-12 hidden-sm hidden-xs' id='slider-thumbs'>"));
            plhFeatured1.Controls.Add(new LiteralControl("<ul class='list-inline'>"));
            while (File.Exists(Server.MapPath("/images/inventory/" + stocknumber + "-thumb" + i + ".jpg")))
            {
                plhFeatured1.Controls.Add(new LiteralControl("<li> <a id='carousel-selector-" + (i - 1) + "' "));

                if (i == 1)
                {
                    plhFeatured1.Controls.Add(new LiteralControl("class='selected'"));
                }
                plhFeatured1.Controls.Add(new LiteralControl("><img src='images/inventory/" + stocknumber + "-thumb" + i + ".jpg' style='height: 75px' class='img-responsive'></a></li>"));
                i++;
            }
            plhFeatured1.Controls.Add(new LiteralControl("</ul>"));
            plhFeatured1.Controls.Add(new LiteralControl("</div>"));    

            plhFeatured1.Controls.Add(new LiteralControl("<div class='row'>"));
            plhFeatured1.Controls.Add(new LiteralControl("<div class='col-md-12' id='slider'>"));


            plhFeatured1.Controls.Add(new LiteralControl("<div class='col-md-12' id='carousel-bounding-box'>"));
            plhFeatured1.Controls.Add(new LiteralControl("<div id='myCarousel' class='carousel slide'>"));
            plhFeatured1.Controls.Add(new LiteralControl("<div class='carousel-inner'>"));

            i = 1;

            while (File.Exists(Server.MapPath("/images/inventory/" + stocknumber + "-full" + i + ".jpg")))
            {
                plhFeatured1.Controls.Add(new LiteralControl("<div class='item"));
                if (i == 1)
                {
                    plhFeatured1.Controls.Add(new LiteralControl(" active"));
                }
                plhFeatured1.Controls.Add(new LiteralControl("' data-slide-number='" + (i - 1) + "'>"));


                plhFeatured1.Controls.Add(new LiteralControl("<img src='images/inventory/" + stocknumber + "-full" + i + ".jpg' class='img-responsive'>"));                
                plhFeatured1.Controls.Add(new LiteralControl("</div>"));
                i++;
            }
            plhFeatured1.Controls.Add(new LiteralControl("</div>"));
        }
    }
}