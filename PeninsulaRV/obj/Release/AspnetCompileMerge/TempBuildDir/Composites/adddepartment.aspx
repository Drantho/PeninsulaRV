<%@ Page Title="Add Department" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data" %>
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
		
            FillDepartmentList()
           
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
    
    Sub FillDepartmentList()
    
        Dim conDefaultDb As SqlConnection
        Dim dtaSelect As SqlDataAdapter
        Dim dtsSet1 As New DataSet()
        Dim strRole, strQuery As String
        Dim intID As Integer
        
        conDefaultDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conDefaultDb.Open()
        
        strQuery = "Select * from Department"
        
        dtaSelect = New SQLDataAdapter(strQuery, conDefaultDb)
        
        dtaSelect.Fill(dtsSet1)
                
        rptDepartments.DataSource = dtsSet1
        
        rptDepartments.DataBind()
                    
        conDefaultDb.Close()        
    
    
    End Sub
    
    Sub AddDepartment(Sender As Object, E As EventArgs)
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdInsert As SqlCommand
        Dim strQuery As String
        
        strQuery = "Insert into Department(Name, Head, Notes) values(@Name, @Head, @Notes)"
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        cmdInsert = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdInsert.Parameters.Add("@Name",  txtDepartmentName.Text)
        cmdInsert.Parameters.Add("@Head",  txtHead.Text)    
        cmdInsert.Parameters.Add("@Notes",  txtNotes.Text)    
        
        cmdInsert.ExecuteNonQuery()
        
        conPeninsulaRVDb.Close()
        
        pnlDepartmentForm.Visible="False"
        pnlSuccess.Visible="True"
        
        FillDepartmentList()
    
    End Sub
    
    Sub Reload(Sender As Object, E As EventArgs)    
    
        Response.Redirect("adddepartment.aspx")
    
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
    
        <div class="row">
            <div class="col-sm-12">
                <h4>Add Department</h4>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-4">
                <asp:Panel id="pnlDepartmentForm" runat="server">
                    <label for="txtDepartmentName">Name:</label>
                    <asp:TextBox id="txtDepartmentName" Class="form-control" runat="server"/>
                    <asp:RequiredFieldValidator ControlToValidate="txtDepartmentName" ErrorMessage="<font class='text-danger'>*Department name required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                    <label for="txtHead">Head:</label>
                    <asp:TextBox id="txtHead" Class="form-control" runat="server"/>
                    <asp:RequiredFieldValidator ControlToValidate="txtHead" ErrorMessage="<font class='text-danger'>*Department head required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                    <label for="txtNotes">Notes:</label>
                    <asp:TextBox id="txtNotes" TextMode="Multiline" Class="form-control" runat="server"/><br>
                    <asp:Button OnClick="AddDepartment" Text="Add Department"  Class="btn btn-default" Runat="server"/>
                </asp:Panel>
                <asp:Panel id="pnlSuccess" Visible="False" runat="Server">
                    <asp:Label id="lblSuccess" Runat="server"/><br>
                    <asp:Button OnClick="Reload" ValidationGroup="Reload" Text="Add Another Department" Class="btn btn-default" Runat="server"/>
                </asp:Panel>
            </div>
            <div class="col-sm-8">
                <asp:Repeater id="rptDepartments" Runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <th>Department ID</th>
                                <th>Name</th>
                                <th>Head</th>
                                <th>Notes</th>
                            </tr>
                    </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%# Container.DataItem("DepartmentID")%></%#>
                                </td>
                                <td>
                                    <%# Container.DataItem("Name")%></%#>
                                </td>
                                <td>
                                    <%# Container.DataItem("Head")%></%#>
                                </td>
                                <td>
                                    <%# Container.DataItem("Notes")%></%#>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
        <br><br>
    
</asp:Content>