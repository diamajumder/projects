<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminComment.aspx.cs" Inherits="ITproject.AdminComment"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Comments</h2>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:GridView ID="grid1" runat="server">
    </asp:GridView>
    <br /><br />
    <asp:SqlDataSource ID="ds1" ConnectionString="<% $ConnectionStrings:str %>"
        SelectCommand="select distinct c_id from comments where status='pending' and task_id=@task_id" runat="server">
        <SelectParameters>
            <asp:QueryStringParameter Name="task_id" QueryStringField="taskid" />
        </SelectParameters>
        </asp:SqlDataSource>
    <h4>Approve or Reject Comments</h4>
    <br />
    <asp:Label ID="label1" runat="server" Text="choose the ID of the comment to approve/reject" />
    <asp:DropDownList ID="list1" runat="server" DataSourceID="ds1" DataTextField="c_id" />
    <br />
    <asp:Button ID="btn1" runat="server" Text="Approve" OnClick="approve" />
    <asp:Button ID="btn2" runat="server" Text="Reject" OnClick="reject" />

    <br />
    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
