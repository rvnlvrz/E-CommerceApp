<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductListControl.ascx.cs" Inherits="E_CommerceApp.ProductListControl" %>

<%@ Register TagPrefix="uc1" TagName="ProductCardControl" Src="~/ProductCardControl.ascx" %>

<div class="container my-4">
    <asp:ListView ID="ProductList" runat="server" DataSourceID="ProductsDataSource" DataKeyNames="id" GroupItemCount="6" OnItemCommand="ProductList_ItemCommand">
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <EmptyItemTemplate>
            <%-- Nothing Here --%>
        </EmptyItemTemplate>
        <GroupTemplate>
            <tr id="itemPlaceholderContainer" runat="server">
                <td id="itemPlaceholder" runat="server"></td>
            </tr>
        </GroupTemplate>
        <ItemTemplate>
            <td runat="server">
                <%-- Product Card --%>
                <uc1:ProductCardControl runat="server" ID="ProductCardControl" />
            </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server" class="">
                <tr runat="server">
                    <td runat="server">
                        <table id="groupPlaceholderContainer" runat="server" border="0" class="">
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
</div>

<%-- Data Source --%>
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
<asp:SqlDataSource ID="DirectoryDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DirectoryConnectionString %>" SelectCommand="SELECT * FROM [directory]"></asp:SqlDataSource>