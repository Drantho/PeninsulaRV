<%@ Page Title="Implied Warranty Statement" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImpliedWarrantyStatement.aspx.cs" Inherits="PeninsulaRV.secure.ImpliedWarrantyStatement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        p{
            font-size: 17pt;
        }

        .lineLabel{
            position: relative;
            top: -20px;
        }
    </style>
    <p>
        <h1 class="text-center">Implied Warranty Negotiation Statement</h1>
        <p>
            Under the law, a vehicle is sold with an IMPLIED WARRANTY as to the MERCHANTABILITY and FITNESS of that vehicle.
        </p>
    <p>
        Unless specified in the comments section below, my/our signature(s) below acknowledges, understands, and agrees that the SELLER MAKES NO WARRANTY WHATSOEVER, EXPRESS OR IMPLIED, 
        respecting the quality, characteristics, performance, or condition of the vehicle, or any of its component parts, including but not limited to, the engine and its internal 
        and external parts, the clutch assembly and related parts, the drive line, the rear axle and related parts, the steering assembly and related parts, the electrical system, 
        the front and rear suspension and related parts, the tires and wheels, the braking system, the radiator and cooling system, the fuel system, the exhaust system, the frame 
        and body, and any and all inoperable accessories.
    </p>
    <p>
        I/we understand that the below-described vehicle is being purchased AS IS, without any warranties, specifically, without limitation, without any implied warranties as to the 
        MERCHANTABILITY, or FITNESS, also acknowledging that this disclaimer of all warranties was explicitly verbally negotiated between the buyer and seller, and such is reflected 
        in the negotiated purchase price of the vehicle.
    </p>
    <p>
        With my/our signature at the bottom of this document, I/we, the customer(s) named below further acknowledge that I/we will pay for any and all costs of repair on the vehicle, upon my taking possession of said vehicle.
    </p>
    <h3>Vehicle Description</h3>
    <h3><asp:Label ID="lblVehicle" runat="server" /></h3>
    <h3>IMPLIED WARRANTY IS PROVIDED FOR THE FOLLOWING ITEMS ONLY:</h3>
    <ul>
        <li>
            <p>None as negotiated with reduction in price.</p>
        </li>
    </ul>
    
    <h3>
        Agreed to 
        <asp:Label ID="lblDate" runat="server" />
    </h3>
    <h3 class="align-text-top"><asp:Label ID="lblCustomerName" runat="server" /></h3>
    <h3>
        <div class='row'>
            <div class='col -xs-12'>
                _____________________________________________________________________________________<br><br>

            </div>
        </div>
        <div class='row'>
            <div class='col-xs-6'>
                <span class='lineLabel'>Peninsula RV by</span>
            </div>
        </div>
    </h3>
</asp:Content>
