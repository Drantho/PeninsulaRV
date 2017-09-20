using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeninsulaRV.secure
{
    public partial class Lenders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Lender lenderList = new Lender();
            rptLenderList.DataSource = lenderList.AllLenders();
            rptLenderList.DataBind();
        }

        protected void AddLender(object sender, EventArgs e)
        {
            Lender newLender = new Lender();
            newLender.Name = txtName.Text;
            newLender.Address = txtAddress.Text;
            newLender.City = txtCity.Text;
            newLender.State = txtState.Text;
            newLender.Zip = txtZip.Text;
            newLender.Phone = txtPhone.Text;
            newLender.Fax = txtFax.Text;
            newLender.IDType = rblIDType.SelectedValue;
            newLender.IDNumber = txtIDNumber.Text;
            newLender.Notes = txtNotes.Text;

            newLender.AddLenderToDatabase();

            Response.Redirect("lenders.aspx");
        }
    }
}