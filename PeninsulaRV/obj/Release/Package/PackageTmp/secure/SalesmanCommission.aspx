<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalesmanCommission.aspx.cs" Inherits="PeninsulaRV.secure.SalesmanCommission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        th {
            padding: 10px 10px 10px 0px;
        }
        .col-md-4{
            display: none;
        }
    </style>
    <script>
        function toggleDiv(div) {
            $("#" + div).toggle();
        }
    </script>
    <asp:Panel ID="pnlSelectMonth" runat="server">
        <div class="row">
            <div class="col-sm-6">
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
                    <asp:ListItem Value="12">November</asp:ListItem>
                    <asp:ListItem Value="13">December</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div class="col-sm-6">
                <asp:RadioButtonList ID="rblYear" runat="server">
                    <asp:ListItem Value="2012">2012</asp:ListItem>
                    <asp:ListItem Value="2013">2013</asp:ListItem>
                    <asp:ListItem Value="2014">2014</asp:ListItem>
                    <asp:ListItem Value="2015">2015</asp:ListItem>
                    <asp:ListItem Value="2016">2016</asp:ListItem>
                    <asp:ListItem Value="2017">2017</asp:ListItem>
                    <asp:ListItem Value="2018">2018</asp:ListItem>
                    <asp:ListItem Value="2019">2019</asp:ListItem>
                </asp:RadioButtonList>
            </div>
        </div>
        <asp:Button OnClick="SelectMonth" Text="Select Month" CssClass="btn btn-default" runat="server" />
    </asp:Panel>
    <asp:Panel ID="pnlSales" Visible="false" runat="server">
        <asp:Repeater ID="rptSales" runat="server">
            <HeaderTemplate>
                <table>
                    <tr>
                        <th>OfferID</th>
                        <th>Vehicle</th>
                        <th>Sale Date</th>
                        <th>Seller</th>
                        <th>Buyer</th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>

                <tr>
                    <td>
                        <asp:LinkButton OnCommand="SelectSale" CommandArgument='<%# Eval("OfferID") %>' runat="server">
                            <%# Eval("OfferID") %>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <%# Eval("ModelYear") %> <%# Eval("Make") %> <%# Eval("Model") %>
                    </td>
                    <td>
                        <strong>Sale Date: </strong><%# Eval("SaleDate", "{0:MM/dd/yy}")%>
                    </td>
                    <td>Seller: <%# Eval("SellerName") %>
                    </td>
                    <td>
                        <%# Eval("BuyerName") %>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </asp:Panel>
    <asp:Panel ID="pnlSaleInfo" Visible="false" runat="server">

        <div class="panel-group" id="accordion">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Edit deal details</a>
                    </h4>
                </div>
                <div id="collapse1" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <asp:Label ID="lblResult" runat="server" />

                        <div class="row form-group">
                            <a href="javascript:toggleDiv('divStatus');">
                                <span class="col-md-1 glyphicon glyphicon-edit" aria-hidden="true"></span> 
                            </a>
                            <asp:Label runat="server" ID="lblEditStatus" AssociatedControlID="rblStatus" CssClass="col-md-3 control-label"></asp:Label>
                            <div id="divStatus" class="col-md-4">
                                <asp:RadioButtonList ID="rblStatus" runat="server">
                                    <asp:ListItem>Offer</asp:ListItem>
                                    <asp:ListItem>Sold</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:LinkButton OnCommand="UpdateStatus" runat="server">Update sale status</asp:LinkButton><br />
                            </div>
                        </div>

                        <div class="row form-group">
                            <a href="javascript:toggleDiv('divSaleDate');">
                                <span class="col-md-1 glyphicon glyphicon-edit" aria-hidden="true"></span>
                            </a>
                            <asp:Label runat="server" ID="lblEditSaleDate" AssociatedControlID="txtSaleDate" CssClass="col-md-3 control-label"></asp:Label>
                            <div id="divSaleDate" class="col-md-4">
                                <asp:TextBox ID="txtSaleDate" TextMode="Date" CssClass="form-control" runat="server" /><br />
                                <asp:LinkButton OnCommand="UpdateSaleDate" runat="server">Update sale date</asp:LinkButton><br />
                            </div>
                        </div>

                        <div class="row form-group">
                            <a href="javascript:toggleDiv('divDealType');">
                                <span class="col-md-1 glyphicon glyphicon-edit" aria-hidden="true"></span>
                            </a>
                            <asp:Label ID="lblEditDealType" AssociatedControlID="rblDealType" CssClass="col-md-3 control-label" runat="server"></asp:Label>
                            <div id="divDealType" class="col-md-4">
                                <asp:RadioButtonList ID="rblDealType" runat="server">
                                    <asp:ListItem>Percent Deal</asp:ListItem>
                                    <asp:ListItem>Excess of Deal</asp:ListItem>
                                    <asp:ListItem>Flat Fee Deal</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:LinkButton OnCommand="UpdateDealType" runat="server">Update deal type</asp:LinkButton><br />
                            </div>
                        </div>

                        <div class="row form-group">
                            <a href="javascript:toggleDiv('divCommissionCalc');">    
                                <span class="col-md-1 glyphicon glyphicon-edit" aria-hidden="true"></span>
                            </a>
                            <asp:Label ID="lblEditCommissionCalc" AssociatedControlID="txtEditCommissionCalc" CssClass="col-md-3 control-label" runat="server"></asp:Label>
                            <div id="divCommissionCalc" class="col-md-4">
                                <asp:TextBox ID="txtEditCommissionCalc" TextMode="Number" CssClass="form-control" runat="server" />
                                <asp:LinkButton OnCommand="UpdateCommissionCalc" runat="server">Update commission calc</asp:LinkButton><br />
                            </div>
                        </div>

                        <div class="row form-group">
                            <a href="javascript:toggleDiv('divDealerCost');">
                                <span class="col-md-1 glyphicon glyphicon-edit" aria-hidden="true"></span>
                            </a>
                            <asp:Label ID="lblEditDealerCost" AssociatedControlID="txtDealerCost" CssClass="col-md-3 control-label" runat="server"></asp:Label>
                            <div id="divDealerCost" class="col-md-4">
                                <asp:TextBox ID="txtDealerCost" TextMode="Number" CssClass="form-control" runat="server" />
                                <asp:LinkButton OnCommand="UpdateDealerCost" runat="server">Update dealer cost</asp:LinkButton>
                            </div>
                        </div>
                        
                        <div class="row form-group">
                            <a href="javascript:toggleDiv('divSalesmen');">
                                <span class="col-md-1 glyphicon glyphicon-edit" aria-hidden="true"></span>
                            </a>
                            <asp:Label ID="lblEditSalesmen" AssociatedControlID="cblSalesmen" CssClass="col-md-3 control-label" runat="server"></asp:Label>    
                            <div id="divSalesmen" class="col-md-4">
                                <asp:CheckBoxList ID="cblSalesmen" runat="server">
                                    <asp:ListItem>Harry Mitchell</asp:ListItem>
                                    <asp:ListItem>Dan Carriveau</asp:ListItem>
                                    <asp:ListItem>Mike Mantle</asp:ListItem>
                                    <asp:ListItem>Joe Abandonato</asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">All details</a>
                    </h4>
                </div>
                <div id="collapse2" class="panel-collapse collapse">
                    <div class="panel-body">














                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#SaleInfo">Sale Info</a></li>
                            <li><a data-toggle="tab" href="#VehicleInfo">Vehicle Info</a></li>
                            <li><a data-toggle="tab" href="#BuyerInfo">Buyer Info</a></li>
                            <li><a data-toggle="tab" href="#BuyerInfo">Seller Info</a></li>
                            <li><a data-toggle="tab" href="#ConsignmentInfo">Consignment Info</a></li>
                            <li><a data-toggle="tab" href="#DealInfo">Deal Info</a></li>
                        </ul>

                        <div class="tab-content">
                            <div id="SaleInfo" class="tab-pane fade in active">


                                <h4>Sale Info</h4>
                                <strong>Offer ID: </strong>
                                <asp:Label ID="lblOfferID" runat="server" />
                                <br />
                                <strong>Sale Status: </strong>
                                <asp:Label ID="lblSaleStatus" runat="server" />
                                <br />
                                <strong>Sale Date: </strong>
                                <asp:Label ID="lblSaleDate" runat="server" />
                                <br />
                                <strong>Sale Price: </strong>
                                <asp:Label ID="lblSalePrice" runat="server" />
                                <br />
                                <strong>Options Price: </strong>
                                <asp:Label ID="lblOptionsPrice" runat="server" />
                                <br />
                                <strong>Document Fee: </strong>
                                <asp:Label ID="lblDocumentFee" runat="server" />
                                <br />
                                <strong>License Fee: </strong>
                                <asp:Label ID="lblLicenseFee" runat="server" />
                                <br />
                                <strong>Sales Tax: </strong>
                                <asp:Label ID="lblSalesTax" runat="server" />
                                <br />
                                <strong>Grand Total: </strong>
                                <asp:Label ID="lblGrandTotal" runat="server" />
                                <br />



                            </div>
                            <div id="VehicleInfo" class="tab-pane fade">




                                <h4>Vehicle Info</h4>
                                <strong>Vehicle ID: </strong>
                                <asp:Label ID="lblVehicleID" runat="server" />
                                <br />
                                <strong>Stock Number: </strong>
                                <asp:Label ID="lblStockNumber" runat="server" />
                                <br />
                                <strong>Year: </strong>
                                <asp:Label ID="lblModelYear" runat="server" />
                                <br />
                                <strong>Make: </strong>
                                <asp:Label ID="lblMake" runat="server" />
                                <br />
                                <strong>Model: </strong>
                                <asp:Label ID="lblModel" runat="server" />
                                <br />
                                <strong>VIN: </strong>
                                <asp:Label ID="lblVIN" runat="server" />
                                <br />
                                <strong>Vehicle Type: </strong>
                                <asp:Label ID="lblVehicleType" runat="server" />
                                <br />





                            </div>
                            <div id="BuyerInfo" class="tab-pane fade">



                                <h4>Buyer Info</h4>
                                <strong>Customer ID: </strong>
                                <asp:Label ID="lblBuyerID" runat="server" />
                                <br />
                                <strong>Name: </strong>
                                <asp:Label ID="lblBuyerName" runat="server" />
                                <br />
                                <strong>Address: </strong>
                                <asp:Label ID="lblBuyerAddress" runat="server" />
                                <br />
                                <strong>Phone: </strong>
                                <asp:Label ID="lblBuyerPhone" runat="server" />
                                <br />




                            </div>
                            <div id="SellerInfo" class="tab-pane fade">



                                <h4>Seller Info</h4>
                                <strong>Customer ID: </strong>
                                <asp:Label ID="lblSellerID" runat="server" />
                                <br />
                                <strong>Name: </strong>
                                <asp:Label ID="lblSellerName" runat="server" />
                                <br />
                                <strong>Address: </strong>
                                <asp:Label ID="lblSellerAddress" runat="server" />
                                <br />
                                <strong>Phone: </strong>
                                <asp:Label ID="lblSellerPhone" runat="server" />
                                <br />




                            </div>
                            <div id="ConsignmentInfo" class="tab-pane fade">



                                <h4>Consignment Info</h4>
                                <strong>Consignment ID: </strong>
                                <asp:Label ID="lblConsignmentID" runat="server" />
                                <br />
                                <strong>Consign Date: </strong>
                                <asp:Label ID="lblConsignDate" runat="server" />
                                <br />
                                <strong>Deal Type: </strong>
                                <asp:Label ID="lblDealType" runat="server" />
                                <br />
                                <strong>Commission Calc: </strong>
                                <asp:Label ID="lblCommissionCalc" runat="server" />
                                <br />




                            </div>
                            <div id="DealInfo" class="tab-pane fade">



                                <h4>Deal Info</h4>
                                <strong>Dealer Commission: </strong>
                                <asp:Label ID="lblDealerCommission" runat="server" />
                                <br />
                                <strong>Dealer Cost: </strong>
                                <asp:Label ID="lblDealerCost" runat="server" />
                                <br />
                                <strong>Salesmen: </strong>
                                <asp:Label ID="lblSalesmen" runat="server" />
                                <br />
                                <strong>Salesmen Commissions: </strong>
                                <asp:Label ID="lblSalesmenCommissions" runat="server" />




                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>





    </asp:Panel>

</asp:Content>
