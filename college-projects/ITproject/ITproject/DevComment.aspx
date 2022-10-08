<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DevComment.aspx.cs" Inherits="ITproject.DevComment1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Comments</h2>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:GridView ID="grid1" runat="server" >
    </asp:GridView>
    <br />
    <asp:Button ID="btn1" Text="add comment on this task" runat="server" OnClick="addComment" />
    <br />
    <asp:Label ID="label1" Text="comment" runat="server" Visible="false" />
    <br />
    <asp:TextBox ID="tb1" runat="server" Visible="false" />
    <br />
    <asp:Button ID="btn2" Text="comment" runat="server" OnClick="comment" Visible="false" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
