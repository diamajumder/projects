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
    public partial class SearchParam : System.Web.UI.Page
    {
        DataSet ds=new DataSet();
        protected void Page_PreInit(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["themeCookie"];
            if (cookie != null)
                Page.Theme = cookie["theme"];
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void searchClient(object sender, EventArgs e)
        {
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("select * from tasks where client=@client", con);
            cmd.Parameters.AddWithValue("@client", tb1.Text);
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
        protected void searchTitle(object sender, EventArgs e)
        {
            string s = WebConfigurationManager.ConnectionStrings["str"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            SqlCommand cmd = new SqlCommand("select * from tasks where title=@title", con);
            cmd.Parameters.AddWithValue("@title", tb2.Text);
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
    }
}