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
    public partial class AdminHome : System.Web.UI.Page
    {
        DataSet ds = new DataSet();
        int count = 0;
        
        protected void display()
        {
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("select * from tasks", con);
            
            SqlDataAdapter adapter=new SqlDataAdapter(cmd);
            
            //grid1.DataSource = null;
            //grid1.DataBind();
            try
            {
                con.Open();
                adapter.Fill(ds, "tasks");
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
            Label1.Visible = false;
            TextBox1.Visible = false;
            Label2.Visible = false;
            TextBox2.Visible = false;
            Label3.Visible = false;
            TextBox3.Visible = false;
            Button1.Visible = false;
           
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("select * from comments where status='pending'", con);
            SqlDataReader reader;
            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                while (reader.Read())
                    count++;
                    //list1.Items.Add(reader["task_id"].ToString());
            }
            catch { }
            finally
            {
                con.Close();
            }
            Session["usertype"] = "admin";
            Session["comments"] = count.ToString();
            label5.Text = "new comments: " + count.ToString();
            display();
        }
        protected void create_Project(object sender, EventArgs e)
        {
            btn_1.Visible = false;
            list1.Visible = false;
            label4.Visible = false;
            Label1.Visible = true;
            TextBox1.Visible = true;
            Label2.Visible = true;
            TextBox2.Visible = true;
            Label3.Visible = true;
            TextBox3.Visible = true;
            Button1.Visible = true;
        }
        protected void submit_Project(object sender, EventArgs e)
        {
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("insert into tasks(title,client,description) values(@title,@client,@description)", con);
            cmd.Parameters.AddWithValue("@title", TextBox1.Text);
            cmd.Parameters.AddWithValue("@client", TextBox2.Text);
            cmd.Parameters.AddWithValue("@description", TextBox3.Text);
            try { con.Open();
                cmd.ExecuteNonQuery(); }
            catch { }
            finally { con.Close(); }

            btn_1.Visible = true;
            list1.Visible = true;
            label4.Visible = true;
            Label1.Visible = false;
            TextBox1.Visible = false;
            Label2.Visible = false;
            TextBox2.Visible = false;
            Label3.Visible = false;
            TextBox3.Visible = false;
            Button1.Visible = false;

            //grid1.Columns.Clear();
            //grid1.DataBind();
            display();
        }
        protected void viewComment(object sender, EventArgs e)
        {
            string url = "AdminComment.aspx?taskid=" + list1.SelectedItem.Text;
            Response.Redirect(url);
        }
        protected void search(object sender, EventArgs e)
        {
            Response.Redirect("searchParam.aspx");
        }
        protected void logout(object sender, EventArgs e)
        {
            Session["usertype"] = null;
            Response.Redirect("WebForm1.aspx");
        }
    }
}