<%@ Page Title="Link Part" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
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

        If Request.QueryString("LinkType") <> "" Then

            If Request.QueryString("LinkType") = "Machine" Then

                If Request.QueryString("LinkID") <> "" Then

                    If Not IsPostBack Then
                        FillID()
                    End If

                Else

                    FillMachine()

                End If

            ElseIf Request.QueryString("LinkType") = "Supplier" Then

                If Request.QueryString("LinkID") <> "" Then

                    If Not IsPostBack Then
                        FillID()
                    End If

                Else

                    FillSupplier()

                End If

            ElseIf Request.QueryString("LinkType") = "Shelf" Then

                If Request.QueryString("LinkID") <> "" Then

                    If Not IsPostBack Then
                        FillID()
                    End If

                Else

                    FillShelf()

                End If

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

    Sub FillMachine()

        Dim conDefaultDb As SqlConnection
        Dim dtaSelect As SqlDataAdapter
        Dim dtsSet1 As New DataSet()
        Dim strRole, strQuery As String
        Dim intID As Integer

        conDefaultDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conDefaultDb.Open()

        strQuery = "Select machineid, departmentname + ' - ' + machinename as info from DepartmentMachineView order by departmentname, machinename"

        dtaSelect = New SQLDataAdapter(strQuery, conDefaultDb)

        dtaSelect.Fill(dtsSet1)

        rblMachine.DataSource = dtsSet1
        rblMachine.DataValueField = "MachineID"
        rblMachine.DataTextField = "Info"
        rblMachine.DataBind()

        conDefaultDb.Close()

        pnlMachine.Visible="True"
        pnlSelectLink.Visible="False"

    End Sub

    Sub FillSupplier()

        Dim conDefaultDb As SqlConnection
        Dim dtaSelect As SqlDataAdapter
        Dim dtsSet1 As New DataSet()
        Dim strRole, strQuery As String
        Dim intID As Integer

        conDefaultDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conDefaultDb.Open()

        strQuery = "Select supplierid, name from Supplier"

        dtaSelect = New SQLDataAdapter(strQuery, conDefaultDb)

        dtaSelect.Fill(dtsSet1)

        rblSupplier.DataSource = dtsSet1
        rblSupplier.DataValueField = "SupplierID"
        rblSupplier.DataTextField = "Name"
        rblSupplier.DataBind()

        conDefaultDb.Close()

        pnlSupplier.Visible="True"
        pnlSelectLink.Visible="False"

    End Sub

    Sub FillShelf()

        Dim conDefaultDb As SqlConnection
        Dim dtaSelect As SqlDataAdapter
        Dim dtsSet1 As New DataSet()
        Dim strRole, strQuery As String
        Dim intID As Integer

        conDefaultDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conDefaultDb.Open()

        strQuery = "Select shelfid, name + ' - ' + location as info from Shelf"

        dtaSelect = New SQLDataAdapter(strQuery, conDefaultDb)

        dtaSelect.Fill(dtsSet1)

        rblShelf.DataSource = dtsSet1
        rblShelf.DataValueField = "ShelfID"
        rblShelf.DataTextField = "Info"
        rblShelf.DataBind()

        conDefaultDb.Close()

        pnlShelf.Visible="True"
        pnlSelectLink.Visible="False"

    End Sub


    Sub FillPart()

        Dim conDefaultDb As SqlConnection
        Dim dtaSelect As SqlDataAdapter
        Dim dtsSet1 As New DataSet()
        Dim strRole, strQuery As String
        Dim intID As Integer

        conDefaultDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conDefaultDb.Open()

        strQuery = "Select partid, name + ' - ' + partnumber + ' - ' + description as info from mervinpart order by name"

        dtaSelect = New SQLDataAdapter(strQuery, conDefaultDb)

        dtaSelect.Fill(dtsSet1)

        cblPart.DataSource = dtsSet1
        cblPart.DataValueField = "PartID"
        cblPart.DataTextField = "Info"
        cblPart.DataBind()

        conDefaultDb.Close()

        FillChecks()


    End Sub

    Sub SelectMachine(Sender As Object, E As CommandEventArgs)

        FillMachine()

    End Sub

    Sub SelectSupplier(Sender As Object, E As CommandEventArgs)

        FillSupplier()

    End Sub

    Sub SelectShelf(Sender As Object, E As CommandEventArgs)

        FillShelf()

    End Sub

    Sub FillID()

        pnlSelectLink.Visible = "False"
        hdnLinkType.Value = Request.QueryString("LinkType")
        hdnLinkID.Value = Request.QueryString("LinkID")
        pnlPartList.Visible="True"
        FillPart()
        lblPartHeader.Text = GetLinkName(Request.QueryString("LinkID"), Request.QueryString("LinkType"))

    End Sub

    Function GetLinkName(intID As Integer, strType As String)

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim strQuery, strResult As String

        strResult = " "

        If strType = "Machine" Then

            strQuery = "Select departmentName + ' - ' + machinename from departmentmachineview where machineid = " & intID

        ElseIf strType = "Supplier" Then

            strQuery = "Select name from supplier where supplierid = " & intID

        ElseIf strType = "Shelf" Then

            strQuery = "Select Name + ' - ' + location from shelf where shelfid = " & intID

        End If

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        cmdSelect = New SQLCommand(strQuery, conPeninsulaRVDb)

        Try
            strResult = cmdSelect.ExecuteScalar()
        Catch
        End Try

        Return strResult

        conPeninsulaRVDb.Close()

    End Function

    Sub SelectMachineID(Sender As Object, E As EventArgs)

        hdnLinkType.Value = "Machine"
        hdnLinkID.Value = rblMachine.SelectedItem.Value
        pnlMachine.Visible="False"
        pnlPartList.Visible="True"
        FillPart()
        lblPartHeader.Text = rblMachine.SelectedItem.Text

    End Sub

    Sub SelectSupplierID(Sender As Object, E As EventArgs)

        hdnLinkType.Value = "Supplier"
        hdnLinkID.Value = rblsupplier.SelectedItem.Value
        pnlSupplier.Visible="False"
        pnlPartList.Visible="True"
        FillPart()
        lblPartHeader.Text = rblSupplier.SelectedItem.Text

    End Sub

    Sub SelectShelfID(Sender As Object, E As EventArgs)

        hdnLinkType.Value = "Shelf"
        hdnLinkID.Value = rblShelf.SelectedItem.Value
        pnlshelf.Visible="False"
        pnlPartList.Visible="True"
        FillPart()
        lblPartHeader.Text = rblshelf.SelectedItem.Text

    End Sub

    Sub LinkParts(Sender As Object, E As EventArgs)

        For Each itm As ListItem in cblPart.Items

            If itm.Selected = "True" Then

                AddLink(itm.Value)
                lblSuccess.Text &= "<h5>" & itm.Text & "</h5>"

            Else

                DeleteLink(itm.Value)

            End If

        Next

        pnlPartList.Visible="False"
        pnlSuccess.Visible="True"

        lblSuccessType.Text = lblPartHeader.Text



    End Sub

    Function IsLinked(intID As Integer)

        If hdnLinkType.Value = "Shelf" Then

            Return False

        Else

            Dim conPeninsulaRVDb As SqlConnection
            Dim cmdSelect As SqlCommand
            Dim dtrReader As SqlDataReader
            Dim strQuery As String
            Dim boolRows As Boolean

            strQuery = "Select * from " & hdnLinkType.Value & "Part where " & hdnLinkType.Value & "Ref = " & hdnLinkID.Value & " and PartRef = " & intID

            conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

            conPeninsulaRVDb.Open()

            cmdSelect = New SQLCommand(strQuery, conPeninsulaRVDb)

            dtrReader = cmdSelect.ExecuteReader()

            If dtrReader.HasRows() Then

                boolRows = "True"

            Else

                boolRows = "False"

            End If

            Return boolRows

            conPeninsulaRVDb.Close()

        End If

    End Function

    Sub AddLink(intID As Integer)

        If Not IsLinked(intID) Then

            Dim conPeninsulaRVDb As SqlConnection
            Dim cmdInsert As SqlCommand
            Dim strQuery As String

            If hdnLinkType.Value = "Shelf" Then
                strQuery = "Update MervinPart set shelfref = @LinkRef where PartID = @PartRef"
            Else
                strQuery = "Insert into " & hdnLinkType.Value & "Part (" & hdnLinkType.Value & "Ref, PartRef) values(@LinkRef, @PartRef)"
            End If

            conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

            conPeninsulaRVDb.Open()

            cmdInsert = New SQLCommand(strQuery, conPeninsulaRVDb)
            cmdInsert.Parameters.Add("@LinkRef",  hdnLinkID.Value)
            cmdInsert.Parameters.Add("@PartRef",  intID)

            cmdInsert.ExecuteNonQuery()

            conPeninsulaRVDb.Close()

        End If

    End Sub

    Sub DeleteLink(intID As Integer)

        If hdnLinkType.Value <> "Shelf" Then

            Dim conPeninsulaRVDb As SqlConnection
            Dim cmdInsert As SqlCommand
            Dim strQuery As String

            strQuery = "Delete from " & hdnLinkType.Value & "Part where " & hdnLinkType.Value & "Ref = @LinkRef and PartRef = @PartRef"

            conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

            conPeninsulaRVDb.Open()

            cmdInsert = New SQLCommand(strQuery, conPeninsulaRVDb)
            cmdInsert.Parameters.Add("@LinkRef",  hdnLinkID.Value)
            cmdInsert.Parameters.Add("@PartRef",  intID)

            cmdInsert.ExecuteNonQuery()

            conPeninsulaRVDb.Close()

        End If

    End Sub

    Sub FillChecks()

        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader

        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()

        If hdnLinkType.Value = "Shelf" Then
            cmdSelect = New SQLCommand("Select ShelfRef As PartRef from MervinPart where " & hdnLinkType.Value & "Ref = @LinkID" , conPeninsulaRVDb)
        Else
            cmdSelect = New SQLCommand("Select * from " & hdnLinkType.Value & "Part where " & hdnLinkType.Value & "Ref = @LinkID" , conPeninsulaRVDb)
        End If
        cmdSelect.Parameters.Add("@LinkID",  hdnLinkID.Value)

        dtrReader = cmdSelect.ExecuteReader()

        While dtrReader.Read()

            For Each itm As ListItem in cblPart.Items

                If dtrReader("PartRef") = itm.Value Then

                    itm.Selected = "True"

                End If

            Next

        End While

        conPeninsulaRVDb.Close()

    End Sub

    Sub Reload(Sender As Object, E As EventArgs)

        Response.Redirect("linkpart.aspx")

    End Sub

    Sub LogOut(Sender As Object, E As CommandEventArgs)

        Session.Clear()
        Response.Redirect("Login.aspx")


    End Sub


