<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="E_CommerceApp.frm_login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container h-100" style=" max-width: 36rem;">
        <div class="card  my-4">
            <div class="card-body">
                <asp:Label ID="lbl_LoginHeader" runat="server" Text="Login" CssClass="h3"></asp:Label>
                <hr />
                <div class="form-group">
                    <asp:TextBox ID="tbx_mail" runat="server" CssClass="form-control input-lg"
                        Placeholder="E-mail Address" />
                </div>
                <div class="form-group">
                    <asp:TextBox ID="tbx_password" runat="server" CssClass="form-control input-lg"
                        Placeholder="Password" TextMode="Password" />
                </div>
                <div class="text-right">
                    <asp:Button ID="btn_login" runat="server" Text="Login" CssClass="btn btn-outline-primary" OnClick="btn_login_Click" />
                    <asp:Button ID="btn_reset" runat="server" Text="Sign Up" CssClass="btn btn-outline-secondary" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
