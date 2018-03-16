<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="E_CommerceApp.Home" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-0">
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block w-100" src="https://i.imgur.com/jEOfMPv.jpg" alt="First slide">
                    <div class="carousel-caption d-none d-md-block">
                        <h4>The Orange Knight</h4>
                        <p>Go burn em' with fire!</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="https://i.imgur.com/8XGxsCx.jpg" alt="Second slide">
                    <div class="carousel-caption d-none d-md-block">
                        <h4>The Red Knight</h4>
                        <p>Go zap em' with everything you've got!</p>

                    </div>
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="https://i.imgur.com/I1n1g5u.jpg" alt="Third slide">
                    <div class="carousel-caption d-none d-md-block">
                        <h4>The Green Knight</h4>
                        <p>Go kill em' with poison!</p>
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
    <div class="container py-4">
        <div class="row">
            <asp:TextBox ID="TxtSearch" runat="server" CssClass="w-80 form-control form-control-lg" Placeholder="Search"></asp:TextBox>
        </div>
    </div>
    <div class="container">
        <asp:ListView ID="ProductList" runat="server" DataSourceID="ProductsDataSource" DataKeyNames="id" GroupItemCount="4" OnItemCommand="ProductList_ItemCommand">
            <EmptyDataTemplate>
                <table runat="server" style="">
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EmptyItemTemplate>
                <td runat="server"/>
            </EmptyItemTemplate>
            <GroupTemplate>
                <tr id="itemPlaceholderContainer" runat="server">
                    <td id="itemPlaceholder" runat="server"></td>
                </tr>
            </GroupTemplate>
            <ItemTemplate>
                <td runat="server" style="">
                    <div class="card">
                        <a href="#" class="card-link">
                            <img src='<%# RenderImage(Eval("img_url"))%>' alt="Alternate Text" class="card-img-top"/>
                            <div class="card-body">
                            <h6 class="card-text">
                                <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>'/>
                            </h6>
                        </a>
                        <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("price", "{0:c}") %>' CssClass="card-text"/>
                        <br/>
                        <br/>
                        <div class="d-flex flex-row">
                            <asp:Button ID="BtnAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-primary p-2" CommandArgument='<%#Eval("sku") + "," + Eval("price") %>'/>
                        </div>
                    </div>
                    </div>
                </td>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server" class="table">
                    <tr runat="server">
                        <td runat="server">
                            <table id="groupPlaceholderContainer" runat="server" border="0" class="table">
                                <div class="card-group">
                                    <tr id="groupPlaceholder" runat="server">
                                    </tr>
                                </div>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style="">
                            <div class="d-flex flex-row">
                                <div class="ml-auto p-2">
                                    <asp:DataPager ID="ProductPager" runat="server" PageSize="12">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" ButtonCssClass="btn"/>
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:ListView>
    </div>
    <%-- Data Source --%>
    <asp:SqlDataSource ID="ProductsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ProductsConnectionString %>" SelectCommand="SELECT * FROM [Products]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="CartDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CartConnectionString %>" DeleteCommand="DELETE FROM [purchases] WHERE [Id] = @original_Id" InsertCommand="INSERT INTO [purchases] ([customer], [items], [prices], [quants], [totalCount], [totalPrice], [reference_key]) VALUES (@customer, @items, @prices, @quants, @totalCount, @totalPrice, @reference_key)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [purchases]" UpdateCommand="UPDATE [purchases] SET [customer] = @customer, [items] = @items, [prices] = @prices, [quants] = @quants, [totalCount] = @totalCount, [totalPrice] = @totalPrice WHERE [Id] = @original_Id" OnInserting="CartDataSource_Inserting" OnUpdating="CartDataSource_Updating" OnDeleting="CartDataSource_Deleting">
        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32"/>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="customer" Type="String"/>
            <asp:Parameter Name="items" Type="String"/>
            <asp:Parameter Name="prices" Type="String"/>
            <asp:Parameter Name="quants" Type="String"/>
            <asp:Parameter Name="totalCount" Type="Int32"/>
            <asp:Parameter Name="totalPrice" Type="Decimal"/>
            <asp:Parameter Name="reference_key" Type="String"/>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="customer" Type="String"/>
            <asp:Parameter Name="items" Type="String"/>
            <asp:Parameter Name="prices" Type="String"/>
            <asp:Parameter Name="quants" Type="String"/>
            <asp:Parameter Name="totalCount" Type="Int32"/>
            <asp:Parameter Name="totalPrice" Type="Decimal"/>
            <asp:Parameter Name="original_Id" Type="Int32"/>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="userInfoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:UserConnectionString %>" SelectCommand="SELECT [Id], [latest_cart_id] FROM [userInfo]" DeleteCommand="DELETE FROM [userInfo] WHERE [Id] = @Id" InsertCommand="INSERT INTO [userInfo] ([latest_cart_id]) VALUES (@latest_cart_id)" OnUpdating="userInfoDataSource_Updating" UpdateCommand="UPDATE [userInfo] SET [latest_cart_id] = @latest_cart_id WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"/>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="latest_cart_id" Type="Int32"/>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="latest_cart_id" Type="Int32"/>
            <asp:Parameter Name="Id" Type="Int32"/>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DirectoryDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DirectoryConnectionString %>" SelectCommand="SELECT * FROM [directory]"></asp:SqlDataSource>
</asp:Content>