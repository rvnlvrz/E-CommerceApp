<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="E_CommerceApp.ProductDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
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
                <td runat="server" />
            </EmptyItemTemplate>
            <GroupTemplate>
                <tr id="itemPlaceholderContainer" runat="server">
                    <td id="itemPlaceholder" runat="server"></td>
                </tr>
            </GroupTemplate>
            <ItemTemplate>
                <td runat="server" style="">
                    <div class="card">
                        <a href='ProductDetails.aspx?sku=<%# Eval("sku") %>' class="card-link">
                            <img src='<%# RenderImage(Eval("img_url")) %>' alt="Alternate Text" class="card-img-top img-fluid" />
                            <div class="card-body">
                                <h6 class="card-text">
                                    <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' />
                                </h6>
                        </a>
                        <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("price", "{0:c}") %>' CssClass="card-text" />
                        <br />
                        <br />
                        <div class="d-flex flex-row">
                            <asp:Button ID="Button1" runat="server" Text="Add to Cart" CssClass="btn btn-primary p-2" CommandArgument='<%# Eval("sku")+","+ Eval("price") %>' />
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
                                    <asp:DataPager ID="DataPager1" runat="server" PageSize="12">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" ButtonCssClass="btn" />
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="ProductsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ProductsConnectionString %>" SelectCommand="SELECT * FROM [Products]"></asp:SqlDataSource>

        <asp:SqlDataSource ID="CartDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CartConnectionString %>" DeleteCommand="DELETE FROM [purchases] WHERE [Id] = @original_Id" InsertCommand="INSERT INTO [purchases] ([customer], [items], [prices], [quants], [totalCount], [totalPrice], [reference_key]) VALUES (@customer, @items, @prices, @quants, @totalCount, @totalPrice, @reference_key)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [purchases]" UpdateCommand="UPDATE [purchases] SET [customer] = @customer, [items] = @items, [prices] = @prices, [quants] = @quants, [totalCount] = @totalCount, [totalPrice] = @totalPrice WHERE [Id] = @original_Id" OnInserting="CartDataSource_Inserting" OnUpdating="CartDataSource_Updating" OnDeleting="CartDataSource_Deleting">
            <DeleteParameters>
                <asp:Parameter Name="original_Id" Type="Int32" />
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
                <asp:Parameter Name="original_Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="userInfoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:UserConnectionString %>" SelectCommand="SELECT [Id], [latest_cart_id] FROM [userInfo]" DeleteCommand="DELETE FROM [userInfo] WHERE [Id] = @Id" InsertCommand="INSERT INTO [userInfo] ([latest_cart_id]) VALUES (@latest_cart_id)" OnUpdating="userInfoDataSource_Updating" UpdateCommand="UPDATE [userInfo] SET [latest_cart_id] = @latest_cart_id WHERE [Id] = @Id">
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
    </div>

</asp:Content>

