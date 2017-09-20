<%@ Page Language="VB"  Debug="true"%>
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

            lblHeader.Text = Session("Name") & " - " & Session("Role")

            FillYear()

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

    Sub FillYear()

        Dim conDefaultDb As SqlConnection
        Dim dtaSelect As SqlDataAdapter
        Dim dtsSet1 As New DataSet()
        Dim strRole, strQuery As String
        Dim intID As Integer

        conDefaultDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conDefaultDb.Open()

        strQuery = "Select Distinct DatePart(yyyy, onsetdate) As Year from MachineStatus"

        dtaSelect = New SQLDataAdapter(strQuery, conDefaultDb)

        dtaSelect.Fill(dtsSet1)

        rblYear.DataSource = dtsSet1
        rblYear.DataTextField = "Year"
        rblYear.DataValueField = "Year"
        rblYear.Databind()

        conDefaultDb.Close()

    End Sub

    Sub GetReport(Sender As Object, E As EventArgs)

        lblReportHeader.Text = "<h3>" & rblMonth.SelectedItem.Text & " " & rblYear.SelectedItem.Text & " Down Time Report </h3>"

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader
        Dim strQuery As String

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        strQuery = "Select   IsNull(department.name, ' ') as departmentname,  IsNull(machine.name, ' ') as machinename,  Sum(RepairTime) As RepairTime,  IsNull(Sum(DownTime), 0) As DownTime  From department  left outer join machine  on department.departmentid = machine.departmentref  left outer join machinestatus  on machine.machineid = machinestatus.machineref  Where DatePart(mm, onsetdate) = @Month  And DatePart(yyyy, onsetdate) = @Year  Group By department.name,  machine.name With Rollup"

        cmdSelect = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdSelect.Parameters.Add("@Month",  rblMonth.SelectedItem.Value)
        cmdSelect.Parameters.Add("@Year",  rblYear.SelectedItem.Value)

        dtrReader = cmdSelect.ExecuteReader()

        Dim strOldDepartment, strNewDepartment, strOldMachine, strNewMachine As String

        While dtrReader.Read()

            strNewDepartment = dtrReader("DepartmentName")
            strNewMachine = dtrReader("MachineName")

            If strNewDepartment = strOldDepartment Then

                If dtrReader("MachineName") <> " " Then

                    lblReportHeader.Text &= "<div class='row'>"
                    lblReportHeader.Text &= "<div class='col-xs-4'>"
                    lblReportHeader.Text &= dtrReader("MachineName")
                    lblReportHeader.Text &= "</div>"
                    lblReportHeader.Text &= "<div class='col-xs-4'>"
                    lblReportHeader.Text &= "Repair Time: " & dtrReader("RepairTime") & " hrs"
                    lblReportHeader.Text &= "</div>"
                    lblReportHeader.Text &= "<div class='col-xs-4'>"
                    lblReportHeader.Text &= "Down Time: " & dtrReader("DownTime") & " hrs"
                    lblReportHeader.Text &= "</div>"
                    lblReportHeader.Text &= "</div>"

                End If

            Else

                If dtrReader("DepartmentName") <> " " Then

                    lblReportHeader.Text &= "<hr><h3>" & dtrReader("DepartmentName") & "</h3>"
                    lblReportHeader.Text &= "<div class='row'>"
                    lblReportHeader.Text &= "<div class='col-xs-4'>"
                    lblReportHeader.Text &= dtrReader("MachineName")
                    lblReportHeader.Text &= "</div>"
                    lblReportHeader.Text &= "<div class='col-xs-4'>"
                    lblReportHeader.Text &= "Repair Time: " & dtrReader("RepairTime") & " hrs"
                    lblReportHeader.Text &= "</div>"
                    lblReportHeader.Text &= "<div class='col-xs-4'>"
                    lblReportHeader.Text &= "Down Time: " & dtrReader("DownTime") & " hrs"
                    lblReportHeader.Text &= "</div>"
                    lblReportHeader.Text &= "</div>"

                End If

            End If

            If dtrReader("MachineName") = " " And dtrReader("DepartmentName") <> " " Then

                lblReportHeader.Text &= "<div class='row'>"
                lblReportHeader.Text &= "<div class='col-xs-4'>"
                lblReportHeader.Text &= "<strong>Department Total</strong>"
                lblReportHeader.Text &= "</div>"
                lblReportHeader.Text &= "<div class='col-xs-4'>"
                lblReportHeader.Text &= "<strong>Repair Time: " & dtrReader("RepairTime") & " hrs</strong>"
                lblReportHeader.Text &= "</div>"
                lblReportHeader.Text &= "<div class='col-xs-4'>"
                lblReportHeader.Text &= "<strong>Down Time: " & dtrReader("DownTime") & " hrs</strong>"
                lblReportHeader.Text &= "</div>"
                lblReportHeader.Text &= "</div>"

            End If

            If dtrReader("DepartmentName") = " " Then

                lblReportHeader.Text &= "<hr><div class='row'>"
                lblReportHeader.Text &= "<div class='col-xs-4'>"
                lblReportHeader.Text &= "<strong>Grand Total</strong>"
                lblReportHeader.Text &= "</div>"
                lblReportHeader.Text &= "<div class='col-xs-4'>"
                lblReportHeader.Text &= "<strong>Repair Time: " & dtrReader("RepairTime") & " hrs</strong>"
                lblReportHeader.Text &= "</div>"
                lblReportHeader.Text &= "<div class='col-xs-4'>"
                lblReportHeader.Text &= "<strong>Down Time: " & dtrReader("DownTime") & " hrs</strong>"
                lblReportHeader.Text &= "</div>"
                lblReportHeader.Text &= "</div>"

            End If

            strOldDepartment = strNewDepartment

        End While

        dtrReader.Close()

        conPeninsulaRVDb.Close()



        pnlDateForm.Visible="False"
        pnlReport.Visible="True"

        GetGraph()

    End Sub

    Sub GetGraph()

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader
        Dim strQuery As String

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        strQuery = "select top 12 sum(downtime) as downtime, sum(repairtime) as repairtime, datepart(mm, onsetdate) As Month, datepart(yyyy, onsetdate) as Year from departmentmachinestatusgraphview where onsetdate > '7/31/2016' AND (datePart(mm, onsetDate) <= " & rblMonth.SelectedItem.Value & " and datePart(yyyy, OnsetDate) <= " & rblYear.SelectedItem.Value & ") group by datepart(mm, onsetdate), datepart(yyyy, onsetdate) order by datepart(yyyy, onsetdate) desc, datepart(mm, onsetdate) desc"
        'strQuery = "select top 12 sum(downtime) as downtime, sum(repairtime) as repairtime, datepart(mm, onsetdate) As Month, datepart(yyyy, onsetdate) as Year from departmentmachinestatusgraphview where (datePart(mm, onsetDate) <= " & rblMonth.SelectedItem.Value & " and datePart(yyyy, OnsetDate) <= " & rblYear.SelectedItem.Value & ") group by datepart(mm, onsetdate), datepart(yyyy, onsetdate) order by datepart(yyyy, onsetdate) desc, datepart(mm, onsetdate) desc"

        cmdSelect = New SQLCommand(strQuery, conPeninsulaRVDb)

        dtrReader = cmdSelect.ExecuteReader()

        Dim decMaxBarHeight As Decimal

        Dim intCount As Integer

        intCount = 1

        While dtrReader.Read()

            If intCount = 1 Then
                decMaxBarHeight = dtrReader("DownTime")

                If decMaxBarHeight < dtrReader("RepairTime") Then
                    decMaxBarHeight = dtrReader("RepairTime")
                End If
            Else

                If decMaxBarHeight < dtrReader("DownTime") Then

                    decMaxBarHeight = dtrReader("DownTime")

                End If

                If decMaxBarHeight < dtrReader("RepairTime") Then

                    decMaxBarHeight = dtrReader("RepairTime")

                End If

            End If

            plhGraph.Controls.Add(New LiteralControl("<li><center>"))

            Dim lblDown As New Label()
            lblDown.ID = "DownTime" & dtrReader("Month") & dtrReader("Year")
            lblDown.CssClass="DownTime"
            lblDown.Text = dtrReader("DownTime")
            If dtrReader("DownTime") > 0 Then
                plhGraph.Controls.Add(lblDown)
            End If

            divScale.Controls.Add(New LiteralControl("<div style='position: absolute; bottom: -20px; left: " & 80 + ((intcount - 1) * 150) & "px;'>" & ReturnMonth(dtrReader("Month")) & " " & dtrReader("Year") & "</div>"))

            plhGraph.Controls.Add(New LiteralControl("</center></li>"))

            plhGraph.Controls.Add(New LiteralControl("<li><center>"))

            Dim lblRepair As New Label()
            lblRepair.ID = "RepairTime" & dtrReader("Month") & dtrReader("Year")
            lblRepair.CssClass="RepairTime"
            lblRepair.Text = dtrReader("RepairTime")
            If dtrReader("RepairTime") > 0 Then
                plhGraph.Controls.Add(lblRepair)
            End If

            plhGraph.Controls.Add(New LiteralControl("</center></li>"))

            intCount += 1

        End While

        dtrReader.Close()

        conPeninsulaRVDb.Close()






        Dim decMaxScale As Decimal
        Dim intStep, intCurrentStep, intMaxScale As Integer

        intMaxScale = Math.Ceiling(decMaxBarHeight)

        Select intMaxScale

            Case 0 to 5
                decMaxScale = 5
                intStep = 1
            Case 6 to 10
                decMaxScale = 10
                intStep = 2
            Case 11 to 20
                decMaxScale = 20
                intStep = 5
            Case 21 to 30
                decMaxScale = 30
                intStep = 5
            Case 31 to 40
                decMaxScale = 40
                intStep = 5
            Case 41 to 50
                decMaxScale = 50
                intStep = 10
            Case 51 to 60
                decMaxScale = 60
                intStep = 10
            Case 61 to 70
                decMaxScale = 70
                intStep = 10
            Case 71 to 80
                decMaxScale = 70
                intStep = 10
            Case 81 to 90
                decMaxScale = 90
                intStep = 10
            Case 91 to 100
                decMaxScale = 100
                intStep = 20
            Case Else
                decMaxScale = 100
                intStep = 20
                Response.Write("intCurrentStep: " & intCurrentStep & "<br>intStep: " & intStep & "<br>decMaxScale: " & decMaxScale & "<br> decMaxBarHeight: " & decMaxBarHeight)
        End Select

        intCurrentStep = intStep


        While intCurrentStep <= decMaxScale

            divScale.Controls.Add(New LiteralControl("<div style='position: absolute; bottom: " & intCurrentStep * (200 / decMaxScale ) & "px; left: 40px; z-index: -1; background-color: #000000 !important; height: 1px; width: 100%'></div>"))
            divScale.Controls.Add(New LiteralControl("<div style='position: absolute; bottom: " & intCurrentStep * (200 / decMaxScale ) & "px; right: -40px;'>" & intCurrentStep & "</div>"))
            intCurrentStep += intStep

        End While






        Dim lblControl As New Label()

        Dim decBarHeight As Decimal

        For Each ctrl As Control in plhGraph.Controls

            Dim i, j As Integer

            j = rblYear.SelectedItem.Value

            For i = 1 to 12

                If TypeOf ctrl Is Label Then

                    If ctrl.ID = "DownTime" & i & j Then

                        lblControl = ctrl
                        decBarHeight = lblCOntrol.Text

                        decBarHeight = (decBarHeight / decMaxScale) * 100
                        lblControl.Style("height") = decBarHeight & "%"

                    ElseIf ctrl.ID = "RepairTime" & i & j Then

                        lblControl = ctrl
                        decBarHeight = lblCOntrol.Text

                        decBarHeight = (decBarHeight / decMaxScale) * 100
                        lblControl.Style("height") = decBarHeight & "%"

                    End If

                End If

            Next

        Next





    End Sub

    Sub Reload(Sender As Object, E As EventArgs)

        Response.Redirect("addMachine.aspx")

    End Sub

    Sub LogOut(Sender As Object, E As CommandEventArgs)

        Session.Clear()
        Response.Redirect("Login.aspx")


    End Sub

    Function ReturnMonth(intMonth As Integer)

        Select Case intMonth
            Case 1
                Return "Jan"
            Case 2
                Return "Feb"
            Case 3
                Return "Mar"
            Case 4
                Return "Apr"
            Case 5
                Return "May"
            Case 6
                Return "Jun"
            Case 7
                Return "Jul"
            Case 8
                Return "Aug"
            Case 9
                Return "Sep"
            Case 10
                Return "Oct"
            Case 11
                Return "Nov"
            Case 12
                Return "Dec"
        End Select

    End Function


