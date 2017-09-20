<%@ Page Title="Photo Upload" Debug="true" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" %>

<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.IO.Path" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="PeninsulaRV" %>

<script runat="server">

    Sub Page_Load(Sender As Object, E As EventArgs)

        Dim newConsignment As New Consignment

        rptVehicleList.DataSource = newConsignment.GetCurrentConsignments()

        rptVehicleList.DataBind()

        If Not IsPostBack Then

            If String.IsNullOrEmpty(Request.QueryString("StockNumber")) Then



            Else

                hdnStocknumber.Value = Request.QueryString("StockNumber")
                pnlSelectVehicle.Visible = False
                pnlSelectPhoto.Visible = True
                FillCurrentPhotos()

            End If

        End If

    End Sub

    Protected Sub SelectVehicle(Sender As Object, E As CommandEventArgs)

        pnlSelectVehicle.Visible = False
        pnlSelectPhoto.Visible = True

        hdnStocknumber.Value = E.CommandArgument

        FillCurrentPhotos()

    End Sub

    Sub FillCurrentPhotos()

        Dim intCount As Integer = 1

        While File.Exists(Server.MapPath("../images/inventory/" & hdnStocknumber.Value & "-thumb" & intCount & ".jpg"))

            plhCurrentPhotos.Controls.Add(New LiteralControl("<img src='../images/inventory/" & hdnStocknumber.Value & "-thumb" & intCount & ".jpg'>&nbsp;"))

            intCount += 1

        End While

    End Sub

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs)

        Dim intCount As Integer = 1

        While File.Exists(Server.MapPath("../images/inventory/" & hdnStocknumber.Value & "-thumb" & intCount & ".jpg"))

            intCount += 1

        End While

        ' First we check to see if the user has selected a file
        If FileUpload1.HasFile Then

            ' Create a bitmap of the content of the fileUpload control in memory
            Dim originalBMP As New Bitmap(FileUpload1.FileContent)

            ' Calculate the new image dimensions
            Dim intOldHeight, intOldWidth, intNewHeight, intNewWidth As Integer

            intOldHeight = originalBMP.Height
            intOldWidth = originalBMP.Width

            intNewHeight = 120
            intNewWidth = intOldWidth * intNewHeight / intOldHeight

            ' Create a new bitmap which will hold the previous resized bitmap
            Dim newBMP As New Bitmap(originalBMP, intNewWidth, intNewHeight)
            ' Create a graphic based on the new bitmap
            Dim oGraphics As Graphics = Graphics.FromImage(newBMP)

            ' Set the properties for the new graphic file
            oGraphics.SmoothingMode = Drawing2D.SmoothingMode.AntiAlias
            oGraphics.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
            ' Draw the new graphic based on the resized bitmap
            oGraphics.DrawImage(originalBMP, 0, 0, intNewWidth, intNewHeight)

            'Full Size Image
            Dim intNewHeight2, intNewWidth2 As Integer

            If originalBMP.Height > 711 Then

                intNewHeight2 = 711

            Else

                intNewHeight2 = originalBMP.Height

            End If

            intNewWidth2 = intOldWidth * intNewHeight2 / intOldHeight

            Dim newBMP2 As New Bitmap(originalBMP, intNewWidth2, intNewHeight2)
            ' Create a graphic based on the new bitmap
            Dim oGraphics2 As Graphics = Graphics.FromImage(newBMP2)

            ' Set the properties for the new graphic file
            oGraphics2.SmoothingMode = Drawing2D.SmoothingMode.AntiAlias
            oGraphics2.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
            ' Draw the new graphic based on the resized bitmap
            oGraphics2.DrawImage(originalBMP, 0, 0, intNewWidth2, intNewHeight2)

            ' Save the new graphic file to the server

            newBMP.Save(Server.MapPath("../images/inventory/" & hdnStocknumber.Value & "-thumb" & intCount & ".jpg"))
            newBMP2.Save(Server.MapPath("../images/inventory/" & hdnStocknumber.Value & "-full" & intCount & ".jpg"))

            ' Once finished with the bitmap objects, we deallocate them.
            originalBMP.Dispose()
            newBMP.Dispose()
            newBMP2.Dispose()
            oGraphics.Dispose()
            oGraphics2.Dispose()

        End If

        pnlResults.Visible = "True"
        pnlSelectPhoto.Visible = "False"

        lblResult.Text &= "Image uploaded as:<br> images/inventory/" & hdnStocknumber.Value & "-thumb" & intCount & ".jpg<br> images/inventory/" & hdnStocknumber.Value & "-full" & intCount & ".jpg<br>"
        lblResult.Text &= "<img src='../images/inventory/" & hdnStocknumber.Value & "-thumb" & intCount & ".jpg'><br>"
        lblResult.Text &= "<img src='../images/inventory/" & hdnStocknumber.Value & "-full" & intCount & ".jpg'><br>"

    End Sub

    Sub AddAnother(Sender As Object, E As EventArgs)

        Response.Redirect("upload.aspx?StockNumber=" & hdnStocknumber.Value)

    End Sub

    Sub Reset(Sender As Object, E As EventArgs)

        Response.Redirect("upload.aspx")

    End Sub

