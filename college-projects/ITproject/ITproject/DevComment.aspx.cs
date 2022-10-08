using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace ITproject
{
    public partial class DevComment1 : System.Web.UI.Page
    {
        DataSet ds = new DataSet();
        string querystr;
        protected void display()
        {
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            string query = "select * from comments where task_id=@task_id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@task_id", querystr);

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);

            try
            {
                con.Open();
                adapter.Fill(ds, "comments");
                grid1.DataSource = ds;
                grid1.DataBind();
                ds.Clear();
            }
            catch { }
            finally
            {
                con.Close();
            }

        }
        protected void Page_PreInit(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["themeCookie"];
            if (cookie != null)
                Page.Theme = cookie["theme"];
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            querystr = Request.QueryString["taskid"];
            display();
        }
        protected void addComment(object sender, EventArgs e)
        {
            label1.Visible = true;
            tb1.Visible = true;
            btn2.Visible = true;
            btn1.Visible = false;
        }
        protected void comment(object sender, EventArgs e)
        {
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            string query = "insert into comments(task_id,comment,status) values(@task_id,@comment,@status)";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@task_id", querystr);
            cmd.Parameters.AddWithValue("@comment", tb1.Text);
            cmd.Parameters.AddWithValue("@status", "pending");
            try { con.Open();
                cmd.ExecuteNonQuery(); }
            catch { }
            finally { con.Close(); }


            label1.Visible = false;
            tb1.Visible = false;
            btn2.Visible = false;
            btn1.Visible = true;
            display();
        }
    }
}