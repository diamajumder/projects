<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SearchParam.aspx.cs" Inherits="ITproject.SearchParam" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="StyleSheet1.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h4>Search based on:</h4> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div id="SearchParam_content">
    Client:
    <asp:TextBox ID="tb1" runat="server" />
    <asp:Button ID="btn1" runat="server" Text="Search" OnClick="searchClient" />
    <br />
    Title:
    <asp:TextBox ID="tb2" runat="server" OnTextChanged="searchTitle" />
    <asp:Button ID="btn2" runat="server" Text="Search" OnClick="searchTitle" />
     </div>
    <br />
    <div id="search_grid" >
    <asp:GridView ID="grid1" runat="server">
    </asp:GridView>
        </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
