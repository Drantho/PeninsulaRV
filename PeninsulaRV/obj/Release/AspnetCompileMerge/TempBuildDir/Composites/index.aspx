<%@ Page Title="Home Page" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
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

        If Not IsPostBack Then

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

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SqlCommand("Select * from departmentmachineview order by departmentname", conPeninsulaRVDb)

        dtrReader = cmdSelect.ExecuteReader()

        Dim strNewDepartmentID, strOldDepartmentID As String
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
                plhDepartmentList.Controls.Add(New LiteralControl("<a data-toggle='collapse' data-parent='#accordion' href='#collapse" & intCount & "'><div style='height: 100%; width: 100%'>" & dtrReader("DepartmentName") & "</div></a>"))
                plhDepartmentList.Controls.Add(New LiteralControl("</h4>"))
                plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
                plhDepartmentList.Controls.Add(New LiteralControl("<div id='collapse" & intCount & "' class='panel-collapse collapse'>"))
                plhDepartmentList.Controls.Add(New LiteralControl("<div class='panel-body'>"))

            End If

            If dtrReader.IsDBNull(4) Then
                plhDepartmentList.Controls.Add(New LiteralControl("No machines entered."))
            Else
                plhDepartmentList.Controls.Add(New LiteralControl(dtrReader("MachineName") & " - <a href='Machine.aspx?MachineID=" & dtrReader("MachineID") & "'>View Detail</a> - <a href='addrepair.aspx?MachineID=" & dtrReader("MachineID") & "'>Add Repair</a><br>"))
            End If

            strOldDepartmentID = strNewDepartmentID

            intCount += 1

        End While

        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))


        plhDepartmentList.Controls.Add(New LiteralControl("<div class='panel panel-default'>"))
        plhDepartmentList.Controls.Add(New LiteralControl("<div class='panel-heading'>"))
        plhDepartmentList.Controls.Add(New LiteralControl("<h4 class='panel-title'>"))
        plhDepartmentList.Controls.Add(New LiteralControl("<a href='supplier.aspx'><div style='height: 100%; width: 100%'>Suppliers</div></a>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</h4>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
        plhDepartmentList.Controls.Add(New LiteralControl("<div id='collapse" & intCount & "' class='panel-collapse collapse'>"))
        plhDepartmentList.Controls.Add(New LiteralControl("<div class='panel-body'>"))

        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))



        plhDepartmentList.Controls.Add(New LiteralControl("<div class='panel panel-default'>"))
        plhDepartmentList.Controls.Add(New LiteralControl("<div class='panel-heading'>"))
        plhDepartmentList.Controls.Add(New LiteralControl("<h4 class='panel-title'>"))
        plhDepartmentList.Controls.Add(New LiteralControl("<a href='part.aspx'><div style='height: 100%; width: 100%'>Parts</div></a>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</h4>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
        plhDepartmentList.Controls.Add(New LiteralControl("<div id='collapse" & intCount & "' class='panel-collapse collapse'>"))
        plhDepartmentList.Controls.Add(New LiteralControl("<div class='panel-body'>"))

        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))
        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))




        plhDepartmentList.Controls.Add(New LiteralControl("</div>"))


        dtrReader.Close()

        conPeninsulaRVDb.Close()

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
                        
            <asp:PlaceHolder id="plhDepartmentList" runat="server"/>
                                                
        </div>
    
    </div>
    <br>
    </asp:Content>