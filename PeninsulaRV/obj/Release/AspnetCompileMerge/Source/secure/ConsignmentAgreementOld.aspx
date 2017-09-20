<%@ Page Title="Default Title" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsignmentAgreementOld.aspx.cs" Inherits="PeninsulaRV.secure.ConsignmentAgreement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlCustomer" runat="server">

        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#SelectCustomer">Select Customer</a></li>
            <li><a data-toggle="tab" href="#AddNewCustomer">Add New Customer</a></li>  
            <li><a data-toggle="tab" href="#CurrentConsignments">Current Consignments</a></li>          
        </ul>

        <div class="tab-content">
            <div id="SelectCustomer" class="tab-pane fade in active">
                <div style="height: 550px; width: 100%; overflow-y: scroll; overflow-x: hidden">
                    <asp:RadioButtonList ID="rblCustomerList" CssClass="mylist" RepeatColumns="4" RepeatDirection="Horizontal" runat="server" />
                </div><br />
                <asp:Button OnClick="SelectCustomer" Text="Select Customer" CssClass="btn btn-default" runat="server" />

            </div>
            <div id="AddNewCustomer" class="tab-pane fade">
                <h3>Add New Customer</h3>
                
                <div class="form-horizontal">

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="col-md-2 control-label">First Name</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control" />
                            
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtLastName" CssClass="col-md-2 control-label">Last Name/Business</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="Dynamic" ValidationGroup="AddCustomer" runat="server" ControlToValidate="txtLastName"
                                CssClass="text-danger" ErrorMessage="The last name field is required." />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtAddress" CssClass="col-md-2 control-label">Address</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control" />
                            
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtCity" CssClass="col-md-2 control-label">City</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtCity" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtState" CssClass="col-md-2 control-label">State</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtState" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtZip" CssClass="col-md-2 control-label">Zip</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtZip" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="col-md-2 control-label">Phone</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtAltPhone" CssClass="col-md-2 control-label">Alt Phone</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtAltPhone" CssClass="form-control" />
                        </div>
                    </div>

                    <asp:Button OnClick="AddCustomer" Text="Add Customer" ValidationGroup="AddCustomer" CssClass="btn btn-default" runat="server" />

                </div>
            </div>
            <div id="CurrentConsignments" class="tab-pane fade">
                <asp:Repeater ID="rptCurrentConsignments" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <th>Sale ID</th>
                                <th>Year</th>
                                <th>Make</th>
                                <th>Model</th>
                                <th>Vehicle Type</th>
                                <th>Customer</th>
                                <th>Phone</th>
                                <th>Alt Phone</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        
                            <tr>
                                <td>
                                    <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("SaleID") %>' runat="server">
                                        <%# Eval("SaleID") %>
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("SaleID") %>' runat="server">
                                        <%# Eval("ModelYear") %>
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("SaleID") %>' runat="server">
                                    <%# Eval("Make") %>
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("SaleID") %>' runat="server">
                                    <%# Eval("Model") %>
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("SaleID") %>' runat="server">
                                    <%# Eval("VehicleType") %>
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("SaleID") %>' runat="server">
                                    <%# Eval("LastName") %>, <%# Eval("FirstName") %>
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("SaleID") %>' runat="server">
                                    <%# Eval("PhoneNumber") %>
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("SaleID") %>' runat="server">
                                    <%# Eval("AltPhoneNumber") %>
                                    </asp:LinkButton>
                                </td>
                            </tr>                        
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>

        <asp:HiddenField ID="hdnCustomerID" runat="server" />
        <asp:HiddenField ID="hdnVehicleID" runat="server" />
        <asp:HiddenField ID="hdnSaleID" runat="server" />

    </asp:Panel>

    <asp:Panel ID="pnlVehicle" Visible="false" runat="server">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#SelectVehicle">Select Vehicle</a></li>
            <li><a data-toggle="tab" href="#AddVehicle">Add Vehicle</a></li>
            <li><a data-toggle="tab" href="#UpdateCustomer">Update Customer Info</a></li>
        </ul>

        <div class="tab-content">

            <div id="SelectVehicle" class="tab-pane fade in active">
                <h4><asp:Label ID="lblVehicleMessage" runat="server" /></h4>
                <div style="height: 350px; width: 100%; overflow-y: scroll; overflow-x: hidden">
                    <asp:RadioButtonList ID="rblVehicleList" CssClass="mylist" runat="server" />
                </div><br />
                <asp:Button ID="btnSelectVehicle" OnClick="SelectVehicle" Text="Select Vehicle" CssClass="btn btn-default" runat="server" />

            </div>

            <div id="AddVehicle" class="tab-pane fade">
                <h3>Add Vehicle</h3>
                <div class="form-horizontal">

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtModelYear" CssClass="col-md-2 control-label">Model Year:</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtModelYear" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="AddVehicle" runat="server" ControlToValidate="txtModelYear"
                                        CssClass="text-danger" ErrorMessage="The model year field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtMake" CssClass="col-md-2 control-label">Make</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtMake" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="AddVehicle" runat="server" ControlToValidate="txtMake"
                                        CssClass="text-danger" ErrorMessage="The make field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtModel" CssClass="col-md-2 control-label">Model</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtModel" CssClass="form-control" />

                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtVIN" CssClass="col-md-2 control-label">VIN</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtVIN" CssClass="form-control" />

                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtMileage" CssClass="col-md-2 control-label">Mileage</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtMileage" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="AddVehicle" runat="server" ControlToValidate="txtMileage"
                                        CssClass="text-danger" ErrorMessage="The mileage field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtStocknumber" CssClass="col-md-2 control-label">Stock Number</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtStocknumber" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="AddVehicle" runat="server" ControlToValidate="txtStocknumber"
                                        CssClass="text-danger" ErrorMessage="The stock number field is required." />
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <h4>Vehicle Type</h4>
                            <asp:RadioButtonList ID="rblVehicleType" runat="server">
                                <asp:ListItem>Class A Motorhome</asp:ListItem>
                                <asp:ListItem>Class B Motorhome</asp:ListItem>
                                <asp:ListItem>Class C Motorhome</asp:ListItem>
                                <asp:ListItem>Fifth Wheel Trailer</asp:ListItem>
                                <asp:ListItem>Travel Trailer</asp:ListItem>
                                <asp:ListItem>Truck Camper</asp:ListItem>
                                <asp:ListItem>Automobile</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ValidationGroup="AddVehicle" runat="server" ControlToValidate="rblVehicleType"
                                        CssClass="text-danger" ErrorMessage="The vehicle type field is required." />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <asp:Button OnClick="AddVehicle" ValidationGroup="AddVehicle" Text="Add Vehicle" CssClass="btn btn-default" runat="server" />
                        </div>
                    </div>
                </div>
            </div>

            <div id="UpdateCustomer" class="tab-pane fade">
            
                <h3>Update Customer</h3>

                <div class="form-horizontal">

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUpdateFirstName" CssClass="col-md-2 control-label">First Name</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtUpdateFirstName" CssClass="form-control" />
                            
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUpdateLastName" CssClass="col-md-2 control-label">Last Name/Business</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtUpdateLastName" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="Dynamic" ValidationGroup="UpdateCustomer" runat="server" ControlToValidate="txtUpdateLastName"
                                CssClass="text-danger" ErrorMessage="The last name field is required." />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUpdateAddress" CssClass="col-md-2 control-label">Address</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtUpdateAddress" CssClass="form-control" />
                            
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUpdateCity" CssClass="col-md-2 control-label">City</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtUpdateCity" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUpdateState" CssClass="col-md-2 control-label">State</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtUpdateState" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUpdateZip" CssClass="col-md-2 control-label">Zip</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtUpdateZip" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUpdatePhone" CssClass="col-md-2 control-label">Phone</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtUpdatePhone" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUpdateAltPhone" CssClass="col-md-2 control-label">Alt Phone</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtUpdateAltPhone" CssClass="form-control" />
                        </div>
                    </div>

                    <asp:Button OnClick="UpdateCustomer" Text="Update Customer" ValidationGroup="UpdateCustomer" CssClass="btn btn-default" runat="server" />

            
            </div>

        </div>

        </div>
    </asp:Panel>

    <asp:Panel ID="pnlConsignment" Visible="false" runat="server">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#AddConsignment">Add Consignment</a></li>
            <li><a data-toggle="tab" href="#SelectConsignment">Select Consignment</a></li>
            <li><a data-toggle="tab" href="#UpdateVehicle">Update Vehicle</a></li>
        </ul>

        <div class="tab-content">
            <div id="AddConsignment" class="tab-pane fade in active">
                <h3>Add Consignment</h3>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="rblDealType" CssClass="col-md-2 control-label">Commission Type:</asp:Label>
                    <asp:RadioButtonList ID="rblDealType" runat="server">
                        <asp:ListItem>Percent Deal</asp:ListItem>
                        <asp:ListItem>Excess Of Deal</asp:ListItem>
                        <asp:ListItem>Flat Fee Deal</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ValidationGroup="AddConsignment" runat="server" ControlToValidate="rblDealType"
                            CssClass="text-danger" ErrorMessage="The deal type field is required." />
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtCustomerPrice" CssClass="col-md-2 control-label">Consignor Amount:</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="txtCustomerPrice" Text="0" CssClass="form-control" />
                        <asp:RequiredFieldValidator ValidationGroup="AddConsignment" runat="server" ControlToValidate="txtCustomerPrice"
                            CssClass="text-danger" ErrorMessage="The consignor amount field is required." />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtPercent" CssClass="col-md-2 control-label">Percent Commission:</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="txtPercent" Text="0" CssClass="form-control" />
                        <asp:RequiredFieldValidator ValidationGroup="AddConsignment" runat="server" ControlToValidate="txtPercent"
                            CssClass="text-danger" ErrorMessage="The percent commission field is required." />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtFlatFee" CssClass="col-md-2 control-label">Flat Fee:</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="txtFlatFee" Text="0" CssClass="form-control" />
                        <asp:RequiredFieldValidator ValidationGroup="AddConsignment" runat="server" ControlToValidate="txtFlatFee"
                            CssClass="text-danger" ErrorMessage="The flat fee field is required." />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtAskingPrice" CssClass="col-md-2 control-label">Asking Price:</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="txtAskingPrice" CssClass="form-control" />
                        <asp:RequiredFieldValidator ValidationGroup="AddConsignment" runat="server" ControlToValidate="txtAskingPrice"
                            CssClass="text-danger" ErrorMessage="The consignor amount field is required." />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtTerm" CssClass="col-md-2 control-label">Term(days):</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="txtTerm" CssClass="form-control" />
                        <asp:RequiredFieldValidator ValidationGroup="AddConsignment" runat="server" ControlToValidate="txtTerm"
                            CssClass="text-danger" ErrorMessage="The term field is required." />
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtLienHolder" CssClass="col-md-2 control-label">Lien Holder:</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="txtLienHolder" Text="None" CssClass="form-control" />                        
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtbalanceOwed" CssClass="col-md-2 control-label">Balance Owed:</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="txtBalanceOwed" Text="0" CssClass="form-control" />                        
                    </div>
                </div>                
                <asp:Button Text="Add Consignment" OnClick="AddConsignment" CssClass="btn btn-default" runat="server" />
            </div>

            <div id="SelectConsignment" class="tab-pane fade">
                <h3>Select Consignment</h3>
                <asp:RadioButtonList ID="rblConsignments" runat="server" />
                <asp:Button Text="Select Consignment" OnClick="SelectConsignment" CssClass="btn btn-default" runat="server" />
            </div>

             <div id="UpdateVehicle" class="tab-pane fade">
                <h3>Update Vehicle</h3>
                <div class="form-horizontal">

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtUpdateStockNumber" CssClass="col-md-2 control-label">Stock Number:</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtUpdateStockNumber" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="UpdateVehicle" runat="server" ControlToValidate="txtUpdateStockNumber"
                                        CssClass="text-danger" ErrorMessage="The model year field is required." />
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

    <asp:Panel ID="pnlReview" Visible="false" runat="server">
        <div class="row">
            <div class="col-sm-4">
                <h4><asp:HyperLink ID="hlkPrint" Target="_blank" runat="server">Printable Form</asp:HyperLink></h4>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-4">
                <h3>Customer Info</h3>
                <strong>Customer ID: </strong><asp:Label ID="lblSaleReviewCustomerID" runat="server" /><br />
                <a href="javascript: toggleDiv('divFirstName');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>First Name: </strong><asp:Label ID="lblSaleReviewFirstName" runat="server" /><br />
                <div id="divFirstName" style="display: none">
                    <asp:TextBox ID="txtEditFirstName" CssClass="form-control" runat="server" />
                </div>
                <a href="javascript: toggleDiv('divLastName');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Last Name: </strong><asp:Label ID="lblSaleReviewLastName" runat="server" /><br />
                <div id="divLastName" style="display: none">
                    <asp:TextBox ID="txtEditLastName" CssClass="form-control" runat="server" />
                </div>
                <a href="javascript: toggleDiv('divAddress');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Address: </strong><asp:Label ID="lblSaleReviewAddress" runat="server" /><br />
                <div id="divAddress" style="display: none">
                    <asp:TextBox ID="txtEditAddress" CssClass="form-control" runat="server" />
                </div>
                <a href="javascript: toggleDiv('divCity');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>City: </strong><asp:Label ID="lblSaleReviewCity" runat="server" /><br />
                <div id="divCity" style="display: none">
                    <asp:TextBox ID="txtEditCity" CssClass="form-control" runat="server" />
                </div>
                <a href="javascript: toggleDiv('divState');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>State: </strong><asp:Label ID="lblSaleReviewState" runat="server" /><br />
                <div id="divState" style="display: none">
                    <asp:TextBox ID="txtEditState" CssClass="form-control" runat="server" />
                </div>
                <a href="javascript: toggleDiv('divZip');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Zip: </strong><asp:Label ID="lblSaleReviewZip" runat="server" /><br />
                <div id="divZip" style="display: none">
                    <asp:TextBox ID="txtEditZip" CssClass="form-control" runat="server" />
                </div>
                <a href="javascript: toggleDiv('divPhone');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Phone: </strong><asp:Label ID="lblSaleReviewPhone" runat="server" /><br />
                <div id="divPhone" style="display: none">
                    <asp:TextBox ID="txtEditPhone" CssClass="form-control" runat="server" />
                </div>
                <a href="javascript: toggleDiv('divAltPhone');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Alt Phone: </strong><asp:Label ID="lblSaleReviewAltPhone" runat="server" /><br />
                <div id="divAltPhone" style="display: none">
                    <asp:TextBox ID="txtEditAltPhone" CssClass="form-control" runat="server" />
                </div>
            </div>
            <div class="col-sm-4">
                <h3>Vehicle Info</h3>
                <strong>Vehicle ID: </strong><asp:Label ID="lblSaleReviewVehicleID" runat="server" /><br />
                <a href="javascript: toggleDiv('divModelYear');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Model Year: </strong><asp:Label ID="lblSaleReviewModelYear" runat="server" /><br />
                <div id="divModelYear" style="display: none">
                    <asp:TextBox ID="txtEditModelYear" CssClass="form-control" runat="server" />
                    <asp:LinkButton CommandArgument="ModelYear" OnCommand="UpdateVehicle" runat="server">Update Model Year</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divMake');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Make: </strong><asp:Label ID="lblSaleReviewMake" runat="server" /><br />
                <div id="divMake" style="display: none">
                    <asp:TextBox ID="txtEditMake" CssClass="form-control" runat="server" />
                    <asp:LinkButton CommandArgument="Make" OnCommand="UpdateVehicle" runat="server">Update Make</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divModel');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Model: </strong><asp:Label ID="lblSaleReviewModel" runat="server" /><br />
                <div id="divModel" style="display: none">
                    <asp:TextBox ID="txtEditModel" CssClass="form-control" runat="server" />
                    <asp:LinkButton CommandArgument="Model" OnCommand="UpdateVehicle" runat="server">Update Model</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divVIN');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>VIN: </strong><asp:Label ID="lblSaleReviewVIN" runat="server" /><br />
                <div id="divVIN" style="display: none">
                    <asp:TextBox ID="txtEditVIN" CssClass="form-control" runat="server" />
                    <asp:LinkButton CommandArgument="VIN" OnCommand="UpdateVehicle" runat="server">Update VIN</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divStockNumber');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Stock Number: </strong><asp:Label ID="lblSaleReviewStocknumber" runat="server" /><br />
                <div id="divStockNumber" style="display: none">
                    <asp:TextBox ID="txtEditStockNumber" CssClass="form-control" runat="server" />
                    <asp:LinkButton CommandArgument="StockNumber" OnCommand="UpdateVehicle" runat="server">Update Stock Number</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divVehicleType');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Vehicle Type: </strong><asp:Label ID="lblSaleReviewRvType" runat="server" /><br />
                <div id="divVehicleType" style="display: none">
                    <asp:RadioButtonList ID="rblEditVehicleType" runat="server">
                        <asp:ListItem>Class A Motorhome</asp:ListItem>
                        <asp:ListItem>Class B Motorhome</asp:ListItem>
                        <asp:ListItem>Class C Motorhome</asp:ListItem>
                        <asp:ListItem>Fifth Wheel Trailer</asp:ListItem>
                        <asp:ListItem>Travel Trailer</asp:ListItem>
                        <asp:ListItem>Truck Camper</asp:ListItem>
                        <asp:ListItem>Automobile</asp:ListItem>
                    </asp:RadioButtonList>    
                    <asp:LinkButton CommandArgument="VehicleType" OnCommand="UpdateVehicle" runat="server">UpdateVehicle Type</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divDescription');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Description: </strong><asp:Label ID="lblSaleReviewDescription" runat="server" /><br />
                <div id="divDescription" style="display: none">
                    <asp:TextBox ID="txtEditDescription" TextMode="MultiLine" CssClass="form-control" runat="server" />
                    <asp:LinkButton CommandArgument="Description" OnCommand="UpdateVehicle" runat="server">Update Description</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divMileage');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Mileage: </strong><asp:Label ID="lblSaleReviewMileage" runat="server" /><br />
                <div id="divMileage" style="display: none">
                    <asp:TextBox ID="txtEditMileage" CssClass="form-control" runat="server" />
                    <asp:LinkButton CommandArgument="Mileage" OnCommand="UpdateVehicle" runat="server">Update Mileage</asp:LinkButton>
                </div>
            </div>
            <div class="col-sm-4">
                <h3>Sale Info</h3>
                <strong>Sale ID: </strong><asp:Label ID="lblSaleReviewSaleID" runat="server" /><br />
                <a href="javascript: toggleDiv('divAskingPrice');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Asking Price: </strong><asp:Label ID="lblSaleReviewAskingPrice" runat="server" /><br />
                <div id="divAskingPrice" style="display: none">
                    <asp:TextBox ID="txtEditAskingPrice" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="Updatesale" CommandArgument="AskingPrice" Text="" runat="server">Update Asking Price</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divDealType');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Deal Type: </strong>
                <asp:Label ID="lblSaleReviewPercentDeal" runat="server">Percent Deal</asp:Label>
                <asp:Label ID="lblSaleReviewExcessOfDeal" runat="server">Excess Of Deal</asp:Label>
                <asp:Label ID="lblSaleReviewFlatFeeDeal" runat="server">Flat Fee Deal</asp:Label>

                &nbsp;
                <a href="javascript: toggleDiv('divCommissionCalc');"> <span class="glyphicon glyphicon-edit"></span></a>
                <asp:Label ID="lblSaleReviewPercent" runat="server">%</asp:Label>
                <asp:Label ID="lblSaleReviewCustomerPrice" runat="server" />
                <asp:Label ID="lblSaleReviewFeeAmount" runat="server" />
                
                <br />
                <div id="divDealType" style="display: none">
                    <asp:RadioButtonList ID="rblEditDealType" runat="server">
                        <asp:ListItem>Percent Deal</asp:ListItem>
                        <asp:ListItem>Excess Of Deal</asp:ListItem>
                        <asp:ListItem>Flat Fee Deal</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:LinkButton OnCommand="Updatesale" CommandArgument="DealType" runat="server">Update Deal Type</asp:LinkButton>
                </div>

                <div id="divCommissionCalc" style="display: none">
                    <asp:TextBox ID="txtEditCommissionCalc" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="Updatesale" CommandArgument="CommissionCalc" Text="" runat="server">Update Commission</asp:LinkButton>
                </div>

                <a href="javascript: toggleDiv('divConsignDate');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Consign Date: </strong><asp:Label ID="lblSaleReviewConsignDate" runat="server" /><br />
                <div id="divConsignDate" style="display: none">
                    <asp:TextBox ID="txtEditConsignDate" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="Updatesale" CommandArgument="ConsignDate" Text="" runat="server">Update Consign Date</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divExpireDate');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Expire Date: </strong><asp:Label ID="lblSaleReviewExpireDate" runat="server" /><br />
                <div id="divExpireDate" style="display: none">
                    <asp:TextBox ID="txtEditExpireDate" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="Updatesale" CommandArgument="ExpireDate" Text="" runat="server">Update Expire Date</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divLienHolder');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Lien Holder: </strong><asp:Label ID="lblSaleReviewLienHolder" runat="server" /><br />
                <div id="divLienHolder" style="display: none">
                    <asp:TextBox ID="txtEditLienHolder" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="Updatesale" CommandArgument="LienHolderName" Text="" runat="server">Update Lien Holder Name</asp:LinkButton>
                </div>
                <a href="javascript: toggleDiv('divBalanceOwed');"> <span class="glyphicon glyphicon-edit"></span></a>
                <strong>Balance Owed: </strong><asp:Label ID="lblSaleReviewBalanceOwed" runat="server" /><br />
                <div id="divBalanceOwed" style="display: none">
                    <asp:TextBox ID="txtEditBalanceOwed" CssClass="form-control" runat="server" />
                    <asp:LinkButton OnCommand="Updatesale" CommandArgument="BalanceOwed" Text="" runat="server">Update Balance Owed</asp:LinkButton>
                </div>

            </div>
        </div>
        <asp:PlaceHolder ID="plhReview" runat="server" /><br />
        <a href="ConsignmentAgreementForm.aspx">Printable Form</a>
    </asp:Panel>
    <asp:Label ID="lblResult" runat="server" />
</asp:Content>
