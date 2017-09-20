<%@ Page Title="Add Machine" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
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
		
            FillMachineList()
            
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
    
    Sub FillMachineList()
    
    
        Dim conDefaultDb As SqlConnection
        Dim dtaSelect, dtaSelect2 As SqlDataAdapter
        Dim dtsSet1, dtsSet2 As New DataSet()
        Dim strRole, strQuery As String
        Dim intID As Integer
        
        conDefaultDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conDefaultDb.Open()
        
        strQuery = "Select * from Machine"
        
        dtaSelect = New SQLDataAdapter(strQuery, conDefaultDb)
        
        dtaSelect.Fill(dtsSet1)
                
        rptMachines.DataSource = dtsSet1
        
        rptMachines.DataBind()
        
        strQuery = "Select * from department"
        
        dtaSelect2 = New SQLDataAdapter(strQuery, conDefaultDb)
        
        dtaSelect2.Fill(dtsSet2)
                
        rblDepartmentList.DataSource = dtsSet2
        rblDepartmentList.DataTextField = "Name"
        rblDepartmentList.DataValueField = "DepartmentID"
        rblDepartmentList.DataBind()
                    
        conDefaultDb.Close()        
    
    End Sub
    
    Sub AddMachine(Sender As Object, E As EventArgs)
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdInsert As SqlCommand
        Dim strQuery As String
        
        strQuery = "Insert into Machine(Name, DepartmentRef, Description, Notes) values(@Name, @DepartmentRef, @Description, @Notes)"
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        cmdInsert = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdInsert.Parameters.Add("@Name",  txtMachineName.Text)
        cmdInsert.Parameters.Add("@DepartmentRef",  rblDepartmentList.SelectedItem.Value)
        cmdInsert.Parameters.Add("@Description",  txtDescription.Text)    
        cmdInsert.Parameters.Add("@Notes",  txtNotes.Text)    
        
        cmdInsert.ExecuteNonQuery()
        
        conPeninsulaRVDb.Close()
        
        pnlMachineForm.Visible="False"
        pnlSuccess.Visible="True"
        
        FillMachineList()
    
    End Sub
    
    Sub Reload(Sender As Object, E As EventArgs)    
    
        Response.Redirect("addMachine.aspx")
    
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
        <div class="col-sm-4">
            <asp:Panel id="pnlMachineForm" runat="server">
                <label for="txtMachineName">Name:</label>
                <asp:TextBox id="txtMachineName" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtMachineName" ErrorMessage="<font class='text-danger'>*Machine name required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                <label for="txtDescription">Description:</label>
                <asp:TextBox id="txtDescription" TextMode="MultiLine" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtDescription" ErrorMessage="<font class='text-danger'>*Machine description required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                <label for="txtNotes">Notes:</label>
                <asp:TextBox id="txtNotes" TextMode="Multiline" Class="form-control" runat="server"/><br>
                <asp:Button OnClick="AddMachine" Text="Add Machine"  Class="btn btn-default" Runat="server"/>
            </asp:Panel>
            <asp:Panel id="pnlSuccess" Visible="False" runat="Server">
                <asp:Label id="lblSuccess" Runat="server"/><br>
                <asp:Button OnClick="Reload" ValidationGroup="Reset" Text="Add Another Machine" Class="btn btn-default" Runat="server"/>
            </asp:Panel>
        </div>
        <div class="col-sm-2">
            Select Department
            <asp:RadioButtonList id="rblDepartmentList" Runat="server"/>
            <asp:RequiredFieldValidator ControlToValidate="rblDepartmentList" ErrorMessage="<font class='text-danger'>*Select department<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
        </div>
        <div class="col-sm-6">
            <asp:Repeater id="rptMachines" Runat="server">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th>Machine ID</th>
                            <th>Name</th>
                            <th>Department Ref</th>
                            <th>Description</th>
                            <th>Notes</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <%# Container.DataItem("MachineID")%></%#>
                        </td>
                        <td>
                            <%# Container.DataItem("Name")%></%#>
                        </td>
                        <td>
                            <%# Container.DataItem("DepartmentRef")%></%#>
                        </td>
                        <td>
                            <%# Container.DataItem("Description")%></%#>
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