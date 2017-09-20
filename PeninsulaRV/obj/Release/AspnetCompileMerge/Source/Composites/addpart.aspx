<%@ Page Title="Add Part" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Collections" %>
<%@ import Namespace="System.Configuration" %>
        
<script runat="server">

    Sub Page_Load()

        If Session("Name") = "" Then
            GetMemberInfo()
        End If

        If Not IsPostBack Then

            If Session("Role") = "MervinUser" or Session("Role") = "MervinAdmin"  Then


            Else

                Response.Redirect("../Default")

            End If

            FillShelf()

        End If

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

    Sub FillShelf()

        Dim conDefaultDb As SqlConnection
        Dim dtaSelect As SqlDataAdapter
        Dim dtsSet1 As New DataSet()
        Dim strRole, strQuery As String
        Dim intID As Integer

        conDefaultDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conDefaultDb.Open()

        strQuery = "Select ShelfID, Name + ' - ' + Location As Info from Shelf"

        dtaSelect = New SQLDataAdapter(strQuery, conDefaultDb)

        dtaSelect.Fill(dtsSet1)

        rblShelf.DataSource = dtsSet1
        rblShelf.DataValueField = "ShelfID"
        rblShelf.DataTextField = "Info"
        rblShelf.Databind()

        conDefaultDb.Close()

    End Sub

    Sub AddPart(Sender As Object, E As EventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdInsert As SqlCommand
        Dim strQuery As String

        Dim intShelfRef As Integer

        Try
            intShelfRef = rblShelf.SelectedItem.Value
        Catch
            intShelfRef = -1
        End Try

        strQuery = "Insert into MervinPart(Name, PartNumber, Description, ShelfRef) values(@Name, @PartNumber, @Description, @ShelfRef)"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdInsert = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdInsert.Parameters.Add("@Name",  txtPartName.Text)
        cmdInsert.Parameters.Add("@PartNumber",  txtPartNumber.Text)
        cmdInsert.Parameters.Add("@Description",  txtDescription.Text)
        cmdInsert.Parameters.Add("@ShelfRef",  intShelfRef)

        cmdInsert.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        pnlPartForm.Visible="False"
        pnlSuccess.Visible="True"

        lblSuccess.Text = txtPartName.Text & " - " & txtPartNumber.Text & " - " & txtDescription.Text & " added successfully.<br>"

    End Sub

    Sub Reload(Sender As Object, E As EventArgs)

        Response.Redirect("addpart.aspx")

    End Sub

    Sub LogOut(Sender As Object, E As CommandEventArgs)

        FormsAuthentication.SignOut()
        Session.Abandon()

        Dim cookie1 As HttpCookie = New HttpCookie(FormsAuthentication.FormsCookieName, "")
        cookie1.Expires = DateTime.Now.AddYears(-1)
        Response.Cookies.Add(cookie1)

        Dim cookie2 As HttpCookie = New HttpCookie("ASP.NET_SessionId", "")
        cookie2.Expires = DateTime.Now.AddYears(-1)
        Response.Cookies.Add(cookie2)

        FormsAuthentication.RedirectToLoginPage()

    End Sub


</script>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Add Part</h3>
    <asp:Panel id="pnlPartForm" runat="server">
        <div class="row">
            <div class="col-sm-4">
                <label for="txtPartName">Name:</label>
                <asp:TextBox id="txtPartName" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtPartName" ErrorMessage="<font class='text-danger'>*Part name required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                <label for="txtPartNumber">Part Number:</label>
                <asp:TextBox id="txtPartNumber" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtPartNumber" ErrorMessage="<font class='text-danger'>*Part number required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                <label for="txtDescription">Description:</label>
                <asp:TextBox id="txtDescription" TextMode="MultiLine" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtDescription" ErrorMessage="<font class='text-danger'>*Part description required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                <asp:Button OnClick="AddPart" Text="Add Part"  Class="btn btn-default" Runat="server"/>
            </div>
            <div class="col-sm-4">
                Select Shelf (Optional, can be added later.)<br>
                <asp:RadioButtonList id="rblShelf" Runat="server"/>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel id="pnlSuccess" Visible="False" runat="Server">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label id="lblSuccess" Runat="server"/><br>
                <asp:Button OnClick="Reload" ValidationGroup="Reload" Text="Add Another Part" Class="btn btn-default" Runat="server"/>
            </div>
        </div>
    </asp:Panel>
    <br><br>
</asp:Content>