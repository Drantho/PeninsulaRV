<%@ Page Title="Checklist" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
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
        
        FillOutstanding()
    
    End Sub
    
    Sub FillOutStanding()
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader
        Dim dtNow, dtStartDate, dtOldCompleteDate, dtNewCompleteDate, dtRecentComplete, dtDue As DateTime
        Dim intOldItemID, intNewItemID, intCount, intCompleteCOunt, intIncompleteCount As Integer
        Dim strComplete As String
        
        dtNow = DateTime.Now()
        dtNow = dtNow.AddHours(-2)
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        cmdSelect = New SQLCommand("Select * from CheckListView order by ItemId desc, CompleteDate desc", conPeninsulaRVDb)                
        
        dtrReader = cmdSelect.ExecuteReader()                
        
        intCount = 1
        intCompleteCount = 1
        intIncompleteCount = 1
        
        While dtrReader.Read()
        
            intNewItemID = dtrReader("ItemID")
            
            Try
            
                dtNewCompleteDate = dtrReader("CompleteDate")
                
            Catch
            
                dtNewCompleteDate = Nothing
            
            End Try
            
            Try
                dtRecentComplete = dtrReader("RecentComplete")
            Catch
                dtRecentComplete = "1/1/1900"
            End Try
            
            If Not IsComplete(dtNewCompleteDate, dtrReader("Frequency"), dtrReader("ShiftTarget")) Or dtrReader.IsDBNull(6) Then
            
                If intNewItemID <> intOldItemID Then                                
            
                    plhOutstanding.Controls.Add(New LiteralControl("<div class='row"))
                    
                    If intIncompleteCount Mod 2 = 0 Then
                    
                        plhOutstanding.Controls.Add(New LiteralControl(" gray"))
                    
                    End If
                    
                    plhOutstanding.Controls.Add(New LiteralControl("'>"))
                        plhOutstanding.Controls.Add(New LiteralControl("<div class='col-sm-4'>"))
                            plhOutstanding.Controls.Add(New LiteralControl("<h4 style='display: inline'>"))
                                plhOutstanding.Controls.Add(New LiteralControl("<a href=""javascript:toggleDiv('div" & intCount & "');""><span class='glyphicon glyphicon-edit'></span>&nbsp;" & dtrReader("ShortTitle") & "</a>"))
                            plhOutstanding.Controls.Add(New LiteralControl("</h4>&nbsp;/&nbsp;" & dtrReader("Frequency") & "<br><h5><a href=''><span class='glyphicon glyphicon-time' aria-hidden='true'></span>&nbsp;History</a></h5>"))
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        plhOutstanding.Controls.Add(New LiteralControl("<div class='col-sm-3'><label>Description: </label><br>"))
                            plhOutstanding.Controls.Add(New LiteralControl(dtrReader("Description")))
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        plhOutstanding.Controls.Add(New LiteralControl("<div class='col-sm-2'>"))
                            plhOutstanding.Controls.Add(New LiteralControl("<label>Last Complete: </label><br>"))
                            
                            If dtRecentComplete = "1/1/1900" Then
                                plhOutstanding.Controls.Add(New LiteralControl("No value recorded."))
                            Else
                                plhOutstanding.Controls.Add(New LiteralControl(dtRecentComplete))
                            End If
                            
                            
                            plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                            plhOutstanding.Controls.Add(New LiteralControl("<div class='col-sm-3'>"))
                                
                                plhOutstanding.Controls.Add(New LiteralControl("<label>Recent Note: </label><br>" & dtrReader("Notes")))
                                
                            plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<div id='div" & intCount & "' style='display: none'>"))
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<hr>"))
                        plhOutstanding.Controls.Add(New LiteralControl("<div class='row'>"))
                        plhOutstanding.Controls.Add(New LiteralControl("<div class='col-sm-2'>"))
                        
                        Dim txtDate, txtHour, txtMinute, txtNote As New TextBox()
                        
                        txtDate.ID = "txtDate" & dtrReader("ItemID")
                        txtDate.CssClass = "form-control"
                        txtDate.TextMode = TextBoxMode.Date
                        
                        txtDate.Text = dtNow.ToString("yyyy-MM-dd")
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<label for='txtDate" & intCount & "'>Date:</label>"))
                                                
                        plhOutstanding.Controls.Add(txtDate)
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<div class='col-sm-1'>"))
                        txtHour.ID = "txtHour" & dtrReader("ItemID")
                        txtHour.CssClass = "form-control"
                        txtHour.TextMode = TextBoxMode.Number
                        
                        txtHour.Text = dtNow.ToString("HH")
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<label for='txtHour" & intCount & "'>Hour(24):</label>"))
                                                
                        plhOutstanding.Controls.Add(txtHour)
                        
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<div class='col-sm-1'>"))
                        txtMinute.ID = "txtMinute" & dtrReader("ItemID")
                        txtMinute.CssClass = "form-control"
                        txtMinute.TextMode = TextBoxMode.Number
                        
                        txtMinute.Text = dtNow.ToString("mm")
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<label for='txtMinute" & intCount & "'>Minute:</label>"))
                                                
                        plhOutstanding.Controls.Add(txtMinute)
                        
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<div class='col-sm-3'>"))
                        txtNote.ID = "txtNote" & dtrReader("ItemID")
                        txtNote.CssClass = "form-control"
                        txtNote.Text = "Checklist entry completed by: " & Session("Name")
                        txtNote.TextMode = TextBoxMode.MultiLine
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<label for='txtNote" & intCount & "'>Note:</label>"))
                                                
                        plhOutstanding.Controls.Add(txtNote)
                        
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        
                        
                        Dim rblShiftTarget As New RadioButtonList()
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<div class='col-sm-1'>"))
                        rblShiftTarget.ID = "rblShiftTarget" & dtrReader("ItemID")
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<label for='rblShiftTarget" & intCount & "'>Shift:</label>"))
                                                
                        rblShiftTarget.Items.Add("Day")
                        rblShiftTarget.Items.Add("Night")
                        
                        If ReturnShift() = "Day" Then
                        
                            rblShiftTarget.Items(0).Selected = "True"
                            
                        Else
                        
                            rblShiftTarget.Items(1).Selected = "True"
                            
                        End If
                        
                        plhOutstanding.Controls.Add(rblShiftTarget)
                        
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<div class='col-sm-2'>"))
                        
                        Dim lbnCheck As New LinkButton()
                        
                        lbnCheck.ID = "lbnCheck" & intCount
                        lbnCheck.Text = "Submit"
                        lbnCheck.CssClass="button"
                        lbnCheck.CommandArgument = dtrReader("ItemID")
                        
                        AddHandler lbnCheck.Command, AddressOf SubmitCheck
                        
                        plhOutstanding.Controls.Add(New LiteralControl("<br>"))
                        plhOutstanding.Controls.Add(lbnCheck)
                        
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        
                        
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                        
                        plhOutstanding.Controls.Add(New LiteralControl("</div>"))
                      
                        intIncompleteCount += 1
             
                End If
            
                dtOldCompleteDate = dtNewCompleteDate
                
                strComplete = "Outstanding"
                
                
                
            Else
            
                If intNewItemID <> intOldItemID Then                                
            
                    plhComplete.Controls.Add(New LiteralControl("<div class='row"))
                    
                    If intCompleteCount Mod 2 = 0 Then
                    
                        plhComplete.Controls.Add(New LiteralControl(" gray"))
                    
                    End If
                    
                    plhComplete.Controls.Add(New LiteralControl("'>"))
                        plhComplete.Controls.Add(New LiteralControl("<div class='col-sm-4'>"))
                            plhComplete.Controls.Add(New LiteralControl("<h4><span class='glyphicon glyphicon-ok'></span> &nbsp;"))
                                plhComplete.Controls.Add(New LiteralControl(dtrReader("ShortTitle")))
                            plhComplete.Controls.Add(New LiteralControl("</h4>&nbsp;/&nbsp;" & dtrReader("Frequency") & "<br><a href=''><h5><span class='glyphicon glyphicon-time' aria-hidden='true'></span>&nbsp;History</a></h5>"))
                        plhComplete.Controls.Add(New LiteralControl("</div>"))
                        plhComplete.Controls.Add(New LiteralControl("<div class='col-sm-3'><label>Description: </label><br>"))
                            plhComplete.Controls.Add(New LiteralControl(dtrReader("Description")))
                        plhComplete.Controls.Add(New LiteralControl("</div>"))
                        plhComplete.Controls.Add(New LiteralControl("<div class='col-sm-2'>"))
                            plhComplete.Controls.Add(New LiteralControl("<label>Last Complete: </label><br>"))
                                plhComplete.Controls.Add(New LiteralControl(dtrReader("RecentComplete")))
                            plhComplete.Controls.Add(New LiteralControl("</div>"))
                            plhComplete.Controls.Add(New LiteralControl("<div class='col-sm-3'>"))
                                
                                plhComplete.Controls.Add(New LiteralControl("<label>Recent Note: </label><br>" & dtrReader("Notes")))
                                
                            plhComplete.Controls.Add(New LiteralControl("</div>"))
                        plhComplete.Controls.Add(New LiteralControl("</div>"))
                      
                        intCompleteCount += 1
             
                End If
            
                dtOldCompleteDate = dtNewCompleteDate
                
                strComplete = "Complete"
                
                
            
            End If
            
            intCount += 1
            
            intOldItemID = intNewItemID
            
        End While
        
        dtrReader.Close()
        
        conPeninsulaRVDb.Close()
        
        lblIncompleteCount.Text = intIncompleteCount -1
        lblCompleteCount.Text = intCompleteCount -1
    
    End Sub
    
    Sub SubmitCheck(Sender As Object, E As CommandEventArgs)
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdInsert As SqlCommand        
        Dim dtComplete As DateTime
        Dim strQuery As String
        
        Dim txtDate, txtHour, txtMinute, txtNote As New TextBox()
        Dim rblShiftTarget As New RadioButtonList()
        
        txtDate = plhOutstanding.FindControl("txtDate" & E.CommandArgument)
        txtHour = plhOutstanding.FindControl("txtHour" & E.CommandArgument)
        txtMinute = plhOutstanding.FindControl("txtMinute" & E.CommandArgument)
        txtNote = plhOutstanding.FindControl("txtNote" & E.CommandArgument)
        
        rblShiftTarget = plhOutstanding.FindControl("rblShiftTarget" & E.CommandArgument)
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        strQuery = "Insert into CheckListEntry(ItemRef, CompleteDate, Notes, ShiftTarget) values(@ItemRef, @CompleteDate, @Notes, @ShiftTarget)"
        
        cmdInsert = New SQLCommand(strQuery, conPeninsulaRVDb) 
        cmdInsert.Parameters.AddWithValue("@ItemRef", E.CommandArgument)
        cmdInsert.Parameters.AddWithValue("@CompleteDate", txtDate.Text & " " & txtHour.Text & ":" & txtMinute.Text & ":00")
        cmdInsert.Parameters.AddWithValue("@Notes", txtNote.Text)
        cmdInsert.Parameters.AddWithValue("@ShiftTarget", rblShiftTarget.SelectedItem.Text)
        
        cmdInsert.ExecuteNonQuery()
        
        Response.Redirect("checklist.aspx")        
    
    End Sub
    
    Function IsComplete(dtRecentComplete As Date, strFrequency As String, Optional strShiftTarget As String = Nothing)
    
        Dim boolIsComplete As Boolean
        Dim dtNow As DateTime
        
        dtNow = DateTime.Now()
        dtNow = dtNow.AddHours(-2)
        
        boolIsComplete = False
    
        If strFrequency = "Shift" Then
        
            If strShiftTarget = "Night" Then
            
                dtRecentComplete = dtRecentComplete.AddHours(-12)
                dtNow = dtNow.AddHours(-12)
            
            End If
            
            If DateDiff("d", dtRecentComplete, dtNow) < 1 and strShiftTarget = ReturnShift() Then
            
                boolIsComplete = True
            
            End If
            
        
        ElseIf strFrequency = "Day" Then
        
            If DateDiff(DateInterval.Day, dtRecentComplete, dtNow) < 1 Then
            
                boolIsComplete = True
            
            End If
        
        ElseIf strFrequency = "Week" Then
            
            If DateDiff("ww", dtRecentComplete, dtNow) < 1 Then
            
                boolIsComplete = True
                
            End If            
            
        ElseIf strFrequency = "Month" Then
        
            If DatePart("M", dtNow) = DatePart("M", dtRecentComplete) Then
            
                boolIsComplete = True
            
            End If
        
        End If
        
        Return boolIsComplete
        
    End Function   
    
    Function ReturnShift()
    
        Dim dtNow As DateTime
        
        dtNow = DateTime.Now()
        
        If dtNow.Hour < 5 Or dtNow.Hour > 17 Then
        
            Return "Night"
        
        Else
        
            Return "Day"
            
        End If
    
    End Function
    
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
    
    Sub Reload(Sender As Object, E As EventArgs)    
    
        Response.Redirect("addchecklist.aspx")
    
    End Sub
    
    Sub LogOut(Sender As Object, E As CommandEventArgs)
    
        Session.Clear()
        Response.Redirect("Login.aspx")
        
    
    End Sub
    
    
</script>
    
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:Panel id="pnlListItemForm" runat="server">
                    
        <div class="row">     
                        
            <div class="col-sm-12">
                        
                <h3>Checklist</h3>
                <div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Incomplete (<asp:Label id="lblIncompleteCount" runat="server" />)</a>
                            </h4>
                        </div>
                        <div id="collapse1" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <asp:PlaceHolder id="plhOutstanding" runat="server"/>                
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">Complete (<asp:Label id="lblCompleteCount" runat="server" />)</a>
                            </h4>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse">
                            <div class="panel-body">
                                <asp:PlaceHolder id="plhComplete" runat="server"/>                
                            </div>
                        </div>
                    </div>
                </div>
                            
                            
            </div>
                        
        </div>
                    
    </asp:Panel> 
                
    <asp:Panel id="pnlSuccess" Visible="False" runat="Server">
                    
        <div class="row">
                
            <div class="col-sm-12">
                                                    
                <asp:Button OnClick="Reload" Text="Add Another Checklist Item" Class="btn btn-default" Runat="server"/>
                            
            </div>
                        
        </div>
                    
    </asp:Panel>
                
    <br><br>
    <asp:Label id="lblSuccess" Runat="server"/><br>

</asp:Content>