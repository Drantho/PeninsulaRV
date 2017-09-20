<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostSaleView.aspx.cs" Inherits="PeninsulaRV.secure.PostSaleView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><asp:Label ID="lblTest" runat="server" /></h1>
    <asp:Panel ID="pnlSelectMonth" runat="server">
        <div class="row">
            <div class="col-sm-4">
                <asp:RadioButtonList ID="rblMonth" runat="server">
                    <asp:ListItem Value="1">January</asp:ListItem>
                    <asp:ListItem Value="2">February</asp:ListItem>
                    <asp:ListItem Value="3">March</asp:ListItem>
                    <asp:ListItem Value="4">April</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">June</asp:ListItem>
                    <asp:ListItem Value="7">July</asp:ListItem>
                    <asp:ListItem Value="8">August</asp:ListItem>
                    <asp:ListItem Value="9">September</asp:ListItem>
                    <asp:ListItem Value="10">October</asp:ListItem>
                    <asp:ListItem Value="11">November</asp:ListItem>
                    <asp:ListItem Value="12">December</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div class="col-sm-4">
                <asp:RadioButtonList ID="rblYear" runat="server" />
            </div>
        </div>
        <div class="row">
            <div class="col-sm-4">
                <asp:Button Text="Select Month" OnClick="SelectMonth" CssClass="btn btn-default" runat="server" />
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlOfferList" runat="server">
        <asp:Repeater ID="rptOfferList" runat="server">
            <HeaderTemplate>
                <div class="row">
                    <div class="col-sm-2">
                        <strong>OfferID</strong>
                    </div>
                    <div class="col-sm-2">
                        <strong>Vehicle</strong>
                    </div>
                    <div class="col-sm-2">
                        <strong>Seller</strong>
                    </div>
                    <div class="col-sm-2">
                        <strong>Buyer</strong>
                    </div>
                    <div class="col-sm-2">
                        <strong>Sale Date</strong>
                    </div>
                    <div class="col-sm-2">
                        <strong>Post Sale Steps</strong>
                    </div>
                </div>
            </HeaderTemplate>
            <ItemTemplate>
                <div class="row">
                    <div class="col-sm-2">
                        <asp:LinkButton OnCommand="SelectVehicle" CommandArgument='<%# Eval("OfferID")%>' runat="server"><%# Eval("OfferID")%></asp:LinkButton>
                    </div>
                    <div class="col-sm-2">
                        <%# Eval("ModelYear")%> <%# Eval("Make")%> <%# Eval("Model")%>
                    </div>
                    <div class="col-sm-2">
                        <%# Eval("SellerName")%>
                    </div>
                    <div class="col-sm-2">
                        <%# Eval("BuyerName")%>
                    </div>
                    <div class="col-sm-2">
                        <%# Eval("SaleDate", "{0:MM/dd/yy}")%>
                    </div>
                    <div class="col-sm-2">
                        <%# Eval("PostSaleSteps")%>
                    </div>
                </div>

            </ItemTemplate>
            <FooterTemplate>
            </FooterTemplate>
        </asp:Repeater>
    </asp:Panel>
    <asp:Panel ID="pnlOfferView" runat="server">

        <div class="row">
            <div class="col-sm-4">
                <h2>Vehicle</h2>
                <asp:Label ID="lblSaleInfo" runat="server" />

            </div>
            <div class="col-sm-8">
                <h2>1. Deposit Funds</h2>
                <strong>Deposit Amount: </strong>
                <asp:Label ID="lblDepositAmount" runat="server" /><br />
                <strong>Deposit Date: </strong>
                <asp:Label ID="lblDepositDate" runat="server" /><br />
                <strong>Notes: </strong>
                <asp:Label ID="lblDepositNotes" runat="server" /><br />
                <asp:Panel ID="pnl1Edit" runat="server">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtDepositDate" CssClass="col-md-2 control-label">Deposit Date</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtDepositDate" TextMode="Date" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDepositDate"
                                CssClass="text-danger" ValidationGroup="DepositFunds" ErrorMessage="The deposit date field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtDepositNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtDepositNotes" TextMode="Multiline" CssClass="form-control" />
                        </div>
                    </div>
                    <asp:Button Text="Complete Step" CssClass="btn btn-default" runat="server" />
                </asp:Panel>

                <h2>2. Pay Lienholder</h2>
                <strong>Lienholder: </strong>
                <asp:Label ID="lblLienHolder" runat="server" /><br />
                <strong>Payoff: </strong>
                <asp:Label ID="lblPayoff" runat="server" /><br />
                <strong>Lienholder paid: </strong>
                <asp:Label ID="lblLienholderPaid" runat="server" /><br /> 
                <strong>Payoff due: </strong>
                <asp:Label ID="lblPayoffDue" runat="server" /><br />                
                <strong>Notes: </strong>
                <asp:Label ID="lblLienHolderNotes" runat="server" /><br />
                <asp:Panel ID="pnlEditLienHolder" runat="server">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPayoff" CssClass="col-md-2 control-label">Payoff Amount</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtPayoff" TextMode="Number" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPayoff"
                                CssClass="text-danger" ValidationGroup="LienHolder" ErrorMessage="The payoff field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPayoffDate" CssClass="col-md-2 control-label">Payoff Date</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtPayoffDate" TextMode="Date" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPayoffDate"
                                CssClass="text-danger" ValidationGroup="LienHolder" ErrorMessage="The payoff date field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtLienholderNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtLienholderNotes" TextMode="Multiline" CssClass="form-control" />
                        </div>
                    </div>
                    <asp:Button Text="Complete Step" CssClass="btn btn-default" runat="server" />
                </asp:Panel>



                <h2>3. Negotiate Commission</h2>
                <strong>Commission Type: </strong>
                <asp:Label ID="lblCommissionType" runat="server" /><br />                
                <asp:Label ID="lblCommissionCalc" runat="server" /><br />
                <strong>Notes: </strong>
                <asp:Label ID="lblCommissionNotes" runat="server" /><br />
                <asp:Panel ID="pnlEditCommission" runat="server">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="rblCommissionType" CssClass="col-md-2 control-label">Commission Type</asp:Label>
                        <div class="col-md-10">
                            <asp:RadioButtonList ID="rblCommissionType" runat="server">
                                <asp:ListItem>Percent Deal</asp:ListItem>
                                <asp:ListItem>Excess of Deal</asp:ListItem>
                                <asp:ListItem>Flat Fee Deal</asp:ListItem>
                            </asp:RadioButtonList>                             
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtCommissionCalc" CssClass="col-md-2 control-label">Commission Calc</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtCommissionCalc" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCommissionCalc"
                                CssClass="text-danger" ValidationGroup="NegotiateCommission" ErrorMessage="The commission calc date field is required." />
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtCommissionNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtCommissionNotes" TextMode="Multiline" CssClass="form-control" />
                        </div>
                    </div>
                    <asp:Button Text="Complete Step" CssClass="btn btn-default" runat="server" />
                </asp:Panel>


                <h2>4. Get Owner Payoff</h2>
                <strong>Consignor Amount: </strong>
                <asp:Label ID="lblConsignorDue" runat="server" /><br /> 
                <strong>Seller Paid Fee: </strong>               
                <asp:Label ID="lblSellerPaidFee" runat="server" /><br />
                <strong>Notes: </strong>
                <asp:Label ID="lblGetOwnerPayoffNotes" runat="server" /><br />
                <asp:Panel ID="pnlConsignorPaid" runat="server">                    

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtSellerPaidFee" CssClass="col-md-2 control-label">Seller Paid Fee</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtSellerPaidFee" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSellerPaidFee"
                                CssClass="text-danger" ValidationGroup="GetOwnerPayoff" ErrorMessage="The seller paid fee field is required." />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtConsignorNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtConsignorNotes" TextMode="Multiline" CssClass="form-control" />
                        </div>
                    </div>
                    <asp:Button Text="Complete Step" CssClass="btn btn-default" runat="server" />
                </asp:Panel>







                <h2>5. Pay Consignor</h2>
                <strong>Consignor Due: </strong>
                <asp:Label ID="Label1" runat="server" /><br /> 
                <strong>Consignor Paid Date: </strong>               
                <asp:Label ID="Label2" runat="server" /><br />
                <strong>Notes: </strong>
                <asp:Label ID="Label3" runat="server" /><br />
                <asp:Panel ID="Panel1" runat="server">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtConsignorPaidDate" CssClass="col-md-2 control-label">Consignor Paid Date</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox ID="txtConsignorPaidDate" CssClass="form-control" TextMode="Date" runat="server" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConsignorPaidDate"
                                CssClass="text-danger" ValidationGroup="PayConsignor" ErrorMessage="The consignor paid date field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPayConsignorNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtPayConsignorNotes" TextMode="Multiline" CssClass="form-control" />
                        </div>
                    </div>
                    <asp:Button Text="Complete Step" CssClass="btn btn-default" runat="server" />
                </asp:Panel>







                <h2>6. Transfer Funds</h2>
                <strong>Amount to Transfer: </strong>
                <asp:Label ID="lblTransferAmount" runat="server" /><br /> 
                <strong>Transfer Date: </strong>               
                <asp:Label ID="lblTransferDate" runat="server" /><br />
                <strong>Notes: </strong>
                <asp:Label ID="lblTransferFundsNotes" runat="server" /><br />
                <asp:Panel ID="pnlEditTransferFunds" runat="server">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtTransferFundsDate" CssClass="col-md-2 control-label">Transfer Date</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox ID="txtTransferFundsDate" CssClass="form-control" TextMode="Number" runat="server" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTransferFundsDate"
                                CssClass="text-danger" ValidationGroup="TransferFunds" ErrorMessage="The transfer funds date field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtTransferFundsNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtTransferFundsNotes" TextMode="Multiline" CssClass="form-control" />
                        </div>
                    </div>
                    <asp:Button Text="Complete Step" CssClass="btn btn-default" runat="server" />
                </asp:Panel>








                <h2>7. License Vehicle</h2>
                <strong>License Date: </strong>
                <asp:Label ID="lblLicenseDate" runat="server" /><br /> 
                <strong>License Cost: </strong>
                <asp:Label ID="lblLicenseCost" runat="server" /><br /> 
                <strong>Notes: </strong>
                <asp:Label ID="lblLicenseVehicleNotes" runat="server" /><br />
                <asp:Panel ID="pnlLicenseVehicle" runat="server">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtLicenseVehicleDate" CssClass="col-md-2 control-label">License Vehicle Date</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox ID="txtLicenseVehicleDate" CssClass="form-control" TextMode="Date" runat="server" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLicenseVehicleDate"
                                CssClass="text-danger" ValidationGroup="LicenseVehicle" ErrorMessage="The license vehicle date field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtLicenseCost" CssClass="col-md-2 control-label">License Cost</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox ID="txtLicenseCost" CssClass="form-control" TextMode="Number" runat="server" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLicenseCost"
                                CssClass="text-danger" ValidationGroup="LicenseVehicle" ErrorMessage="The license cost field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtLicenseVehicleNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtLicenseVehicleNotes" TextMode="Multiline" CssClass="form-control" />
                        </div>
                    </div>
                    <asp:Button Text="Complete Step" CssClass="btn btn-default" runat="server" />
                </asp:Panel>






                <h2>8. Send Licensing</h2>
                <strong>License Sent Date: </strong>
                <asp:Label ID="lblLicenseSentDate" runat="server" /><br /> 
                <strong>License Fee Collected: </strong>
                <asp:Label ID="lblLicenseFeeCollected" runat="server" /><br /> 
                <strong>License Cost: </strong>
                <asp:Label ID="lblLicenseCost2" runat="server" /><br /> 
                <strong>Difference: </strong>
                <asp:Label ID="lblLicenseDifference" runat="server" /><br /> 
                <strong>Notes: </strong>
                <asp:Label ID="lblSendLicensingNotes" runat="server" /><br />
                <asp:Panel ID="pnlSendLicensing" runat="server">

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtSendLicenseDate" CssClass="col-md-2 control-label">License Sent Date</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox ID="txtSendLicenseDate" CssClass="form-control" TextMode="Date" runat="server" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSendLicenseDate"
                                CssClass="text-danger" ValidationGroup="SendLicense" ErrorMessage="The send license date field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtSendLicenseNotes" CssClass="col-md-2 control-label">Notes</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtSendLicenseNotes" TextMode="Multiline" CssClass="form-control" />
                        </div>
                    </div>
                    <asp:Button Text="Complete Step" CssClass="btn btn-default" runat="server" />
                </asp:Panel>

            </div>
        </div>


    </asp:Panel>
</asp:Content>
