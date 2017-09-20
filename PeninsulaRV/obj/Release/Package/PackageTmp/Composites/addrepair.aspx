<%@ Page Title="Add Repair" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
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

            If Session("Role") = "MervinUser" Or Session("Role") = "MervinAdmin" Then


            Else

                Response.Redirect("../Default")

            End If

            FillFixer()

            Dim dtNow As Date

            dtNow = Date.Now

            txtOnsetDate.Text = dtNow.ToString("M/d/yyyy")

        End If

        If Request.QueryString("MachineID") <> "" Then

            FillSelectMachine(Request.QueryString("MachineID"))

        End If

        FillIssueList()



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

    Sub FillFixer()

        Dim conDefaultDb As SqlConnection
        Dim dtaSelect As SqlDataAdapter
        Dim dtsSet1 As New DataSet()
        Dim strQuery As String

        conDefaultDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conDefaultDb.Open()

        strQuery = "Select Email, FirstName + ' ' + LastName As Name from AspNetUsers where UserRole like '%Mervin%'"

        dtaSelect = New SQLDataAdapter(strQuery, conDefaultDb)

        dtaSelect.Fill(dtsSet1)

        cblFixer.DataSource = dtsSet1
        cblFixer.DataTextField = "Name"
        cblFixer.DataValueField = "Email"
        cblFixer.DataBind()

        conDefaultDb.Close()

        Response.Write("HELLO???")

    End Sub

    Sub FillIssueList()

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SQLCommand("Select * from DepartmentMachineview order by departmentid, machineid", conPeninsulaRVDb)

        dtrReader = cmdSelect.ExecuteReader()

        Dim strOldDepartmentID, strNewDepartmentID As String
        Dim intCount As Integer

        intCount = 1

        plhDepartmentList.Controls.Add(New LiteralControl("<div class=""panel-group"" id=""accordion"">"))

        While dtrReader.Read()

            strNewDepartmentID = dtrReader("DepartmentID")

            If strNewDepartmentID <> strOldDepartmentID Then

                If intCount > 1 Then

                    plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
                    plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
                    plhDepartmentList.Controls.Add(New LiteralControl("</div>"))

                End If

                plhDepartmentList.Controls.Add(New LiteralControl("<div class='panel panel-default'>"))
                plhDepartmentList.Controls.Add(New LiteralControl("<div class='panel-heading'>"))
                plhDepartmentList.Controls.Add(New LiteralControl("<h4 class='panel-title'>"))
                plhDepartmentList.Controls.Add(New LiteralControl("<a data-toggle='collapse' data-parent='#accordion' href='#collapse" & intCount & "'>" & dtrReader("DepartmentName") & "</a>"))
                plhDepartmentList.Controls.Add(New LiteralControl("</h4>"))
                plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
                plhDepartmentList.Controls.Add(New LiteralControl("<div id='collapse" & intCount & "' class='panel-collapse collapse'>"))
                plhDepartmentList.Controls.Add(New LiteralControl("<div class='panel-body'>"))

            End If

            Dim lbnSelect As New LinkButton()
            lbnSelect.Text = dtrReader("MachineName")
            lbnSelect.CommandArgument = dtrReader("MachineID")

            plhDepartmentList.Controls.Add(lbnSelect)
            plhDepartmentList.Controls.Add(New LiteralControl("<br>"))

            AddHandler lbnSelect.Command, AddressOf SelectMachine

            strOldDepartmentID = strNewDepartmentID

            intCount += 1

        End While

        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))

        dtrReader.Close()

        conPeninsulaRVDb.Close()

    End Sub

    Sub AddStatus(Sender As Object, E As EventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdInsert As SqlCommand
        Dim strQuery, strNotes As String
        Dim intStatusID, intRepairID, intCount As Integer

        intCount = 1

        'strQuery = "Insert into MachineStatus(MachineRef, OnsetDate, RepairTime, DownTime, Notes) values(@MachineRef, @OnsetDate, @Notes, @RepairTime, @DownTime)"
        strQuery = "Insert into MachineStatus(MachineRef, OnsetDate, RepairTime, DownTime, Notes) values(@MachineRef, @OnsetDate, @RepairTime, @DownTime, @Notes) Select SCOPE_IDENTITY()"

        strNotes = txtNotes.Text

        For Each itm As ListItem in cblFixer.Items

            If itm.Selected = "True" Then

                If intCount = 1 Then

                    strNotes &= " Repair done by: "

                Else

                    strNotes &= ", "

                End If

                strNotes &= itm.Text

                intCount += 1

            End If

        Next

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdInsert = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdInsert.Parameters.Add("@MachineRef",  hdnMachineID.Value)
        cmdInsert.Parameters.Add("@OnsetDate",  txtOnsetDate.Text)
        cmdInsert.Parameters.Add("@RepairTime",  txtRepairTime.Text)
        cmdInsert.Parameters.Add("@DownTime",  txtDownTime.Text)
        cmdInsert.Parameters.Add("@Notes",  strNotes)

        intRepairID = cmdInsert.ExecuteScalar()

        conPeninsulaRVDb.Close()

        hlkMachineDetail.NavigateURL = "machine.aspx?MachineID=" & Request.QueryString("MachineID")

        pnlStatusForm.Visible="False"
        pnlSuccess.Visible="True"

        lblSuccess.Text = "Repair recorded.<br><a href='upload.aspx?PhotoType=Repair&TypeID=" & intRepairID & "'>Add photos of repair</a>"

    End Sub

    Sub SelectMachine(Sender As Object, E As CommandEventArgs)

        FillSelectMachine(E.CommandArgument)

    End Sub

    Sub FillSelectMachine(intID As Integer)

        hdnMachineID.Value = intID

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader
        Dim intMachineStatus As Integer
        Dim dtNow As DateTime

        dtNow = DateTime.Now()

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SqlCommand("Select * from DepartmentMachinestatusview where MachineID = " & intID.ToString(), conPeninsulaRVDb)

        dtrReader = cmdSelect.ExecuteReader()

        While dtrReader.Read()

            hdnStatusID.Value = dtrReader("StatusID")
            hdnMachineStatus.Value = dtrReader("MachineStatus")
            Try
                hdnStatusNotes.Value = dtrReader("StatusNotes")
            Catch
            End Try
        End While

        conPeninsulaRVDb.Close()

        pnlStatusForm.Visible="True"

        pnlMachineList.Visible = "False"

    End Sub

    Sub Reload(Sender As Object, E As CommandEventArgs)

        If E.CommandArgument Then
            Response.Redirect("addrepair.aspx?MachineID=" & Request.QueryString("MachineID"))
        Else
            Response.Redirect("addrepair.aspx")
        End If

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
    <h3>Add Repair</h3>
    <asp:Panel id="pnlMachineList" runat="server">
        <div class="row">
            <div class="col-sm-12">
                <aspPlaceHolder id="plhDepartmentList" runat="server"/>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel id="pnlStatusForm" Visible="False" runat="server">
        <div class="row">
            <div class="col-sm-6">
                <label for="txtOnsetDate">Onset Date:</label>
                <asp:TextBox id="txtOnsetDate" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtOnsetDate" ValidationGroup="Onset" ErrorMessage="<font class='text-danger'>*Onset date required. <br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                <asp:CompareValidator Operator="DataTypeCheck" Type="Date"  ControlToValidate="txtOnsetDate" Display="dynamic" ErrorMessage="<font color='red'><b>Enter a valid date</b></font><br>"  runat="server"/>                            
                        
                <label for="txtRepairTime">Repair Time:</label>
                <asp:TextBox id="txtRepairTime" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtRepairTime" ValidationGroup="Onset" ErrorMessage="<font class='text-danger'>*Repair time required.<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>                            
                <asp:CompareValidator Operator="DataTypeCheck" Type="Double"  ControlToValidate="txtRepairTime" Display="dynamic" ErrorMessage="<font color='red'><b>Enter numbers only</b></font><br>"  runat="server"/>                            
                        
                <label for="txtDownTime">Down Time:</label>
                <asp:TextBox id="txtDownTime" Class="form-control" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtDownTime" ValidationGroup="Onset" ErrorMessage="<font class='text-danger'>*Down time required.<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>                            
                <asp:CompareValidator Operator="DataTypeCheck" Type="Double"  ControlToValidate="txtDownTime" Display="dynamic" ErrorMessage="<font color='red'><b>Enter numbers only</b></font><br>"  runat="server"/>                            
                        
                <label for="txtNotes">Notes:</label>
                <asp:TextBox id="txtNotes" Class="form-control" TextMode="Multiline" runat="server"/>
                <asp:RequiredFieldValidator ControlToValidate="txtNotes" ValidationGroup="Onset" ErrorMessage="<font class='text-danger'>*Notes required<br></font></asp:RequiredFieldValidato>" DisplayMode="Dynamic" Runat="server"/>
                <br>
                <asp:Button OnClick="AddStatus" ValidationGroup="Onset" Text="Add Repair Information"  Class="btn btn-default" Runat="server"/>
                            
            </div>
            <div class="col-sm-4">
                        
                <h4>Repair done by:</h4>
                <asp:CheckBoxList id="cblFixer" runat="server"/>
                        
            </div>
        </div>
    </asp:Panel>
            
            
    <asp:Panel id="pnlSuccess" Visible="False" runat="Server">
        <div class="row">
            <div class="col-sm-12">
                        
                <asp:Label id="lblSuccess" Runat="server"/><br><br> 
                        
                <asp:LinkButton id="lbnReload1" OnCommand="Reload" CommandArgument="1" Runat="server">Add another repair for this machine</asp:LinkButton><br>
                <asp:LinkButton id="lbnReload2" OnCommand="Reload" CommandArgument="0" Runat="server">Add a repair for a different machine</asp:LinkButton><br>
                <asp:HyperLink id="hlkMachineDetail" Runat="server">Machine Detail</asp:HyperLink><br><br>
            </div>
        </div>                    
    </asp:Panel>
                        
    <asp:HiddenField id="hdnMachineID" runat="server"/>
    <asp:HiddenField id="hdnStatusID" runat="server"/>
    <asp:HiddenField id="hdnMachineStatus" runat="server"/>
    <asp:HiddenField id="hdnStatusNotes" runat="server"/>
    <br><br>
    
</asp:Content>