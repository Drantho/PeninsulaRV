<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConsignmentAgreementForm.aspx.cs" Inherits="PeninsulaRV.secure.ConsignmentAgreementForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">


                <div class="col-xs-3">
                    261293 Hwy 101<br>
                    Sequim, WA 98382<br>
                    www.peninsularv.net
                </div>
                <div class="col-xs-1"></div>
                <div class="col-xs-4">
                    <img src="../Images/penrvlogov1.gif" class="img-responsive" />
                </div>
                <div class="col-xs-1"></div>
                <div class="col-xs-3">
                    Phone: 360.582.9199<br>
                    Fax: 360.582.9959<br>
                    peninsularv@gmail.com
                </div>
            </div>
            <h3 class="text-center">AGREEMENT TO CONSIGN AND SELL</h3>
            <div class="row">
                <div class="col-xs-6">
                    <h4 class="text-center">Consignor Information</h4>
                    <h4>
                        <asp:Label ID="lblConsignorInfoName" runat="server" />
                    </h4>
                    <h4>
                        <asp:Label ID="lblConsignorInfoAddress" runat="server" /></h4>
                    <h4>
                        <asp:Label ID="lblConsignorInfoPhone" runat="server" />
                    </h4>
                </div>
                <div class="col-xs-6">
                    <h4 class="text-center">Vehicle Information</h4>
                    <p>As owner(s) of the following described vehicle, I(we) hereby consign a</p>
                    <p>
                        <asp:Label ID="lblVehicleInfo" runat="server" />
                    </p>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6">
                    <h4 class="text-center">Ownership Information</h4>
                    <p>Owner guarantees to be the registered owner of the vehicle. </p>
                    <p>
                        <asp:Label ID="lblLegalOwner" runat="server" />
                    </p>
                    <p>
                        <asp:Label ID="lblShortSale" runat="server">If the consignment amount is less than the amount owed, consignor will immediately upon sale, pay the difference to Peninsula RV to facilitate prompt payment to the legal owner.</asp:Label>
                    </p>
                </div>
                <div class="col-xs-6">

                    <h4 class="text-center">Commission Information</h4>
                    <p>
                        <asp:Label ID="lblCommissionType" runat="server" />
                    </p>
                    <p>In addition, consigner agrees to pay $85.00 monthly space rent.</p>
                </div>
            </div>

            <h4 class="text-center">Insurance Notice</h4>
            <p>Consignor agrees to continue insurance on the vehicle while on consignment and agrees to hold dealer harmless, as there is no insurance on the vehicle provided by the dealer. Consignor's insurance is the only insurance coverage for any circumstance. Consignor initials here, accepting and understanding both insurance and hold harmless agreement.</p>
            <h4>Consignor Initials:___&nbsp;&nbsp;&nbsp;___</h4>
            <h4 class="text-center">Term</h4>
            <p>
                The term of this agreement shall be
        <asp:Label ID="lblDays" runat="server" />
                days and will expire on
        <asp:Label ID="lblExpireDate" runat="server" />.
            </p>

            <h4 class="text-center">Authorization</h4>
            <table>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <h4>
                            <asp:Label ID="lblConsignorName1" runat="server" />&nbsp;                            
                        </h4>
                    </td>
                    <td>
                        <h4>Signature:____________________________________
                        </h4>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <h4>
                            <h4>
                                <asp:Label ID="lblConsignorName2" runat="server" />&nbsp;                              
                            </h4>
                        </h4>
                    </td>
                    <td>
                        <h4>
                            <asp:Label ID="lblSginature2" runat="server">Signature:____________________________________</asp:Label>
                        </h4>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <h4>
                            <h4>Peninsula RV                            
                            </h4>
                        </h4>
                    </td>
                    <td style="text-align: right">
                        <h4>by:____________________________________
                        </h4>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
