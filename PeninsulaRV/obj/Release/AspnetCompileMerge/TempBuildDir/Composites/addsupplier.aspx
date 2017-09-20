<%@ Page Title="Add Supplier" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
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
    
    Sub AddSupplier(Sender As Object, E As EventArgs)
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdInsert As SqlCommand
        Dim strQuery As String        
        
        strQuery = "Insert into Supplier(Name, Address, Phone, Fax, Email, Website, ContactName, Notes) values(@Name, @Address, @Phone, @Fax, @Email, @Website, @ContactName, @Notes)"
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        cmdInsert = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdInsert.Parameters.Add("@Name",  txtSupplierName.Text)
        cmdInsert.Parameters.Add("@Address",  txtAddress.Text)
        cmdInsert.Parameters.Add("@Phone",  txtPhone.Text)
        cmdInsert.Parameters.Add("@Fax",  txtFax.Text)
        cmdInsert.Parameters.Add("@Email",  txtEmail.Text)
        cmdInsert.Parameters.Add("@Website",  txtWebsite.Text)
        cmdInsert.Parameters.Add("@ContactName",  txtContactName.Text)
        cmdInsert.Parameters.Add("@Notes",  txtNotes.Text)
        
        cmdInsert.ExecuteNonQuery()
        
        conPeninsulaRVDb.Close()
        
        pnlSupplierForm.Visible="False"
        pnlSuccess.Visible="True"
        
        lblSuccess.Text = txtSupplierName.Text & " added successfully.<br>"        
    
    End Sub
    
    Sub Reload(Sender As Object, E As EventArgs)    
    
        Response.Redirect("addSupplier.aspx")
    
    End Sub
    
    Sub LogOut(Sender As Object, E As CommandEventArgs)
    
        Session.Clear()
        Response.Redirect("Login.aspx")
        
    
    End Sub
    
    
</script>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Add Supplier</h3>
    <asp:Panel id="pnlSupplierForm" runat="server">
                    
        <div class="row">     
                        
            <div class="col-sm-12">
                        
                <label for="txtSupplierName">Name:</label>
                <asp:TextBox id="txtSupplierName" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtSupplierName" ErrorMessage="<font class='text-danger'>*Supplier name required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                            
                <label for="txtAddress">Address:</label>
                <asp:TextBox id="txtAddress" Class="form-control" runat="server"/><br>
                        
                <label for="txtPhone">Phone:</label>
                <asp:TextBox id="txtPhone" Class="form-control" runat="server"/><br>
                        
                <label for="txtFax">Fax:</label>
                <asp:TextBox id="txtFax" Class="form-control" runat="server"/><br>
                            
                <label for="txtEmail">Email:</label>
                <asp:TextBox id="txtEmail" Class="form-control" runat="server"/><br>
                            
                <label for="txtWebsite">Website: (include full address e.g. https://www...)</label>
                <asp:TextBox id="txtWebsite" Class="form-control" runat="server"/><br>
                            
                <label for="txtContactName">Contact Name:</label>
                <asp:TextBox id="txtContactName" Class="form-control" runat="server"/><br>
                            
                <label for="txtNotes">Notes:</label>
                <asp:TextBox id="txtNotes" TextMode="MultiLine" Class="form-control" runat="server"/><br>
                            
                <asp:Button OnClick="AddSupplier" Text="Add Supplier"  Class="btn btn-default" Runat="server"/>
                        
            </div>
                        
        </div>
                    
    </asp:Panel> 
                
    <asp:Panel id="pnlSuccess" Visible="False" runat="Server">
                    
        <div class="row">
                    
            <div class="col-sm-12">
                            
                <asp:Label id="lblSuccess" Runat="server"/><br>
                            
                <asp:Button OnClick="Reload" Text="Add Another Supplier" Class="btn btn-default" Runat="server"/>
                            
            </div>
                        
        </div>
                    
    </asp:Panel>
                
    <br><br>
    
</asp:Content>