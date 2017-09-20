<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Migrate.aspx.cs" Inherits="PeninsulaRV.secure.Migrate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:CheckBoxList ID="cblSaleInfo" runat="server" />
    <asp:Button OnClick="MigrateData" Text="Migrate Data" CssClass="btn btn-default" runat="server" />
    <asp:Label ID="lblResult" runat="server" />
</asp:Content>
