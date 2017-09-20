<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalesBySalesman.aspx.cs" Inherits="PeninsulaRV.secure.SalesBySalesman" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlSelectMonth" runat="server">
        <div class="row">
            <div class="col-sm-4">
                <asp:RadioButtonList ID="rblMonth" runat="server">
                    <asp:ListItem Value="1">January</asp:ListItem>
                    <asp:ListItem Value="2">February</asp:ListItem>
                    <asp:ListItem Value="3">March</asp:ListItem>
                    <asp:ListItem Value="4">April</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">June</asp:ListItem>
                    <asp:ListItem Value="7">July</asp:ListItem>
                    <asp:ListItem Value="8">August</asp:ListItem>
                    <asp:ListItem Value="9">September</asp:ListItem>
                    <asp:ListItem Value="10">October</asp:ListItem>
                    <asp:ListItem Value="11">November</asp:ListItem>
                    <asp:ListItem Value="12">December</asp:ListItem>
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ControlToValidate="rblMonth" ErrorMessage="Select a month." CssClass="text-danger" Display="Dynamic" runat="server" />
            </div>
            <div class="col-sm-4">
                <asp:RadioButtonList ID="rblYear" runat="server">
                    <asp:ListItem Value="2017">2017</asp:ListItem>                    
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ControlToValidate="rblYear" ErrorMessage="Select a year." CssClass="text-danger" Display="Dynamic" runat="server" />
            </div>
            <div class="col-sm-4">
                <asp:RadioButtonList ID="rblSalesman" runat="server">
                    <asp:ListItem>Harry Mitchell</asp:ListItem>
                    <asp:ListItem>Dan Carriveau</asp:ListItem>
                    <asp:ListItem>Mike Mantle</asp:ListItem>
                    <asp:ListItem>Joe Abandonato</asp:ListItem>
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ControlToValidate="rblSalesman" ErrorMessage="Select a salesman." CssClass="text-danger" Display="Dynamic" runat="server" />
            </div>
        </div>        
        <div class="row">
            <div class="col-sm-12">
                <asp:Button Text="GetReport" OnClick="SelectMonth" CssClass="btn btn-default" runat="server" />
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlReport" Visible="false" runat="server">
        <h1 class="text-center">Commission Report</h1>
        <h2 class="text-center"><asp:Label ID="lblsalesmanName" runat="server" /> - <asp:Label ID="lblMonth" runat="server" /></h2>
        <div class="row">
            <div class="col-xs-2">
                <strong>
                    Sale Date
                </strong>
            </div>
            <div class="col-xs-2">
                <strong>
                    Seller
                </strong>
            </div>
            <div class="col-xs-2">
                <strong>
                    Buyer
                </strong>
            </div>
            <div class="col-xs-2">
                <strong>
                    Vehicle
                </strong>
            </div>
            <div class="col-xs-2 text-right">
                <strong>
                    Commission
                </strong>
            </div>
        </div>
        <asp:PlaceHolder ID="plhReport" runat="server" />
        <div class="row">
            <div class="col-xs-10 text-right">
                <strong>Commission Total: </strong><asp:Label ID="lblMonthCommission" runat="server" />
            </div>
        </div>        
    </asp:Panel>
</asp:Content>
