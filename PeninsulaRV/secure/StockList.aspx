<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StockList.aspx.cs" Inherits="PeninsulaRV.secure.StockList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <style>
        th{
            text-align: center;
        }
        td{
            text-align: center;
        }
        body{
            font-size:small;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12">
                <asp:PlaceHolder ID="plhStockList" runat="server" />
            </div>
        </div>        
    </div>
    </form>
</body>
</html>
