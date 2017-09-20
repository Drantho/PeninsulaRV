<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="links.aspx.cs" Inherits="PeninsulaRV.secure.links" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:Panel ID="pnlSupervisor" Visible="false" runat="server">
        <h3>Supervisor Links</h3>
        <a href="SalesBySalesman.aspx"><h4>Sales By Salesman</h4></a>
        <a href="SalesByMonth.aspx"><h4>Sales By Month</h4></a>
        <a href="SoldVehicles.aspx"><h4>Sold Vehicles and Offers</h4></a>
        <a href="SellVehicle.aspx"><h4>Sell Vehicle</h4></a>
        <a href="ReturnVehicle.aspx"><h4>Return Vehicle To Consignor</h4></a>
        <a href="ConsignmentAgreement.aspx"><h4>Consignment Agreement</h4></a>
        <a href="ImpliedWarrantyStatement.aspx"><h4>Blank Implied Warranty Statement</h4></a>
        <a href="PurchaseOrderBackSide.aspx"><h4>Purchase Order Back Side</h4></a>
        <a href="https://secure.dol.wa.gov/home/" target="_blank"><h4>DOL</h4></a>
        <a href="Lenders.aspx" target="_blank"><h4>Lenders</h4></a>
        <a href="SQLQueryTool.aspx"><h4>SQL Tool</h4></a>
        <hr />
    </asp:Panel>
    <asp:Panel ID="pnlTechnician" Visible="false" runat="server">
        <h3>Technician Links</h3>
        <a href="WorkOrder.aspx"><h4>Work Order</h4></a>
        <hr />
    </asp:Panel>
    <asp:Panel ID="pnlSales" runat="server">
        <h3>Salesman Links</h3>
        <a href="StockList.aspx"><h4>Stock List</h4></a>
        <a href="Upload.aspx"><h4>Upload Photos</h4></a>
        <a href="SalesLeads.aspx"><h4>Sales Leads</h4></a>
        <a href="AddDescription.aspx"><h4>Add Vehicle Description</h4></a>

    </asp:Panel>

</asp:Content>
