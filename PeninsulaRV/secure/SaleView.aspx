<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaleView.aspx.cs" Inherits="PeninsulaRV.secure.SaleView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlMonthSelect" runat="server">
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
                <asp:RequiredFieldValidator ControlToValidate="rblMonth" Display="Dynamic" ErrorMessage="Select Month" runat="server" />
            </div>
            <div class="col-sm-4">
                <asp:RadioButtonList ID="rblYear" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="rblYear" Display="Dynamic" ErrorMessage="Select Year" runat="server" />
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <asp:Button OnClick="GetMonthInfo" Text="Select Month" ValidationGroup="SelectMonth" CssClass="btn btn-default" runat="server" />
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlMonthView" Visible="false" runat="server">
        <asp:PlaceHolder ID="plhMonth" runat="server" />
    </asp:Panel>
    <asp:Label ID="lblResult" runat="server" />
</asp:Content>
