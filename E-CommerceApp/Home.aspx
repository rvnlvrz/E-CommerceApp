<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="E_CommerceApp.Home" %>

<%@ Register Src="~/ProductListControl.ascx" TagPrefix="uc1" TagName="ProductListControl" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-0">
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block w-100" src="Content/Images/Products/Carousel/banner-iphonex.jpg" alt="First slide">
                    <div class="carousel-caption d-none d-md-block">
                        <h4>The new iPhone X</h4>
                        <p>Pre order now</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="Content/Images/Products/Carousel/banner-s7.jpg" alt="Second slide">
                    <div class="carousel-caption d-none d-md-block">
                        <h4>The Red Knight</h4>
                        <p>Go zap em' with everything you've got!</p>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
    <uc1:ProductListControl runat="server" ID="ProductListControl" />
</asp:Content>
