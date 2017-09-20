<%@ Page Title="" Language="C#" MasterPageFile="Blank.Master" AutoEventWireup="true" CodeBehind="SqlQueryTool.aspx.cs" Inherits="PeninsulaRV.secure.SqlQueryTool" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
   
            <asp:TextBox ID="Query" CssClass="form-control" runat="server" /><br />
            <asp:RadioButtonList ID="rblConnectionString" runat="server">
                <asp:ListItem>Local DB</asp:ListItem>
                <asp:ListItem>RV DB</asp:ListItem>
            </asp:RadioButtonList>
            <asp:Button Text="Run Query" OnClick="QueryDatabase" CssClass="btn btn-default" runat="server" />
        
    <asp:Label ID="lblResults" runat="server" />
</asp:Content>
