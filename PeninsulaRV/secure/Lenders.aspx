<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lenders.aspx.cs" Inherits="PeninsulaRV.secure.Lenders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .card {
            padding: 10px 0px 10px 0px;
            margin-bottom: 15px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

        .cardTitle {
            background-color: #21769e;
            color: white;
            width: 100%;
            padding: 1px 5px 5px 5px;
        }

        .cardBody {
            padding: 10px 0px 10px 30px;
        }
    </style>
    <h1 class="text-center">Lenders</h1>
    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#LenderList">Lender List</a></li>
        <li><a data-toggle="tab" href="#AddLender">Add Lender</a></li>
    </ul>

    <div class="tab-content">
        <div id="LenderList" class="tab-pane fade in active">
            <asp:Repeater ID="rptLenderList" runat="server">
                <HeaderTemplate>
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="card">
                        <div class="cardTitle">
                            <h3 class="text-center"><%# Eval("Name") %></h3>
                        </div>
                        <div class="cardBody">

                            <strong>Address: </strong>
                            <br />
                            <%# Eval("Address") %><br />
                            <%# Eval("City") %>,<%# Eval("State") %>
                            <%# Eval("Zip") %><br />
                            <strong>Phone: </strong><%# Eval("Phone") %><br />
                            <strong>Fax: </strong><%# Eval("Fax") %><br />
                            <strong><%# Eval("IDType") %></strong>: <%# Eval("IDNumber") %><br />
                            <strong>Notes: </strong><%# Eval("Notes") %>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <div id="AddLender" class="tab-pane fade">
            <h3>Add Lender</h3>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtName" CssClass="col-md-2 control-label">Name</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName"
                        CssClass="text-danger" ErrorMessage="The name field is required." Display="Dynamic" />
                </div>
            </div>
            <br />
            <br />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtAddress" CssClass="col-md-2 control-label">Address</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAddress"
                        CssClass="text-danger" ErrorMessage="The address field is required." Display="Dynamic" />
                </div>
            </div>
            <br />
            <br />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtCity" CssClass="col-md-2 control-label">City</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtCity" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity"
                        CssClass="text-danger" ErrorMessage="The city field is required." Display="Dynamic" />
                </div>
            </div>
            <br />
            <br />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtState" CssClass="col-md-2 control-label">State</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtState" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtState"
                        CssClass="text-danger" ErrorMessage="The state field is required." Display="Dynamic" />
                </div>
            </div>
            <br />
            <br />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtZip" CssClass="col-md-2 control-label">Zip</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtZip" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtZip"
                        CssClass="text-danger" ErrorMessage="The zip field is required." Display="Dynamic" />
                </div>
            </div>
            <br />
            <br />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="col-md-2 control-label">Phone</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" />
                </div>
            </div>
            <br />
            <br />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtFax" CssClass="col-md-2 control-label">Fax</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtFax" CssClass="form-control" />
                </div>
            </div>
            <br />
            <br />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="rblIDType" CssClass="col-md-2 control-label">ID Type</asp:Label>
                <div class="col-md-10">
                    <asp:RadioButtonList ID="rblIDType" runat="server">
                        <asp:ListItem>Tax ID Number</asp:ListItem>
                        <asp:ListItem>UBI</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblIDType"
                        CssClass="text-danger" ErrorMessage="The id type field is required." Display="Dynamic" />
                </div>
            </div>
            <br />
            <br />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtIDNumber" CssClass="col-md-2 control-label">ID Number</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtIDNumber" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtIDNumber"
                        CssClass="text-danger" ErrorMessage="The  field is required." Display="Dynamic" />
                </div>
            </div>
            <br />
            <br />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtNotes" TextMode="MultiLine" CssClass="form-control" />
                </div>
            </div>
            <br />
            <br />
            <asp:Button Text="Add Lender" OnClick="AddLender" CssClass="btn btn-default" runat="server" />
        </div>
    </div>
</asp:Content>
