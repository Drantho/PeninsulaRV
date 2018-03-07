<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PartsCenter.aspx.cs" Inherits="PeninsulaRV.secure.PartsCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        th {
            padding: 0px 25px 0px 0px;
        }
    </style>

    <asp:Panel ID="pnlMain" runat="server">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#availableParts">Available Parts</a></li>
            <li><a data-toggle="tab" href="#soldParts">Sold Parts</a></li>
            <li><a data-toggle="tab" href="#addParts">Add Parts</a></li>
        </ul>

        <div class="tab-content">
            <div id="availableParts" class="tab-pane fade in active">
                <h3>Available Parts</h3>
                <asp:Repeater ID="rptAvailableParts" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <th>Part ID
                                </th>
                                <th>Name
                                </th>
                                <th>Quantity
                                </th>
                                <th>Price
                                </th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# Eval("PartID") %>
                            </td>
                            <td>
                                <%# Eval("Name") %>
                            </td>
                            <td style="text-align: right">
                                <%# Eval("Quantity","{0:F0}")%>
                            </td>
                            <td style="text-align: right">
                                <%# Eval("Price") %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div id="soldParts" class="tab-pane fade">
                <h3>Sold Parts</h3>
                <asp:Repeater ID="rptSoldParts" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <th>Part ID
                                </th>
                                <th>Name
                                </th>
                                <th>Quantity
                                </th>
                                <th>Price
                                </th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# Eval("PartID") %>
                            </td>
                            <td>
                                <%# Eval("Name") %>
                            </td>
                            <td>
                                <%# Eval("Quantity") %>
                            </td>
                            <td>
                                <%# Eval("Price") %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div id="addParts" class="tab-pane fade">
                <h3>Add Parts</h3>
                <asp:Panel ID="pnlForm" runat="server">
                    <div class="form-group row">
                        <asp:Label runat="server" AssociatedControlID="txtName" CssClass="col-md-2 control-label">Name</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ControlToValidate="txtName"
                                CssClass="text-danger" ErrorMessage="The name field is required." />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label runat="server" AssociatedControlID="txtCategory" CssClass="col-md-2 control-label">Category</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="txtCategory" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ControlToValidate="txtCategory"
                                CssClass="text-danger" ErrorMessage="The category field is required." />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label runat="server" AssociatedControlID="txtDescription" CssClass="col-md-2 control-label">Description</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="txtDescription" TextMode="MultiLine" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecName1" CssClass="control-label">Spec Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecName1" CssClass="form-control" />
                            <a href="javascript:toggleDivs('2');" id="link2">Add Another Spec</a>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecValue1" CssClass="control-label">Spec Value</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecValue1" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="row" id="divSpec2" style="display: none;">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecName2" CssClass="control-label">Spec Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecName2" CssClass="form-control" />
                            <a href="javascript:toggleDivs('3');" id="link3">Add Another Spec</a>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecValue2" CssClass="control-label">Spec Value</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecValue2" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="row" id="divSpec3" style="display: none;">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecName3" CssClass="control-label">Spec Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecName3" CssClass="form-control" />
                            <a href="javascript:toggleDivs('4');" id="link4">Add Another Spec</a>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecValue3" CssClass="control-label">Spec Value</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecValue3" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="row" id="divSpec4" style="display: none;">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecName4" CssClass="control-label">Spec Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecName4" CssClass="form-control" />
                            <a href="javascript:toggleDivs('5');" id="link5">Add Another Spec</a>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecValue4" CssClass="control-label">Spec Value</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecValue4" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="row" id="divSpec5" style="display: none;">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecName5" CssClass="control-label">Spec Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecName5" CssClass="form-control" />
                            <a href="javascript:toggleDivs('6');" id="link6">Add Another Spec</a>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecValue5" CssClass="control-label">Spec Value</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecValue5" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="row" id="divSpec6" style="display: none;">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecName6" CssClass="control-label">Spec Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecName6" CssClass="form-control" />
                            <a href="javascript:toggleDivs('7');" id="link7">Add Another Spec</a>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecValue6" CssClass="control-label">Spec Value</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecValue6" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="row" id="divSpec7" style="display: none;">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecName7" CssClass="control-label">Spec Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecName7" CssClass="form-control" />
                            <a href="javascript:toggleDivs('8');" id="link8">Add Another Spec</a>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecValue7" CssClass="control-label">Spec Value</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecValue7" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="row" id="divSpec8" style="display: none;">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecName8" CssClass="control-label">Spec Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecName8" CssClass="form-control" />
                            <a href="javascript:toggleDivs('9');" id="link9">Add Another Spec</a>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecValue8" CssClass="control-label">Spec Value</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecValue8" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="row" id="divSpec9" style="display: none;">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecName9" CssClass="control-label">Spec Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecName9" CssClass="form-control" />
                            <a href="javascript:toggleDivs('10');" id="link10">Add Another Spec</a>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecValue9" CssClass="control-label">Spec Value</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecValue9" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="row" id="divSpec10" style="display: none;">
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecName10" CssClass="control-label">Spec Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecName10" CssClass="form-control" />
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label runat="server" AssociatedControlID="txtSpecValue10" CssClass="control-label">Spec Value</asp:Label>
                            <asp:TextBox runat="server" ID="txtSpecValue10" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label runat="server" AssociatedControlID="txtKeywords" CssClass="col-md-2 control-label">Key Words (separate by commas)</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="txtKeywords" TextMode="MultiLine" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label runat="server" AssociatedControlID="txtPrice" CssClass="col-md-2 control-label">Price</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="txtPrice" TextMode="Number" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="txtPrice"
                                CssClass="text-danger" ErrorMessage="The price field is required." />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label runat="server" AssociatedControlID="txtQuantity" CssClass="col-md-2 control-label">Quantity Available</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="txtQuantity" TextMode="Number" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ControlToValidate="txtQuantity"
                                CssClass="text-danger" ErrorMessage="The quantity field is required." />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label runat="server" AssociatedControlID="txtLocation" CssClass="col-md-2 control-label">Location</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="txtLocation" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ControlToValidate="txtLocation"
                                CssClass="text-danger" ErrorMessage="The location field is required." />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label runat="server" AssociatedControlID="txtNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="txtNotes" TextMode="MultiLine" CssClass="form-control" />
                        </div>
                    </div>

                    <asp:Button OnClick="AddPart" Text="Add Part" CssClass="btn btn-default" runat="server" />
                </asp:Panel>
            </div>

        </div>
    </asp:Panel>
    <asp:Panel ID="pnlSellPart" runat="server">

    </asp:Panel>
    <script>
        function toggleDivs(divId) {

            $("#divSpec" + divId).toggle();

            $("#link" + divId).toggle();
        }
    </script>

</asp:Content>