</script>
    
<!DOCTYPE html>
<html lang="en">
    <head>
        
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

        <!-- Latest compiled JavaScript -->
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        
        <style>
            
            .graph{         
                
                list-style: none; 
                z-index: 100;
            }
            
            .graph li {
                width: 75px; 
                height: 200px;
                float: left;
                border: 1px solid;
                position: relative;
                vertical-align: text-bottom;
            }
            
             .graph span {
                 position:absolute;
                 right:0;
                 bottom:0;
                 left:0; /*"bottom-align" the bars,widths will be set inline*/
                 height: 100%;
                 vertical-align: text-bottom;
                 margin-left: 5px;
                 margin-right:  5px;
            }
            
            .DownTime{
                background-color:darkorange !important;  
                font-weight: 700;
                color: white !important;
            }
            
            .RepairTime{
                background-color: blueviolet !important;
                color: white !important;
                font-weight: 700;
            }
            
             @media print {
                    body {-webkit-print-color-adjust: exact;}
            }
            
            
}
            
        </style>
            
    </head>
    <body id="mBody" runat="server">
        <div class="container">
            <form role="form" runat="server">
                
                <asp:Panel id="pnlDateForm" runat="server">
                    <div class="row">
                    <div class="col-xs-12">
                        <h2>Mervin Maintenance</h2>
                        <h3>
                            Welcome, <asp:Label id="lblHeader" runat="server"/>
                        </h3>
                        <h4>Down Time Report</h4>
                        <hr>
                    </div>
                </div>
                    <div class="row">
                        <div class="col-xs-4">
                            <asp:RadioButtonList id="rblMonth" runat="server">
                                <asp:ListItem Value="1">
                                    January    
                                </asp:ListItem>
                                <asp:ListItem Value="2">
                                    February
                                </asp:ListItem>
                                <asp:ListItem Value="3">
                                    March
                                </asp:ListItem>
                                <asp:ListItem Value="4">
                                    April
                                </asp:ListItem>
                                <asp:ListItem Value="5">
                                    May
                                </asp:ListItem>
                                <asp:ListItem Value="6">
                                    June
                                </asp:ListItem>
                                <asp:ListItem Value="7">
                                    July
                                </asp:ListItem>
                                <asp:ListItem Value="8">
                                    August
                                </asp:ListItem>
                                <asp:ListItem Value="9">
                                    September
                                </asp:ListItem>
                                <asp:ListItem Value="10">
                                    October
                                </asp:ListItem>
                                <asp:ListItem Value="11">
                                    November
                                </asp:ListItem>
                                <asp:ListItem Value="12">
                                    December
                                </asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ControlToValidate="rblMonth" ErrorMessage="Month required" Display="Dynamic" Runat="server"/>
                        </div>
                        
                        <div class="col-xs-4">
                            <asp:RadioButtonList id="rblYear" runat="server"/>
                            <asp:RequiredFieldValidator ControlToValidate="rblYear" ErrorMessage="Year required" Display="Dynamic" Runat="server"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <asp:Button OnClick="GetReport" Text="Get Report" Class="btn btn-default" Runat="server"/>
                        </div>
                    </div>
                </asp:Panel> 
                <asp:Panel id="pnlReport" Visible="False" Runat="server">
                    <asp:Label id="lblReportHeader" runat="server"/>
                
                    <br>
                        <h3 style="page-break-before: always;">History</h3>
                    <table>
                        <tr>
                            <td><div style="position: relative; top: 0px; height: 15px; width: 30px; border-style: solid; border-width: 1px;" class="DownTime"></div></td>
                            <td><h5>&nbsp;&nbsp;Down Time</h5></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td><div style="position: relative; top: 00px; height: 15px; width: 30px; border-style: solid; border-width: 1px;" class="RepairTime"></div></td>
                            <td><h5>&nbsp;&nbsp;Repair Time</h5></td>
                        </tr>
                    </table>                     
                    <div style="position: relative; left: -40px; top: 0px; height: 200px; display: table;">
                        <ul class="graph" ID="ulGraph" runat="server">                            
                            <asp:PlaceHolder id="plhGraph" runat="server"/>
                        </ul>
                        <div style="position: absolute; top: 1px; width: 100%; height: 100%;">
                            <asp:Placeholder id="divScale" runat="server"/>
                        </div>
                    </div>
                    
                </asp:Panel>
                    
            </form>
        </div>
        <br><br><br><br>
    </body>
</html>