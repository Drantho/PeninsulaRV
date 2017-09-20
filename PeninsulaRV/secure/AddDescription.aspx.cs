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


namespace PeninsulaRV.secure
{
    public partial class AddDescription : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = "Consignment Agreement";

            if (!Page.IsPostBack)
            {

                if (String.IsNullOrEmpty(Request.QueryString["SaleID"]))
                {
                    SqlConnection connection;
                    DataSet dataset;

                    connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

                    Consignment newConsignment = new Consignment();

                    dataset = new DataSet();

                    dataset = newConsignment.GetCurrentConsignments();

                    rptStocklist.DataSource = dataset;
                    rptStocklist.DataBind();

                    connection.Close();

                    Vehicle newVehicle = new Vehicle();

                    
                }
            }
        }

        protected void SelectCurrentConsignment(object sender, CommandEventArgs e)
        {
            Consignment newConsignment = new Consignment();
            newConsignment = newConsignment.GetConsignment(e.CommandArgument.ToString());

            hdnConsignmentID.Value = e.CommandArgument.ToString();

            txtDescription.Text = newConsignment.SaleVehicle.Description;
            lblStocknumber.Text = newConsignment.SaleVehicle.Stocknumber;
            lblYear.Text = newConsignment.SaleVehicle.ModelYear.ToString();
            lblMake.Text = newConsignment.SaleVehicle.Make.ToString();
            lblModel.Text = newConsignment.SaleVehicle.Model.ToString();
            lblVIN.Text = newConsignment.SaleVehicle.VIN.ToString();
            lblType.Text = newConsignment.SaleVehicle.RVType.ToString();

            plhPhotoList.Controls.Add(new LiteralControl("<img src='http://www.peninsularv.net/images/inventory/" + newConsignment.SaleVehicle.Stocknumber + "-thumb1.jpg'/>"));
            int i = 1;

            while (File.Exists(Server.MapPath("../images/inventory/" + newConsignment.SaleVehicle.Stocknumber + "-thumb" + i + ".jpg")))
            {
                plhPhotoList.Controls.Add(new LiteralControl("<img src='http://www.peninsularv.net/images/inventory/" + newConsignment.SaleVehicle.Stocknumber + "-thumb" + i + ".jpg'/>"));
                i++;
            }

            pnlStocklist.Visible = false;
            pnlEditDescription.Visible = true;
        }

        protected void SaveDescription(object sender, EventArgs e)
        {
            Consignment newConsignment = new Consignment();
            newConsignment = newConsignment.GetConsignment(hdnConsignmentID.Value);

            newConsignment.SaleVehicle.UpdateVehicle("Description", txtDescription.Text);

            Response.Redirect("AddDescription.aspx");
        }
    }
}