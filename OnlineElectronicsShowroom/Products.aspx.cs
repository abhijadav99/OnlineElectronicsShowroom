using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineElectronicsShowroom
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts();
            }
        }

        private void LoadCategories()
        {
            string query = "SELECT CategoryID, CategoryName FROM Categories";

            DataTable dt = Database.GetData(query);

            ddlCategories.DataSource = dt;
            ddlCategories.DataTextField = "CategoryName";
            ddlCategories.DataValueField = "CategoryID";
            ddlCategories.DataBind();

            // Add default option
            ddlCategories.Items.Insert(0, new ListItem("All Categories", "0"));
        }

        private void LoadProducts()
        {
            string query = @"
        SELECT p.*, c.CategoryName 
        FROM Products p
        INNER JOIN Categories c ON p.CategoryID = c.CategoryID
        WHERE (@CategoryID = 0 OR p.CategoryID = @CategoryID)
    ";

            SqlParameter[] parameters =
            {
        new SqlParameter("@CategoryID", ddlCategories.SelectedValue)
    };

            DataTable dt = Database.GetDataParameters(query, parameters);

            rptProducts.DataSource = dt;
            rptProducts.DataBind();
        }

        protected void ddlCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadProducts();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            try
            {
                int userId = GetCurrentUserId();
                Button btn = (Button)sender;
                int productId = Convert.ToInt32(btn.CommandArgument);

                int result = Database.AddToCart(userId, productId);

                if (result > 0)
                {
                    ltMessage.Text = "<div class='alert alert-success'>Item added to cart!</div>";
                }
            }
            catch (Exception ex)
            {
                ltMessage.Text = $"<div class='alert alert-danger'>Error: {ex.Message}</div>";
            }
        }

        private int GetCurrentUserId()
        {
            if (Session["UserID"] == null)
            {
                string username = User.Identity.Name;

                string query = "SELECT UserID FROM Users WHERE Username = @Username";

                SqlParameter[] parameters =
                {
            new SqlParameter("@Username", username)
        };

                DataTable dt = Database.GetDataParameters(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    Session["UserID"] = Convert.ToInt32(dt.Rows[0]["UserID"]);
                }
            }

            return Convert.ToInt32(Session["UserID"]);
        }

    }

}