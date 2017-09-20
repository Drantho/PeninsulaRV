<%@ Page Title="Recent" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.IO.Path" %>
<%@ Import Namespace="System.Collections" %>
<%@ import Namespace="System.Configuration" %>
        
<script runat="server">

    Sub Page_Load()

        If Session("Name") = "" Then
            GetMemberInfo()
        End If

        If Session("Role") = "MervinUser" Or Session("Role") = "MervinAdmin" Then


        Else

            Response.Redirect("../Default")

        End If

        FillMachine()

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

    Sub FillMachine()

        pnlMachineDetail.Visible="True"

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader

        Dim intCount, intPhotoCount As Integer

        Dim dtOldDate, dtNewDate, dtNow, dtOnset As Date

        dtNow = Date.Now()

        intCount = 1
        intPhotoCount = 1

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SqlCommand("Select * from departmentmachinestatuslistview where DateDiff(Day,  OnsetDate, '" & dtNow & "') <= 31 order by onsetdate desc", conPeninsulaRVDb)

        dtrReader = cmdSelect.ExecuteReader()

        plhMachineDetail.Controls.Add(New LiteralControl("<div class='panel-group' id='accordion'>"))

        While dtrReader.Read()

            dtNewDate = dtrReader("OnsetDate")

            If dtNewDate <> dtOldDate Then

                If intCount > 1 Then

                    plhMachineDetail.Controls.Add(New LiteralControl("</div>"))
                    plhMachineDetail.Controls.Add(New LiteralControl("</div>"))
                    plhMachineDetail.Controls.Add(New LiteralControl("</div>"))

                End If

                plhMachineDetail.Controls.Add(New LiteralControl("<div class='panel panel-default'>"))
                plhMachineDetail.Controls.Add(New LiteralControl("<div class='panel-heading'>"))
                plhMachineDetail.Controls.Add(New LiteralControl("<h4 class='panel-title'>"))

                dtOnset = dtrReader("OnsetDate")

                plhMachineDetail.Controls.Add(New LiteralControl("<a data-toggle='collapse' data-parent='#accordion' href='#collapse" & intCount & "'>" & dtOnset.ToString("D") & "</a>"))
                plhMachineDetail.Controls.Add(New LiteralControl("</h4>"))
                plhMachineDetail.Controls.Add(New LiteralControl("</div>"))
                plhMachineDetail.Controls.Add(New LiteralControl("<div id='collapse" & intCount & "' class='panel-collapse collapse'>"))
                plhMachineDetail.Controls.Add(New LiteralControl("<div class='panel-body'>"))

            Else





            End If

            plhMachineDetail.Controls.Add(New LiteralControl("<h4><a href='machine.aspx?MachineID=" & dtrReader("MachineID") & "'>" & dtrReader("MachineName") & "</a> - Down time: " & dtrReader("DownTime") & " - Repair time: " & dtrReader("RepairTime") & "</h4>"))

            intCount += 1

            dtOldDate = dtNewDate

        End While

        plhMachineDetail.Controls.Add(New LiteralControl("</div>"))
        plhMachineDetail.Controls.Add(New LiteralControl("</div>"))
        plhMachineDetail.Controls.Add(New LiteralControl("</div>"))

        dtrReader.Close()

        conPeninsulaRVDb.Close()

    End Sub

    Sub LogOut(Sender As Object, E As CommandEventArgs)

        Session.Clear()
        Response.Redirect("Login.aspx")

    End Sub


</script>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:Panel id="pnlMachineDetail" Visible="False" runat="server">
                        
        <asp:PlaceHolder id="plhMachineDetail" runat="server"/>
                
    </asp:Panel>
    
    <asp:Label id="lblSuccess" runat="server"/>
    <asp:HiddenField id="hdnMachineID" runat="server"/>
    
</asp:Content>