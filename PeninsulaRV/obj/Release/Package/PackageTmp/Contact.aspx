<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="PeninsulaRV.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    
    <address>
        <strong>Address</strong><br />
       261293 Hwy 101<br />
        Sequim, WA 98382<br />
    </address>

    <address>
        <strong>Phone:</strong>   360.582.9199<br />
        <strong>Fax:</strong>   360.582.9959<br />
        <strong>Email:</strong> <a href="mailto:peninsularv@gmail.com">peninsularv@gmail.com</a>
    </address>

    <h4>Hours</h4>
    <strong>Mon-Fri:</strong> 8:00am - 5:00pm<br />
    <strong>Sat</strong> 9:00am - 1:00pm<br />
    <strong>Sun</strong> Closed
</asp:Content>
