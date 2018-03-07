<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Parts.aspx.cs" Inherits="PeninsulaRV.Parts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .topBar {
            height: 30px;
            margin-top: -10px;
            margin-bottom: 20px;

        }

        .topBarItem {
            display: inline-block;
            height: 30px;
        }

        a:hover {
            cursor: pointer;
        }

        .itemInfo {
            border-style: solid;
            position: absolute;
            bottom: 0px;
            right: 0px;
            background-color: rgba(255,255,255,0.8);
            padding: 5px 10px 5px 10px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

        .itemRow {
            height: 180px;
        }

        .part{
            height: 100%;
        }
    </style>
    <div class="row">
        <div class="col-sm-12">
            <h3>RV Parts</h3>
            <div class="jumbotron">
                <p>Here at Peninsula RV, we have the largest RV parts inventory on the Olympic Peninsula. We can also special order parts from all the big suppliers. Our staff has been in the business for decades and is ready to help you find what you need. </p>
                <p>Here is a sample of unique or notable items we carry.</p>
            </div>

            <div class="row">
                <div class="col-sm-12 topBar">
                    <div class="topBarItem">
                        <div class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown">Categories
                                <span class="caret"></span>
                            </a>
                            <asp:Repeater ID="rptCategories" runat="server">
                                <HeaderTemplate>
                                    <ul class="dropdown-menu">
                                        <li><a href="Parts.aspx">All Parts</a></li>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <li><a href='parts.aspx?Category=<%#Container.DataItem %>'><%#Container.DataItem %></a></li>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>                            
                        </div>
                    </div>
                    <div class="topBarItem">
                        <asp:TextBox ID="txtSearch" placeholder="search" CssClass="form-control" runat="server" />
                    </div>
                    <div class="topBarItem">
                        <asp:Button Text="Search" CssClass="btn btn-default" runat="server" />
                    </div>
                </div>
            </div>

            <div class="row itemRow">

                <asp:Repeater ID="rptParts" runat="server">
                    <ItemTemplate>
                        <a href='parts.aspx?PartID=<%# Eval("PartID") %>'>
                            <div class="col-sm-2 part">
                                <img src='images/parts/part<%# Eval("PartID") %>-thumb1.jpg' class="img-responsive" /><br />
                                <div class="itemInfo">
                                    <h5><%# Eval("Name") %></h5>
                                </div>
                            </div>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>
    </div>
</asp:Content>
