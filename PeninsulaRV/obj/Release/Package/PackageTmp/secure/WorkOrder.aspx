<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WorkOrder.aspx.cs" Inherits="PeninsulaRV.secure.WorkOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlSelectCustomer" runat="server">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#SelectCustomer">Select Customer</a></li>
            <li><a data-toggle="tab" href="#AddCustomer">Add New Customer</a></li>
            <li><a data-toggle="tab" href="#Recent">Recent Orders</a></li>
        </ul>

        <div class="tab-content">

            <div id="SelectCustomer" class="tab-pane fade in active">

                <div style="height: 550px; width: 100%; overflow-y: scroll; overflow-x: hidden">
                    <asp:RadioButtonList ID="rblCustomerList" CssClass="mylist" RepeatColumns="3" ValidationGroup="SelectCustomer" RepeatDirection="Horizontal" runat="server" />

                </div>
                <br />
                <asp:RequiredFieldValidator ErrorMessage="Select Customer. <br>" CssClass="text-danger" ControlToValidate="rblCustomerList" ValidationGroup="SelectCustomer" Display="Dynamic" runat="server" />
                <asp:Button OnClick="SelectCustomer" Text="Select Customer" ValidationGroup="SelectCustomer" CssClass="btn btn-default" runat="server" />

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

                    <asp:Button OnClick="AddCustomer" Text="Add Customer" ValidationGroup="AddCustomer" CssClass="btn btn-default" runat="server" />

                </div>



            </div>

            <div id="Recent" class="tab-pane fade">
                <h3>Recent Orders</h3>
                <asp:Repeater ID="rptRecentOrders" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <th>Order Number</th>
                                <th>Date Ordered</th>
                                <th>Order Taken By</th>
                                <th>Customer</th>
                                <th>Phone</th>
                                <th>Vehicle</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:LinkButton OnCommand="SelectRecentWorkOrder" CommandArgument='<%# Eval("OrderNumber") %>' runat="server"><%# Eval("OrderNumber") %></asp:LinkButton></td>
                            <td><%# string.Format("{0:MM/dd/yyyy}", Eval("DateOrdered"))%></td>
                            <td><%# Eval("OrderTakenBy") %></td>
                            <td><%# Eval("Name") %></td>
                            <td><%# Eval("PhoneNumber") %> <%# Eval("AltPhoneNumber") %></td>
                            <td><%# Eval("ModelYear") %> <%# Eval("Make") %> <%# Eval("Model") %> <%# Eval("VehicleType") %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

        </div>
    </asp:Panel>
    <asp:Repeater ID="rptSelectedCustomer" runat="server">
        <HeaderTemplate>
            <ul class="native">
        </HeaderTemplate>
        <ItemTemplate>
            <li>
                <asp:LinkButton OnCommand="SelectCustomer" CommandArgument='<%# Eval("CustomerID") %>' runat="server"><%# Eval("LastName") %>, <%# Eval("FirstName") %></asp:LinkButton><br />
                <%# Eval("Address") %><br />
                <%# Eval("City") %>, <%# Eval("State") %> <%# Eval("Zip") %><br />
                <%# Eval("PhoneNumber") %> <%# Eval("AltPhoneNumber") %><br />
                <br />
            </li>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>

    <asp:Panel ID="pnlVehicle" Visible="false" runat="server">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#SelectVehicle">Select Vehicle</a></li>
            <li><a data-toggle="tab" href="#AddVehicle">Add Vehicle</a></li>
            <li><a data-toggle="tab" href="#UpdateCustomer">Update Customer Info</a></li>
        </ul>

        <div class="tab-content">

            <div id="SelectVehicle" class="tab-pane fade in active">

                <div style="height: 350px; width: 100%; overflow-y: scroll; overflow-x: hidden">
                    <asp:RadioButtonList ID="rblVehicleList" CssClass="mylist" runat="server" />
                    <asp:RequiredFieldValidator ControlToValidate="rblVehicleList" ErrorMessage="Select Vehicle." ValidationGroup="SelectVehicle" CssClass="text-danger" Display="Dynamic" runat="server" />
                </div>
                <br />
                <asp:Button OnClick="SelectVehicle" Text="Select Vehicle" ValidationGroup="SelectVehicle" CssClass="btn btn-default" runat="server" />

            </div>

            <div id="AddVehicle" class="tab-pane fade">
                <h3>Add Vehicle</h3>
                <div class="form-horizontal">

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ModelYear" CssClass="col-md-2 control-label">Model Year:</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="ModelYear" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="AddVehicle" runat="server" ControlToValidate="ModelYear"
                                        CssClass="text-danger" ErrorMessage="The model year field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="Make" CssClass="col-md-2 control-label">Make</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="Make" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="AddVehicle" runat="server" ControlToValidate="Make"
                                        CssClass="text-danger" ErrorMessage="The make field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="Model" CssClass="col-md-2 control-label">Model</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="Model" CssClass="form-control" />

                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="VIN" CssClass="col-md-2 control-label">VIN</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="VIN" CssClass="form-control" />

                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="Mileage" CssClass="col-md-2 control-label">Mileage</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="Mileage" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ValidationGroup="AddVehicle" runat="server" ControlToValidate="Mileage"
                                        CssClass="text-danger" ErrorMessage="The mileage field is required." />
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
    </asp:Panel>

    <asp:Panel ID="pnlWorkOder" Visible="false" runat="server">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#SelectWorkOrder">Select Work Order</a></li>
            <li><a data-toggle="tab" href="#AddWorkOrder">Add Work Order</a></li>
            <li><a data-toggle="tab" href="#UpdateVehicle">Update Vehicle</a></li>
        </ul>

        <div class="tab-content">

            <div id="SelectWorkOrder" class="tab-pane fade in active">

                <div style="height: 350px; width: 100%; overflow-y: scroll; overflow-x: hidden">
                    <asp:RadioButtonList ID="rblWorkOrderList" CssClass="mylist" runat="server" />
                    <asp:RequiredFieldValidator ControlToValidate="rblWorkOrderList" ValidationGroup="SelectWorkOrder" ErrorMessage="Select Work Order." CssClass="text-danger" Display="Dynamic" runat="server" />
                </div>
                <br />
                <asp:Button OnClick="SelectWorkOrder" Text="Select Work Order" ValidationGroup="SelectWorkOrder" CssClass="btn btn-default" runat="server" />

            </div>

            <div id="AddWorkOrder" class="tab-pane fade">
                <h3>Add WorkOrder</h3>

                <div class="row">
                    <div class="col-sm-3">
                        <h4>Order Info</h4>
                        <label for="DateOrdered">Date Ordered</label>
                        <asp:TextBox ID="DateOrdered" CssClass="form-control" TextMode="Date" runat="server" />
                        <asp:RequiredFieldValidator CssClass="text-danger" ErrorMessage="Date Required.<br>" ControlToValidate="DateOrdered" Display="Dynamic" runat="server" />
                        <label for="TakenBy">Taken By</label>
                        <asp:TextBox ID="TakenBy" CssClass="form-control" runat="server" />
                        <asp:RequiredFieldValidator CssClass="text-danger" ErrorMessage="Order taken by required.<br>" ControlToValidate="TakenBy" Display="Dynamic" runat="server" />
                        <label for="Mileage">Mileage</label>
                        <asp:TextBox ID="OrderMileage" CssClass="form-control" Text="0" runat="server" />
                        <asp:RequiredFieldValidator CssClass="text-danger" ErrorMessage="Mileage Required.<br>" ControlToValidate="OrderMileage" Display="Dynamic" runat="server" />
                        <asp:CheckBox ID="MaterialExempt" Text="Materials Are Exempt" runat="server" /><br />
                        <asp:CheckBox ID="LaborExempt" Text="Labor Is Exempt" runat="server" /><br />
                    </div>
                </div>
                <hr />
                <h4>Jobs</h4>
                <div class="row">
                    <div class="col-sm-8">
                        <label for="Job1">Job 1</label>
                        <asp:TextBox ID="Job1" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Job2');" id="Job2link">Add Another Job</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="Rate1">Rate 1</label>
                        <asp:TextBox ID="Rate1" Text="99.50" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Hours1">Hours 1</label>
                        <asp:TextBox ID="Hours1" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divJob2" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Job2">Job 2</label>
                        <asp:TextBox ID="Job2" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Job3');" id="Job3link">Add Another Job</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="Rate2">Rate 2</label>
                        <asp:TextBox ID="Rate2" Text="99.50" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Hours2">Hours 2</label>
                        <asp:TextBox ID="Hours2" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divJob3" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Job3">Job 3</label>
                        <asp:TextBox ID="Job3" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Job4');" id="Job4link">Add Another Job</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="Rate3">Rate 3</label>
                        <asp:TextBox ID="Rate3" Text="99.50" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Hours3">Hours 3</label>
                        <asp:TextBox ID="Hours3" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divJob4" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Job4">Job 4</label>
                        <asp:TextBox ID="Job4" TextMode="MultiLine" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Rate4">Rate 4</label>
                        <asp:TextBox ID="Rate4" Text="99.50" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Hours4">Hours 4</label>
                        <asp:TextBox ID="Hours4" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Job5');" id="Job5link">Add Another Job</a>
                    </div>
                </div>
                <div class="row" id="divJob5" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Job5">Job 5</label>
                        <asp:TextBox ID="Job5" TextMode="MultiLine" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Rate4">Rate 5</label>
                        <asp:TextBox ID="Rate5" Text="99.50" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Hours5">Hours 5</label>
                        <asp:TextBox ID="Hours5" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Job6');" id="Job6link">Add Another Job</a>
                    </div>
                </div>
                <div class="row" id="divJob6" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Job6">Job 6</label>
                        <asp:TextBox ID="Job6" TextMode="MultiLine" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Rate6">Rate 6</label>
                        <asp:TextBox ID="Rate6" Text="99.50" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Hours6">Hours 6</label>
                        <asp:TextBox ID="Hours6" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <hr />
                <h4>Materials</h4>
                <div class="row">
                    <div class="col-sm-8">
                        <label for="Material1">Material 1</label>
                        <asp:TextBox ID="Material1" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Material2');" id="Material2link">Add Another Material</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="Quantity1">Quantity 1</label>
                        <asp:TextBox ID="Quantity1" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Price1">Price 1(ea)</label>
                        <asp:TextBox ID="MaterialPrice1" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divMaterial2" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Material2">Material 2</label>
                        <asp:TextBox ID="Material2" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Material3');" id="Material3link">Add Another Material</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="Quantity2">Quantity 2</label>
                        <asp:TextBox ID="Quantity2" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Price2">Price 2(ea)</label>
                        <asp:TextBox ID="MaterialPrice2" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divMaterial3" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Material3">Material 3</label>
                        <asp:TextBox ID="Material3" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Material4');" id="Material4link">Add Another Material</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="Quantity3">Quantity 3</label>
                        <asp:TextBox ID="Quantity3" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Price3">Price 3(ea)</label>
                        <asp:TextBox ID="MaterialPrice3" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divMaterial4" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Material4">Material 4</label>
                        <asp:TextBox ID="Material4" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Material5');" id="Material5link">Add Another Material</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="Quantity4">Quantity 4</label>
                        <asp:TextBox ID="Quantity4" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Price4">Price 4(ea)</label>
                        <asp:TextBox ID="MaterialPrice4" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divMaterial5" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Material5">Material 5</label>
                        <asp:TextBox ID="Material5" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Material6');" id="Material6link">Add Another Material</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="Quantity5">Quantity 5</label>
                        <asp:TextBox ID="Quantity5" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Price5">Price 5(ea)</label>
                        <asp:TextBox ID="MaterialPrice5" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divMaterial6" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Material6">Material 6</label>
                        <asp:TextBox ID="Material6" TextMode="MultiLine" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Quantity6">Quantity 6</label>
                        <asp:TextBox ID="Quantity6" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="Price6">Price 6(ea)</label>
                        <asp:TextBox ID="MaterialPrice6" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <hr />
                <h4>Miscellaneous</h4>
                <div class="row">
                    <div class="col-sm-8">
                        <label for="Miscellaneous1">Miscellaneous 1</label>
                        <asp:TextBox ID="Miscellaneous1" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Miscellaneous2');" id="Miscellaneous2link">Add Another Material</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="MiscellaneousPrice1">Price 1</label>
                        <asp:TextBox ID="MiscellaneousPrice1" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divMiscellaneous2" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Miscellaneous2">Miscellaneous 2</label>
                        <asp:TextBox ID="Miscellaneous2" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Miscellaneous3');" id="Miscellaneous3link">Add Another Material</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="MiscellaneousPrice2">Price 2</label>
                        <asp:TextBox ID="MiscellaneousPrice2" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divMiscellaneous3" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Miscellaneous1">Miscellaneous 3</label>
                        <asp:TextBox ID="Miscellaneous3" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Miscellaneous4');" id="Miscellaneous4link">Add Another Material</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="MiscellaneousPrice1">Price 3</label>
                        <asp:TextBox ID="MiscellaneousPrice3" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divMiscellaneous4" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Miscellaneous4">Miscellaneous 4</label>
                        <asp:TextBox ID="Miscellaneous4" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Miscellaneous5');" id="Miscellaneous5link">Add Another Material</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="MiscellaneousPrice4">Price 4</label>
                        <asp:TextBox ID="MiscellaneousPrice4" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divMiscellaneous5" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Miscellaneous5">Miscellaneous 5</label>
                        <asp:TextBox ID="Miscellaneous5" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        <a href="javascript:toggleDivs('Miscellaneous6');" id="Miscellaneous6link">Add Another Material</a>
                    </div>
                    <div class="col-sm-2">
                        <label for="MiscellaneousPrice4">Price 5</label>
                        <asp:TextBox ID="MiscellaneousPrice5" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="row" id="divMiscellaneous6" style="display: none;">
                    <div class="col-sm-8">
                        <label for="Miscellaneous6">Miscellaneous 6</label>
                        <asp:TextBox ID="Miscellaneous6" TextMode="MultiLine" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-2">
                        <label for="MiscellaneousPrice6">Price 6</label>
                        <asp:TextBox ID="MiscellaneousPrice6" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <asp:Button OnClick="AddWorkOrder" Text="Add Work Order" CssClass="form-control" runat="server" />
            </div>

            <div id="UpdateVehicle" class="tab-pane fade">
                <h3>Update Vehicle</h3>
                <div class="form-horizontal">

                    <div class="row">
                        <div class="col-sm-6">
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
        <asp:PlaceHolder ID="plhReview" runat="server" />
    </asp:Panel>

    <asp:Label ID="lblResult" runat="server" />
    <asp:HiddenField ID="hdnCustomerID" runat="server" />
    <asp:HiddenField ID="hdnVehicleID" runat="server" />
    <asp:HiddenField ID="hdnOrderNumber" runat="server" />

    <script type="text/javascript">

        function toggleDivs(divId) {

            $("#div" + divId).toggle();

            $("#" + divId + "link").toggle();
        }

        $("#MainContent_txtVIN").keyup(function () {
            if ($(this).val().length != 17) {
                $("#divVINCount").html($(this).val().length + " digits. 17 digits expected.");
            }
            else {
                $("#divVINCount").html($(this).val().length + " digits.");
            }

        });

    </script>

</asp:Content>
