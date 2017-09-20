<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalesLeads.aspx.cs" Inherits="PeninsulaRV.secure.SalesLeads" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        ul {
            list-style: none;
        }
    </style>
    <h1>
        <asp:Label ID="lblHeader" runat="server" />
    </h1>

    <asp:Panel ID="pnlAddReviewLeads" runat="server">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#home">Current Leads</a></li>
            <li><a data-toggle="tab" href="#menu1">Add New Lead</a></li>
        </ul>

        <div class="tab-content">
            <div id="home" class="tab-pane fade in active">
                <h3>Leads</h3>
                <asp:Repeater ID="rptLeads" runat="server">
                    <HeaderTemplate>
                        <div class="row">
                            <div class="col-sm-1">
                                <strong>
                                    Lead ID
                                </strong>
                            </div>
                            <div class="col-sm-1">
                                <strong>
                                    Date
                                </strong>
                            </div>
                            <div class="col-sm-2">
                                <strong>
                                    Status
                                </strong>
                            </div>
                            <div class="col-sm-1">
                                <strong>
                                    Customer
                                </strong>
                            </div>
                            <div class="col-sm-1">
                                <strong>
                                    Year(s)
                                </strong>
                            </div>
                            <div class="col-sm-1">
                                <strong>
                                    Make(s)
                                </strong>
                            </div>
                            <div class="col-sm-1">
                                <strong>
                                    Model(s)
                                </strong>
                            </div>
                            <div class="col-sm-1">
                                <strong>
                                    Vehicle Types(s)
                                </strong>
                            </div>
                            <div class="col-sm-1">
                                <strong>
                                    Min Price
                                </strong>
                            </div>
                            <div class="col-sm-1">
                                <strong>
                                    Max Price
                                </strong>
                            </div>
                        </div>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="row">
                            <div class="col-sm-1">
                                <asp:LinkButton OnCommand="btnGetResults" CommandArgument='<%# Eval("LeadID") %>' runat="server"><%# Eval("LeadID") %></asp:LinkButton>
                            </div>
                            <div class="col-sm-1">
                                <%# DataBinder.Eval(Container.DataItem, "LeadDate", "{0:MM/d/yyyy}") %>
                            </div>
                            <div class="col-sm-2">
                                <%# Eval("Status") %>
                            </div>
                            <div class="col-sm-1">
                                <%# Eval("LastName") %>, <%# Eval("FirstName") %><br />
                                <%# Eval("PhoneNumber") %><br />
                                <%# Eval("AltPhoneNumber") %>
                            </div>
                            <div class="col-sm-1">
                                <%# Eval("VehicleYears") %>
                            </div>
                            <div class="col-sm-1">
                                <%# Eval("VehicleMakes") %>
                            </div>
                            <div class="col-sm-1">
                                <%# Eval("VehicleModels") %>
                            </div>
                            <div class="col-sm-1">
                                <%# Eval("VehicleTypes") %>
                            </div>
                            <div class="col-sm-1">
                                <%# Eval("VehicleMinPrice", "{0:c}") %>
                            </div>
                            <div class="col-sm-1">
                                <%# Eval("VehicleMaxPrice", "{0:c}") %>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div id="menu1" class="tab-pane fade">

                <h3>Add New Lead</h3>

                <ul class="nav nav-pills">
                    <li class="active"><a data-toggle="pill" href="#AddCustomer">Add Customer</a></li>
                    <li><a data-toggle="pill" href="#SelectCustomer">SelectCustomer</a></li>
                </ul>

                <div class="tab-content">
                    <div id="AddCustomer" class="tab-pane fade in active">
                        <div class="form-horizontal">
                            <h3>Customer Info</h3>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="col-md-2 control-label">First Name</asp:Label>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control" />

                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtLastName" CssClass="col-md-2 control-label">Last Name</asp:Label>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtPhoneNumber" CssClass="col-md-2 control-label">Phone Number</asp:Label>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" ID="txtPhoneNumber" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtAltPhone" CssClass="col-md-2 control-label">Alt Phone Number</asp:Label>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" ID="txtAltPhone" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-md-2 control-label">Email</asp:Label>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="SelectCustomer" class="tab-pane fade">

                        <div style="height: 350px; width: 100%; overflow-y: scroll; overflow-x: hidden">
                            <asp:RadioButtonList ID="rblCustomerList" CssClass="mylist" RepeatColumns="4" RepeatDirection="Horizontal" runat="server" />
                        </div>
                        <br />
                    </div>
                </div>

                <h3>Vehicle Info</h3>
                <div class="form-horizontal">

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="cblVehicleTypes" CssClass="col-md-2 control-label">Select all interested types</asp:Label>
                        <div class="col-md-10">
                            <asp:CheckBoxList ID="cblVehicleTypes" runat="server">
                                <asp:ListItem>Class A Motorhome</asp:ListItem>
                                <asp:ListItem>Class B Motorhome</asp:ListItem>
                                <asp:ListItem>Class C Motorhome</asp:ListItem>
                                <asp:ListItem>Fifth Wheel Trailer</asp:ListItem>
                                <asp:ListItem>Travel Trailer</asp:ListItem>
                                <asp:ListItem>Truck Camper</asp:ListItem>
                                <asp:ListItem>Automobile</asp:ListItem>
                            </asp:CheckBoxList>
                            <asp:CustomValidator ID="CustomValidator1" ErrorMessage="Please select at least one vehicle type." CssClass="text-danger" ClientValidationFunction="ValidateCheckBoxList" runat="server" ValidationGroup="Lead" />

                        </div>
                    </div>

                    <div class="form-group">

                        <asp:Label runat="server" AssociatedControlID="ddlMinYear" CssClass="col-md-2 control-label">Minimum Year</asp:Label>
                        <div class="col-md-2">
                            <asp:DropDownList ID="ddlMinYear" runat="server">
                                <asp:ListItem Value="1970">1970</asp:ListItem>
                                <asp:ListItem Value="1971">1971</asp:ListItem>
                                <asp:ListItem Value="1972">1972</asp:ListItem>
                                <asp:ListItem Value="1973">1973</asp:ListItem>
                                <asp:ListItem Value="1974">1974</asp:ListItem>
                                <asp:ListItem Value="1975">1975</asp:ListItem>
                                <asp:ListItem Value="1976">1976</asp:ListItem>
                                <asp:ListItem Value="1977">1977</asp:ListItem>
                                <asp:ListItem Value="1978">1978</asp:ListItem>
                                <asp:ListItem Value="1979">1979</asp:ListItem>
                                <asp:ListItem Value="1980">1980</asp:ListItem>
                                <asp:ListItem Value="1981">1981</asp:ListItem>
                                <asp:ListItem Value="1982">1982</asp:ListItem>
                                <asp:ListItem Value="1983">1983</asp:ListItem>
                                <asp:ListItem Value="1984">1984</asp:ListItem>
                                <asp:ListItem Value="1985">1985</asp:ListItem>
                                <asp:ListItem Value="1986">1986</asp:ListItem>
                                <asp:ListItem Value="1987">1987</asp:ListItem>
                                <asp:ListItem Value="1988">1988</asp:ListItem>
                                <asp:ListItem Value="1989">1989</asp:ListItem>
                                <asp:ListItem Value="1990">1990</asp:ListItem>
                                <asp:ListItem Value="1991">1991</asp:ListItem>
                                <asp:ListItem Value="1992">1992</asp:ListItem>
                                <asp:ListItem Value="1993">1993</asp:ListItem>
                                <asp:ListItem Value="1994">1994</asp:ListItem>
                                <asp:ListItem Value="1995">1995</asp:ListItem>
                                <asp:ListItem Value="1996">1996</asp:ListItem>
                                <asp:ListItem Value="1997">1997</asp:ListItem>
                                <asp:ListItem Value="1998">1998</asp:ListItem>
                                <asp:ListItem Value="1999">1999</asp:ListItem>
                                <asp:ListItem Value="2000">2000</asp:ListItem>
                                <asp:ListItem Value="2001">2001</asp:ListItem>
                                <asp:ListItem Value="2002">2002</asp:ListItem>
                                <asp:ListItem Value="2003">2003</asp:ListItem>
                                <asp:ListItem Value="2004">2004</asp:ListItem>
                                <asp:ListItem Value="2005">2005</asp:ListItem>
                                <asp:ListItem Value="2006">2006</asp:ListItem>
                                <asp:ListItem Value="2007">2007</asp:ListItem>
                                <asp:ListItem Value="2008">2008</asp:ListItem>
                                <asp:ListItem Value="2009">2009</asp:ListItem>
                                <asp:ListItem Value="2010">2010</asp:ListItem>
                                <asp:ListItem Value="2011">2011</asp:ListItem>
                                <asp:ListItem Value="2012">2012</asp:ListItem>
                                <asp:ListItem Value="2013">2013</asp:ListItem>
                                <asp:ListItem Value="2014">2014</asp:ListItem>
                                <asp:ListItem Value="2015">2015</asp:ListItem>
                                <asp:ListItem Value="2016">2016</asp:ListItem>
                                <asp:ListItem Value="2017">2017</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlMaxYear" CssClass="col-md-2 control-label">Maximum Year</asp:Label>
                        <div class="col-md-2">
                            <asp:DropDownList ID="ddlMaxYear" runat="server">
                                <asp:ListItem Value="1970">1970</asp:ListItem>
                                <asp:ListItem Value="1971">1971</asp:ListItem>
                                <asp:ListItem Value="1972">1972</asp:ListItem>
                                <asp:ListItem Value="1973">1973</asp:ListItem>
                                <asp:ListItem Value="1974">1974</asp:ListItem>
                                <asp:ListItem Value="1975">1975</asp:ListItem>
                                <asp:ListItem Value="1976">1976</asp:ListItem>
                                <asp:ListItem Value="1977">1977</asp:ListItem>
                                <asp:ListItem Value="1978">1978</asp:ListItem>
                                <asp:ListItem Value="1979">1979</asp:ListItem>
                                <asp:ListItem Value="1980">1980</asp:ListItem>
                                <asp:ListItem Value="1981">1981</asp:ListItem>
                                <asp:ListItem Value="1982">1982</asp:ListItem>
                                <asp:ListItem Value="1983">1983</asp:ListItem>
                                <asp:ListItem Value="1984">1984</asp:ListItem>
                                <asp:ListItem Value="1985">1985</asp:ListItem>
                                <asp:ListItem Value="1986">1986</asp:ListItem>
                                <asp:ListItem Value="1987">1987</asp:ListItem>
                                <asp:ListItem Value="1988">1988</asp:ListItem>
                                <asp:ListItem Value="1989">1989</asp:ListItem>
                                <asp:ListItem Value="1990">1990</asp:ListItem>
                                <asp:ListItem Value="1991">1991</asp:ListItem>
                                <asp:ListItem Value="1992">1992</asp:ListItem>
                                <asp:ListItem Value="1993">1993</asp:ListItem>
                                <asp:ListItem Value="1994">1994</asp:ListItem>
                                <asp:ListItem Value="1995">1995</asp:ListItem>
                                <asp:ListItem Value="1996">1996</asp:ListItem>
                                <asp:ListItem Value="1997">1997</asp:ListItem>
                                <asp:ListItem Value="1998">1998</asp:ListItem>
                                <asp:ListItem Value="1999">1999</asp:ListItem>
                                <asp:ListItem Value="2000">2000</asp:ListItem>
                                <asp:ListItem Value="2001">2001</asp:ListItem>
                                <asp:ListItem Value="2002">2002</asp:ListItem>
                                <asp:ListItem Value="2003">2003</asp:ListItem>
                                <asp:ListItem Value="2004">2004</asp:ListItem>
                                <asp:ListItem Value="2005">2005</asp:ListItem>
                                <asp:ListItem Value="2006">2006</asp:ListItem>
                                <asp:ListItem Value="2007">2007</asp:ListItem>
                                <asp:ListItem Value="2008">2008</asp:ListItem>
                                <asp:ListItem Value="2009">2009</asp:ListItem>
                                <asp:ListItem Value="2010">2010</asp:ListItem>
                                <asp:ListItem Value="2011">2011</asp:ListItem>
                                <asp:ListItem Value="2012">2012</asp:ListItem>
                                <asp:ListItem Value="2013">2013</asp:ListItem>
                                <asp:ListItem Value="2014">2014</asp:ListItem>
                                <asp:ListItem Value="2015">2015</asp:ListItem>
                                <asp:ListItem Value="2016">2016</asp:ListItem>
                                <asp:ListItem Selected="True" Value="2017">2017</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtMakes" CssClass="col-md-2 control-label">Make(s)</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtMakes" PlaceHolder="Make 1, Make 2, Make 3... Leave blank if no preference." CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtModels" CssClass="col-md-2 control-label">Model(s)</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtModels" PlaceHolder="Model 1, Model 2, Model 3... Leave blank if no preference." CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtMinimumPrice" CssClass="col-md-2 control-label">Min Price</asp:Label>
                        <div class="col-md-4">
                            <asp:TextBox runat="server" ID="txtMinimumPrice" Text="0" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtMaxPrice" CssClass="col-md-2 control-label">Max Price</asp:Label>
                        <div class="col-md-4">
                            <asp:TextBox runat="server" ID="txtMaxPrice" PlaceHolder="Leave blank if no max. $10,000,000 will be entered." CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtNotes" TextMode="MultiLine" CssClass="form-control" />
                        </div>
                    </div>
                    <asp:Button OnClick="AddLead" Text="Add Lead" CssClass="btn btn-default" ValidationGroup="Lead" runat="server" />
                </div>
            </div>



        </div>
    </asp:Panel>

    <asp:Panel ID="pnlLeadResults" Visible="false" runat="server">
        <asp:Label ID="lblLeadInfo" runat="server" />
        <div class="row">
            <div class="col-sm-4">
                <strong>Lead ID: </strong><asp:Label ID="lblLeadID" runat="server" /><br />
                <strong>Date: </strong><asp:Label ID="lblDate" runat="server" /><br />
                <a href="javascript:toggleDiv('divLeadStatus');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a><strong>Status: </strong><asp:Label ID="lblStatus" runat="server" /><br />
                <div id="divLeadStatus" style="display: none;">
                    <asp:RadioButtonList ID="rblLeadStatus" runat="server">
                        <asp:ListItem>Cancelled by customer</asp:ListItem>
                        <asp:ListItem>Customer bought a vehicle</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:LinkButton OnCommand="UpdateStatus" runat="server">update status.</asp:LinkButton>
                </div>
                <strong>Customer: </strong><asp:Label ID="lblCustomerName" runat="server" /><br />
                <strong>Phone: </strong><asp:Label ID="lblPhone" runat="server" /><br />
                <strong>Email: </strong><asp:Label ID="lblEmail" runat="server" /><br />
            </div>
            <div class="col-sm-8">
                <strong>Vehicle Types: </strong><asp:Label ID="lblVehicleTypes" runat="server" /><br />
                <strong>Makes: </strong><asp:Label ID="lblMakes" runat="server" /><br />
                <strong>Models: </strong><asp:Label ID="lblModels" runat="server" /><br />
                <strong>Price Range: </strong><asp:Label ID="lblPriceRange" runat="server" /><br />
                <strong>Year Range: </strong><asp:Label ID="lblYearRange" runat="server" /><br />
                <strong>Notes: </strong><asp:Label ID="lblNotes" runat="server" />
            </div>
        </div>
        <div class="panel-group" id="accordion">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">5/5 Criteria Matched</a>
                    </h4>
                </div>
                <div id="collapse1" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <asp:PlaceHolder ID="plhResults1" runat="server" />
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">4/5 Criteria Matched</a>
                    </h4>
                </div>
                <div id="collapse2" class="panel-collapse collapse">
                    <div class="panel-body">
                        <asp:PlaceHolder ID="plhResults2" runat="server" />
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">3/5 Criteria Matched</a>
                    </h4>
                </div>
                <div id="collapse3" class="panel-collapse collapse">
                    <div class="panel-body">
                        <asp:PlaceHolder ID="plhResults3" runat="server" />
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse4">2/5 Criteria Matched</a>
                    </h4>
                </div>
                <div id="collapse4" class="panel-collapse collapse">
                    <div class="panel-body">
                        <asp:PlaceHolder ID="plhResults4" runat="server" />
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse5">1/5 Criteria Matched</a>
                    </h4>
                </div>
                <div id="collapse5" class="panel-collapse collapse">
                    <div class="panel-body">
                        <asp:PlaceHolder ID="plhResults5" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
    <script type="text/javascript">
        function ValidateCheckBoxList(sender, args) {
            var checkBoxList = document.getElementById("<%=cblVehicleTypes.ClientID %>");
            var checkboxes = checkBoxList.getElementsByTagName("input");
            var isValid = false;
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    isValid = true;
                    break;
                }
            }
            args.IsValid = isValid;
        }

        function toggleDiv(divId) {

            $("#" + divId).toggle();

        }
    </script>
</asp:Content>
