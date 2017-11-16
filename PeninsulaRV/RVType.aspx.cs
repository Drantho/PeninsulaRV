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
    public partial class RVTpye : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlDataReader reader;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "Select * FROM ConsignmentVehicleView WHERE Status = 'Active' and VehicleType = @vehicletype ORDER BY ModelYear DESC";

            connection.Open();

            string rvType;

            rvType = Request.QueryString["RvType"];

            if (string.IsNullOrEmpty(rvType))
            {
                rvType = "Class A Motorhome";
            }

            lblTypeHeader.Text = rvType + "s";           

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@vehicletype", rvType);

            reader = command.ExecuteReader();

            decimal askingPrice;
            int i = 1;

            while (reader.Read())
            {

                if (i % 3 == 1)
                {
                    plhVehicleList.Controls.Add(new LiteralControl("<div class='row'>"));
                }
                askingPrice = Convert.ToDecimal(reader["AskingPrice"]);
                plhVehicleList.Controls.Add(new LiteralControl("<div class='col-sm-4'>"));
                plhVehicleList.Controls.Add(new LiteralControl("<a href='unit.aspx?Stocknumber=" + reader["VehicleRef"] + "'><img src='images/inventory/" + reader["VehicleRef"] + "-thumb1.jpg'><br>"));
                plhVehicleList.Controls.Add(new LiteralControl("<strong>" + reader["modelyear"] + " " + reader["make"] + " " + reader["model"] + "</strong></a><br>"));
                plhVehicleList.Controls.Add(new LiteralControl("<strong>" + reader["vehicletype"] + "</strong><br>"));
                plhVehicleList.Controls.Add(new LiteralControl("<strong>Stock Number:</strong> " + reader["VehicleRef"] + "<br>"));
                plhVehicleList.Controls.Add(new LiteralControl("<strong>VIN:</strong> " + reader["VIN"] + "<br>"));
                if (reader["vehicletype"].ToString() == "Class A Motorhome" || reader["vehicletype"].ToString() == "Class A Motorhome" || reader["vehicletype"].ToString() == "Class C Motorhome" || reader["vehicletype"].ToString() == "Automobile")
                {
                    plhVehicleList.Controls.Add(new LiteralControl("<strong>Mileage:</strong> " + reader["mileage"] + "<br>"));
                }
                plhVehicleList.Controls.Add(new LiteralControl("<strong>Asking Price:</strong> " + askingPrice.ToString("c") + "<br><br>"));
                plhVehicleList.Controls.Add(new LiteralControl("</div>"));

                if (i % 3 == 0)
                {
                    plhVehicleList.Controls.Add(new LiteralControl("</div>"));
                }

                i++;
            }

            i -= 1;

            if (i % 3 != 0)
            {
                plhVehicleList.Controls.Add(new LiteralControl("</div>"));
            }
            
        }
           
    }
}