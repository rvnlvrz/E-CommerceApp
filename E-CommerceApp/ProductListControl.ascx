<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductListControl.ascx.cs" Inherits="E_CommerceApp.ProductListControl" %>
<%@ Register Src="~/ProductCardControl.ascx" TagName="ProductCardControl" TagPrefix="uc1" %>

<div class="container my-4">
    <%-- Search Bar --%>
    <asp:Panel ID="SearchPanel" runat="server" CssClass="input-group mb-3" DefaultButton="BtnSearch">
        <asp:TextBox ID="TxtSearch" runat="server" CssClass="form-control form-control-lg" Placeholder="Search"></asp:TextBox>
        <div class="input-group-append">
            <asp:Button ID="BtnSearch" runat="server" Text="Go" CssClass="btn btn-primary" OnClick="BtnSearch_Click" UseSubmitBehavior="False" />
        </div>
    </asp:Panel>
    <asp:ListView ID="ProductList" runat="server" DataSourceID="ProductsDataSource" DataKeyNames="id" GroupItemCount="5" OnItemCommand="ProductList_ItemCommand">
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <EmptyItemTemplate>
            <%-- Nothing Here --%>
            <td>
                <div style="width: 209px;">
                </div>
            </td>
        </EmptyItemTemplate>
        <GroupTemplate>
            <tr id="itemPlaceholderContainer" runat="server">
                <td id="itemPlaceholder" runat="server"></td>
            </tr>
        </GroupTemplate>
        <ItemTemplate>
            <td runat="server">
                <%-- Product Card --%>
                <asp:UpdatePanel ID="CardUpdatePanel" runat="server" ChildrenAsTriggers="true" UpdateMode="Always">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ProductCardControl" />
                    </Triggers>
                    <ContentTemplate>
                        <uc1:ProductCardControl runat="server" ID="ProductCardControl" />
                    </ContentTemplate>
                </asp:UpdatePanel>
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
<asp:SqlDataSource ID="ProductsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ProductsConnectionString %>" SelectCommand="SELECT id, name, category, manufacturer, description, sku, price, qty, tags, img_url, md_url FROM Products WHERE (name LIKE '%' + @name + '%')" UpdateCommand="UPDATE Products SET [qty] = @qty WHERE [sku] = @sku" OnUpdating="ProductsDataSource_Updating">
    <SelectParameters>
        <asp:ControlParameter ControlID="TxtSearch" ConvertEmptyStringToNull="False" DefaultValue="" Name="name" PropertyName="Text" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="sku" Type="String" />
        <asp:Parameter Name="qty" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
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
