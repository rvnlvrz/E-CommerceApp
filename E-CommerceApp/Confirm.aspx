<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Frm_Confirm.aspx.cs" Inherits="E_CommerceApp.Frm_Confirm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="jumbotron">
            <p class="display-4 text-center">YOUR ORDER HAS BEEN RECEIVED.</p>
            <hr />
            <p class="h4 text-muted text-center">THANK YOU FOR YOUR PURCHASE</p>

            <br />
            <div class="card text-center">
                <div class="card-block">
                    <div class="card-body">
                        <asp:Label ID="LBL_refNum" runat="server" Text="Your reference number is: " CssClass="lead"></asp:Label>
                        <p><small class="text-muted">Please do not share this number with others.</small></p>
                        <asp:Button ID="Btn_finalize" runat="server" Text="Return to the catalog &raquo;" CssClass="btn btn-outline-primary" OnClick="Btn_finalize_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
