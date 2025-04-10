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
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!IsAdmin())
                {
                    Response.Redirect(GetRouteUrl("AdminLoginRoute", null));
                    return;
                }

                BindData();
            }
            else
            {
                MaintainScrollPositionOnPostBack = true;
            }
        }

        private void BindData()
        {
            ProductsBinding();
            OrdersBinding();
            UsersBinding();
        }

        private bool IsAdmin()
        {
            return Session["UserRole"]?.ToString() == "Admin";
        }

        private void ProductsBinding()
        {
            const string query = @"
        SELECT p.*, c.CategoryName 
        FROM Products p 
        INNER JOIN Categories c ON p.CategoryID = c.CategoryID";

            DataTable dt = Database.GetDataParameters(query, new SqlParameter[0]);
            gridViewProducts.DataSource = dt;
            gridViewProducts.DataBind();
        }

        protected void gridViewProductsRowEditing(object sender, GridViewEditEventArgs e)
        {
            gridViewProducts.EditIndex = e.NewEditIndex;
            ProductsBinding();
        }

        protected void gridViewProductsRowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gridViewProducts.EditIndex = -1;
            ProductsBinding();
        }

        protected void gridViewProductsRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int productId = Convert.ToInt32(gridViewProducts.DataKeys[e.RowIndex].Value);

                const string query = "DELETE FROM Products WHERE ProductID = @ProductID";
                var parameters = new[]
                {
            new SqlParameter("@ProductID", productId)
        };

                Database.ExecuteQueryParameters(query, parameters);
                ProductsBinding();
            }
            catch (Exception ex)
            {
                ShowError($"Delete failed: {ex.Message}");
            }
        }


        protected void gridViewProductsRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int productId = Convert.ToInt32(gridViewProducts.DataKeys[e.RowIndex].Value);
                GridViewRow row = gridViewProducts.Rows[e.RowIndex];

                // Get controls
                DropDownList ddlCategories = (DropDownList)row.FindControl("ddlCategories");
                TextBox txtName = (TextBox)row.FindControl("txtName");
                TextBox txtDescription = (TextBox)row.FindControl("txtDescription");
                TextBox txtPrice = (TextBox)row.FindControl("txtPrice");
                TextBox txtImageURL = (TextBox)row.FindControl("txtImageURL");

                const string query = @"
            UPDATE Products SET 
                Name = @Name,
                Description = @Description,
                Price = @Price,
                CategoryID = @CategoryID,
                ImageURL = @ImageURL
            WHERE ProductID = @ProductID";

                var parameters = new[]
                {
            new SqlParameter("@Name", txtName.Text),
            new SqlParameter("@Description", txtDescription.Text),
            new SqlParameter("@Price", Convert.ToDecimal(txtPrice.Text)),
            new SqlParameter("@CategoryID", Convert.ToInt32(ddlCategories.SelectedValue)),
            new SqlParameter("@ImageURL", txtImageURL.Text),
            new SqlParameter("@ProductID", productId)
        };

                Database.ExecuteQueryParameters(query, parameters);
                gridViewProducts.EditIndex = -1;
                ProductsBinding();
            }
            catch (Exception ex)
            {
                ShowError($"Update failed: {ex.Message}");
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            try
            {
                const string query = @"
            INSERT INTO Products 
                (Name, Description, Price, CategoryID, ImageURL)
            VALUES 
                (@Name, @Description, @Price, @CategoryID, @ImageURL)";

                var parameters = new[]
                {
            new SqlParameter("@Name", txtName.Text.Trim()),
            new SqlParameter("@Description", txtDescription.Text.Trim()),
            new SqlParameter("@Price", Convert.ToDecimal(txtPrice.Text)),
            new SqlParameter("@CategoryID", ddlCategory.SelectedValue),
            new SqlParameter("@ImageURL", txtImageURL.Text.Trim())
        };

                Database.ExecuteQueryParameters(query, parameters);
                ClearProductForm();
                ProductsBinding();
            }
            catch (Exception ex)
            {
                ShowError($"Add failed: {ex.Message}");
            }
        }

        private void ClearProductForm()
        {
            txtName.Text = string.Empty;
            txtPrice.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtImageURL.Text = string.Empty;
            ddlCategory.SelectedIndex = 0;
        }

        private void OrdersBinding()
        {
            const string query = @"
        SELECT o.*, u.Username 
        FROM Orders o
        INNER JOIN Users u ON o.UserID = u.UserID
        ORDER BY o.OrderDate DESC";

            DataTable dt = Database.GetDataParameters(query, new SqlParameter[0]);
            gridViewOrders.DataSource = dt;
            gridViewOrders.DataBind();
        }

        protected void gridViewOrdersRowEditing(object sender, GridViewEditEventArgs e)
        {
            gridViewOrders.EditIndex = e.NewEditIndex;
            OrdersBinding();
        }

        protected void gridViewOrdersRowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gridViewOrders.EditIndex = -1;
            OrdersBinding();
        }

        protected void gridViewOrdersRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int orderId = Convert.ToInt32(gridViewOrders.DataKeys[e.RowIndex].Value);
                DropDownList ddlStatus = (DropDownList)gridViewOrders.Rows[e.RowIndex].FindControl("ddlStatus");

                const string query = @"
            UPDATE Orders 
            SET OrderStatus = @Status 
            WHERE OrderID = @OrderID";

                var parameters = new[]
                {
            new SqlParameter("@Status", ddlStatus.SelectedValue),
            new SqlParameter("@OrderID", orderId)
        };

                Database.ExecuteQueryParameters(query, parameters);
                gridViewOrders.EditIndex = -1;
                OrdersBinding();
            }
            catch (Exception ex)
            {
                ShowError($"Order update failed: {ex.Message}");
            }
        }

        private void ShowError(string message)
        {
            ClientScript.RegisterStartupScript(
                GetType(),
                "alert",
                $"alert('{message.Replace("'", @"\'")}');",
                true
            );
        }


        private void UsersBinding()
        {
            const string query = "SELECT UserID, Username, Email, Role FROM Users";
            DataTable dt = Database.GetDataParameters(query, new SqlParameter[0]);
            gridViewUsers.DataSource = dt;
            gridViewUsers.DataBind();
        }

        protected void gridViewUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gridViewUsers.EditIndex = e.NewEditIndex;
            UsersBinding();
        }

        protected void gridViewUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gridViewUsers.EditIndex = -1;
            UsersBinding();
        }

        protected void gridViewUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(gridViewUsers.DataKeys[e.RowIndex].Value);
                GridViewRow row = gridViewUsers.Rows[e.RowIndex];

                TextBox txtUsername = (TextBox)row.FindControl("txtUsername");
                TextBox txtEmail = (TextBox)row.FindControl("txtEmail");
                DropDownList ddlRoles = (DropDownList)row.FindControl("ddlRoles");

                const string query = @"
            UPDATE Users 
            SET Username = @Username,
                Email = @Email,
                Role = @Role
            WHERE UserID = @UserID";

                var parameters = new[]
                {
            new SqlParameter("@Username", txtUsername.Text),
            new SqlParameter("@Email", txtEmail.Text),
            new SqlParameter("@Role", ddlRoles.SelectedValue),
            new SqlParameter("@UserID", userId)
        };

                Database.ExecuteQueryParameters(query, parameters);
                gridViewUsers.EditIndex = -1;
                UsersBinding();
            }
            catch (Exception ex)
            {
                ShowError($"User update failed: {ex.Message}");
            }
        }

        protected void gridViewUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(gridViewUsers.DataKeys[e.RowIndex].Value);

                const string query = "DELETE FROM Users WHERE UserID = @UserID";
                var parameters = new[] { new SqlParameter("@UserID", userId) };

                Database.ExecuteQueryParameters(query, parameters);
                UsersBinding();
            }
            catch (Exception ex)
            {
                ShowError($"Delete failed: {ex.Message}");
            }
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            try
            {
                const string query = @"
            INSERT INTO Users (Username, Password, Email, Role)
            VALUES (@Username, @Password, @Email, @Role)";

                var parameters = new[]
                {
            new SqlParameter("@Username", txtNewUsername.Text.Trim()),
            new SqlParameter("@Password", txtNewPassword.Text), // Plain text as instructed
            new SqlParameter("@Email", txtNewEmail.Text.Trim()),
            new SqlParameter("@Role", ddlNewRole.SelectedValue)
        };

                Database.ExecuteQueryParameters(query, parameters);
                ClearUserForm();
                UsersBinding();
            }
            catch (Exception ex)
            {
                ShowError($"Add user failed: {ex.Message}");
            }
        }

        private void ClearUserForm()
        {
            txtNewUsername.Text = string.Empty;
            txtNewEmail.Text = string.Empty;
            txtNewPassword.Text = string.Empty;
            ddlNewRole.SelectedValue = "User"; // Reset to default role
        }

    }
}