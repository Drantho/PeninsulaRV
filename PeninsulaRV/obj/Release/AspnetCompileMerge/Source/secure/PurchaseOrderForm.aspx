<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseOrderForm.aspx.cs" Inherits="PeninsulaRV.secure.PurchaseOrderForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body {
            vertical-align: text-top;
        }

        th {
        }

        td {
            vertical-align: text-top;
            vertical-align: top;
            padding-left: 10px;
            padding-right: 10px;
            font-size: 8pt;
        }

        h1 {
            text-align: center;
            font-size: 16pt;
        }

        table {
            width: 100%;
        }

        .right {
            text-align: right;
        }

        .description {
            width: 50%;
        }

        .price {
            width: 16%;
            text-align: right;
        }

        h4 {
            margin-top: 0px;
            margin-bottom: 0px;
            font-size: 12pt;
        }
        h5 {
            font-size: 8pt;
        }
        .underline {
            border-bottom: solid;
        }

        .paid {
            font-weight: 800;
        }

        .head {
        }
    </style>
</head>
    <body>
    <form id="form1" runat="server">
        <div class="container">
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
                    Phone: 360.582.9199<br/>
                    Fax: 360.582.9959<br/>
                    peninsularv@gmail.com
                </div>
            </div>
            <div class="panel" style="margin: -15px 0 0 0;">
                <div class="panel-heading">
                    <h1><asp:Label ID="lblStatus" runat="server" /></h1>
                </div>
                <div class="panel-body" style="margin: -20px 0 0 0;">
                    <div class="row">
                        <div class="col-xs-4 head">
                            <strong>Purchaser: </strong><br />
                            <asp:Label ID="lblPurchaser" runat="server" />
                        </div>
                        <div class="col-xs-8 head">
                            <strong>Vehicle: </strong><br />
                            <asp:Label ID="lblVehicle" runat="server" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-12">
                    <div class="panel panel-default" style="margin: -10px 0 0 0; padding: 0px 0px 0px 0px;">
                        <div class="panel-heading">
                            <h4>As Is No Warranty</h4>
                        </div>
                        <div class="panel-body">
                            <p style="font-size: 11pt">
                                AS IS: this vehicle is sold "as is" by Peninsula RV. This motor vehicle is sold as is without any warranty. The purchaser will bear the entire expense of repairing or correcting any defects that presently exist or that may occur in the vehicle.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="panel panel-default" style="margin: -25px 0 0 0;">
                        <div class="panel-heading">
                            <h4 style="margin: 10px 0 0 0;">Contractual Disclosure</h4>
                        </div>
                        <div class="panel-body">
                            <p style="font-size: 11pt">
                                Contractual disclosure statemnt for used vehicle: The information you see on the window form for this vehicle is part of this contract. Information on the window form overrides any contrary provisions in the contract of sale.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4" style="margin-left: 0px; margin-right: 0px; padding-right: 0px;">
                    <div class="panel panel-default" style="margin-left: 0px; margin-right: 0px; padding-left: 0px; padding-right: 0px;">
                        <div class="panel-heading">
                            <h4>Sale Information</h4>
                        </div>
                        <div class="panel-body">
                            <table>
                                <tr>
                                    <td><strong>Sale Date: </strong></td>
                                    <td class="text-right"><asp:Label ID="lblSaleDate" runat="server" /></td>
                                </tr>
                                <tr>
                                    <td><strong>Sales Person: </strong></td>
                                    <td class="text-right"><asp:Label ID="lblSalesmen" runat="server" /></td>
                                </tr>
                                <tr>
                                    <td><strong>Sale Price: </strong></td>
                                    <td class="text-right"><asp:Label ID="lblSalePrice1" CssClass="text-right" runat="server" /></td>
                                </tr>
                                <tr>
                                    <td><strong>Options: </strong></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table>
                                            <asp:Label ID="lblOptions" CssClass="text-right" runat="server" />
                                        </table>                                    
                                    </td>                                    
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-xs-4" style="margin-left: 0px; margin-right: 0px; padding-left: 0px; padding-right: 0px;">
                    <div class="panel panel-default" style="margin-left: 0px; margin-right: 0px; padding-left: 0px; padding-right: 0px;">
                        <div class="panel-heading">
                            <h4>Credit Information</h4>
                        </div>
                        <div class="panel-body">
                            <table>
                                <tr>
                                    <td>
                                        <strong>Trade Info: </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="text-right">
                                        <asp:Label ID="lblTradeInfo" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Trade Credit: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblTradeCredit" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Deposit: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblDeposit" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Cash With Order: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblCashWithOrder" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Total Credit: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblTotalCredit1" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-xs-4" style="margin-left: 0px; margin-right: 0px; padding-left: 0px;">
                    <div class="panel panel-default" style="margin-left: 0px; margin-right: 0px; padding-left: 0px; padding-right: 0px;">
                        <div class="panel-heading">
                            <h4>Totals</h4>
                        </div>
                        <div class="panel-body">
                            <table style="margin-left: -15px;">
                                <tr>
                                    <td>
                                        <strong>Subtotal: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblSalePriceAndOptions" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Negotiable&nbsp;Document&nbsp;Fee: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblDocumentFee" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Sales Tax: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblSalesTax" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>License Fee: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblLicenseFee" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Total Price: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblGrandTotal" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Total Credit: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblTotalCredit2" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Balance Due: </strong>
                                    </td>
                                    <td class="text-right">
                                        <asp:Label ID="lblBalanceDue" CssClass="text-right" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-12">
                    <div class="panel panel-default" style="margin: -30px 0 0 0;">
                        <div class="panel-heading">
                            <h4>Legal Information</h4>
                        </div>
                        <div class="panel-body">
                            <p style="font-size: 11pt">
                                Purchaser agrees that this order on the face and reverse side herof and any attachments hereto includes all the terms and conditions,
that this order cancels and supercedes any prior agreements and as of the date hereof comprises the complete and exclusive
statement of the terms of the agreement relating to the subject matters covered hereby, and that this order shall not become
binding until accepted by dealer or authorized representative. Purchaser by execution of this order acknowledges that he
or she has read its terms and conditions and has received a true copy of the order. If a documentary fee or preparation charge is
made, you have a right to a written itemized price for each specific service performed. Dealers may not charge customers for
services which are paid for by the manufacturer.
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="row">
                    <div class="col-xs-12">
                        <br /><br />
                        <img src="images/blackdot.png" style="width: 100%; height:2px; background-color: black">
                    </div>
                </div>
                <div class="col-xs-3">
                    <h5>Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dealer Signature:</h5>
                </div>
                <div class="col-xs-9">
                    <h5>Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Purchaser(s) Signature:</h5>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
