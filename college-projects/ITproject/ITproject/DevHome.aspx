<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DevHome.aspx.cs" Inherits="ITproject.DevHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="StyleSheet1.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Developer Home</h2>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div id="DevHome_logout">
        <asp:Button ID="logoutBtn" Text="Logout" runat="server" OnClick="logout" />
    </div><br /><br />
    <h3>Projects</h3>
    
    <div id="DevHome_content3">
    <asp:GridView ID="grid1" runat="server" >
    </asp:GridView>
    </div>
    <div id="DevHome_content2">
    <asp:Label ID="label1" runat="server" Text="choose the ID of the project whose comments you want to view" />
        
    <asp:SqlDataSource ID="ds1" ConnectionString="<% $ConnectionStrings:str %>"
        SelectCommand="select distinct task_id from tasks" runat="server">
        </asp:SqlDataSource>
    
    <asp:DropDownList ID="list1" runat="server" DataSourceID="ds1" DataTextField="task_id"
        AutoPostBack="true" OnSelectedIndexChanged="viewComment" />
        </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
