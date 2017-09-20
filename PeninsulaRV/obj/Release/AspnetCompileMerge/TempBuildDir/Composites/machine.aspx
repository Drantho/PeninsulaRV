<%@ Page Title="Machine" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
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

        If Request.QueryString("MachineID") = "" Then

            If hdnMachineID.Value = "" Then
                FillMachineList()
            Else
                FillMachine(hdnMachineID.Value)
            End If

        Else

            FillMachine(Request.QueryString("MachineID"))

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

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SQLCommand("Select * from departmentmachinestatusview", conPeninsulaRVDb)

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

    Sub SelectMachine(Sender As Object, E As CommandEventArgs)

        FillMachine(E.CommandArgument)

    End Sub

    Sub FillMachine(intID As Integer)

        hdnMachineID.Value = intID

        pnlMachineList.Visible="False"
        pnlMachineDetail.Visible="True"

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader

        Dim intCount, intPhotoCount As Integer

        Dim strNewDepartmentID, strOldDepartmentID As String

        intCount = 1
        intPhotoCount = 1

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SQLCommand("Select * from departmentmachinestatuslistview where machineid = @MachineID order by onsetdate desc", conPeninsulaRVDb)
        cmdSelect.Parameters.Add("@MachineID",  intID)

        dtrReader = cmdSelect.ExecuteReader()

        While dtrReader.Read()

            strNewDepartmentID = dtrReader("DepartmentID")

            If intCount = 1 Then

                plhMachineDetail.Controls.Add(New LiteralControl("<ul class='nav nav-tabs'><li class='active'><a data-toggle='tab' href='#home'>Machine Information</a></li><li><a data-toggle='tab' href='#menu1'>Photos</a></li><li><a data-toggle='tab' href='#menu2'>Repair History</a></li><li><a data-toggle='tab' href='#menu3'>Part List</a></li></ul>"))

                plhMachineDetail.Controls.Add(New LiteralControl("<div class='tab-content'>"))
                plhMachineDetail.Controls.Add(New LiteralControl("<div id='home' class='tab-pane fade in active'>"))
                plhMachineDetail.Controls.Add(New LiteralControl("<br><h3 style='display: inline'>" & dtrReader("MachineName") & "</h3> <a href=""javascript:toggleDiv('divEditMachineName');"">Edit machine name</a><br>"))
                'MachineName Edit Div

                plhMachineDetail.Controls.Add(New LiteralControl("<div id='divEditMachineName' style='display: none'>"))

                Dim txtEditMachineName As New TextBox()
                txtEditMachineName.ID = "txtEditMachineName"
                txtEditMachineName.Text = dtrReader("MachineName")
                txtEditMachineName.TextMode = TextBoxMode.MultiLine
                txtEditMachineName.CssClass="form-control"
                plhMachineDetail.Controls.Add(txtEditMachineName)

                Dim lbnUpdateMachineName As New LinkButton()
                lbnUpdateMachineName.Text = "Update name"

                AddHandler lbnUpdateMachineName.Command, AddressOf UpdateMachineName

                plhMachineDetail.Controls.Add(lbnUpdateMachineName)

                plhMachineDetail.Controls.Add(New LiteralControl("</div>"))


                plhMachineDetail.Controls.Add(New LiteralControl("<strong>Machine ID:</strong> " & dtrReader("MachineID") & "<br>"))
                plhMachineDetail.Controls.Add(New LiteralControl("<strong>Department ID:</strong> " & dtrReader("DepartmentID") & "<br>"))
                plhMachineDetail.Controls.Add(New LiteralControl("<strong>Department Name:</strong> " & dtrReader("DepartmentName") & "<br>"))
                plhMachineDetail.Controls.Add(New LiteralControl("<strong>Machine Description:</strong> " & dtrReader("MachineDescription") & " <a href=""javascript:toggleDiv('divEditMachineDescription');"">Edit description</a><br>"))

                'MachineDescription Edit Div 
                plhMachineDetail.Controls.Add(New LiteralControl("<div id='divEditMachineDescription' style='display: none'>"))

                Dim txtEditMachineDescription As New TextBox()
                txtEditMachineDescription.ID = "txtEditMachineDescription"
                txtEditMachineDescription.Text = dtrReader("MachineDescription")
                txtEditMachineDescription.TextMode = TextBoxMode.MultiLine
                txtEditMachineDescription.CssClass="form-control"
                plhMachineDetail.Controls.Add(txtEditMachineDescription)

                Dim lbnUpdateMachineDescription As New LinkButton()
                lbnUpdateMachineDescription.Text = "Update description"

                AddHandler lbnUpdateMachineDescription.Command, AddressOf UpdateMachineDescription

                plhMachineDetail.Controls.Add(lbnUpdateMachineDescription)

                plhMachineDetail.Controls.Add(New LiteralControl("</div>"))

                plhMachineDetail.Controls.Add(New LiteralControl("Machine Notes: " & dtrReader("MachineNotes") & " <a href=""javascript:toggleDiv('divEditMachineNotes');"">Edit notes</a><br>"))

                plhMachineDetail.Controls.Add(New LiteralControl("<div id='divEditMachineNotes' style='display: none'>"))

                Dim txtEditMachineNotes As New TextBox()
                txtEditMachineNotes.ID = "txtEditMachineNotes"
                txtEditMachineNotes.Text = dtrReader("MachineNotes")
                txtEditMachineNotes.TextMode = TextBoxMode.MultiLine
                txtEditMachineNotes.CssClass="form-control"
                plhMachineDetail.Controls.Add(txtEditMachineNotes)

                Dim lbnUpdateMachineNotes As New LinkButton()
                lbnUpdateMachineNotes.Text = "Update notes"

                AddHandler lbnUpdateMachineNotes.Command, AddressOf UpdateMachineNotes

                plhMachineDetail.Controls.Add(lbnUpdateMachineNotes)

                plhMachineDetail.Controls.Add(New LiteralControl("</div>"))

                plhMachineDetail.Controls.Add(New LiteralControl("</div>"))

                plhMachineDetail.Controls.Add(New LiteralControl("<div id='menu1' class='tab-pane fade'>"))

                plhMachineDetail.Controls.Add(New LiteralControl("<h3>Photos of " & dtrReader("MachineName") & "</h3>"))

                While File.Exists(Server.MapPath("images/Machine-" & dtrReader("MachineID") & "-" & intPhotoCount & "Thumb.jpg"))

                    plhMachineDetail.Controls.Add(New LiteralControl("<a href='photo.aspx?PhotoType=Machine&TypeID=" & dtrReader("MachineID") & "&PhotoNumber=" & intPhotoCount & "'>"))
                    plhMachineDetail.Controls.Add(New LiteralControl("<img src='images/Machine-" & dtrReader("MachineID") & "-" & intPhotoCount & "Thumb.jpg'>"))
                    plhMachineDetail.Controls.Add(New LiteralControl("</a>"))
                    intPhotoCount += 1

                End While

                plhMachineDetail.Controls.Add(New LiteralControl("<br><br><a href='upload.aspx?PhotoType=Machine&TypeID=" & dtrReader("MachineID") & "'>Add photos of " & dtrReader("MachineName") & "</a>"))

                plhMachineDetail.Controls.Add(New LiteralControl("</div>"))

                plhMachineDetail.Controls.Add(New LiteralControl("<div id='menu2' class='tab-pane fade'>"))

                Dim plhRepairList As New PlaceHolder()
                plhRepairList.ID = "plhRepairList"

                plhMachineDetail.Controls.Add(plhRepairList)

                plhMachineDetail.Controls.Add(New LiteralControl("</div>"))

                plhMachineDetail.Controls.Add(New LiteralControl("<div id='menu3' class='tab-pane fade'>"))

                Dim plhPartList As New PlaceHolder()
                plhPartList.ID = "plhPartList"

                plhMachineDetail.Controls.Add(plhPartList)

                plhMachineDetail.Controls.Add(New LiteralControl("</div>"))


            End If



            If dtrReader("StatusID") > 0 Then


                Dim plhRepairList As New PlaceHolder()
                plhRepairList = plhMachineDetail.FindControl("plhRepairList")

                plhRepairList.Controls.Add(New LiteralControl("<hr>"))
                plhRepairList.Controls.Add(New LiteralControl("<strong>Status ID</strong>: " & dtrReader("StatusID") & "<br>"))
                plhRepairList.Controls.Add(New LiteralControl("<strong>Onset Date:</strong> " & dtrReader("OnsetDate") & " <a href=""javascript:toggleDiv('divEditOnsetDate" & dtrReader("StatusID") & "');"">Edit onset date</a><br>"))

                'Status OnsetDate Edit Div
                plhRepairList.Controls.Add(New LiteralControl("<div id='divEditOnsetDate" & dtrReader("StatusID") & "' style='display: none'>"))

                Dim dtOnset = dtrReader("OnsetDate")

                Dim txtEditOnsetDate As New TextBox()
                txtEditOnsetDate.ID = "txtEditOnsetDate" & dtrReader("StatusID")

                txtEditOnsetDate.Text = dtOnset.Month & "/" & dtOnset.Day & "/" & dtOnset.Year

                txtEditOnsetDate.CssClass="form-control"
                plhRepairList.Controls.Add(New LiteralControl("<label for='txtEditOnsetDate" & dtrReader("StatusID") & "'>Onset Date:</label>"))
                plhRepairList.Controls.Add(txtEditOnsetDate)

                Dim lbnUpdateOnsetDate As New LinkButton()
                lbnUpdateOnsetDate.Text = "Update onset date"

                lbnUpdateOnsetDate.CommandArgument = dtrReader("StatusID")

                AddHandler lbnUpdateOnsetDate.Command, AddressOf UpdateOnsetDate

                plhRepairList.Controls.Add(lbnUpdateOnsetDate)

                plhRepairList.Controls.Add(New LiteralControl("</div>"))



                plhRepairList.Controls.Add(New LiteralControl("<strong>Repair Time:</strong> " & dtrReader("RepairTime") & " <a href=""javascript:toggleDiv('divEditStatusRepairTime" & dtrReader("StatusID") & "');"">Edit repair time</a><br>"))

                'Status repair time Edit Div

                plhRepairList.Controls.Add(New LiteralControl("<div id='divEditStatusRepairTime" & dtrReader("StatusID") & "' style='display: none'>"))

                Dim txtEditStatusRepairTime As New TextBox()
                Try
                    txtEditStatusRepairTime.ID = "txtEditStatusRepairTime" & dtrReader("StatusID")
                Catch
                End Try
                Try
                    txtEditStatusRepairTime.Text = dtrReader("RepairTime")
                Catch
                End Try
                txtEditStatusRepairTime.CssClass="form-control"
                plhRepairList.Controls.Add(txtEditStatusRepairTime)

                Dim lbnUpdateStatusRepairTime As New LinkButton()
                lbnUpdateStatusRepairTime.Text = "Update repair time"

                lbnUpdateStatusRepairTime.CommandArgument = dtrReader("StatusID")
                AddHandler lbnUpdateStatusRepairTime.Command, AddressOf UpdateStatusRepairTime

                plhRepairList.Controls.Add(lbnUpdateStatusRepairTime)

                plhRepairList.Controls.Add(New LiteralControl("</div>"))


                plhRepairList.Controls.Add(New LiteralControl("<strong>Down Time:</strong> " & dtrReader("DownTime") & " <a href=""javascript:toggleDiv('divEditStatusDownTime" & dtrReader("StatusID") & "');"">Edit down time</a><br>"))

                'Status Downtime Edit Div

                plhRepairList.Controls.Add(New LiteralControl("<div id='divEditStatusDownTime" & dtrReader("StatusID") & "' style='display: none'>"))

                Dim txtEditStatusDownTime As New TextBox()
                Try
                    txtEditStatusDownTime.ID = "txtEditStatusDownTime" & dtrReader("StatusID")
                Catch
                End Try
                Try
                    txtEditStatusDownTime.Text = dtrReader("DownTime")
                Catch
                End Try
                txtEditStatusDownTime.CssClass="form-control"
                plhRepairList.Controls.Add(txtEditStatusDownTime)

                Dim lbnUpdateStatusDownTime As New LinkButton()
                lbnUpdateStatusDownTime.Text = "Update down time"

                lbnUpdateStatusDownTime.CommandArgument = dtrReader("StatusID")
                AddHandler lbnUpdateStatusDownTime.Command, AddressOf UpdateStatusDownTime

                plhRepairList.Controls.Add(lbnUpdateStatusDownTime)

                plhRepairList.Controls.Add(New LiteralControl("</div>"))


                plhRepairList.Controls.Add(New LiteralControl("<strong>Repair Notes:</strong> " & dtrReader("StatusNotes") & " <a href=""javascript:toggleDiv('divEditStatusNotes" & dtrReader("StatusID") & "');"">Edit status notes</a><br>"))

                plhRepairList.Controls.Add(New LiteralControl("<div id='divEditStatusNotes" & dtrReader("StatusID") & "' style='display: none'>"))

                Dim txtEditStatusNotes As New TextBox()
                txtEditStatusNotes.ID = "txtEditStatusNotes" & dtrReader("StatusID")

                Try
                    txtEditStatusNotes.Text = dtrReader("StatusNotes")
                Catch
                End Try
                txtEditStatusNotes.CssClass="form-control"
                plhRepairList.Controls.Add(txtEditStatusNotes)

                Dim lbnUpdateStatusNotes As New LinkButton()
                lbnUpdateStatusNotes.Text = "Update status notes"

                lbnUpdateStatusNotes.CommandArgument = dtrReader("StatusID")
                AddHandler lbnUpdateStatusNotes.Command, AddressOf UpdateStatusNotes

                plhRepairList.Controls.Add(lbnUpdateStatusNotes)

                plhRepairList.Controls.Add(New LiteralControl("</div>"))

                plhRepairList.Controls.Add(New LiteralControl("<strong>Photos of repair</strong><br>"))

                intPhotoCount = 1

                While File.Exists(Server.MapPath("images/Repair-" & dtrReader("StatusID") & "-" & intPhotoCount & "Thumb.jpg"))

                    plhRepairList.Controls.Add(New LiteralControl("<a href='photo.aspx?PhotoType=Repair&TypeID=" & dtrReader("StatusID") & "&PhotoNumber=" & intPhotoCount & "'>"))
                    plhRepairList.Controls.Add(New LiteralControl("<img src='images/Repair-" & dtrReader("StatusID") & "-" & intPhotoCount & "Thumb.jpg'>"))
                    plhRepairList.Controls.Add(New LiteralControl("</a>"))
                    intPhotoCount += 1

                End While

                plhRepairList.Controls.Add(New LiteralControl("<br><br><a href='upload.aspx?PhotoType=Repair&TypeID=" & dtrReader("StatusID") & "'>Add photos of repair id: " & dtrReader("StatusID") & "</a>"))




            End If

            intCount += 1

        End While

        plhMachineDetail.Controls.Add(New LiteralControl("</div>"))

        dtrReader.Close()

        conPeninsulaRVDb.Close()


        plhMachineDetail.Controls.Add(New LiteralControl("<div id='menu3' class='tab-pane fade'>"))
        plhMachineDetail.Controls.Add(New LiteralControl("<h3>Parts List Here</h3>"))
        plhMachineDetail.Controls.Add(New LiteralControl("</div>"))

        FillParts()

    End Sub

    Sub FillParts()

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SQLCommand("Select * from machinepartview where machineid = @MachineID and partid <> -1", conPeninsulaRVDb)
        cmdSelect.Parameters.Add("@MachineID",  hdnMachineID.Value)

        dtrReader = cmdSelect.ExecuteReader()


        Dim plhPartList As PlaceHolder

        plhPartlist = plhMachineDetail.FindControl("plhPartList")

        plhPartlist.Controls.Add(New LiteralControl("<h4>Parts List</h4>"))

        While dtrReader.Read()

            plhPartlist.Controls.Add(New LiteralControl("<h5><a href='part.aspx?PartID=" & dtrReader("PartID") & "'>" & dtrReader("PartName") & "</a></h5>"))

        End While

        plhPartlist.Controls.Add(New LiteralControl("<br><a href='linkpart.aspx?LinkType=Machine&LinkID=" & Request.QueryString("MachineID") & "'><h4>Link parts to this machine</h4></a>"))

    End Sub

    Sub UpdateMachineDescription(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditMachineDescription As New TextBox()

        txtEditMachineDescription = plhMachineDetail.FindControl("txtEditMachineDescription")

        strQuery = "Update Machine set Description = @Description where MachineID = @MachineID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Description",  txtEditMachineDescription.Text)
        cmdUpdate.Parameters.Add("@MachineID",  hdnMachineID.Value)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("machine.aspx?machineID=" & hdnMachineID.Value)

    End Sub

    Sub UpdateMachineNotes(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditMachineNotes As New TextBox()

        txtEditMachineNotes = plhMachineDetail.FindControl("txtEditMachineNotes")

        strQuery = "Update Machine set Notes = @Notes where MachineID = @MachineID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Notes",  txtEditMachineNotes.Text)
        cmdUpdate.Parameters.Add("@MachineID",  hdnMachineID.Value)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("machine.aspx?machineID=" & hdnMachineID.Value)

    End Sub

    Sub UpdateMachineName(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditMachineName As New TextBox()

        txtEditMachineName = plhMachineDetail.FindControl("txtEditMachineName")

        strQuery = "Update Machine set Name = @Name where MachineID = @MachineID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Name",  txtEditMachineName.Text)
        cmdUpdate.Parameters.Add("@MachineID",  hdnMachineID.Value)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("machine.aspx?machineID=" & hdnMachineID.Value)

    End Sub

    Sub UpdateStatusDownTime(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditStatusDownTime As New TextBox()

        txtEditStatusDownTime = plhMachineDetail.FindControl("txtEditStatusDownTime" & E.CommandArgument)

        Dim decDownTime As Decimal

        decDownTime = txtEditStatusDownTime.Text

        strQuery = "Update MachineStatus set DownTime = @DownTime where StatusID = @StatusID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@DownTime",  txtEditStatusDownTime.Text)
        cmdUpdate.Parameters.Add("@StatusID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("machine.aspx?machineID=" & hdnMachineID.Value)

    End Sub

    Sub UpdateStatusRepairTime(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditStatusRepairTime As New TextBox()

        txtEditStatusRepairTime = plhMachineDetail.FindControl("txtEditStatusRepairTime" & E.CommandArgument)

        Dim decRepairTime As Decimal

        decRepairTime = txtEditStatusRepairTime.Text

        strQuery = "Update MachineStatus set RepairTime = @RepairTime where StatusID = @StatusID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@RepairTime",  txtEditStatusRepairTime.Text)
        cmdUpdate.Parameters.Add("@StatusID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("machine.aspx?machineID=" & hdnMachineID.Value)

    End Sub

    Sub UpdateStatusNotes(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtEditStatusNotes As New TextBox()

        txtEditStatusNotes = plhMachineDetail.FindControl("txtEditStatusNotes" & E.CommandArgument)

        strQuery = "Update MachineStatus set Notes = @Notes where StatusID = @StatusID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Notes",  txtEditStatusNotes.Text)
        cmdUpdate.Parameters.Add("@StatusID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("machine.aspx?machineID=" & hdnMachineID.Value)

    End Sub

    Sub UpdateOnsetDate(Sender As Object, E As CommandEventArgs)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String

        Dim txtOnsetDate As New TextBox()

        txtOnsetDate = plhMachineDetail.FindControl("txtEditOnsetDate" & E.CommandArgument)

        Dim dtOnset As DateTime

        dtOnset = txtOnsetDate.Text

        strQuery = "Update MachineStatus set OnsetDate = @Onset where StatusID = @StatusID"

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Onset",  dtOnset)
        cmdUpdate.Parameters.Add("@StatusID",  E.CommandArgument)

        cmdUpdate.ExecuteNonQuery()

        conPeninsulaRVDb.Close()

        Response.Redirect("machine.aspx?machineID=" & hdnMachineID.Value)


    End Sub

    Sub Reload(Sender As Object, E As EventArgs)

        Response.Redirect("addMachine.aspx")

    End Sub

    Sub LogOut(Sender As Object, E As CommandEventArgs)

        Session.Clear()
        Response.Redirect("Login.aspx")


    End Sub


</script>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:Panel id="pnlMachineList" Runat="server">
        <div class="row">
            <div class="col-sm-12">
                <h4>Machine List</h4>
                <hr>
                <asp:PlaceHolder id="plhDepartmentList" runat="server"/>
            
                <asp:Repeater id="rptMachines" Runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <th>Department ID</th>
                                <th>Department Name</th>
                                <th>Machine ID</th>
                                <th>Machine Name</th>                                        
                                <th>Description</th>
                                <th>Notes</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# Container.DataItem("DepartmentID")%></%#>
                            </td>
                            <td>
                                <%# Container.DataItem("DepartmentName")%></%#>
                            </td>
                            <td>
                                <asp:LinkButton OnCommand="SelectMachine" CommandArgument='<%# Container.DataItem("MachineID")%>' runat="server">
                                    <%# Container.DataItem("MachineID")%></%#>
                                </asp:LinkButton>
                            </td>                                    
                            <td>
                                <asp:LinkButton OnCommand="SelectMachine" CommandArgument='<%# Container.DataItem("MachineID")%>' runat="server">
                                    <%# Container.DataItem("MachineName")%></%#>
                                </asp:LinkButton>
                            </td>                                    
                            <td>
                                <%# Container.DataItem("MachineDescription")%></%#>                                            
                            </td>
                            <td>
                                <%# Container.DataItem("MachineNotes")%></%#>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel id="pnlMachineDetail" Visible="False" runat="server">
                
        <asp:PlaceHolder id="plhMachineDetail" runat="server"/>
                
    </asp:Panel>
    <asp:Label id="lblSuccess" runat="server"/>
    
    <asp:HiddenField id="hdnMachineID" runat="server"/>
    
</asp:Content>