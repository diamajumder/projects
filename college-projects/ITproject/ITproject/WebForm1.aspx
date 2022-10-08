<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="ITproject.WebForm1"
    UnobtrusiveValidationMode="none" Theme="gray" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet"  href="StyleSheet1.css" />
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
 <div id="wrapper_login">  
 <div id="login_admin" >
      <h2>Admin Login </h2>
     <br/>
     Username:
     <asp:TextBox ID="tb1" runat="server" />
     <br />
     Password:
     <asp:TextBox ID="tb2" runat="server" TextMode="Password" />
     <br />
     <asp:Button ID="btn1" runat="server" Text="Login" OnClick="goToAdmin" />
     <br />
 </div>
<div id="login_dev">
     <h2>Developer Login</h2>
      <br/> 
     Username:
     <asp:TextBox ID="tb3" runat="server" />
     <br />
     Password:
     <asp:TextBox ID="tb4" runat="server" TextMode="Password" />
     <br />
     <asp:Button ID="btn2" runat="server" Text="Login" OnClick="goToDev" />
     <br />
 </div>
</div>

</asp:Content>
