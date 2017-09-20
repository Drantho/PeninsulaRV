<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SellVehicle.aspx.cs" Inherits="PeninsulaRV.secure.SellVehicle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlSelectVehicle" runat="server">
        <h1 class="text-center">Select Vehicle</h1>

        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#SelectVehicle">Select Vehicle</a></li>
            <li><a data-toggle="tab" href="#SelectOffer">Select Offer</a></li>
        </ul>

        <div class="tab-content">

            <div id="SelectVehicle" class="tab-pane fade in active">

                <asp:Repeater ID="rptStockList" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <th>Stock Number</th>
                                <th>Model Year</th>
                                <th>Make</th>
                                <th>Model</th>
                                <th>Vehicle Type</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:LinkButton OnCommand="SelectVehicle" CommandArgument='<%# Eval("ConsignmentID")%>' runat="server"><%# Eval("Stocknumber") %></asp:LinkButton></td>
                            <td>
                                <asp:LinkButton OnCommand="SelectVehicle" CommandArgument='<%# Eval("ConsignmentID")%>' runat="server"><%# Eval("ModelYear") %></asp:LinkButton></td>
                            <td>
                                <asp:LinkButton OnCommand="SelectVehicle" CommandArgument='<%# Eval("ConsignmentID")%>' runat="server"><%# Eval("Make") %></asp:LinkButton></td>
                            <td>
                                <asp:LinkButton OnCommand="SelectVehicle" CommandArgument='<%# Eval("ConsignmentID")%>' runat="server"><%# Eval("Model") %></asp:LinkButton></td>
                            <td>
                                <asp:LinkButton OnCommand="SelectVehicle" CommandArgument='<%# Eval("ConsignmentID")%>' runat="server"><%# Eval("VehicleType") %></asp:LinkButton></td>
                            <td>
                                <asp:LinkButton OnCommand="SelectVehicle" CommandArgument='<%# Eval("ConsignmentID")%>' runat="server"><%# Eval("LastName") %>, <%# Eval("FirstName") %></asp:LinkButton></td>
                            <td>
                                <asp:LinkButton OnCommand="SelectVehicle" CommandArgument='<%# Eval("ConsignmentID")%>' runat="server"><%# Eval("PhoneNumber") %></asp:LinkButton></td>
                            <td>
                                <asp:LinkButton OnCommand="SelectVehicle" CommandArgument='<%# Eval("ConsignmentID")%>' runat="server"><%# Eval("AltPhoneNumber") %></asp:LinkButton></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

            </div>

            <div id="SelectOffer" class="tab-pane fade in">

                <asp:Repeater ID="rptOffer" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <th>Stock Number</th>
                                <th>Model Year</th>
                                <th>Make</th>
                                <th>Model</th>
                                <th>Vehicle Type</th>
                                <th>Seller Name</th>
                                <th>Seller Phone</th>
                                <th>Buyer Name</th>
                                <th>Buyer Phone</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("Stocknumber") %></asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("ModelYear") %></asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("Make") %></asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("Model") %></asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("VehicleType") %></asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("SellerName") %></asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("SellerPhoneNumber") %></asp:LinkButton><br />
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("SellerAltPhoneNumber") %></asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("BuyerName") %></asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("BuyerPhoneNumber") %></asp:LinkButton><br />
                                <asp:LinkButton OnCommand="SelectOffer" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("BuyerAltPhoneNumber") %></asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

            </div>

        </div>

        
    </asp:Panel>

    <asp:Panel ID="pnlSelectBuyer" Visible="false" runat="server">
        <h1 class="text-center">Select Buyer</h1>
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#SelectCustomer">Select Customer</a></li>
            <li><a data-toggle="tab" href="#AddCustomer">Add New Customer</a></li>
            <li><a data-toggle="tab" href="#UpdateVehicle">Update Vehicle</a></li>
        </ul>

        <div class="tab-content">

            <div id="SelectBuyer" class="tab-pane fade in active">

                <div style="height: 550px; width: 100%; overflow-y: scroll; overflow-x: hidden">
                    <asp:RadioButtonList ID="rblCustomerList" CssClass="mylist" RepeatColumns="3" ValidationGroup="SelectCustomer" RepeatDirection="Horizontal" runat="server" />

                </div>
                <br />
                <asp:RequiredFieldValidator ErrorMessage="Select Customer. <br>" CssClass="text-danger" ControlToValidate="rblCustomerList" ValidationGroup="SelectCustomer" Display="Dynamic" runat="server" />
                <asp:Button OnClick="SelectBuyer" Text="Select Customer" ValidationGroup="SelectCustomer" CssClass="btn btn-default" runat="server" />

            </div>

            <div id="AddCustomer" class="tab-pane fade">
                <h3>Add New Customer</h3>

                <div class="form-horizontal">

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="FirstName" CssClass="col-md-2 control-label">First Name</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="FirstName" CssClass="form-control" />

                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="LastName" CssClass="col-md-2 control-label">Last Name/Business</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="LastName" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="Dynamic" ValidationGroup="AddCustomer" runat="server" ControlToValidate="LastName"
                                CssClass="text-danger" ErrorMessage="The last name field is required." />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Address" CssClass="col-md-2 control-label">Address</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Address" CssClass="form-control" />

                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="City" CssClass="col-md-2 control-label">City</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="City" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="State" CssClass="col-md-2 control-label">State</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="State" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Zip" CssClass="col-md-2 control-label">Zip</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Zip" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Phone" CssClass="col-md-2 control-label">Phone</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Phone" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="AltPhone" CssClass="col-md-2 control-label">Alt Phone</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="AltPhone" CssClass="form-control" />
                        </div>
                    </div>

                    <asp:Button OnClick="AddNewCustomer" Text="Add Customer" ValidationGroup="AddCustomer" CssClass="btn btn-default" runat="server" />

                </div>

            </div>   
            
            <div id="UpdateVehicle" class="tab-pane fade">
                <h3>Update Vehicle</h3>
                <div class="form-horizontal">

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtUpdateStocknumber" CssClass="col-md-2 control-label">Stock Number:</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtUpdateStocknumber" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="UpdateVehicle" runat="server" ControlToValidate="txtUpdateStocknumber"
                                        CssClass="text-danger" ErrorMessage="The stock number field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtUpdateModelYear" CssClass="col-md-2 control-label">Model Year:</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtUpdateModelYear" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="UpdateVehicle" runat="server" ControlToValidate="txtUpdateModelYear"
                                        CssClass="text-danger" ErrorMessage="The model year field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtUpdateMake" CssClass="col-md-2 control-label">Make</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtUpdateMake" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="UpdateVehicle" runat="server" ControlToValidate="txtUpdateMake"
                                        CssClass="text-danger" ErrorMessage="The make field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtUpdateModel" CssClass="col-md-2 control-label">Model</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtUpdateModel" CssClass="form-control" />

                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtUpdateVIN" CssClass="col-md-2 control-label">VIN</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtUpdateVIN" CssClass="form-control" />

                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtUpdateMileage" CssClass="col-md-2 control-label">Mileage</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtUpdateMileage" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="UpdateVehicle" runat="server" ControlToValidate="txtUpdateMileage"
                                        CssClass="text-danger" ErrorMessage="The mileage field is required." />
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <h4>Vehicle Type</h4>
                            <asp:RadioButtonList ID="rblUpdateVehicleType" runat="server">
                                <asp:ListItem>Class A Motorhome</asp:ListItem>
                                <asp:ListItem>Class B Motorhome</asp:ListItem>
                                <asp:ListItem>Class C Motorhome</asp:ListItem>
                                <asp:ListItem>Fifth Wheel Trailer</asp:ListItem>
                                <asp:ListItem>Travel Trailer</asp:ListItem>
                                <asp:ListItem>Truck Camper</asp:ListItem>
                                <asp:ListItem>Automobile</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ValidationGroup="UpdateVehicle" runat="server" ControlToValidate="rblUpdateVehicleType"
                                        CssClass="text-danger" ErrorMessage="The vehicle type field is required." />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <asp:Button OnClick="UpdateVehicle" ValidationGroup="UpdateVehicle" Text="Update Vehicle" CssClass="btn btn-default" runat="server" />
                        </div>
                    </div>
                </div>
            </div>         

        </div>
    </asp:Panel>
    
    <asp:Panel ID="pnlSaleInfo" Visible="false" runat="server">
        <h1 class="text-center">Sale Info</h1>
        <div class="form-horizontal">

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="rblOffer" CssClass="col-md-2 control-label">Offer or Final Sale</asp:Label>
                <div class="col-md-2">
                    <asp:RadioButtonList runat="server" ID="rblOffer">
                        <asp:ListItem>Offer</asp:ListItem>
                        <asp:ListItem>Sold</asp:ListItem>
                    </asp:RadioButtonList>

                </div>
            </div>      

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtSalePrice" CssClass="col-md-2 control-label">Sale Price</asp:Label>
                <div class="col-md-2">
                    <asp:TextBox runat="server" ID="txtSalePrice" CssClass="form-control" />

                </div>
            </div>            

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtDocumentFee" CssClass="col-md-2 control-label">Document Fee</asp:Label>
                <div class="col-md-2">
                    <asp:TextBox runat="server" ID="txtDocumentFee" Text="150" CssClass="form-control" />

                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtLicenseFee" CssClass="col-md-2 control-label">License Fee</asp:Label>
                <div class="col-md-2">
                    <asp:TextBox runat="server" ID="txtLicenseFee" CssClass="form-control" />

                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtDealerCost" CssClass="col-md-2 control-label">Dealer Cost</asp:Label>
                <div class="col-md-2">
                    <asp:TextBox runat="server" ID="txtDealerCost" Text="150" CssClass="form-control" />

                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtLienHolder" CssClass="col-md-2 control-label">New Lien Holder</asp:Label>
                <div class="col-md-2">
                    <asp:TextBox runat="server" ID="txtLienHolder" Text="None" CssClass="form-control" />

                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="cblSalesman" CssClass="col-md-2 control-label">Salesman:</asp:Label>
                <div class="col-md-2">
                    <asp:CheckBoxList ID="cblSalesman" runat="server">
                        <asp:ListItem>Harry Mitchell</asp:ListItem>
                        <asp:ListItem>Dan Carriveau</asp:ListItem>
                        <asp:ListItem>Mike Mantle</asp:ListItem>
                        <asp:ListItem>Joe Abandonato</asp:ListItem>
                    </asp:CheckBoxList>
                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtSaleDate" CssClass="col-md-2 control-label">Sale Date(Delivery Date)</asp:Label>
                <div class="col-md-2">
                    <asp:TextBox runat="server" ID="txtSaleDate" TextMode="Date" CssClass="form-control" />

                </div>
            </div>                

            <h2 class="text-center">Tax Info</h2>
            
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="rblTaxExempt" CssClass="col-md-2 control-label">Tax Exempt:</asp:Label>
                <div class="col-md-2">
                    <asp:RadioButtonList ID="rblTaxExempt" runat="server">                        
                        <asp:ListItem Selected="True">No</asp:ListItem>
                        <asp:ListItem>Yes</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
            <div id="divTax" style="display: none">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="rblExemptReason" CssClass="col-md-2 control-label">Exempt Reason</asp:Label>
                    <div class="col-md-4">
                        <asp:RadioButtonList ID="rblExemptReason" runat="server">
                            <asp:ListItem>Out of State</asp:ListItem>
                            <asp:ListItem>Wholesale</asp:ListItem>
                            <asp:ListItem>Sale to Native on Native Land</asp:ListItem>
                        </asp:RadioButtonList>

                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtDriversLicense" CssClass="col-md-2 control-label">Drivers License</asp:Label>
                    <div class="col-md-2">
                        <asp:TextBox runat="server" ID="txtDriversLicense" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="rblAltIDType" CssClass="col-md-2 control-label">Alternate ID Type:</asp:Label>
                    <div class="col-md-2">
                        <asp:RadioButtonList ID="rblAltIDType" runat="server">
                            <asp:ListItem>Current Residential Agreement</asp:ListItem>
                            <asp:ListItem>Property tax statement from current or previous year</asp:ListItem>
                            <asp:ListItem>Utility Bill dated with the previous two months</asp:ListItem>
                            <asp:ListItem>State income tax return from previous year</asp:ListItem>
                            <asp:ListItem>Voter ID Card</asp:ListItem>
                            <asp:ListItem>Current credit report</asp:ListItem>
                        </asp:RadioButtonList>

                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="rblTaxExempt" CssClass="col-md-2 control-label">Is there a trade?</asp:Label>
                    <div class="col-md-2">
                        <asp:RadioButtonList ID="RadioButtonList2" runat="server">
                            <asp:ListItem Selected="True">No</asp:ListItem>
                            <asp:ListItem>Yes</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>

            </div>

            <h2 class="text-center">Trade Info</h2>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="rblTrade" CssClass="col-md-2 control-label">Is there a trade?</asp:Label>
                <div class="col-md-2">
                    <asp:RadioButtonList ID="rblTrade" runat="server">                        
                        <asp:ListItem Selected="True">No</asp:ListItem>
                        <asp:ListItem>Yes</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>

            <div id="divTrade" style="display: none">

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtTradeModelYear" CssClass="col-md-2 control-label">Model Year</asp:Label>
                    <div class="col-md-2">
                        <asp:TextBox runat="server" ID="txtTradeModelYear" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtTradeMake" CssClass="col-md-2 control-label">Make</asp:Label>
                    <div class="col-md-2">
                        <asp:TextBox runat="server" ID="txtTradeMake" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtTradeModel" CssClass="col-md-2 control-label">Model</asp:Label>
                    <div class="col-md-2">
                        <asp:TextBox runat="server" ID="txtTradeModel" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtTradeVIN" CssClass="col-md-2 control-label">VIN</asp:Label>
                    <div class="col-md-2">
                        <asp:TextBox runat="server" ID="txtTradeVIN" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtTradeValue" CssClass="col-md-2 control-label">Trade Value</asp:Label>
                    <div class="col-md-2">
                        <asp:TextBox runat="server" ID="txtTradeValue" Text="0" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtTradeTaxCredit" CssClass="col-md-2 control-label">Trade Tax Credit</asp:Label>
                    <div class="col-md-2">
                        <asp:TextBox runat="server" ID="txtTradeTaxCredit" Text="0" CssClass="form-control" />
                    </div>
                </div>
            </div>

                             
            
            <h2 class="text-center">Payment Info</h2>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtCashWithOrder" CssClass="col-md-2 control-label">Cash With Order</asp:Label>
                <div class="col-md-2">
                    <asp:TextBox runat="server" ID="txtCashWithOrder" Text="0" CssClass="form-control" />
                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtDeposit" CssClass="col-md-2 control-label">Deposit</asp:Label>
                <div class="col-md-2">
                    <asp:TextBox runat="server" ID="txtDeposit" Text="0" CssClass="form-control" />
                </div>
            </div>
            
            <h2 class="text-center">Options</h2>

            <div class="row">
                <div class="col-sm-8">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionDescription1" CssClass="col-md-2 control-label">Option 1</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtOptionDescription1" TextMode="MultiLine" Text="MCC Gas Check" CssClass="form-control" />

                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionPrice1" CssClass="col-md-2 control-label">Price</asp:Label>
                        <div class="col-md-5">
                            <asp:TextBox runat="server" ID="txtOptionPrice1" Text="0" CssClass="form-control" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-8">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionDescription2" CssClass="col-md-2 control-label">Option 2</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtOptionDescription2" TextMode="MultiLine" Text="Walk through with technician" CssClass="form-control" />

                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionPrice2" CssClass="col-md-2 control-label">Price</asp:Label>
                        <div class="col-md-5">
                            <asp:TextBox runat="server" ID="txtOptionPrice2" Text="0" CssClass="form-control" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-8">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionDescription3" CssClass="col-md-2 control-label">Option 3</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtOptionDescription3" TextMode="MultiLine" Text="" CssClass="form-control" />

                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionPrice3" CssClass="col-md-2 control-label">Price</asp:Label>
                        <div class="col-md-5">
                            <asp:TextBox runat="server" ID="txtOptionPrice3" CssClass="form-control" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-8">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionDescription4" CssClass="col-md-2 control-label">Option 4</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtOptionDescription4" TextMode="MultiLine" Text="" CssClass="form-control" />

                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionPrice4" CssClass="col-md-2 control-label">Price</asp:Label>
                        <div class="col-md-5">
                            <asp:TextBox runat="server" ID="txtOptionPrice4" CssClass="form-control" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-8">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionDescription5" CssClass="col-md-2 control-label">Option 5</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtOptionDescription5" TextMode="MultiLine" Text="" CssClass="form-control" />

                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionPrice5" CssClass="col-md-2 control-label">Price</asp:Label>
                        <div class="col-md-5">
                            <asp:TextBox runat="server" ID="txtOptionPrice5" CssClass="form-control" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-8">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionDescription6" CssClass="col-md-2 control-label">Option 6</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtOptionDescription6" TextMode="MultiLine" Text="" CssClass="form-control" />

                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtOptionPrice6" CssClass="col-md-2 control-label">Price</asp:Label>
                        <div class="col-md-5">
                            <asp:TextBox runat="server" ID="txtOptionPrice6" CssClass="form-control" />
                        </div>
                    </div>
                </div>
            </div>
            <asp:Button Text="Add Sale" OnClick="AddSale" CssClass="btn btn-default" runat="server" />
        </div>
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

    <asp:HiddenField ID="hdnConsignmentID" runat="server" />
    <asp:HiddenField ID="hdnBuyerID" runat="server" />
    <asp:HiddenField ID="hdnVehicleID" runat="server" />
    <asp:HiddenField ID="hdnTradeID" runat="server" />
    <script>
        $("#MainContent_rblTaxExempt_0").on('change', function () {
            $("#divTax").toggle();
        });

        $("#MainContent_rblTaxExempt_1").on('change', function () {
            $("#divTax").toggle();
        });

        $("#MainContent_rblTrade_0").on('change', function () {
            $("#divTrade").toggle();
        });

        $("#MainContent_rblTrade_1").on('change', function () {
            $("#divTrade").toggle();
        });

        function toggleDiv(divId) {

            $("#" + divId).toggle();

        }

        
    </script>
</asp:Content>
