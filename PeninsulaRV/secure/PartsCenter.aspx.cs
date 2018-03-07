using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeninsulaRV.secure
{
    public partial class PartsCenter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Part parts = new Part();

            //foreach (Part part in parts.AvailableParts())
            //{
            //    plhAvailableParts.Controls.Add(new LiteralControl("<h4>" + part.Name + "</h4>"));
            //}

            rptAvailableParts.DataSource = parts.AvailableParts();
            rptAvailableParts.DataBind();

            rptSoldParts.DataSource = parts.SoldParts();
            rptSoldParts.DataBind();
        }

        protected void AddPart(object sender, EventArgs e)
        {
            Part part = new Part();
            part.Name = txtName.Text;
            part.Description = txtDescription.Text;
            part.Category = txtCategory.Text;
            part.ListDate = DateTime.Now;
            part.Location = txtLocation.Text;
            part.Notes = txtNotes.Text;
            part.Quantity = Convert.ToDecimal(txtQuantity.Text);
            part.Price = Convert.ToDecimal(txtPrice.Text);
            part.KeyWords = part.StringToList(txtKeywords.Text);

            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            for(int i = 1; i<=10; i++)
            {

                TextBox textBoxName = pnlForm.FindControl("txtSpecName" + i) as TextBox;
                TextBox textBoxValue = pnlForm.FindControl("txtSpecValue" + i) as TextBox;
                if (!string.IsNullOrEmpty(textBoxName.Text))
                {
                    dictionary.Add(textBoxName.Text, textBoxValue.Text);
                }
                else
                {
                    break;
                }
            }
            part.Specs = dictionary;

            part.AddPartToDatabase();

            Response.Redirect("PartsCenter.aspx");
        }
    }
}