<%@ Page Title="Part" Language="VB" MasterPageFile="mervinmaster.master" AutoEventWireup="true" %>
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
                
        End If
        
        FillPartList()
    
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
    
    Sub FillPartList()
    
        Dim intPartID As Integer
        
        intPartID = -1
        
        If Request.QueryString("PartID") <> "" Then
        
            intPartID = Request.QueryString("PartID")
        
        End If
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        cmdSelect = New SQLCommand("Select * from partmachinesuppliershelfview order by partname, partid, machineid, supplierid", conPeninsulaRVDb)
        
        dtrReader = cmdSelect.ExecuteReader()
        
        plhPartList.Controls.Add(New LiteralControl("<div class=""panel-group"" id=""accordion"">"))
        
        Dim intPartCount, intMachineCount, intSupplierCount, intOldPartID, intNewPartID, intOldMachineID, intNewMachineID, intOldSupplierID, intNewSupplierID, intPhotoCount As Integer
        
        intPhotoCount = 1
        intPartCount = 1
        intMachineCount = 1
        intSupplierCount = 1
        intOldMachineID = 0
        intOldSupplierID = 0
        
        While dtrReader.Read()
        
            intNewPartID = dtrReader("PartID")
            intNewMachineID = dtrReader("MachineID")
            intNewSupplierID = dtrReader("SupplierID")
        
            If intOldPartID <> intNewPartID Then
            
                intNewMachineID = dtrReader("MachineID")
                intNewSupplierID = dtrReader("SupplierID")
                
                If intPartCount > 1 Then
                
                        plhPartList.Controls.Add(New LiteralControl("</div>"))
                    plhPartList.Controls.Add(New LiteralControl("</div>"))
                plhPartList.Controls.Add(New LiteralControl("</div>"))
                
                End If
            
                plhPartList.Controls.Add(New LiteralControl("<div class='panel panel-default'>"))
                    plhPartList.Controls.Add(New LiteralControl("<div class='panel-heading'>"))
                        plhPartList.Controls.Add(New LiteralControl("<h4 class='panel-title'>"))
                            plhPartList.Controls.Add(New LiteralControl("<a data-toggle='collapse' data-parent='#accordion' href='#collapse" & intPartCount & "'>"))
                                plhPartList.Controls.Add(New LiteralControl(dtrReader("PartName")))
                            plhPartList.Controls.Add(New LiteralControl("</a>"))  
                        plhPartList.Controls.Add(New LiteralControl("</h4>"))
                    plhPartList.Controls.Add(New LiteralControl("</div>"))
                    plhPartList.Controls.Add(New LiteralControl("<div id='collapse" & intPartCount & "' class='panel-collapse collapse"))
                    
                    If Request.QueryString("PartID") = dtrReader("PartID") Then
                    
                        plhPartList.Controls.Add(New LiteralControl(" in"))
                    
                    End If
                    
                    plhPartList.Controls.Add(New LiteralControl("'>"))
                        plhPartList.Controls.Add(New LiteralControl("<div class='panel-body'>"))
                        
                        
                            plhPartList.Controls.Add(New LiteralControl("<ul class='nav nav-tabs'>"))
                                
                                plhPartList.Controls.Add(New LiteralControl("<li class='active'><a data-toggle='tab' href='#home'>Part Info</a></li>"))                                
                                plhPartList.Controls.Add(New LiteralControl("<li><a data-toggle='tab' href='#menu1-" & dtrReader("PartID") & "'>Machines</a></li>"))
                                plhPartList.Controls.Add(New LiteralControl("<li><a data-toggle='tab' href='#menu2-" & dtrReader("PartID") & "'>Suppliers</a></li>"))
                                plhPartList.Controls.Add(New LiteralControl("<li><a data-toggle='tab' href='#menu3-" & dtrReader("PartID") & "'>Photos</a></li>"))
                                    
                            plhPartList.Controls.Add(New LiteralControl("</ul>"))
                            
                            plhPartList.Controls.Add(New LiteralControl("<div class='tab-content'>"))
                            
                                plhPartList.Controls.Add(New LiteralControl("<div id='home-" & dtrReader("PartID") & "' class='tab-pane fade in active'>"))
                                
                                    plhPartList.Controls.Add(New LiteralControl("<h3>Part Info</h3>"))
                                    
                                    plhPartList.Controls.Add(New LiteralControl("<strong>Part ID: </strong>" & dtrReader("PartID") & "<br>"))
                                    plhPartList.Controls.Add(New LiteralControl("<strong>Part Number: </strong>" & dtrReader("PartNumber") & "<a href=""javascript:toggleDiv('divEditPartNumber" & dtrReader("PartID") & "');"">Edit part number</a><br>"))
                                    
                                    plhPartList.Controls.Add(New LiteralControl("<div id='divEditPartNumber" & dtrReader("PartID") & "' style='display: none;'>"))
                                    
                                    'Edit PartNumber block
                                    Dim txtEditPartNumber As New TextBox()
                                    txtEditPartNumber.ID = "txtEditPartNumber" & dtrReader("PartID")                                    
                                    txtEditPartNumber.CssClass="form-control"
                                    txtEditPartNumber.Text = dtrReader("PartNumber")
                                    plhPartList.Controls.Add(txtEditPartNumber)
                                    Dim lbnEditPartNumber As New LinkButton()
                                    lbnEditPartNumber.Text = "Update part number"
                                    lbnEditPartNumber.CommandArgument = dtrReader("PartID")
                                    AddHandler lbnEditPartNumber.Command, AddressOf EditPartNumber
                                    plhPartList.Controls.Add(lbnEditPartNumber)
                                    plhPartList.Controls.Add(New LiteralControl("</div>"))
                                    
                                    
                                    
                                    plhPartList.Controls.Add(New LiteralControl("<strong>Description: </strong>" & dtrReader("PartDescription") & "<a href=""javascript:toggleDiv('divEditDescription" & dtrReader("PartID") & "');"">Edit description</a><br>"))
                                    
                                    plhPartList.Controls.Add(New LiteralControl("<div id='divEditDescription" & dtrReader("PartID") & "' style='display: none;'>"))
                                    
                                    'Edit Description block
                                    Dim txtEditDescription As New TextBox()
                                    txtEditDescription.ID = "txtEditDescription" & dtrReader("PartID")                                    
                                    txtEditDescription.CssClass="form-control"
                                    txtEditDescription.Text = dtrReader("PartDescription")
                                    plhPartList.Controls.Add(txtEditDescription)
                                    Dim lbnEditDescription As New LinkButton()
                                    lbnEditDescription.Text = "Update description"
                                    lbnEditDescription.CommandArgument = dtrReader("PartID")
                                    AddHandler lbnEditDescription.Command, AddressOf EditDescription
                                    plhPartList.Controls.Add(lbnEditDescription)
                                    plhPartList.Controls.Add(New LiteralControl("</div>"))
                                    
                                    
                                    plhPartList.Controls.Add(New LiteralControl("<strong>Shelf: </strong>" & dtrReader("ShelfName") & " - " & dtrReader("Location") & " <a href='linkpart.aspx?LinkType=Shelf'>Change shelf location</a><br>"))
                                    
                                plhPartList.Controls.Add(New LiteralControl("</div>"))
                                
                                plhPartList.Controls.Add(New LiteralControl("<div id='menu1-" & dtrReader("PartID") & "' class='tab-pane fade'>"))
                                
                                    plhPartList.Controls.Add(New LiteralControl("<h3>Machines</h3>"))
                                    Dim plhMachineList As New PlaceHolder()
                                    plhMachineList.ID = "plhMachineList" & dtrReader("PartID")
                                    plhPartList.Controls.Add(plhMachineList)
                                    
                                plhPartList.Controls.Add(New LiteralControl("</div>"))
                                
                                plhPartList.Controls.Add(New LiteralControl("<div id='menu2-" & dtrReader("PartID") & "' class='tab-pane fade'>"))
                                
                                    plhPartList.Controls.Add(New LiteralControl("<h3>Suppliers</h3>"))
                                    Dim plhSupplierList As New PlaceHolder()
                                    plhSupplierList.ID = "plhSupplierList" & dtrReader("PartID")
                                    plhPartList.Controls.Add(plhSupplierList)
                                    
                                plhPartList.Controls.Add(New LiteralControl("</div>"))
                                
                                plhPartList.Controls.Add(New LiteralControl("<div id='menu3-" & dtrReader("PartID") & "' class='tab-pane fade'>"))
                                
                                    plhPartList.Controls.Add(New LiteralControl("<h3>Photos</h3>"))
                                    
                                    While File.Exists(Server.MapPath("images/Part-" & dtrReader("PartID") & "-" & intPhotoCount & "thumb.jpg"))
                    
                                        plhPartList.Controls.Add(New LiteralControl("<a href='photo.aspx?PhotoType=Part&TypeID=" & dtrReader("PartID") & "&PhotoNumber=" & intPhotoCount & "'>"))
                                        plhPartList.Controls.Add(New LiteralControl("<img src='images/Part-" & dtrReader("PartID") & "-" & intPhotoCount & "Thumb.jpg'>"))
                                        plhPartList.Controls.Add(New LiteralControl("</a>"))
                                        intPhotoCount += 1
                                        
                                    End While
                                    
                                     plhPartList.Controls.Add(New LiteralControl("<br>"))                                    
                                    
                                    plhPartList.Controls.Add(New LiteralControl("<a href='upload.aspx?PhotoType=Part&TypeID=" & dtrReader("PartID") & "'>Upload photos of " & dtrReader("PartName") & "</a>"))
                                                                        
                                plhPartList.Controls.Add(New LiteralControl("</div>"))
                                
                            plhPartList.Controls.Add(New LiteralControl("</div>"))
                            
                            
            Else
            
                  
            
            End If 
            
            If intNewMachineID > intOldMachineID Then
                
                Dim plhMachineList As New PlaceHolder()
                plhMachineList = plhPartList.FindControl("plhMachineList" & dtrReader("PartID"))
                plhMachineList.Controls.Add(New LiteralControl("<a href='machine.aspx?MachineID=" & dtrReader("MachineID") & "'><h5>" & dtrReader("MachineName") & "</h5></a>"))
                intOldMachineID = intNewMachineID
                
            End If
                            
            If intNewSupplierID > intOldSupplierID Then
            
                Dim plhSupplierList As New PlaceHolder()
                plhSupplierList = plhPartList.FindControl("plhSupplierList" & dtrReader("PartID"))
                plhSupplierList.Controls.Add(New LiteralControl("<a href='Supplier.aspx?SupplierID=" & dtrReader("SupplierID") & "'><h5>" & dtrReader("SupplierName") & "</h5></a>"))
                intOldSupplierID = intNewSupplierID
                
            End If      
            
            
                            
            intOldPartID = intNewPartID            
            
            intPartCount += 1            
        
        End While
        
                        plhPartList.Controls.Add(New LiteralControl("</div>"))
                    plhPartList.Controls.Add(New LiteralControl("</div>"))
                plhPartList.Controls.Add(New LiteralControl("</div>"))
        
        plhPartList.Controls.Add(New LiteralControl("</div>")) 'close accordion
                
        dtrReader.Close()        
        
        conPeninsulaRVDb.Close()  
        
        'FillPartPartsList()
        
    End Sub
    
    Sub EditPartNumber1(Sender As Object, E As CommandEventArgs)
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String
        
        Dim txtEditPartNumber As New TextBox()
        
        txtEditPartNumber = plhPartList.FindControl("txtEditPartNumber" & E.CommandArgument)
        
        strQuery = "Update MervinPart set PartNumber = @PartNumber where PartID = @PartNumberID"
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@PartNumber",  txtEditPartNumber.Text)
        cmdUpdate.Parameters.Add("@SupplierID",  E.CommandArgument)
        
        cmdUpdate.ExecuteNonQuery()
        
        conPeninsulaRVDb.Close()
        
        Response.Redirect("Part.aspx?PartID=" & E.CommandArgument)
    
    End Sub
    
    Sub EditDescription1(Sender As Object, E As CommandEventArgs)
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String
        
        Dim txtEditDescription As New TextBox()
        
        txtEditDescription = plhPartList.FindControl("txtEditDescription" & E.CommandArgument)
        
        strQuery = "Update MervinPart set Description = @Description where PartID = @PartNumberID"
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Description",  txtEditDescription.Text)
        cmdUpdate.Parameters.Add("@SupplierID",  E.CommandArgument)
        
        cmdUpdate.ExecuteNonQuery()
        
        conPeninsulaRVDb.Close()
        
        Response.Redirect("Part.aspx?PartID=" & E.CommandArgument)
    
    End Sub
    
    Sub FillPartPartsList()
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrReader As SqlDataReader
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        cmdSelect = New SQLCommand("Select * from MervinPartPartShelfView", conPeninsulaRVDb)
        
        dtrReader = cmdSelect.ExecuteReader()
        
        Dim strOldPartID, strNewPartID As String
        
        Dim plhPartsList As New PlaceHolder()
        
        While dtrReader.Read()
        
            strNewPartID = dtrReader("PartID")    
        
            If strNewPartID <> strOldPartID Then
            
                plhPartsList = plhPartList.FindControl("plhPartsList" & dtrReader("PartID"))
            
            End If
    
            plhPartsList.Controls.Add(New LiteralControl("<br>" & dtrReader("PartID") & " " & dtrReader("PartName") & " " & dtrReader("Description")))
            
            strOldPartID = strNewPartID 
            
        End While
    
    End Sub
    
    Sub EditPartNumber(Sender As Object, E As CommandEventArgs)
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String
        
        Dim txtEditPartNumber As New TextBox()
        
        txtEditPartNumber = plhPartList.FindControl("txtEditPartNumber" & E.CommandArgument)
        
        strQuery = "Update MervinPart set PartNumber = @PartNumber where PartID = @PartID"
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@PartNumber",  txtEditPartNumber.Text)
        cmdUpdate.Parameters.Add("@PartID",  E.CommandArgument)
        
        cmdUpdate.ExecuteNonQuery()
        
        conPeninsulaRVDb.Close()
        
        Response.Redirect("Part.aspx?PartID=" & E.CommandArgument)
    
    End Sub
    
    Sub EditDescription(Sender As Object, E As CommandEventArgs)
    
        Dim conPeninsulaRVDb As SqlConnection
        Dim cmdUpdate As SqlCommand
        Dim strQuery As String
        
        Dim txtEditDescription As New TextBox()
        
        txtEditDescription = plhPartList.FindControl("txtEditDescription" & E.CommandArgument)
        
        strQuery = "Update MervinPart set Description = @Description where PartID = @PartID"
        
        conPeninsulaRVDb = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        conPeninsulaRVDb.Open()
        
        cmdUpdate = New SQLCommand(strQuery, conPeninsulaRVDb)
        cmdUpdate.Parameters.Add("@Description",  txtEditDescription.Text)
        cmdUpdate.Parameters.Add("@PartID",  E.CommandArgument)
        
        cmdUpdate.ExecuteNonQuery()
        
        conPeninsulaRVDb.Close()
        
        Response.Redirect("Part.aspx?PartID=" & E.CommandArgument)
    
    End Sub
    
    
    
    Sub Reload(Sender As Object, E As EventArgs)    
    
        Response.Redirect("Part.aspx")
    
    End Sub
    
    Sub LogOut(Sender As Object, E As CommandEventArgs)
    
        Session.Clear()
        Response.Redirect("Login.aspx")
            
    End Sub
    
    
</script>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
                
    <asp:Panel id="pnlPartList" runat="server">
                
        <asp:PlaceHolder ID="plhPartList" Runat="server"/>
                
    </asp:Panel>
                
                
    <asp:Panel id="pnlSuccess" Visible="False" runat="Server">
                    
        <div class="row">
                        
            <div class="col-sm-12">
                            
                <asp:Label id="lblSuccess" Runat="server"/><br>
                            
            </div>
                        
        </div>
                    
    </asp:Panel>
                
    <asp:HiddenField id="hdnPartID" runat="server"/>
            
    <br>
    <asp:Label id="lblTest" Runat="server"/>
    <br>
    
</asp:Content>