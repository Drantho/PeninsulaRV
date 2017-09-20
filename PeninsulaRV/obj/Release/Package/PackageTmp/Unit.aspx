<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Unit.aspx.cs" Inherits="PeninsulaRV.Unit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-8">
            
            <asp:PlaceHolder ID="plhFeatured1" runat="server" />
            <asp:PlaceHolder ID="plhFeatured2" runat="server" />
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
            
        </div>
        </div></div></div></div>
        <div class="col-sm-4" style="background-color: #efefef; padding-right: 15px; padding-top: 15px; padding-bottom: 15px;">
            <asp:PlaceHolder ID="plhDetails" runat="server" />
        </div>
    </div>
    
     <script>
        $('#myCarousel').carousel({
            interval: 7000
        });

        // handles the carousel thumbnails
        $('[id^=carousel-selector-]').click(function () {
            var id_selector = $(this).attr("id");
            var id = id_selector.substr(id_selector.length - 1);
            id = parseInt(id);
            $('#myCarousel').carousel(id);
            $('[id^=carousel-selector-]').removeClass('selected');
            $(this).addClass('selected');
        });

        // when the carousel slides, auto update
        $('#myCarousel').on('slid', function (e) {
            var id = $('.item.active').data('slide-number');
            id = parseInt(id);
            $('[id^=carousel-selector-]').removeClass('selected');
            $('[id=carousel-selector-' + id + ']').addClass('selected');
        });

        $('#myCarousel').carousel({
            pause: "true"
        });
    </script>
</asp:Content>
