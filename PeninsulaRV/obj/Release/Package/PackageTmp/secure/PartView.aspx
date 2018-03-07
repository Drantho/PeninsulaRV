<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PartView.aspx.cs" Inherits="PeninsulaRV.secure.PartView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><asp:Label ID="lblResult" runat="server" /></h1>
    <style>
        .img-responsive {
            display: inline-block;
            padding: 5px;
        }
    </style>
    <h3>
        <a href="javascript:toggleDivs('EditName');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
        <asp:Label ID="lblName" runat="server" /></h3>
    <div id="divEditName" style="display: none">
        <asp:TextBox ID="txtName" CssClass="form-control" runat="server" />
        <asp:LinkButton OnCommand="UpdatePart" Text="update part name" runat="server" />
    </div>

    <hr />
    <h4>Specifications</h4>
    <asp:Repeater ID="rptSpecs" runat="server">
        <HeaderTemplate>
        </HeaderTemplate>
        <ItemTemplate>
            <div class="row">
                <div class="col-sm-2">
                    <a href="javascript:toggleDivs('EditSpecKey<%# Container.ItemIndex %>');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                    <strong><%#Eval("Key") %>: </strong>
                    <div id='divEditSpecKey<%# Container.ItemIndex %>' style="display: none">
                        <asp:TextBox ID="txtKey" CssClass="form-control" Text='<%# Eval("Key") %>' runat="server" />
                        <asp:LinkButton Text="update part specification." OnCommand="UpdatePart" runat="server" />
                    </div>
                </div>
                <div class="col-sm-10">
                    <a href="javascript:toggleDivs('EditSpecValue<%# Container.ItemIndex %>');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                    <%#Eval("Value") %>
                    <div id='divEditSpecValue<%# Container.ItemIndex %>' style="display: none">
                        <asp:TextBox ID="txtValue" CssClass="form-control" Text='<%# Eval("Value") %>' runat="server" />
                        <asp:LinkButton Text="update part specification." OnCommand="UpdatePart" runat="server" />
                    </div>
                </div>
            </div>

        </ItemTemplate>
        <FooterTemplate>
        </FooterTemplate>
    </asp:Repeater>

    <asp:Repeater ID="rptNewSpecs" runat="server">
        <HeaderTemplate>
        </HeaderTemplate>
        <ItemTemplate>
            <div id='divAddSpec<%# Container.ItemIndex %>' style="display: none;">
                <div class="row">
                    <div class="col-sm-2">
                        <label for="txtKey">Name:</label>
                        <asp:TextBox ID="txtKey" Placeholder="e.g. Weight" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-sm-10">
                        <label for="txtValue">Value:</label>
                        <asp:TextBox ID="txtValue" Placeholder="e.g. 10 lbs." CssClass="form-control" runat="server" />
                    </div>
                </div>
            </div>
        </ItemTemplate>       
        <FooterTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <a href="javascript:toggleSpec();">add a custom specification</a>
                </div>
            </div>
            <div class="row" id="divSetSpec" style="display: none;">
                <div class="col-sm-12">
                    <asp:LinkButton Text="Set specifications." OnCommand="UpdatePart" runat="server" />
                </div>
            </div>
        </FooterTemplate>
    </asp:Repeater>

    <div class="row" style="padding-top: 10px;">
        <div class="col-sm-2">
            <a href="javascript:toggleDivs('EditStatus');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
            <strong>Status: </strong>
        </div>
        <div class="col-sm-10">
            <p>
                <asp:Label ID="lblStatus" runat="server" />
            </p>
        </div>
    </div>
    <div class="row" id="divEditStatus" style="display: none">
        <div class="col-sm-10 col-sm-offset-2">
            <asp:RadioButtonList ID="rblStatus" runat="server">
                <asp:ListItem>Active</asp:ListItem>
                <asp:ListItem>Inactive</asp:ListItem>
            </asp:RadioButtonList>
            <asp:LinkButton OnCommand="UpdatePart" Text="update part status." runat="server" />
        </div>
    </div>

    <div class="row" style="padding-top: 10px;">
        <div class="col-sm-2">
            <a href="javascript:toggleDivs('EditDescription');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
            <strong>Description: </strong>
        </div>
        <div class="col-sm-10">
            <p>
                <asp:Label ID="lblDescription" runat="server" />
            </p>
        </div>
    </div>
    <div class="row" id="divEditDescription" style="display: none">
        <div class="col-sm-10 col-sm-offset-2">
            <asp:TextBox ID="txtDescription" CssClass="form-control" TextMode="MultiLine" runat="server" />
            <asp:LinkButton OnCommand="UpdatePart" Text="update part description." runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-2">
            <a href="javascript:toggleDivs('EditPrice');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
            <strong>Price: </strong>
        </div>
        <div class="col-sm-10">
            <p>
                <asp:Label ID="lblPrice" runat="server" />
            </p>
        </div>
    </div>
    <div class="row" id="divEditPrice" style="display: none">
        <div class="col-sm-10 col-sm-offset-2">
            <asp:TextBox ID="txtPrice" CssClass="form-control" TextMode="Number" runat="server" />
            <asp:LinkButton OnCommand="UpdatePart" Text="update part price." runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-2">
            <a href="javascript:toggleDivs('EditQuantity');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
            <strong>Quantity: </strong>
        </div>
        <div class="col-sm-10">
            <p>
                <asp:Label ID="lblQuantity" runat="server" />
            </p>
        </div>
    </div>
    <div class="row" id="divEditQuantity" style="display: none">
        <div class="col-sm-10 col-sm-offset-2">
            <asp:TextBox ID="txtQuantity" CssClass="form-control" TextMode="Number" runat="server" />
            <asp:LinkButton OnCommand="UpdatePart" Text="update part quantity." runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-2">
            <a href="javascript:toggleDivs('EditCategory');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
            <strong>Category: </strong>
        </div>
        <div class="col-sm-10">
            <p>
                <asp:Label ID="lblCategory" runat="server" />
            </p>
        </div>
    </div>
    <div class="row" id="divEditCategory" style="display: none">
        <div class="col-sm-10 col-sm-offset-2">
            <asp:TextBox ID="txtCategory" CssClass="form-control" runat="server" />
            <asp:LinkButton OnCommand="UpdatePart" Text="update part category." runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-2">
            <a href="javascript:toggleDivs('EditLocation');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
            <strong>Location: </strong>
        </div>
        <div class="col-sm-10">
            <p>
                <asp:Label ID="lblLocation" runat="server" />
            </p>
        </div>
    </div>
    <div class="row" id="divEditLocation" style="display: none">
        <div class="col-sm-10 col-sm-offset-2">
            <asp:TextBox ID="txtLocation" CssClass="form-control" runat="server" />
            <asp:LinkButton OnCommand="UpdatePart" Text="update part location." runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-2">
            <a href="javascript:toggleDivs('EditKeywords');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
            <strong>Keywords: </strong>
        </div>
        <div class="col-sm-10">
            <p>
                <asp:Label ID="lblKeywords" runat="server" />
            </p>
        </div>
    </div>
    <div class="row" id="divEditKeywords" style="display: none">
        <div class="col-sm-10 col-sm-offset-2">
            <asp:TextBox ID="txtKeywords" CssClass="form-control" TextMode="MultiLine" runat="server" />
            <asp:LinkButton OnCommand="UpdatePart" Text="update part keywords." runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-2">
            <a href="javascript:toggleDivs('EditNotes');"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
            <strong>Notes: </strong>
        </div>
        <div class="col-sm-10">
            <p>
                <asp:Label ID="lblNotes" runat="server" />
            </p>
        </div>
    </div>
    <div class="row" id="divEditNotes" style="display: none">
        <div class="col-sm-10 col-sm-offset-2">
            <asp:TextBox ID="txtNotes" CssClass="form-control" TextMode="MultiLine" runat="server" />
            <asp:LinkButton OnCommand="UpdatePart" Text="update part notes." runat="server" />
        </div>
    </div>
    <hr />
    <h4>Photos</h4>
    <asp:PlaceHolder ID="plhPhotos" runat="server" />
    <hr />
    <h4>Add Photos</h4>
    <div>
        <asp:FileUpload ID="FileUpload1" runat="server" /><br />
        <asp:Button Text="Upload" CssClass="btn btn-default" OnClick="UploadImage" runat="server" /><br />
        <asp:Image ID="Image1" runat="server" /><br />
        <asp:Image ID="Image2" runat="server" />
    </div>
    <script type="text/javascript">
        var specCount = 1;

        function toggleDivs(divId) {

            $("#div" + divId).toggle();
        }

        function toggleSpec() {

            $("#divAddSpec" + specCount).toggle();
            $("#divSetSpec").show();
            specCount++;
        }

    </script>
</asp:Content>