</script>
    
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:Panel id="pnlSelectLink" runat="server">
        <h3>Link parts to:</h3>
        <asp:LinkButton OnCOmmand="SelectMachine" runat="server">Machine</asp:LinkButton><br>
        <asp:LinkButton OnCOmmand="SelectSupplier" runat="server">Supplier</asp:LinkButton><br>
        <asp:LinkButton OnCOmmand="SelectShelf" runat="server">Shelf</asp:LinkButton>
    </asp:Panel>
                
    <asp:Panel id="pnlMachine" Visible="False" runat="server">
        <h3>Select machine to link parts</h3>
        <asp:RadioButtonList id="rblMachine" runat="server"/>
        <asp:Button OnClick="SelectMachineID" Text="Select Machine" CssClass="btn btn-default" Runat="server"/>
    </asp:Panel>
                
    <asp:Panel id="pnlSupplier" Visible="False" runat="server">
        <h3>Select supplier to link parts</h3>
        <asp:RadioButtonList id="rblSupplier" runat="server"/>
        <asp:Button OnClick="SelectSupplierID" Text="Select Supplier" CssClass="btn btn-default" Runat="server"/>
    </asp:Panel>
                
    <asp:Panel id="pnlShelf" Visible="False" runat="server">
        <h3>Select shelf to link parts</h3>
        <asp:RadioButtonList id="rblShelf" runat="server"/>
        <asp:Button OnClick="SelectShelfID" Text="Select Shelf" CssClass="btn btn-default" Runat="server"/>
    </asp:Panel>
                
    <asp:Panel id="pnlPartList" Visible="False" runat="server">
        <h3>Select parts to link to <asp:Label id="lblPartHeader" runat="server"/></h3>
        <asp:CheckBoxList id="cblPart" runat="server"/>
        <asp:Button Text="Link Parts" OnClick="LinkParts" CssClass="btn btn-default" runat="server"/>
    </asp:Panel>
    
    <asp:Panel id="pnlSuccess" Visible="false" runat="server">
        <h3>Part links for <asp:Label id="lblSuccessType" runat="server"/> set to:</h3>
        <asp:Label id="lblSuccess" Runat="server"/>
    </asp:Panel>
    
    <asp:HiddenField id="hdnLinkType" runat="server"/>
    <asp:HiddenField id="hdnLinkID" runat="server"/>
    <br><br>
    
</asp:Content>