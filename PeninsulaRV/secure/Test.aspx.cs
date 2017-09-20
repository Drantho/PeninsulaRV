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
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void QueryDatabase(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            DataTable table;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = Query.Text;

            connection.Open();

            command = new SqlCommand(query, connection);

            try
            {
                reader = command.ExecuteReader(CommandBehavior.KeyInfo);
                table = reader.GetSchemaTable();
                lblResults.Text = "<table border = '1'>";
                while (reader.Read())
                {
                    for (int i = 0; i <= (reader.FieldCount - 1); i++)
                    {

                        if (i == 0)
                        {
                            lblResults.Text += "<tr>";
                            for (int j = 0; j <= (reader.FieldCount - 1); j++)
                            {
                                lblResults.Text += "<td>" + table.Rows[j][0].ToString() + "</td>";
                            }
                            lblResults.Text += "</tr><tr>";
                        }

                        lblResults.Text += "<td>" + reader[i].ToString() + "</td>";
                        if (i == (reader.FieldCount - 1))
                        {
                            lblResults.Text += "</tr><tr>";
                        }
                    }


                }

                lblResults.Text += "</tr></table>";

            }
            catch (Exception exc)
            {
                lblResults.Text = exc.Message.ToString();
            }


        }
    }
}