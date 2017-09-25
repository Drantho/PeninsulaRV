using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeninsulaRV.secure
{
    public partial class MonthlyRevenueForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MonthlyRevenue lists = new MonthlyRevenue();

                rblMonth.DataSource = lists.Months();
                rblMonth.DataBind();

                rblYear.DataSource = lists.Years();
                rblYear.DataBind();
            }            
        }

        protected void ShowForm(object sender, CommandEventArgs e)
        {
            pnlMenu.Visible = false;
            pnlAddMonth.Visible = true;
        }

        protected void AddMonth(object sender, EventArgs e)
        {
            MonthlyRevenue monthlyRevenue = new MonthlyRevenue();
            monthlyRevenue.BankDeposits = Convert.ToDecimal(txtBankDeposits.Text);
            monthlyRevenue.Consignments = Convert.ToDecimal(txtConsignment.Text);
            monthlyRevenue.Month = Convert.ToInt16(ddlMonth.SelectedValue);
            monthlyRevenue.Motorized = Convert.ToDecimal(txtMotorized.Text);
            monthlyRevenue.Notes = txtMotorized.Text;
            monthlyRevenue.OutOfState = Convert.ToDecimal(txtOutOfState.Text);
            monthlyRevenue.Use = Convert.ToDecimal(txtUse.Text);
            monthlyRevenue.Year = Convert.ToInt16(ddlYear.SelectedValue);

            monthlyRevenue.MonthlyRevenueID = monthlyRevenue.AddMonthlyRevenueToDatabase();

            for(int i = 1; i <=10; i++)
            {
                TextBox txtTitle = new TextBox();
                txtTitle = pnlAddMonth.FindControl("txtNTITitle" + i) as TextBox;
                if(txtTitle.Text != "")
                {
                    RevenueItem item = new RevenueItem();

                    TextBox txtAmount = new TextBox();
                    txtAmount = pnlAddMonth.FindControl("txtNTIAmount" + i) as TextBox;

                    TextBox txtNotes = new TextBox();
                    txtNotes = pnlAddMonth.FindControl("txtNTINotes" + i) as TextBox;

                    item.Amount = Convert.ToDecimal(txtAmount.Text);
                    item.MonthlyRevenueRef = monthlyRevenue.MonthlyRevenueID;
                    item.Notes = txtNotes.Text;
                    item.Title = txtTitle.Text;

                    item.AddRevenueItemToDatabase();
                }
                else
                {
                    break;
                }
            }

            ViewState["MonthlyRevenue"] = monthlyRevenue;
            pnlAddMonth.Visible = false;
            pnlViewMonth.Visible = true;

            ViewMonth();
        }

        protected void ViewMonth()
        {
            MonthlyRevenue monthlyRevenue = ViewState["MonthlyRevenue"] as MonthlyRevenue;

            lblBankDeposits.Text = monthlyRevenue.BankDeposits.ToString("C");
            lblConsignment.Text = monthlyRevenue.Consignments.ToString("C");            
            lblDate.Text = MonthName(monthlyRevenue.Month) + " " + monthlyRevenue.Year;
            lblMotorized.Text = monthlyRevenue.Motorized.ToString("C");
            lblNotes.Text = monthlyRevenue.Notes;
            lblOutOfState.Text = (-1 * monthlyRevenue.OutOfState).ToString("C");
            lblOutOfState2.Text = monthlyRevenue.OutOfState.ToString("C");
            lblTotalRetailing.Text = monthlyRevenue.RetailingTotal.ToString("C");
            lblUse.Text = monthlyRevenue.Use.ToString("C");
            lblWholesale.Text = (-1 * monthlyRevenue.Wholesale).ToString("C");
            lblSubtotal.Text = monthlyRevenue.MinusTaxFree.ToString("C");
            lblTaxesBackedOut.Text = monthlyRevenue.TaxesBackedOut.ToString("C");
            lblTaxRate.Text = (monthlyRevenue.TaxRate + 1).ToString();
            rptNTI.DataSource = monthlyRevenue.CurrentRevenueItems;
            rptNTI.DataBind();
            
        }

        protected void GetMonth(object sender, EventArgs e)
        {
            MonthlyRevenue monthlyRevenue = new MonthlyRevenue();
            monthlyRevenue.Month = Convert.ToInt16(rblMonth.SelectedValue);
            monthlyRevenue.Year = Convert.ToInt16(rblYear.SelectedValue);
            monthlyRevenue.SetMonthlyRevenue();

            ViewState["MonthlyRevenue"] = monthlyRevenue;

            ViewMonth();

            pnlMenu.Visible = false;
            pnlViewMonth.Visible = true;
        }

        string MonthName(int number)
        {
            switch (number)
            {
                case 1:
                    return "January";
                case 2:
                    return "February";
                case 3:
                    return "March";
                case 4:
                    return "April";
                case 5:
                    return "May";
                case 6:
                    return "June";
                case 7:
                    return "July";
                case 8:
                    return "August";
                case 9:
                    return "September";
                case 10:
                    return "October";
                case 11:
                    return "November";
                case 12:
                    return "December";
                default:
                    return "";
            }
        }
    }
}