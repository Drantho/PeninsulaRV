<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkOrderForm.aspx.cs" Inherits="PeninsulaRV.secure.WorkOrderForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body {
            vertical-align: text-top;
            font-size: 200%;
        }

        th {
        }

        td {
            vertical-align: text-top;
            vertical-align: top;
            padding-left: 10px;
            padding-right: 10px;
        }

        h1 {
            text-align: center;
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
        }

        h1 {
            margin-bottom: 5px;
            margin-top: 10px;
        }

        .underline {
            border-bottom: solid;
        }

        .paid {
            font-weight: 800;
        }
        .head{
            font-size: 125%;
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
                    <img src="../Images/penrvlogov1.gif" class="img-responsive"/>
                </div>
                <div class="col-xs-1"></div>
                <div class="col-xs-3">
                    Phone: 360.582.9199<br>
                    Fax: 360.582.9959<br>
                    peninsularv@gmail.com
                </div>
            </div>
            <div class="panel">
                <div class="panel-heading">
                    <h1>Service Invoice</h1>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-4 head">
                            <asp:Label ID="lblOrder" runat="server" />
                        </div>
                        <div class="col-xs-4 head">
                            <asp:Label ID="lblCustomer" runat="server" />
                        </div>
                        <div class="col-xs-4 head">
                            <asp:Label ID="lblVehicle" runat="server" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4>Labor</h4>
                        </div>
                        <div class="panel-body">
                            <asp:Repeater ID="rptJob" runat="server">
                                <HeaderTemplate>
                                    <table>
                                        <tr>
                                            <th style="width: 75%">
                                                Description
                                            </th>
                                            <th>
                                                Rate
                                            </th>
                                            <th>
                                                Hours
                                            </th>
                                            <th style="text-align: right">
                                                Price&nbsp;&nbsp;&nbsp;
                                            </th>
                                        </tr>                                    
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <%# Eval("JobDescription") %>
                                        </td>
                                        <td>
                                            <%# Eval("JobRate", "{0:c}") %>
                                        </td>
                                        <td>
                                            <%# Eval("JobHours") %>
                                        </td>
                                        <td align="right">
                                            <%# Eval("JobAmount", "{0:c}") %>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4>Materials</h4>
                        </div>
                        <div class="panel-body">
                            <asp:Repeater ID="rptMaterial" runat="server">
                                <HeaderTemplate>
                                    <table>
                                        <tr>
                                            <th style="width: 75%">
                                                Description
                                            </th>
                                            <th>
                                                Quantity
                                            </th>
                                            <th style="text-align: right">
                                                Price Ea.
                                            </th>
                                            <th style="text-align: right">
                                                Total Price
                                            </th>
                                        </tr>                                    
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <%# Eval("MaterialDescription") %>
                                        </td>
                                        <td>
                                            <%# Eval("MaterialQuantity") %>
                                        </td>
                                        <td style="text-align: right">
                                            <%# Eval("MaterialPrice", "{0:c}") %>
                                        </td>
                                        <td style="text-align: right">
                                            <%# Eval("MaterialAmount", "{0:c}") %>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4>Miscellaneous</h4>
                        </div>
                        <div class="panel-body">
                            <asp:Repeater ID="rptMiscellaneous" runat="server">
                                <HeaderTemplate>
                                    <table>
                                        <tr>
                                            <th style="width: 75%">
                                                Description
                                            </th>                                           
                                            <th style="text-align: right">
                                                Price&nbsp;&nbsp;&nbsp;
                                            </th>
                                        </tr>                                    
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <%# Eval("MiscellaneousDescription") %>
                                        </td>                                       
                                        <td style="text-align: right">
                                            <%# Eval("MiscellaneousAmount", "{0:c}") %>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>

                <div class="col-xs-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4>Totals</h4>
                        </div>
                        <div class="panel-body">
                            <asp:Label ID="lblTotals" runat="server" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12">
                    <br>
                    <h4 class="underline">Customer Signature:</h4>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
