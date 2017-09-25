<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MonthlyRevenueForm.aspx.cs" Inherits="PeninsulaRV.secure.MonthlyRevenueForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .hiddenItem {
            display: none;
        }

        .itemLabel {
            display: inline-block;
            width: 250px;
            font-size: 14pt;
            margin-left: 150px;
        }

        .amount {
            display: inline-block;
            text-align: right;
            width: 250px;
            font-size: 14pt;
        }

        .formContainer{
            width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

    </style>
    <script type="text/javascript">
        function showDiv(div) {
            console.log('showDiv() fires');
            $("#divNTI" + div).show();
            $("#divNTILink" + div).hide();
        }
    </script>
    <asp:Panel ID="pnlMenu" runat="server">
        <asp:LinkButton OnCommand="ShowForm" runat="server"><h3>Add Month</h3></asp:LinkButton>
        <h3>View Month</h3>
        <div>
            <asp:RadioButtonList ID="rblMonth" runat="server" />
            <asp:RadioButtonList ID="rblYear" runat="server" />
            <asp:Button Text="Get Month" OnClick="GetMonth" ValidationGroup="Menu" CssClass="btn btn-default" runat="server" />
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlAddMonth" Visible="false" runat="server">
        <div class="form-group row">
            <asp:Label runat="server" AssociatedControlID="ddlMonth" CssClass="col-md-2 control-label">Month</asp:Label>
            <div class="col-md-2">
                <asp:DropDownList CssClass="form-control" ID="ddlMonth" runat="server">
                    <asp:ListItem Text="January" Value="1" />
                    <asp:ListItem Text="February" Value="2" />
                    <asp:ListItem Text="March" Value="3" />
                    <asp:ListItem Text="April" Value="4" />
                    <asp:ListItem Text="May" Value="5" />
                    <asp:ListItem Text="June" Value="6" />
                    <asp:ListItem Text="July" Value="7" />
                    <asp:ListItem Text="August" Value="8" />
                    <asp:ListItem Text="September" Value="9" />
                    <asp:ListItem Text="October" Value="10" />
                    <asp:ListItem Text="November" Value="11" />
                    <asp:ListItem Text="December" Value="12" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ValidationGroup="AddMonth" runat="server" ControlToValidate="ddlMonth"
                    CssClass="text-danger" ErrorMessage="The month field is required." />
            </div>
        </div>

        <div class="form-group row">
            <asp:Label runat="server" AssociatedControlID="ddlYear" CssClass="col-md-2 control-label">Year</asp:Label>
            <div class="col-md-2">
                <asp:DropDownList CssClass="form-control" ID="ddlYear" runat="server">
                    <asp:ListItem Text="2013" Value="2013" />
                    <asp:ListItem Text="2014" Value="2014" />
                    <asp:ListItem Text="2015" Value="2015" />
                    <asp:ListItem Text="2016" Value="2016" />
                    <asp:ListItem Text="2017" Value="2017" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ValidationGroup="AddMonth" runat="server" ControlToValidate="ddlYear"
                    CssClass="text-danger" ErrorMessage="The year field is required." />
            </div>
        </div>

        <div class="form-group row">
            <asp:Label runat="server" AssociatedControlID="txtBankDeposits" CssClass="col-md-2 control-label">Bank Deposits</asp:Label>
            <div class="col-md-2">
                <asp:TextBox ID="txtBankDeposits" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ValidationGroup="AddMonth" runat="server" ControlToValidate="txtBankDeposits"
                    CssClass="text-danger" ErrorMessage="The bank deposits field is required." />
            </div>
        </div>

        <div class="form-group row">
            <asp:Label runat="server" AssociatedControlID="txtOutOfState" CssClass="col-md-2 control-label">Out Of State</asp:Label>
            <div class="col-md-2">
                <asp:TextBox ID="txtOutOfState" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ValidationGroup="AddMonth" runat="server" ControlToValidate="txtOutOfState"
                    CssClass="text-danger" ErrorMessage="The out of state field is required." />
            </div>
        </div>

        <div class="form-group row">
            <asp:Label runat="server" AssociatedControlID="txtWholesale" CssClass="col-md-2 control-label">Wholesale</asp:Label>
            <div class="col-md-2">
                <asp:TextBox ID="txtWholesale" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ValidationGroup="AddMonth" runat="server" ControlToValidate="txtWholesale"
                    CssClass="text-danger" ErrorMessage="The wholesale field is required." />
            </div>
        </div>

        <div class="form-group row">
            <asp:Label runat="server" AssociatedControlID="txtConsignment" CssClass="col-md-2 control-label">Consignment</asp:Label>
            <div class="col-md-2">
                <asp:TextBox ID="txtConsignment" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ValidationGroup="AddMonth" runat="server" ControlToValidate="txtConsignment"
                    CssClass="text-danger" ErrorMessage="The consignment field is required." />
            </div>
        </div>

        <div class="form-group row">
            <asp:Label runat="server" AssociatedControlID="txtMotorized" CssClass="col-md-2 control-label">Motorized</asp:Label>
            <div class="col-md-2">
                <asp:TextBox ID="txtMotorized" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ValidationGroup="AddMonth" runat="server" ControlToValidate="txtMotorized"
                    CssClass="text-danger" ErrorMessage="The motorized field is required." />
            </div>
        </div>

        <div class="form-group row">
            <asp:Label runat="server" AssociatedControlID="txtUse" CssClass="col-md-2 control-label">Use</asp:Label>
            <div class="col-md-2">
                <asp:TextBox ID="txtUse" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ValidationGroup="AddMonth" runat="server" ControlToValidate="txtUse"
                    CssClass="text-danger" ErrorMessage="The use field is required." />
            </div>
        </div>

        <div class="form-group">
            <h3>Non tax item 1</h3>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="txtNTITitle1" CssClass="col-md-4 control-label">Title</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTIAmount1" CssClass="col-md-4 control-label">Aniunt</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTINotes1" CssClass="col-md-4 control-label">Notes</asp:Label>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTITitle1" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTIAmount1" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTINotes1" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
            </div>
            <a href="javascript:showDiv('2');" id="divNTILink2">Add another non-tax item</a>
        </div>

        <div class="form-group hiddenItem" id="divNTI2">
            <h3>Non tax item 2</h3>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="txtNTITitle2" CssClass="col-md-4 control-label">Title</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTIAmount2" CssClass="col-md-4 control-label">Aniunt</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTINotes2" CssClass="col-md-4 control-label">Notes</asp:Label>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTITitle2" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTIAmount2" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTINotes2" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
            </div>
            <a href="javascript:showDiv('3');" id="divNTILink3"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>Add another non-tax item</a>
        </div>

        <div class="form-group hiddenItem" id="divNTI3">
            <h3>Non tax item 3</h3>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="txtNTITitle3" CssClass="col-md-4 control-label">Title</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTIAmount3" CssClass="col-md-4 control-label">Aniunt</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTINotes3" CssClass="col-md-4 control-label">Notes</asp:Label>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTITitle3" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTIAmount3" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTINotes3" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
            </div>
            <a href="javascript:showDiv('4');" id="divNTILink4"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>Add another non-tax item</a>
        </div>

        <div class="form-group hiddenItem" id="divNTI4">
            <h3>Non tax item 4</h3>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="txtNTITitle4" CssClass="col-md-4 control-label">Title</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTIAmount4" CssClass="col-md-4 control-label">Aniunt</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTINotes4" CssClass="col-md-4 control-label">Notes</asp:Label>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTITitle4" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTIAmount4" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTINotes4" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
            </div>
            <a href="javascript:showDiv('5');" id="divNTILink5"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>Add another non-tax item</a>
        </div>

        <div class="form-group hiddenItem" id="divNTI5">
            <h3>Non tax item 5</h3>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="txtNTITitle5" CssClass="col-md-4 control-label">Title</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTIAmount5" CssClass="col-md-4 control-label">Aniunt</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTINotes5" CssClass="col-md-4 control-label">Notes</asp:Label>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTITitle5" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTIAmount5" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTINotes5" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
            </div>
            <a href="javascript:showDiv('6');" id="divNTILink6"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>Add another non-tax item</a>
        </div>

        <div class="form-group hiddenItem" id="divNTI6">
            <h3>Non tax item 6</h3>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="txtNTITitle6" CssClass="col-md-4 control-label">Title</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTIAmount6" CssClass="col-md-4 control-label">Aniunt</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTINotes6" CssClass="col-md-4 control-label">Notes</asp:Label>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTITitle6" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTIAmount6" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTINotes6" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
            </div>
            <a href="javascript:showDiv('7');" id="divNTILink7"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>Add another non-tax item</a>
        </div>

        <div class="form-group hiddenItem" id="divNTI7">
            <h3>Non tax item 7</h3>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="txtNTITitle7" CssClass="col-md-4 control-label">Title</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTIAmount7" CssClass="col-md-4 control-label">Aniunt</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTINotes7" CssClass="col-md-4 control-label">Notes</asp:Label>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTITitle7" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTIAmount7" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTINotes7" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
            </div>
            <a href="javascript:showDiv('8');" id="divNTILink8"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>Add another non-tax item</a>
        </div>

        <div class="form-group hiddenItem" id="divNTI8">
            <h3>Non tax item 8</h3>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="txtNTITitle8" CssClass="col-md-4 control-label">Title</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTIAmount8" CssClass="col-md-4 control-label">Aniunt</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTINotes8" CssClass="col-md-4 control-label">Notes</asp:Label>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTITitle8" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTIAmount8" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTINotes8" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
            </div>
            <a href="javascript:showDiv('9');" id="divNTILink9"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>Add another non-tax item</a>
        </div>

        <div class="form-group hiddenItem" id="divNTI9">
            <h3>Non tax item 9</h3>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="txtNTITitle9" CssClass="col-md-4 control-label">Title</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTIAmount9" CssClass="col-md-4 control-label">Aniunt</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTINotes9" CssClass="col-md-4 control-label">Notes</asp:Label>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTITitle9" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTIAmount9" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTINotes9" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
            </div>
            <a href="javascript:showDiv('10');" id="divNTILink10"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>Add another non-tax item</a>
        </div>

        <div class="form-group hiddenItem" id="divNTI10">
            <h3>Non tax item 10</h3>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="txtNTITitle10" CssClass="col-md-4 control-label">Title</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTIAmount10" CssClass="col-md-4 control-label">Aniunt</asp:Label>
                <asp:Label runat="server" AssociatedControlID="txtNTINotes10" CssClass="col-md-4 control-label">Notes</asp:Label>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTITitle10" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTIAmount10" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtNTINotes10" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
            </div>
        </div>

        <div class="form-group row">
            <asp:Label runat="server" AssociatedControlID="txtNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
            <div class="col-md-4">
                <asp:TextBox ID="txtNotes" TextMode="MultiLine" CssClass="form-control" runat="server" />
            </div>
        </div>

        <asp:Button Text="Submit" ValidationGroup="AddMonth" OnClick="AddMonth" CssClass="btn btn-default" runat="server" />
    </asp:Panel>

    <asp:Panel ID="pnlViewMonth" Visible="false" runat="server">
        <div class="formContainer">
            <h2 class="text-center">
                <asp:Label ID="lblDate" runat="server" /><br />
                Revenue Report</h2><br />
            <span class="itemLabel">
                <strong>Bank Deposits: </strong>
            </span>
            <span class="amount">
                <asp:Label ID="lblBankDeposits" runat="server" />
            </span>
            <br />
            <span class="itemLabel">
                <strong>Wholesale: </strong>
            </span>
            <span class="amount">
                <asp:Label ID="lblWholesale" runat="server" />
            </span>
            <br />
            <span class="itemLabel">
                <strong>Out of State:</strong>
            </span>
            <span class="amount">
                <asp:Label ID="lblOutOfState" runat="server" />
            </span>
            <br />

            <asp:Repeater ID="rptNTI" runat="server">
                <ItemTemplate>
                    <span class="itemLabel"><strong><%# Eval("Title") %></strong></span>
                    <span class="amount"><%#String.Format("{0:c}", Convert.ToDecimal(Eval("Amount")) * -1) %></span><br />
                </ItemTemplate>
            </asp:Repeater>
            <hr />
            <span class="itemLabel">
                <strong>SubTotal: </strong>
            </span>
            <span class="amount">
                <asp:Label ID="lblSubtotal" runat="server" />
            </span><br />
            <hr />

            <span class="itemLabel">
                <strong>
                    Subtotal / <asp:Label ID="lblTaxRate" runat="server" />
                </strong>
            </span>
            <span class="amount">
                <asp:Label ID="lblTaxesBackedOut" runat="server" /></span><br />
            <hr />

            <span class="itemLabel">
                <strong>Out of State:</strong>
            </span>
            <span class="amount">
                <asp:Label ID="lblOutOfState2" runat="server" />
            </span>
            <br />
            <span class="itemLabel">
                <strong>
                    Consignment: 

                </strong>
            </span>
            <span class="amount">
                <asp:Label ID="lblConsignment" runat="server" />
            </span><br />
            <hr />
            <span class="itemLabel">
                <strong>
                    Total Retailing: 
                </strong>
            </span>
            <span class="amount">
                <asp:Label ID="lblTotalRetailing" runat="server" />
            </span><br />
            <hr />
            <span class="itemLabel">
                <strong>
                    Motorized: 
                </strong>
            </span>
            <span class="amount">
                <asp:Label ID="lblMotorized" runat="server" />
            </span><br />
            <span class="itemLabel">
                <strong>
                    Use: 
                </strong>
            </span>
            <span class="amount">
                <asp:Label ID="lblUse" runat="server" /></span><br />
            <hr />
            <span class="itemLabel"><strong>Notes: </strong></span>
            <br />
            <p>
                <span class="amount"><asp:Label ID="lblNotes" runat="server" /></span>
            </p>
        </div>
    </asp:Panel>

</asp:Content>
