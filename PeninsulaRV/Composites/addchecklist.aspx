<%@ Page Title="Add Checklist Item" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
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

            If Session("Role") = "MervinUser" Or Session("Role") = "MervinAdmin" Then


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

    Sub AddListItem(Sender As Object, E As EventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdInsert As SqlCommand
        Dim strQuery As String
        Dim dtNow As Date

        dtNow = DateTime.Now()

        strQuery = "Insert into ListItem(ShortTitle, Frequency, Description, StartDate) values(@ShortTitle, @Frequency, @Description, @StartDate)"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdInsert = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdInsert.Parameters.Add("@ShortTitle",  txtShortTitle.Text)
        cmdInsert.Parameters.Add("@Frequency",  rblFrequency.SelectedItem.Text)
        cmdInsert.Parameters.Add("@Description",  txtDescription.Text)
        cmdInsert.Parameters.Add("@StartDate",  dtNow)

        cmdInsert.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        pnlListItemForm.Visible="False"
        pnlSuccess.Visible="True"

        lblSuccess.Text = txtShortTitle.Text & " added successfully.<br>"

    End Sub

    Sub Reload(Sender As Object, E As EventArgs)

        Response.Redirect("addchecklist.aspx")

    End Sub

    Sub LogOut(Sender As Object, E As CommandEventArgs)

        Session.Clear()
        Response.Redirect("Login.aspx")


    End Sub


</script>
    
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
                
    <h3>Add Checklist Item</h3>
    
    <asp:Panel id="pnlListItemForm" runat="server">
        
        <div class="row">
            
            <div class="col-sm-12">
                
                <label for="txtSupplierName">Short Title:</label>
                <asp:TextBox id="txtShortTitle" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtShortTitle" ErrorMessage="<font class='text-danger'>*Short title required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                <label for="rblFrequency">Repeat Every:</label>
                <asp:RadioButtonList id="rblFrequency" runat="server">
                    <asp:ListItem>Shift</asp:ListItem>
                    <asp:ListItem>Day</asp:ListItem>
                    <asp:ListItem>Week</asp:ListItem>
                    <asp:ListItem>Month</asp:ListItem>
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ControlToValidate="rblFrequency" ErrorMessage="<font class='text-danger'>*Frequency Required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                
                <label for="txtDescription">Description:</label>
                <asp:TextBox id="txtDescription" TextMode="Multiline" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtDescription" ErrorMessage="<font class='text-danger'>*Description Required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>                            
                
                <asp:Button OnClick="AddListItem" Text="Add Checklist Item"  Class="btn btn-default" Runat="server"/>
            
            </div>
        
        </div>
    
    </asp:Panel>
    
    <asp:Panel id="pnlSuccess" Visible="False" runat="Server">
        
        <div class="row">
            
            <div class="col-sm-12">
                
                <asp:Label id="lblSuccess" Runat="server"/><br>
                
                <asp:Button OnClick="Reload" Text="Add Another Checklist Item" Class="btn btn-default" Runat="server"/>
            
            </div>
        
        </div>
    
    </asp:Panel>
    
    <br><br>
            
</asp:Content>
    