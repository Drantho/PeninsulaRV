<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalesByMonth.aspx.cs" Inherits="PeninsulaRV.secure.SalesByMonth" %>

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
            </div>
            <div class="col-sm-4">
                <asp:RadioButtonList ID="rblYear" runat="server">
                    <asp:ListItem Value="2012">2012</asp:ListItem>
                    <asp:ListItem Value="2013">2013</asp:ListItem>
                    <asp:ListItem Value="2014">2014</asp:ListItem>
                    <asp:ListItem Value="2015">2015</asp:ListItem>
                    <asp:ListItem Value="2016">2016</asp:ListItem>
                    <asp:ListItem Value="2017">2017</asp:ListItem>
                    <asp:ListItem Value="2018">2018</asp:ListItem>
                </asp:RadioButtonList>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <asp:Button Text="Select Month" CssClass="btn btn-default" OnClick="SelectMonth" runat="server" />
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlForm" Visible="false" runat="server">
        <h1><asp:Label ID="lblReportHeader" runat="server" /></h1>
        <asp:PlaceHolder ID="plhReport" runat="server" />
    </asp:Panel>
</asp:Content>
