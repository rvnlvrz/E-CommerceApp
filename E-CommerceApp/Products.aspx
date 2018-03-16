<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="E_CommerceApp.ProductDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <asp:ListView ID="ProductList" runat="server" DataSourceID="ProductsDataSource" DataKeyNames="id" GroupItemCount="4">
            <EmptyDataTemplate>
                <table runat="server">
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
                <td runat="server">
                    <div class="card">
                        <a href="#" class="card-link">
                            <img src="Content/Images/download.svg" alt="Alternate Text" class="card-img-top" />
                            <div class="card-body">
                                <h6 class="card-text">
                                    <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' />
                                </h6>
                        </a>
                        <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("price", "{0:c}") %>' CssClass="card-text" />
                        <br />
                        <br />
                        <div class="d-flex flex-row">
                            <asp:Button ID="Button1" runat="server" Text="Add to Cart" CssClass="btn btn-primary p-2" />
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
                        <td runat="server">
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
    </div>
    <%-- Data Source --%>
    <asp:SqlDataSource ID="ProductsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ProductsConnectionString %>"
        SelectCommand="SELECT * FROM [Products]"></asp:SqlDataSource>
</asp:Content>
