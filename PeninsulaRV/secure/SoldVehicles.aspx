<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SoldVehicles.aspx.cs" Inherits="PeninsulaRV.secure.SoldVehicles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlSelectMonth" runat="server">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#SelectMonth">View sales by month</a></li>
            <li><a data-toggle="tab" href="#Recent">Recent</a></li>
            <li><a data-toggle="tab" href="#Search">Search</a></li>
        </ul>

        <div class="tab-content">
            <div id="SelectMonth" class="tab-pane fade in active">
                <div class="row">
                    <div class="col-sm-3">
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
                        <asp:RequiredFieldValidator ControlToValidate="rblMonth" ValidationGroup="SelectMonth" ErrorMessage="Month is required." Display="Dynamic" CssClass="text-danger" runat="server" />
                    </div>
                    <div class="col-sm-3">
                        <asp:RadioButtonList ID="rblYear" runat="server" />
                        <asp:RequiredFieldValidator ControlToValidate="rblYear" ValidationGroup="SelectMonth" ErrorMessage="Year is required." Display="Dynamic" CssClass="text-danger" runat="server" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <asp:Button OnClick="SelectMonth" ValidationGroup="SelectMonth" Text="Select Month" CssClass="btn btn-default" runat="server" />
                    </div>
                </div>
            </div>
            <div id="Recent" class="tab-pane fade in">
                <asp:Repeater ID="rptRecent" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <th>Sale ID
                                </th>
                                <th>Date
                                </th>
                                <th>Status
                                </th>
                                <th>Vehicle
                                </th>
                                <th>Buyer
                                </th>
                                <th>Seller
                                </th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:LinkButton OnCommand="SelectMonthOffer" CommandArgument='<%# Eval("OfferID") %>' runat="server"><%# Eval("OfferID") %></asp:LinkButton></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "SaleDate", "{0:M/d//yyyy}") %></td>
                            <td><%# Eval("OfferStatus") %></td>
                            <td><%# Eval("ModelYear") %> <%# Eval("Make") %> <%# Eval("Model") %> <%# Eval("VehicleType") %></td>
                            <td><%# Eval("BuyerName") %></td>
                            <td><%# Eval("SellerName") %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div id="Search" class="tab-pane fade in">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtSearch" CssClass="col-md-2 control-label">Make Model VIN Seller or Buyer:</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="txtSearch" CssClass="form-control" />
                        <asp:RequiredFieldValidator ValidationGroup="Search" runat="server" ControlToValidate="txtSearch" CssClass="text-danger" ErrorMessage="Enter a search." />
                    </div>
                    <asp:Button OnClick="Search" Text="Search" CssClass="btn btn-default" ValidationGroup="Search" runat="server" />
                </div>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlMonthList" runat="server">
        <asp:Repeater ID="rptMonthList" runat="server">
            <HeaderTemplate>
                <table>
                    <tr>
                        <th>Sale ID
                        </th>
                        <th>Date
                        </th>
                        <th>Status
                        </th>
                        <th>Vehicle
                        </th>
                        <th>Buyer
                        </th>
                        <th>Seller
                        </th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:LinkButton OnCommand="SelectMonthOffer" CommandArgument='<%# Eval("OfferID") %>' runat="server"><%# Eval("OfferID") %></asp:LinkButton></td>
                    <td><%# DataBinder.Eval(Container.DataItem, "SaleDate", "{0:M/d//yyyy}") %></td>
                    <td><%# Eval("OfferStatus") %></td>
                    <td><%# Eval("ModelYear") %> <%# Eval("Make") %> <%# Eval("Model") %> <%# Eval("VehicleType") %></td>
                    <td><%# Eval("BuyerName") %></td>
                    <td><%# Eval("SellerName") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>

    </asp:Panel>

    <asp:Panel ID="pnlReview" Visible="false" runat="server">

        <h1 class="text-center">Review Sale</h1>

        <ul class="nav nav-tabs">

            <li><a data-toggle="tab" href="#ReviewVehicleInfo">Vehicle Info</a></li>
            <li><a data-toggle="tab" href="#ReviewBuyerInfo">Buyer Info</a></li>
            <li class="active"><a data-toggle="tab" href="#ReviewSaleInfo">Sale Info</a></li>
            <li><a data-toggle="tab" href="#ReviewLinks">Links</a></li>
        </ul>

        <div class="tab-content">

            <div id="ReviewVehicleInfo" class="tab-pane fade in">

                <h2>Vehicle Info</h2>
                <b>Vehicle ID: </b>
                <asp:Label ID="lblVehicleID" runat="server" /><br />
                <b>Stock Number: </b>
                <asp:Label ID="lblStocknumber" runat="server" />
                <a href="javascript:toggleDiv('divStocknumber');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divStocknumber" style="display: none">
                    <asp:TextBox ID="txtReviewStocknumber" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateStocknumber" runat="server">Update stocknumber</asp:LinkButton>
                </div>
                <b>Model Year: </b>
                <asp:Label ID="lblModelYear" runat="server" />
                <a href="javascript:toggleDiv('divModelYear');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divModelYear" style="display: none">
                    <asp:TextBox ID="txtReviewModelYear" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateModelYear" runat="server">Update model year</asp:LinkButton>
                </div>
                <b>Make: </b>
                <asp:Label ID="lblMake" runat="server" />
                <a href="javascript:toggleDiv('divMake');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divMake" style="display: none">
                    <asp:TextBox ID="txtReviewMake" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateMake" runat="server">Update make</asp:LinkButton>
                </div>
                <b>Model: </b>
                <asp:Label ID="lblModel" runat="server" />
                <a href="javascript:toggleDiv('divModel');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divModel" style="display: none">
                    <asp:TextBox ID="txtReviewModel" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateModel" runat="server">Update Model</asp:LinkButton>
                </div>
                <b>VIN: </b>
                <asp:Label ID="lblVIN" runat="server" />
                <a href="javascript:toggleDiv('divVIN');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divVIN" style="display: none">
                    <asp:TextBox ID="txtReviewVIN" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateVIN" runat="server">Update VIN</asp:LinkButton>
                </div>
                <b>Mileage: </b>
                <asp:Label ID="lblMileage" runat="server" />
                <a href="javascript:toggleDiv('divMileage');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divMileage" style="display: none">
                    <asp:TextBox ID="txtReviewMileage" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateMileage" runat="server">Update mileage</asp:LinkButton>
                </div>
                <b>Vehicle Type: </b>
                <asp:Label ID="lblVehicleType" runat="server" />
                <a href="javascript:toggleDiv('divVehicleType');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divVehicleType" style="display: none">
                    <asp:RadioButtonList ID="rblReviewVehicleType" runat="server">
                        <asp:ListItem>Class A Motorhome</asp:ListItem>
                        <asp:ListItem>Class B Motorhome</asp:ListItem>
                        <asp:ListItem>Class C Motorhome</asp:ListItem>
                        <asp:ListItem>Fifth Wheel Trailer</asp:ListItem>
                        <asp:ListItem>Travel Trailer</asp:ListItem>
                        <asp:ListItem>Truck Camper</asp:ListItem>
                        <asp:ListItem>Automobile</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:LinkButton OnCommand="UpdateVehicleType" runat="server">Update vehicle type</asp:LinkButton>
                </div>

            </div>

            <div id="ReviewBuyerInfo" class="tab-pane fade in">

                <h2>Buyer Info</h2>
                <b>Customer ID: </b>
                <asp:Label ID="lblCustomerID" runat="server" /><br />
                <b>First Name: </b>
                <asp:Label ID="lblFirstName" runat="server" />
                <a href="javascript:toggleDiv('divFirstName');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divFirstName" style="display: none">
                    <asp:TextBox ID="txtReviewFirstName" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateFirstName" runat="server">Update first name</asp:LinkButton>
                </div>
                <b>Last/Company Name: </b>
                <asp:Label ID="lblLastName" runat="server" />
                <a href="javascript:toggleDiv('divLastName');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divLastName" style="display: none">
                    <asp:TextBox ID="txtReviewLastName" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateLastName" runat="server">Update last name</asp:LinkButton>
                </div>
                <b>Address: </b>
                <asp:Label ID="lblAddress" runat="server" />
                <a href="javascript:toggleDiv('divAddress');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divAddress" style="display: none">
                    <asp:TextBox ID="txtReviewAddress" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateAddress" runat="server">Update address</asp:LinkButton>
                </div>
                <b>City: </b>
                <asp:Label ID="lblCity" runat="server" />
                <a href="javascript:toggleDiv('divCity');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divCity" style="display: none">
                    <asp:TextBox ID="txtReviewCity" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateCity" runat="server">Update city</asp:LinkButton>
                </div>
                <b>State: </b>
                <asp:Label ID="lblState" runat="server" />
                <a href="javascript:toggleDiv('divState');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divState" style="display: none">
                    <asp:TextBox ID="txtReviewState" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateState" runat="server">Update state</asp:LinkButton>
                </div>
                <b>Zip: </b>
                <asp:Label ID="lblZip" runat="server" />
                <a href="javascript:toggleDiv('divZip');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divZip" style="display: none">
                    <asp:TextBox ID="txtReviewZip" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateZip" runat="server">Update zip</asp:LinkButton>
                </div>
                <b>Phone: </b>
                <asp:Label ID="lblPhone" runat="server" />
                <a href="javascript:toggleDiv('divPhone');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divPhone" style="display: none">
                    <asp:TextBox ID="txtReviewPhone" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdatePhone" runat="server">Update phone</asp:LinkButton>
                </div>
                <b>Alt Phone: </b>
                <asp:Label ID="lblAltPhone" runat="server" />
                <a href="javascript:toggleDiv('divAltPhone');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divAltPhone" style="display: none">
                    <asp:TextBox ID="txtReviewAltPhone" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateAltPhone" runat="server">Update alt phone</asp:LinkButton>
                </div>

            </div>

            <div id="ReviewSaleInfo" class="tab-pane fade in active">

                <h2>Sale Info</h2>
                <b>Sale ID: </b>
                <asp:Label ID="lblSaleID" runat="server" /><br />
                <b>Sale Status: </b>
                <asp:Label ID="lblSaleStatus" runat="server" />
                <a href="javascript:toggleDiv('divSaleStatus');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divSaleStatus" style="display: none">
                    <asp:RadioButtonList ID="rblReviewSaleStatus" runat="server">
                        <asp:ListItem>Offer</asp:ListItem>
                        <asp:ListItem>Sold</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:LinkButton OnCommand="UpdateSaleStatus" runat="server">Update sale status</asp:LinkButton>
                </div>
                <b>Sale Date: </b>
                <asp:Label ID="lblSaleDate" runat="server" />
                <a href="javascript:toggleDiv('divSaleDate');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divSaleDate" style="display: none">
                    <asp:TextBox ID="txtReviewSaleDate" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateSaleDate" runat="server">Update sale date</asp:LinkButton>
                </div>
                <b>Salesman: </b><a href="javascript:toggleDiv('divSalesmen');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <ul>
                    <asp:Label ID="lblSalesman" runat="server" />
                </ul>
                <div id="divSalesmen" style="display: none">
                    <asp:CheckBoxList ID="cblReviewSalesmen" runat="server">
                        <asp:ListItem>Harry Mitchell</asp:ListItem>
                        <asp:ListItem>Dan Carriveau</asp:ListItem>
                        <asp:ListItem>Mike Mantle</asp:ListItem>
                        <asp:ListItem>Joe Abandonato</asp:ListItem>
                    </asp:CheckBoxList>
                    <asp:LinkButton OnCommand="UpdateSalesmen" runat="server">Update salesmen</asp:LinkButton>
                </div>
                <b>Sale Price: </b>
                <asp:Label ID="lblSalePrice" runat="server" />
                <a href="javascript:toggleDiv('divSalePrice');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divSalePrice" style="display: none">
                    <asp:TextBox ID="txtReviewSalePrice" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateSalePrice" runat="server">Update sale price</asp:LinkButton>
                </div>
                <b>Options: </b><a href="javascript:toggleDiv('divOption');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <ul>
                    <asp:Label ID="lblOptions" runat="server" />
                </ul>
                <div id="divOption" style="display: none">
                    <div class="row">
                        <div class="col-sm-7">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionDescription1" CssClass="col-md-4 control-label">Option 1</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionDescription1" TextMode="MultiLine" Text="" CssClass="form-control" />

                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionPrice1" CssClass="col-md-2 control-label">Price</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionPrice1" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-7">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionDescription2" CssClass="col-md-4 control-label">Option 2</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionDescription2" TextMode="MultiLine" Text="" CssClass="form-control" />

                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionPrice2" CssClass="col-md-2 control-label">Price</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionPrice2" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-7">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionDescription3" CssClass="col-md-4 control-label">Option 3</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionDescription3" TextMode="MultiLine" Text="" CssClass="form-control" />

                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionPrice3" CssClass="col-md-2 control-label">Price</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionPrice3" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-7">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionDescription4" CssClass="col-md-4 control-label">Option 4</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionDescription4" TextMode="MultiLine" Text="" CssClass="form-control" />

                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionPrice4" CssClass="col-md-2 control-label">Price</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionPrice4" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-7">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionDescription5" CssClass="col-md-4 control-label">Option 5</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionDescription5" TextMode="MultiLine" Text="" CssClass="form-control" />

                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionPrice5" CssClass="col-md-2 control-label">Price</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionPrice5" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-7">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionDescription6" CssClass="col-md-4 control-label">Option 6</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionDescription6" TextMode="MultiLine" Text="" CssClass="form-control" />

                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtReviewOptionPrice6" CssClass="col-md-2 control-label">Price</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtReviewOptionPrice6" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:LinkButton OnCommand="UpdateOptions" runat="server">Update options</asp:LinkButton>
                </div>
                <b>Options Total: </b>
                <asp:Label ID="lblOptionsTotal" runat="server" /><br />

                <b>Dealer Cost: </b>
                <asp:Label ID="lblDealerCost" runat="server" />
                <a href="javascript:toggleDiv('divDealerCost');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divDealerCost" style="display: none">
                    <asp:TextBox ID="txtReviewDealerCost" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateDealerCost" runat="server">Update dealer cost</asp:LinkButton>
                </div>

                <b>Document Fee: </b>
                <asp:Label ID="lblDocumentFee" runat="server" />
                <a href="javascript:toggleDiv('divDocumentFee');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divDocumentFee" style="display: none">
                    <asp:TextBox ID="txtReviewDocumentFee" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateDocumentFee" runat="server">Update document fee</asp:LinkButton>
                </div>
                <b>Tax Status: </b>
                <asp:Label ID="lblTaxStatus" runat="server" />
                <a href="javascript:toggleDiv('divTaxStatus');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divTaxStatus" style="display: none">
                    <asp:TextBox ID="txtReviewTaxStatus" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateTaxStatus" runat="server">Update tax status</asp:LinkButton>
                </div>
                <b>Tax Exempt ID: </b>
                <asp:Label ID="lblTaxID" runat="server" />
                <a href="javascript:toggleDiv('divTaxExemptID');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divTaxExemptID" style="display: none">
                    <asp:TextBox ID="txtReviewTaxExemptID" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateTaxExemptID" runat="server">Update tax exempt ID</asp:LinkButton>
                </div>
                <b>Sales Tax: </b>
                <asp:Label ID="lblSalesTax" runat="server" /><br />
                <b>License Fee: </b>
                <asp:Label ID="lblLicenseFee" runat="server" />
                <a href="javascript:toggleDiv('divLicenseFee');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divLicenseFee" style="display: none">
                    <asp:TextBox ID="txtReviewLicenseFee" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateLicenseFee" runat="server">Update license fee</asp:LinkButton>
                </div>
                <b>Grand Total: </b>
                <asp:Label ID="lblGrandTotal" runat="server" /><br />
                <b>Trade: </b>
                <asp:Label ID="lblTrade" runat="server" />
                <a href="javascript:toggleDiv('divTradeInfo');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divTradeInfo" style="display: none">
                    <asp:TextBox ID="txtReviewTradeInfo" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateTradeInfo" runat="server">Update trade info</asp:LinkButton>
                </div>
                <b>Trade Value: </b>
                <asp:Label ID="lblTradeValue" runat="server" />
                <a href="javascript:toggleDiv('divTradeValue');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divTradeValue" style="display: none">
                    <asp:TextBox ID="txtReviewTradeValue" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateTradeValue" runat="server">Update trade value</asp:LinkButton>
                </div>
                <b>Trade Tax Credit: </b>
                <asp:Label ID="lblTaxCredit" runat="server" />
                <a href="javascript:toggleDiv('divTradeTaxCredit');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divTradeTaxCredit" style="display: none">
                    <asp:TextBox ID="txtReviewTradeTaxCredit" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateTradeTaxCredit" runat="server">Update trade tax credit</asp:LinkButton>
                </div>
                <b>Cash With Order: </b>
                <asp:Label ID="lblCashWithOrder" runat="server" />
                <a href="javascript:toggleDiv('divCashWithOrder');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divCashWithOrder" style="display: none">
                    <asp:TextBox ID="txtReviewCashWithOrder" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateCashWithOrder" runat="server">Update cash with order</asp:LinkButton>
                </div>
                <b>Deposit: </b>
                <asp:Label ID="lblDeposit" runat="server" />
                <a href="javascript:toggleDiv('divDeposit');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                <br />
                <div id="divDeposit" style="display: none">
                    <asp:TextBox ID="txtReviewDeposit" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="UpdateDeposit" runat="server">Update deposit</asp:LinkButton>
                </div>
                <b>Balance Due: </b>
                <asp:Label ID="lblBalanceDue" runat="server" /><br />

            </div>

            <div id="ReviewLinks" class="tab-pane fade in">

                <h3>Links</h3>
                <asp:HyperLink ID="hlkPurchaseOrder" Target="_blank" runat="server"><h4><span class="glyphicon glyphicon-print" aria-hidden="true"></span> Printable Version</h4></asp:HyperLink>
                <a href="https://sanctionssearch.ofac.treas.gov/" target="_blank">
                    <h4>OFAC Search</h4>
                </a>
                <a href="PurchaseOrderBackSide.aspx" target="_blank">
                    <h4>Purchase order back side</h4>
                </a>
                <asp:HyperLink ID="hlkImpliedWarranty" Target="_blank" runat="server">
                    <h4>Implied warranty negotiation statement</h4>
                </asp:HyperLink>
                <asp:HyperLink ID="hlkUnitPage" Target="_blank" runat="server">
                    <h4>Unit on peninsularv.net</h4>
                </asp:HyperLink>
                <a href="https://secure.dol.wa.gov/home/" target="_blank">
                    <h4>DOL</h4>
                </a>

            </div>

        </div>

    </asp:Panel>
</asp:Content>
