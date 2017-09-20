<%@ Page Title="Photo Upload" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>

<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.IO.Path" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    Sub Page_Load(Sender As Object, E As EventArgs)

        If Session("Name") = "" Then
            GetMemberInfo()
        End If

        If Not IsPostBack Then

            If Session("Role") = "MervinUser" or Session("Role") = "MervinAdmin"  Then


            Else

                Response.Redirect("../Default")

            End If

        End If

        lblType.Text = Request.QueryString("PhotoType") & " ID: " & Request.QueryString("TypeID") & "<br>"

        Dim intMachineID As Integer

        If Request.QueryString("PhotoType") = "Machine" Then

            intMachineID = Request.QueryString("typeID")
            hlkMachine.Text = "Back to machine"

        ElseIf Request.QueryString("PhotoType") = "Repair" Then

            intMachineID = GetMachineID(Request.QueryString("TypeID"))
            hlkMachine.Text = "Back to machine"

        ElseIf Request.QueryString("PhotoType") = "Part" Then

            hlkMachine.Visible = "False"

        End If

        hlkMachine.NavigateUrl = "machine.aspx?MachineID=" & intMachineID

    End Sub

    Sub GetMemberInfo()

        Dim conDefaultDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader
        Dim strQuery As String
        Dim dtNow As Date

        dtNow = Date.Now()

        strQuery = "select * from AspNetUsers where Email = @Email"

        conDefaultDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conDefaultDb.Open()

        cmdSelect = New SqlCommand(strQuery, conDefaultDb)
        cmdSelect.Parameters.AddWithValue("@Email", User.Identity.Name)

        dtrReader = cmdSelect.ExecuteReader()

        While dtrReader.Read()

            Session("Name") = dtrReader("FirstName") & " " & dtrReader("LastName")
            Session("Role") = dtrReader("UserRole")

        End While

        conDefaultDb.Close()

    End Sub

    Function GetMachineID(intStatusID As Integer)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand

        Dim intMachineID As Integer

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SQLCommand("Select top 1 MachineID from departmentmachinestatuslistview where statusid = @StatusID", conPeninsulaRVDb)
        cmdSelect.Parameters.Add("@StatusID",  intStatusID)

        intMachineID = cmdSelect.ExecuteScalar()

        conPeninsulaRVDb.Close()

        Return intMachineID

    End Function

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click

        Dim intCount As Integer = 1
        Dim strFilePath As String

        While File.Exists(Server.MapPath("images/" & Request.QueryString("PhotoType") & "-" & Request.QueryString("TypeID") & "-" & intCount & "Thumb.jpg"))

            intCount += 1

        End While

        strFilePath = "images/" & Request.QueryString("PhotoType") & "-" & Request.QueryString("TypeID") & "-" & intCount

        ' First we check to see if the user has selected a file
        If FileUpload1.HasFile Then

            ' Create a bitmap of the content of the fileUpload control in memory
            Dim originalBMP As New Bitmap(FileUpload1.FileContent)

            ' Calculate the new image dimensions
            Dim intOldHeight, intOldWidth, intNewHeight, intNewWidth As Integer

            intOldHeight = originalBMP.Height
            intOldWidth = originalBMP.Width

            intNewHeight = 200
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

            If originalBMP.Height > 2160 Then

                intNewHeight2 = 2160

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




            newBMP.Save(Server.MapPath(strFilePath & "thumb.jpg"))
            newBMP2.Save(Server.MapPath(strFilePath & "full.jpg"))

            lblFull.Text = "Original width: " & intOldWidth & "<br>"
            lblFull.Text &= "Original height: " & intOldHeight & "<br>"
            lblFull.Text &= "Full width: " & intNewWidth2 & "<br>"
            lblFull.Text &= "Full height: " & intNewHeight2 & "<br><br>"

            ' Once finished with the bitmap objects, we deallocate them.
            originalBMP.Dispose()
            newBMP.Dispose()
            newBMP2.Dispose()
            oGraphics.Dispose()
            oGraphics2.Dispose()


            image1.Visible = True
            image1.ImageUrl = strFilePath & "thumb.jpg"
            image2.Visible = True
            image2.ImageUrl = strFilePath & "full.jpg"
        Else
            Label.Text = "No file uploaded!"
        End If

        pnlResults.Visible = "True"
        pnlSelect.Visible = "False"



    End Sub

    Sub UploadReset(Sender As Object, E As EventArgs)

        Response.Redirect("upload.aspx?phototype=" & Request.QueryString("PhotoType") & "&TypeID=" & Request.QueryString("TypeID"))

    End Sub

    Sub LogOut(Sender As Object, E As CommandEventArgs)

        Session.Clear()
        Response.Redirect("Login.aspx")


    End Sub


</script>
    
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:Panel ID="pnlSelect" runat="server">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label id="lblType" runat="server"/>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <asp:FileUpload id="FileUpload1" accept="image/*" type="file" runat="server" /><br />
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <asp:Button ID="btnUpload" class="btn btn-default" Text="Upload" runat="server" />
            </div>
        </div>
            
    </asp:Panel>

    <asp:Panel ID="pnlResults" Visible="false" runat="server">
        <div class="row">
            <div class="col-sm-12">
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <asp:Image ID="image1" runat="server" /><br>
                <asp:Label id="lblThumb" runat="server"/>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <asp:Image ID="image2" runat="server" /><br>
                <asp:Label id="lblFull" runat="server"/>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <asp:LinkButton ID="LinkButton1" Text="Upload another image" Onclick="UploadReset" runat="server" /><br>
                <asp:Label ID="Label" runat="server" />
            </div>
        </div>
    </asp:Panel>

    <br><asp:HyperLink id="hlkMachine" Runat="server"/> 
                
    <asp:LinkButton OnCommand="LogOut" Runat="server">Log Out</asp:LinkButton>   
    <br><br>
</asp:Content>