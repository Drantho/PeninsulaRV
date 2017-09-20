<%@ Page Title="Supplier" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
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

        End If

        FillSupplierList()

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

    Sub FillSupplierList()

        Dim intSupplierID As Integer

        intSupplierID = -1

        If Request.QueryString("SupplierID") <> "" Then

            intSupplierID = Request.QueryString("SupplierID")

        End If

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SQLCommand("Select * from Supplier", conPeninsulaRVDb)

        dtrReader = cmdSelect.ExecuteReader()

        plhSupplierList.Controls.Add(New LiteralControl("<div class=""panel-group"" id=""accordion"">"))

        While dtrReader.Read()

            plhSupplierList.Controls.Add(New LiteralControl("<div class='panel panel-default'>"))
            plhSupplierList.Controls.Add(New LiteralControl("<div class='panel-heading'>"))
            plhSupplierList.Controls.Add(New LiteralControl("<h4 class='panel-title'>"))
            plhSupplierList.Controls.Add(New LiteralControl("<a data-toggle='collapse' data-parent='#accordion' href='#collapse" & dtrReader("SupplierID") & "'><div style='height: 100%; width: 100%'>" & dtrReader("Name") & "</div></a>"))
            plhSupplierList.Controls.Add(New LiteralControl("</h4>"))
            plhSupplierList.Controls.Add(New LiteralControl("</div>"))
            plhSupplierList.Controls.Add(New LiteralControl("<div id='collapse" & dtrReader("SupplierID") & "' class='panel-collapse collapse"))

            If intSupplierID = dtrReader("SupplierID") Then

                plhSupplierList.Controls.Add(New LiteralControl(" in"))

            End If

            plhSupplierList.Controls.Add(New LiteralControl("'>"))


            plhSupplierList.Controls.Add(New LiteralControl("<div class='panel-body'>"))


            plhSupplierList.Controls.Add(New LiteralControl("<ul class='nav nav-tabs'>"))
            plhSupplierList.Controls.Add(New LiteralControl("<li class='active'><a data-toggle='tab' href='#home" & dtrReader("SupplierID") & "'>Supplier Info</a></li>"))
            plhSupplierList.Controls.Add(New LiteralControl("<li><a data-toggle='tab' href='#menu1-"& dtrReader("SupplierID") & "'>Parts List</a></li>"))
            plhSupplierList.Controls.Add(New LiteralControl("</ul>"))

            plhSupplierList.Controls.Add(New LiteralControl("<div class='tab-content'>"))




            plhSupplierList.Controls.Add(New LiteralControl("<div id='home" & dtrReader("SupplierID") & "' class='tab-pane fade in active'>"))





            plhSupplierList.Controls.Add(New LiteralControl("<strong>Supplier ID:</strong> " & dtrReader("SupplierID") & "<br>"))

            plhSupplierList.Controls.Add(New LiteralControl("<strong>Address:</strong> " & dtrReader("Address") & ""))

            'Edit Address block
            plhSupplierList.Controls.Add(New LiteralControl(" <a href=""javascript:toggleDiv('divEditAddress" & dtrReader("SupplierID") & "');"">Edit address</a><br>"))
            plhSupplierList.Controls.Add(New LiteralControl("<div id='divEditAddress" & dtrReader("SupplierID") & "' style='display: none;'>"))
            Dim txtEditAddress As New TextBox()
            txtEditAddress.ID = "txtEditAddress" & dtrReader("SupplierID")
            txtEditAddress.TextMode = TextBoxMode.MultiLine
            txtEditAddress.CssClass="form-control"
            txtEditAddress.Text = dtrReader("Address")
            plhSupplierList.Controls.Add(txtEditAddress)
            Dim lbnEditAddress As New LinkButton()
            lbnEditAddress.Text = "Update address"
            lbnEditAddress.CommandArgument = dtrReader("SupplierID")
            AddHandler lbnEditAddress.Command, AddressOf EditAddress
            plhSupplierList.Controls.Add(lbnEditAddress)
            plhSupplierList.Controls.Add(New LiteralControl("</div>"))

            plhSupplierList.Controls.Add(New LiteralControl("<strong>Phone:</strong> " & dtrReader("Phone")))

            'Edit Phone block
            plhSupplierList.Controls.Add(New LiteralControl(" <a href=""javascript:toggleDiv('divEditPhone" & dtrReader("SupplierID") & "');"">Edit phone</a><br>"))
            plhSupplierList.Controls.Add(New LiteralControl("<div id='divEditPhone" & dtrReader("SupplierID") & "' style='display: none;'>"))
            Dim txtEditPhone As New TextBox()
            txtEditPhone.ID = "txtEditPhone" & dtrReader("SupplierID")
            txtEditPhone.CssClass="form-control"
            txtEditPhone.Text = dtrReader("Phone")
            plhSupplierList.Controls.Add(txtEditPhone)
            Dim lbnEditPhone As New LinkButton()
            lbnEditPhone.Text = "Update phone"
            lbnEditPhone.CommandArgument = dtrReader("SupplierID")
            AddHandler lbnEditPhone.Command, AddressOf EditPhone
            plhSupplierList.Controls.Add(lbnEditPhone)
            plhSupplierList.Controls.Add(New LiteralControl("</div>"))

            plhSupplierList.Controls.Add(New LiteralControl("<strong>Fax:</strong> " & dtrReader("Fax")))

            'Edit Fax block
            plhSupplierList.Controls.Add(New LiteralControl(" <a href=""javascript:toggleDiv('divEditFax" & dtrReader("SupplierID") & "');"">Edit fax</a><br>"))
            plhSupplierList.Controls.Add(New LiteralControl("<div id='divEditFax" & dtrReader("SupplierID") & "' style='display: none;'>"))
            Dim txtEditFax As New TextBox()
            txtEditFax.ID = "txtEditFax" & dtrReader("SupplierID")
            txtEditFax.CssClass="form-control"
            txtEditFax.Text = dtrReader("Fax")
            plhSupplierList.Controls.Add(txtEditFax)
            Dim lbnEditFax As New LinkButton()
            lbnEditFax.Text = "Update fax"
            lbnEditFax.CommandArgument = dtrReader("SupplierID")
            AddHandler lbnEditFax.Command, AddressOf EditFax
            plhSupplierList.Controls.Add(lbnEditFax)
            plhSupplierList.Controls.Add(New LiteralControl("</div>"))

            plhSupplierList.Controls.Add(New LiteralControl("<strong>Email:</strong> " & dtrReader("Email")))

            'Edit Email block
            plhSupplierList.Controls.Add(New LiteralControl(" <a href=""javascript:toggleDiv('divEditEmail" & dtrReader("SupplierID") & "');"">Edit email</a><br>"))
            plhSupplierList.Controls.Add(New LiteralControl("<div id='divEditEmail" & dtrReader("SupplierID") & "' style='display: none;'>"))
            Dim txtEditEmail As New TextBox()
            txtEditEmail.ID = "txtEditEmail" & dtrReader("SupplierID")
            txtEditEmail.CssClass="form-control"
            txtEditEmail.Text = dtrReader("Email")
            plhSupplierList.Controls.Add(txtEditEmail)
            Dim lbnEditEmail As New LinkButton()
            lbnEditEmail.Text = "Update email"
            lbnEditEmail.CommandArgument = dtrReader("SupplierID")
            AddHandler lbnEditEmail.Command, AddressOf EditEmail
            plhSupplierList.Controls.Add(lbnEditEmail)
            plhSupplierList.Controls.Add(New LiteralControl("</div>"))

            plhSupplierList.Controls.Add(New LiteralControl("<strong>Website:</strong> <a href='" & dtrReader("Website") & "' target='_Blank'>" & dtrReader("Website") & "</a>"))

            'Edit Website block
            plhSupplierList.Controls.Add(New LiteralControl(" <a href=""javascript:toggleDiv('divEditWebsite" & dtrReader("SupplierID") & "');"">Edit website</a><br>"))
            plhSupplierList.Controls.Add(New LiteralControl("<div id='divEditWebsite" & dtrReader("SupplierID") & "' style='display: none;'>"))
            Dim txtEditWebsite As New TextBox()
            txtEditWebsite.ID = "txtEditWebsite" & dtrReader("SupplierID")
            txtEditWebsite.CssClass="form-control"
            txtEditWebsite.Text = dtrReader("Website")
            plhSupplierList.Controls.Add(txtEditWebsite)
            Dim lbnEditWebsite As New LinkButton()
            lbnEditWebsite.Text = "Update website"
            lbnEditWebsite.CommandArgument = dtrReader("SupplierID")
            AddHandler lbnEditWebsite.Command, AddressOf EditWebsite
            plhSupplierList.Controls.Add(lbnEditWebsite)
            plhSupplierList.Controls.Add(New LiteralControl("</div>"))

            plhSupplierList.Controls.Add(New LiteralControl("<strong>Contact Name:</strong> " & dtrReader("ContactName")))

            'Edit ContactName block
            plhSupplierList.Controls.Add(New LiteralControl(" <a href=""javascript:toggleDiv('divEditContactName" & dtrReader("SupplierID") & "');"">Edit contact name</a><br>"))
            plhSupplierList.Controls.Add(New LiteralControl("<div id='divEditContactName" & dtrReader("SupplierID") & "' style='display: none;'>"))
            Dim txtEditContactName As New TextBox()
            txtEditContactName.ID = "txtEditContactName" & dtrReader("SupplierID")
            txtEditContactName.CssClass="form-control"
            txtEditContactName.Text = dtrReader("ContactName")
            plhSupplierList.Controls.Add(txtEditContactName)
            Dim lbnEditContactName As New LinkButton()
            lbnEditContactName.Text = "Update contact name"
            lbnEditContactName.CommandArgument = dtrReader("SupplierID")
            AddHandler lbnEditContactName.Command, AddressOf EditContactName
            plhSupplierList.Controls.Add(lbnEditContactName)
            plhSupplierList.Controls.Add(New LiteralControl("</div>"))

            plhSupplierList.Controls.Add(New LiteralControl("<strong>Notes:</strong> " & dtrReader("Notes")))

            'Edit Notes block
            plhSupplierList.Controls.Add(New LiteralControl(" <a href=""javascript:toggleDiv('divEditNotes" & dtrReader("SupplierID") & "');"">Edit notes</a><br>"))
            plhSupplierList.Controls.Add(New LiteralControl("<div id='divEditNotes" & dtrReader("SupplierID") & "' style='display: none;'>"))
            Dim txtEditNotes As New TextBox()
            txtEditNotes.ID = "txtEditNotes" & dtrReader("SupplierID")
            txtEditNotes.CssClass="form-control"
            txtEditNotes.Text = dtrReader("Notes")
            plhSupplierList.Controls.Add(txtEditNotes)
            Dim lbnEditNotes As New LinkButton()
            lbnEditNotes.Text = "Update notes"
            lbnEditNotes.CommandArgument = dtrReader("SupplierID")
            AddHandler lbnEditNotes.Command, AddressOf EditNotes
            plhSupplierList.Controls.Add(lbnEditNotes)
            plhSupplierList.Controls.Add(New LiteralControl("</div>"))










            plhSupplierList.Controls.Add(New LiteralControl("</div>"))
            plhSupplierList.Controls.Add(New LiteralControl("<div id='menu1-" & dtrReader("SupplierID") & "' class='tab-pane fade'>"))






            Dim plhPartsList As New PlaceHolder()

            plhPartsList.ID = "plhPartsList" & dtrReader("SupplierID")
            plhSupplierList.Controls.Add(plhPartsList)
            plhSupplierList.Controls.Add(New LiteralControl("<br><a href='linkpart.aspx?LinkType=Supplier&LinkID=" & dtrReader("SupplierID") & "'>Link parts to this supplier</a>"))
















            plhSupplierList.Controls.Add(New LiteralControl("</div>"))


            plhSupplierList.Controls.Add(New LiteralControl("</div>"))







            plhSupplierList.Controls.Add(New LiteralControl("</div>"))
            plhSupplierList.Controls.Add(New LiteralControl("</div>"))
            plhSupplierList.Controls.Add(New LiteralControl("</div>"))


        End While

        plhSupplierList.Controls.Add(New LiteralControl("</div>"))

        dtrReader.Close()

        conPeninsulaRVDb.Close()

        FillSupplierPartsList()

    End Sub

    Sub FillSupplierPartsList()

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SQLCommand("Select * from SupplierPartShelfView", conPeninsulaRVDb)

        dtrReader = cmdSelect.ExecuteReader()

        Dim strOldSupplierID, strNewSupplierID As String

        Dim plhPartsList As New PlaceHolder()

        While dtrReader.Read()

            strNewSupplierID = dtrReader("SupplierID")

            If strNewSupplierID <> strOldSupplierID Then

                plhPartsList = plhSupplierList.FindControl("plhPartsList" & dtrReader("SupplierID"))

            End If

            plhPartsList.Controls.Add(New LiteralControl("<br>" & dtrReader("PartID") & " " & dtrReader("PartName") & " " & dtrReader("Description")))

            strOldSupplierID = strNewSupplierID

        End While

    End Sub

    Sub EditAddress(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditaddress As New TextBox()

        txtEditaddress = plhSupplierList.FindControl("txtEditaddress" & E.CommandArgument)

        strQuery = "Update supplier set Address = @Address where SupplierID = @SupplierID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Address",  txtEditaddress.Text)
        cmdUpdate.Parameters.Add("@SupplierID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("Supplier.aspx?SupplierID=" & E.CommandArgument)

    End Sub

    Sub EditPhone(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditPhone As New TextBox()

        txtEditPhone = plhSupplierList.FindControl("txtEditPhone" & E.CommandArgument)

        strQuery = "Update supplier set Phone = @Phone where SupplierID = @SupplierID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Phone",  txtEditPhone.Text)
        cmdUpdate.Parameters.Add("@SupplierID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("Supplier.aspx?SupplierID=" & E.CommandArgument)

    End Sub

    Sub EditFax(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditFax As New TextBox()

        txtEditFax = plhSupplierList.FindControl("txtEditFax" & E.CommandArgument)

        strQuery = "Update supplier set Fax = @Fax where SupplierID = @SupplierID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Fax",  txtEditFax.Text)
        cmdUpdate.Parameters.Add("@SupplierID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("Supplier.aspx?SupplierID=" & E.CommandArgument)

    End Sub

    Sub EditEmail(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditEmail As New TextBox()

        txtEditEmail = plhSupplierList.FindControl("txtEditEmail" & E.CommandArgument)

        strQuery = "Update supplier set Email = @Email where SupplierID = @SupplierID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Email",  txtEditEmail.Text)
        cmdUpdate.Parameters.Add("@SupplierID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("Supplier.aspx?SupplierID=" & E.CommandArgument)

    End Sub

    Sub EditWebsite(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditWebsite As New TextBox()

        txtEditWebsite = plhSupplierList.FindControl("txtEditWebsite" & E.CommandArgument)

        strQuery = "Update supplier set Website = @Website where SupplierID = @SupplierID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Website",  txtEditWebsite.Text)
        cmdUpdate.Parameters.Add("@SupplierID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("Supplier.aspx?SupplierID=" & E.CommandArgument)

    End Sub

    Sub EditContactName(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditContactName As New TextBox()

        txtEditContactName = plhSupplierList.FindControl("txtEditContactName" & E.CommandArgument)

        strQuery = "Update supplier set ContactName = @ContactName where SupplierID = @SupplierID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@ContactName",  txtEditContactName.Text)
        cmdUpdate.Parameters.Add("@SupplierID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("Supplier.aspx?SupplierID=" & E.CommandArgument)

    End Sub

    Sub EditNotes(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditNotes As New TextBox()

        txtEditNotes = plhSupplierList.FindControl("txtEditNotes" & E.CommandArgument)

        strQuery = "Update supplier set Notes = @Notes where SupplierID = @SupplierID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Notes",  txtEditNotes.Text)
        cmdUpdate.Parameters.Add("@SupplierID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("Supplier.aspx?SupplierID=" & E.CommandArgument)

    End Sub





    Sub Reload(Sender As Object, E As EventArgs)

        Response.Redirect("Supplier.aspx")

    End Sub

    Sub LogOut(Sender As Object, E As CommandEventArgs)

        Session.Clear()
        Response.Redirect("Login.aspx")

    End Sub


</script>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <h3>Suppliers</h3>
    
    <asp:Panel id="pnlSupplierList" runat="server">
                
        <asp:PlaceHolder ID="plhSupplierList" Runat="server"/>
                
    </asp:Panel>
                
    <asp:Panel id="pnlSuccess" Visible="False" runat="Server">
                    
        <div class="row">
                        
            <div class="col-sm-12">
                            
                <asp:Label id="lblSuccess" Runat="server"/><br>
                            
            </div>
                        
        </div>
                    
    </asp:Panel>
                
    <asp:HiddenField id="hdnSupplierID" runat="server"/>
                
    <br><br>
    
</asp:Content>