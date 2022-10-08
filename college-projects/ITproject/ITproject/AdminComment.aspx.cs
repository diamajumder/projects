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
    public partial class AdminComment : System.Web.UI.Page
    {
        DataSet ds = new DataSet();
        string querystr;

        protected void display()
        {
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("select * from comments where task_id=@task_id", con);
            cmd.Parameters.AddWithValue("@task_id", querystr);

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);

            //grid1.DataSource = null;
            //grid1.DataBind();
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
            //int i;
            //int.TryParse(s, out i);
            display();
        }
        protected void approve(object sender, EventArgs e)
        {
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("update comments set status='approved' where c_id=@c_id", con);
            cmd.Parameters.AddWithValue("@c_id", list1.SelectedItem.Text);
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch { }
            finally { con.Close(); }
            display();
        }
        protected void reject(object sender, EventArgs e)
        {
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("delete from comments where c_id=@c_id", con);
            cmd.Parameters.AddWithValue("@c_id", list1.SelectedItem.Text);
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch { }
            finally { con.Close(); }
            display();
        }
    }
}