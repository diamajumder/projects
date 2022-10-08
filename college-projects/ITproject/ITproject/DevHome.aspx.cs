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
    public partial class DevHome : System.Web.UI.Page
    {
        DataSet ds = new DataSet();
        protected void display()
        {
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("select * from tasks", con);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
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
            Session["usertype"] = "dev";
            display();
        }
        protected void viewComment(object sender, EventArgs e)
        {
            string url = "DevComment.aspx?taskid=" + list1.SelectedItem.Text;
            Response.Redirect(url);
        }
        protected void logout(object sender, EventArgs e)
        {
            Session["usertype"] = null;
            Response.Redirect("WebForm1.aspx");
        }
    }
}