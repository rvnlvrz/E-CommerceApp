<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="E_CommerceApp.ProductDetails" %>

<%@ Register Src="~/ProductListControl.ascx" TagPrefix="uc1" TagName="ProductListControl" %>
<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:ProductListControl runat="server" ID="ProductListControl" />
</asp:Content>
