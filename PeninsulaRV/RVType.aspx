<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RVType.aspx.cs" Inherits="PeninsulaRV.RVTpye" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <center><h3><asp:Label ID="lblTypeHeader" runat="server" /></h3></center>
    <hr />
    <asp:PlaceHolder ID="plhVehicleList" runat="server" />
</asp:Content>