</script>
    
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Upload Photos</h1>
    <asp:Panel ID="pnlSelectVehicle" runat="server">
        <h3>Select Vehicle</h3>
        <asp:Repeater ID="rptVehicleList" runat="server">
            <HeaderTemplate>
                <div class="row">
                    <div class="col-xs-2">
                        <h4>Stock Number</h4>
                    </div>
                    <div class="col-xs-2">
                        <h4>Model Year</h4>
                    </div>
                    <div class="col-xs-2">
                        <h4>Make</h4>
                    </div>
                    <div class="col-xs-2">
                        <h4>Model</h4>
                    </div>
                    <div class="col-xs-2">
                        <h4>Vehicle Type</h4>
                    </div>
                </div>                
            </ItemTemplate>
            </HeaderTemplate>
            <ItemTemplate>
                <asp:LinkButton OnCommand="SelectVehicle" CommandArgument='<%# Container.DataItem("Stocknumber") %>' runat="server">
                    <div class="row">
                        <div class="col-xs-2">
                            <%# Container.DataItem("Stocknumber") %>
                        </div>
                        <div class="col-xs-2">
                            <%# Container.DataItem("ModelYear") %>
                        </div>
                        <div class="col-xs-2">
                            <%# Container.DataItem("Make") %>
                        </div>
                        <div class="col-xs-2">
                            <%# Container.DataItem("Model") %>
                        </div>
                        <div class="col-xs-2">
                            <%# Container.DataItem("VehicleType") %>
                        </div>
                    </div>  
                </asp:LinkButton>
            </ItemTemplate>
        </asp:Repeater>
            
    </asp:Panel>

    <asp:Panel ID="pnlSelectPhoto" Visible="false" runat="server">
        <h3>Select Photo</h3>
        <asp:FileUpload ID="FileUpload1" runat="server" /><br />
        <asp:Button OnClick="btnUpload_Click" Text="Upload Photo" CssClass="btn btn-default" runat="server" />
        <h3>Current Photos</h3>
        <asp:PlaceHolder ID="plhCurrentPhotos" runat="server" />
    </asp:Panel>

    <asp:Panel ID="pnlResults" Visible="false" runat="server">
        <h3>Result</h3>
        <asp:Label ID="lblResult" runat="server" /><br />
        <asp:LinkButton OnCOmmand="AddAnother" runat="server">Add another photo of this unit</asp:LinkButton><br /><br />
        <asp:LinkButton OnCOmmand="Reset" runat="server">Add a photo of another unit</asp:LinkButton><br />
    </asp:Panel>
    <asp:HiddenField ID="hdnStocknumber" runat="server" />
</asp:Content>