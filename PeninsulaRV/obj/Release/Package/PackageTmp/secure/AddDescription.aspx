<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddDescription.aspx.cs" Inherits="PeninsulaRV.secure.AddDescription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="text-center">Add Description</h1>
    <asp:Panel ID="pnlStocklist" runat="server">
        <asp:Repeater ID="rptStocklist" runat="server">
            <HeaderTemplate>
                <table>
                    <tr>
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
                        <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("ConsignmentID") %>' runat="server">
                            <%# Eval("ModelYear") %>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("ConsignmentID") %>' runat="server">
                            <%# Eval("Make") %>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("ConsignmentID") %>' runat="server">
                            <%# Eval("Model") %>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("ConsignmentID") %>' runat="server">
                            <%# Eval("VehicleType") %>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("ConsignmentID") %>' runat="server">
                            <%# Eval("LastName") %>, <%# Eval("FirstName") %>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("ConsignmentID") %>' runat="server">
                            <%# Eval("PhoneNumber") %>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton OnCommand="SelectCurrentConsignment" CommandArgument='<%# Eval("ConsignmentID") %>' runat="server">
                            <%# Eval("AltPhoneNumber") %>
                        </asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </asp:Panel>
    <asp:Panel ID="pnlEditDescription" Visible="false" runat="server">
        <div class="row">
            <div class="col-sm-6">
                <strong>Stock number: </strong><asp:Label ID="lblStocknumber" runat="server" /><br />
                <strong>Year: </strong><asp:Label ID="lblYear" runat="server" /><br />
                <strong>Make: </strong><asp:Label ID="lblMake" runat="server" /><br />
                <strong>Model: </strong><asp:Label ID="lblModel" runat="server" /><br />
                <strong>VIN: </strong><asp:Label ID="lblVIN" runat="server" /><br />
                <strong>Vehicle Type: </strong><asp:Label ID="lblType" runat="server" /><br />                

                <asp:Label for="txtDescription" runat="server">Description:</asp:Label><br />
                <asp:TextBox ID="txtDescription" TextMode="MultiLine" CssClass="form-control" runat="server" /><br /><br />
                <asp:Button OnClick="SaveDescription" CssClass="btn btn-default" Text="Add Description" runat="server" /><br /><br />
            </div>
        </div>

        <asp:PlaceHolder ID="plhPhotoList" runat="server" />
    </asp:Panel>
    <asp:HiddenField ID="hdnConsignmentID" runat="server" />
</asp:Content>
