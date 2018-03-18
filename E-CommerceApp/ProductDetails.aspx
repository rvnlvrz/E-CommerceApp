<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="E_CommerceApp.ProductDetails1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Start: Add To Cart --%>
    <div class="container my-4" >
        <div class="row">
            <%-- End: Add To Cart --%>
            <div class="product-slider col-5">
                <div id="carousel" class="carousel slide" data-ride="carousel">
                    <asp:Panel ID="InnerCarousel" runat="server" CssClass="carousel-inner"></asp:Panel>
                </div>
                <div class="clearfix">
                    <div id="thumbcarousel" class="carousel slide" data-interval="false">
                        <asp:Panel ID="SmallCarousel" runat="server" CssClass="carousel-inner"></asp:Panel>
                    <!-- /carousel-inner -->
                    <a class="carousel-control-prev" href="#thumbcarousel" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon  dark-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#thumbcarousel" role="button" data-slide="next">
                        <span class="carousel-control-next-icon dark-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                    </div>
                <!-- /thumbcarousel -->
        </div>
        </div>
            <%-- Data Source --%>
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
                    <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-primary" OnClick="btnAddToCart_Click" />
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
    <asp:SqlDataSource ID="CartDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CartConnectionString %>" DeleteCommand="DELETE FROM [purchases] WHERE [Id] = @Id" InsertCommand="INSERT INTO [purchases] ([customer], [items], [prices], [quants], [totalCount], [totalPrice], [reference_key]) VALUES (@customer, @items, @prices, @quants, @totalCount, @totalPrice, @reference_key)" OnDeleting="CartDataSource_Deleting" OnInserting="CartDataSource_Inserting" OnUpdating="CartDataSource_Updating" SelectCommand="SELECT * FROM [purchases]" UpdateCommand="UPDATE [purchases] SET [customer] = @customer, [items] = @items, [prices] = @prices, [quants] = @quants, [totalCount] = @totalCount, [totalPrice] = @totalPrice, [reference_key] = @reference_key WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="customer" Type="String" />
            <asp:Parameter Name="items" Type="String" />
            <asp:Parameter Name="prices" Type="String" />
            <asp:Parameter Name="quants" Type="String" />
            <asp:Parameter Name="totalCount" Type="Int32" />
            <asp:Parameter Name="totalPrice" Type="Decimal" />
            <asp:Parameter Name="reference_key" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="customer" Type="String" />
            <asp:Parameter Name="items" Type="String" />
            <asp:Parameter Name="prices" Type="String" />
            <asp:Parameter Name="quants" Type="String" />
            <asp:Parameter Name="totalCount" Type="Int32" />
            <asp:Parameter Name="totalPrice" Type="Decimal" />
            <asp:Parameter Name="reference_key" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="userInfoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:UserConnectionString %>" DeleteCommand="DELETE FROM [userInfo] WHERE [Id] = @Id" InsertCommand="INSERT INTO [userInfo] ([latest_cart_id]) VALUES (@latest_cart_id)" OnUpdating="userInfoDataSource_Updating" SelectCommand="SELECT [Id], [latest_cart_id] FROM [userInfo]" UpdateCommand="UPDATE [userInfo] SET [latest_cart_id] = @latest_cart_id WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="latest_cart_id" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="latest_cart_id" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
