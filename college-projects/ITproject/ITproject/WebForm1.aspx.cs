using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Drawing;

namespace ITproject
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        HttpCookie cookie = null;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void goToAdmin(object sender, EventArgs e)
        {
            cookie = new HttpCookie("themeCookie");
            cookie["theme"] = "gray";
            Response.Cookies.Add(cookie);
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("select * from users where username=@username and password=@password", con);
            cmd.Parameters.AddWithValue("@username", tb1.Text);
            cmd.Parameters.AddWithValue("@password", tb2.Text);
            SqlDataReader reader;
            Session["usertype"] = null;
            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                if(reader.HasRows)
                {
                    Session["usertype"] = "admin";
                    Response.Redirect("AdminHome.aspx");
                }
            }
            catch { }
            finally { con.Close(); }
        }
        protected void goToDev(object sender, EventArgs e)
        {
            cookie = new HttpCookie("themeCookie");
            cookie["theme"] = "blue";
            Response.Cookies.Add(cookie);
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("select * from users where username=@username and password=@password", con);
            cmd.Parameters.AddWithValue("@username", tb3.Text);
            cmd.Parameters.AddWithValue("@password", tb4.Text);
            SqlDataReader reader;
            Session["usertype"] = null;
            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    Session["usertype"] = "dev";
                    Response.Redirect("DevHome.aspx");
                }
            }
            catch { }
            finally { con.Close(); }
        }
    }
}