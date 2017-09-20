<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReturnVehicle.aspx.cs" Inherits="PeninsulaRV.secure.ReturnVehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="text-center">Return vehicle to  consignor</h1>
    <asp:Repeater ID="rptStockList" runat="server">
        <HeaderTemplate>
        </HeaderTemplate>
        <ItemTemplate>
            <div class="row">
                <div class="col-sm-4">
                    <a href="#" data-toggle="modal" data-target='#modal<%# Eval("vehicleid") %>'>
                        <%# Eval("modelyear") %> <%# Eval("make") %> <%# Eval("model") %>
                    </a>
                </div>
                <div class="col-sm-2">
                    <%# Eval("VehicleType") %>
                </div>
                <div class="col-sm-4">
                    <%# Eval("LastName") %>, <%# Eval("FirstName") %>
                </div>
            </div>
            <div class="modal fade" id="modal<%# Eval("vehicleID") %>" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><%# Eval("modelyear") %> <%# Eval("make") %> <%# Eval("model") %></h4>
                        </div>
                        <div class="modal-body">
                            <p>Remove <%# Eval("LastName") %>, <%# Eval("FirstName") %>'s <%# Eval("modelyear") %> <%# Eval("make") %> <%# Eval("model") %> from the website and current stock list.</p>
                            <asp:LinkButton OnCommand="RemoveVehicle" CommandArgument='<%# Eval("ConsignmentID") %>' runat="server">
                                Return Vehicle                                
                            </asp:LinkButton>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
