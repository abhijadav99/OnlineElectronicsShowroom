using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineElectronicsShowroom
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect(GetRouteUrl("HomeRoute", null));
            }
        }


        protected void loginButton(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string query = $@"
                SELECT * FROM Users
                WHERE Username = '{username}' AND Password = '{password}'";

            DataTable dt = Database.GetData(query);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                Session["UserID"] = Convert.ToInt32(row["UserID"]);
                Session["Username"] = row["Username"].ToString();
                Session["UserRole"] = row["Role"].ToString();

                FormsAuthentication.SetAuthCookie(row["Username"].ToString(), false);

                string role = row["Role"].ToString();
                string redirectRoute = role == "Admin" ? "AdminDashboardRoute" : "HomeRoute";
                Response.Redirect(GetRouteUrl(redirectRoute, null));
            }
            else
            {
                ltMessage.Text = "<div class='alert alert-danger mt-3'>Invalid credentials</div>";
            }
        }

    }
}