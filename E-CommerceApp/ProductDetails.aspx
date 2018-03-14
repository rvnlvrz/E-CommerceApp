<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="E_CommerceApp.ProductDetails1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Layout --%>

    <div class="container">
        <div class="row">
            <%-- Carousel --%>
            <div class="product-slider col-5">
                <div id="carousel" class="carousel slide" data-ride="carousel">
                    <asp:Panel ID="InnerCarousel" runat="server" CssClass="carousel-inner"></asp:Panel>
                </div>
                <div class="clearfix">
                    <div id="thumbcarousel" class="carousel slide" data-interval="false">
                        <asp:Panel ID="ThumbCarousel" runat="server" CssClass="carousel-inner">
                            <div class="carousel-item active">
                                <div data-target="#carousel" data-slide-to="0" class="thumb">
                                    <img src="http://placehold.it/100x80?text=Thumb+01">
                                </div>
                                <div data-target="#carousel" data-slide-to="1" class="thumb">
                                    <img src="http://placehold.it/100x80?text=Thumb+02">
                                </div>
                                <div data-target="#carousel" data-slide-to="2" class="thumb">
                                    <img src="http://placehold.it/100x80?text=Thumb+03">
                                </div>
                                <div data-target="#carousel" data-slide-to="3" class="thumb">
                                    <img src="http://placehold.it/100x80?text=Thumb+04">
                                </div>
                            </div>
                            <div class="carousel-item">
                                <div data-target="#carousel" data-slide-to="5" class="thumb">
                                    <img src="http://placehold.it/100x80?text=Thumb+06">
                                </div>
                                <div data-target="#carousel" data-slide-to="6" class="thumb">
                                    <img src="http://placehold.it/100x80?text=Thumb+07">
                                </div>
                                <div data-target="#carousel" data-slide-to="7" class="thumb">
                                    <img src="http://placehold.it/100x80?text=Thumb+08">
                                </div>
                                <div data-target="#carousel" data-slide-to="8" class="thumb">
                                    <img src="http://placehold.it/100x80?text=Thumb+08">
                                </div>
                            </div>
                    </asp:Panel>
                    <!-- /carousel-inner -->
                    <a class="carousel-control-prev" href="#thumbcarousel" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#thumbcarousel" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                    </div>
                <!-- /thumbcarousel -->
        </div>
        </div>
        <%-- Product Details --%>
        <div class="col-7">
            <asp:Label ID="lblTitle" runat="server" CssClass="h2"></asp:Label>
            <hr />
            <span id="Description" runat="server" class="text-secondary"></span>
            <br />
            <br />
            <asp:Label ID="lblAvailability" runat="server" Text="Availability:" CssClass="text-secondary"></asp:Label>
            <span id="Availability" runat="server"></span>
            <br />
            <br />
            <asp:Label ID="lblSKU" runat="server" Text="SKU:" CssClass="text-secondary"></asp:Label>
            <span id="SKU" runat="server"></span>
            <br />
            <br />
            <h4 id="Price" runat="server" class="font-weight-bold"></h4>
            <%-- Start: Add To Cart --%>
            <div class="input-group my-3">
                <asp:TextBox ID="tbxQty" runat="server" TextMode="Number" CssClass="pl-2">1</asp:TextBox>
                <div class="input-group-append">
                    <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-primary" />
                </div>
            </div>
            <%-- End: Add To Cart --%>
        </div>
    </div>
    </div>
    <%-- Data Source --%>
    <asp:SqlDataSource ID="Products" runat="server" ConnectionString="<%$ ConnectionStrings:ProductsConnectionString %>" SelectCommand="SELECT * FROM [Products] WHERE ([sku] = @sku)">
        <SelectParameters>
            <asp:QueryStringParameter Name="sku" QueryStringField="sku" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
