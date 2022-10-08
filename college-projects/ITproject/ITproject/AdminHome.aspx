<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="ITproject.AdminHome" 
    UnobtrusiveValidationMode="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="StyleSheet1.css" />
</asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2>Admin Home</h2>
<div id="AdminHome_content2">
    <asp:Label ID="label5" runat="server" />
    <br /><br />
    <asp:Button ID="searchBtn" Text="Search" runat="server" OnClick="search" />
    <br /><br />
    <asp:Button ID="logoutBtn" Text="Logout" runat="server" OnClick="logout" />
</div>
    </asp:Content>
    <asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
         
        <h3>Projects</h3>
<div id="AdminHome_content3">   
        <asp:GridView ID="grid1" runat="server">
        </asp:GridView>
</div>
    
<div id="AdminHome_content3_s">
    <asp:Label ID="label4" runat="server" Text="choose the ID of the project whose comments you want to view" />
    <asp:SqlDataSource ID="ds1" ConnectionString="<% $ConnectionStrings:str %>"
        SelectCommand="select distinct task_id from tasks" runat="server">
        </asp:SqlDataSource>
    <asp:DropDownList ID="list1" runat="server" DataSourceID="ds1" DataTextField="task_id"
        AutoPostBack="true" OnSelectedIndexChanged="viewComment" />
        <br />
</div>
   </asp:Content>
    <asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
<div id="AdminHome_content3_ss">
    <asp:Button ID="btn_1" runat="server" OnClick="create_Project"  Text="Create Project"/>
</div>
    <br />
<div id="AdminHome_content4">
    
    <asp:Label ID="Label1" runat="server" Text="TITLE"></asp:Label>
     <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <br/>
    <asp:Label ID="Label2" runat="server" Text="CLIENTNAME"></asp:Label>
     <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <br/>
    <asp:Label ID="Label3" runat="server" Text="DESCRIPTION"></asp:Label>
     <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    <br>
    <asp:Button ID="Button1" runat="server" Text="submit" OnClick="submit_Project" />
    <asp:RequiredFieldValidator ID="rfv1" ControlToValidate="TextBox1" ErrorMessage="please enter project title" runat="server" >
        </asp:RequiredFieldValidator><br />
        <asp:RequiredFieldValidator ID="rfv2" ControlToValidate="TextBox2" ErrorMessage="please enter client name" runat="server" >
        </asp:RequiredFieldValidator><br />
        <asp:RequiredFieldValidator ID="rfv3" ControlToValidate="TextBox3" ErrorMessage="please enter description" runat="server" >
        </asp:RequiredFieldValidator><br />
</div>
    </asp:Content>
    

