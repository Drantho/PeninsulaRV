<%@ Page Title="Add Shelf" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
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

    Sub AddShelf(Sender As Object, E As EventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdInsert As SqlCommand
        Dim strQuery As String

        strQuery = "Insert into Shelf(Name, Location) values(@Name, @Location)"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdInsert = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdInsert.Parameters.Add("@Name",  txtShelfName.Text)
        cmdInsert.Parameters.Add("@Location",  txtLocation.Text)

        cmdInsert.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        pnlShelfForm.Visible="False"
        pnlSuccess.Visible="True"

        lblSuccess.Text = txtShelfName.Text & " - " & txtLocation.Text & " added successfully.<br>"

    End Sub

    Sub Reload(Sender As Object, E As EventArgs)

        Response.Redirect("addShelf.aspx")

    End Sub

    Sub LogOut(Sender As Object, E As CommandEventArgs)

        Session.Clear()
        Response.Redirect("Login.aspx")


    End Sub


</script>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
                    
        <div class="col-sm-12">
                        
            <h3>Add Shelf</h3>
                       
        </div>
                    
    </div>
                
    <asp:Panel id="pnlShelfForm" runat="server">
                
        <div class="row">     
                        
            <div class="col-sm-12">
                        
                <label for="txtShelfName">Name:</label>
                <asp:TextBox id="txtShelfName" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtShelfName" ErrorMessage="<font class='text-danger'>*Shelf name required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                        
                <label for="txtLocation">Location:</label>
                <asp:TextBox id="txtLocation" TextMode="MultiLine" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtLocation" ErrorMessage="<font class='text-danger'>*location required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                            
                <asp:Button OnClick="AddShelf" Text="Add Shelf"  Class="btn btn-default" Runat="server"/>
                        
            </div>
                        
        </div>
                    
    </asp:Panel> 
                
    <asp:Panel id="pnlSuccess" Visible="False" runat="Server">
                    
        <div class="row">
                        
            <div class="col-sm-12">
                            
                <asp:Label id="lblSuccess" Runat="server"/><br>
                            
                <asp:Button OnClick="Reload" Text="Add Another Shelf" Class="btn btn-default" Runat="server"/>
                            
            </div>
                        
        </div>
                    
    </asp:Panel>
                
    <br><br>
</asp:Content>
    