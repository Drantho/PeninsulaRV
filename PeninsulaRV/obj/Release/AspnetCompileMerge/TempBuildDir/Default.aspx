<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PeninsulaRV._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <img src="Images/Travel Trailer in Woods Print.jpg" style="width: 100%" />
        </div>
    </div>
    
    <div class="jumbotron">
        <h2>Welcome to Peninsula RV</h2> 
        Browse our inventory. Learn about our consignment program. View the largest RV parts department on the Olympic Peninsula. See what our service department, run by master certified RV technicians, can do for you.
    </div>
    <h3>Featured Units</h3>
   
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <asp:PlaceHolder ID="plhFeatured1" runat="server" />
        <asp:PlaceHolder ID="plhFeatured2" runat="server" />
        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <asp:Repeater ID="rptRecent" runat="server">
        <HeaderTemplate>
            <h3>Recent Arrivals</h3>
            <div class="row">
        </HeaderTemplate>
        <ItemTemplate>
            <div class="col-sm-4">
                <a href="unit.aspx?StockNumber=<%# Eval("VehicleID") %>"><img class="img-responsive" width="100%" src="images/inventory/<%# Eval("VehicleID") %>-thumb1.jpg" alt="image coming soon." /></a>
                <a href="unit.aspx?StockNumber=<%# Eval("VehicleID") %>">
                    <h5><%# Eval("modelyear") %> <%# Eval("make") %> <%# Eval("model") %></h5>
                </a>
                <%# Eval("vehicletype") %><br />
                Stock Number: <%# Eval("VehicleID") %><br />
                VIN: <%# Eval("vin") %><br />
                Asking Price: <%# Eval("AskingPrice", "{0:c}") %><br /><br />
            </div>
            <%# (Container.ItemIndex != 0 && (Container.ItemIndex+1) % 3 == 0) ? @"</div><div class='row'>" : string.Empty %>
        </ItemTemplate>
            
        <FooterTemplate>
            <br /><br />
        </FooterTemplate>
    </asp:Repeater>
    
    
    


  
  


</asp:Content>
