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
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack && User.Identity.IsAuthenticated)
            {
                LoadingCartItems();
            }
        }

        private void LoadingCartItems()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            string query = @"
        SELECT c.CartID, c.ProductID, c.Quantity, 
               p.Name, p.Price, p.ImageURL
        FROM Cart c
        INNER JOIN Products p ON c.ProductID = p.ProductID
        WHERE c.UserID = @UserID";

            SqlParameter[] parameters = {
        new SqlParameter("@UserID", userId)
    };

            DataTable dt = Database.GetDataParameters(query, parameters);

            gvCart.DataSource = dt;
            gvCart.DataBind();

            UpdateTotal(dt);
        }

        private void UpdateTotal(DataTable dt)
        {
            decimal total = 0;

            foreach (DataRow row in dt.Rows)
            {
                if (row["Price"] != DBNull.Value && row["Quantity"] != DBNull.Value)
                {
                    decimal price = Convert.ToDecimal(row["Price"]);
                    int quantity = Convert.ToInt32(row["Quantity"]);
                    total += price * quantity;
                }
            }

            ltTotal.Text = total.ToString("C");
        }

        protected void txtQuantity_TextChanged(object sender, EventArgs e)
        {
            var txtQuantity = sender as TextBox;
            if (txtQuantity == null) return;

            var row = (GridViewRow)txtQuantity.NamingContainer;
            int productId = Convert.ToInt32(gvCart.DataKeys[row.RowIndex].Value);
            int userId = Convert.ToInt32(Session["UserID"]);
            int newQuantity = Convert.ToInt32(txtQuantity.Text);

            string query = @"
        UPDATE Cart 
        SET Quantity = @Quantity 
        WHERE UserID = @UserID AND ProductID = @ProductID";

            SqlParameter[] parameters = {
        new SqlParameter("@Quantity", newQuantity),
        new SqlParameter("@UserID", userId),
        new SqlParameter("@ProductID", productId)
    };

            Database.ExecuteQueryParameters(query, parameters);
            LoadingCartItems();
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Remove") return;

            int productId = Convert.ToInt32(e.CommandArgument);
            int userId = Convert.ToInt32(Session["UserID"]);

            string query = "DELETE FROM Cart WHERE UserID = @UserID AND ProductID = @ProductID";

            SqlParameter[] parameters = {
        new SqlParameter("@UserID", userId),
        new SqlParameter("@ProductID", productId)
    };

            Database.ExecuteQueryParameters(query, parameters);
            LoadingCartItems();
        }

        protected void gvCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow || e.Row.DataItem == null)
                return;

            var lblTotal = e.Row.FindControl("lblTotal") as Label;
            if (lblTotal == null) return;

            var rowView = (DataRowView)e.Row.DataItem;

            if (rowView["Price"] != DBNull.Value && rowView["Quantity"] != DBNull.Value)
            {
                decimal price = Convert.ToDecimal(rowView["Price"]);
                int quantity = Convert.ToInt32(rowView["Quantity"]);
                lblTotal.Text = (price * quantity).ToString("C");
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect(GetRouteUrl("CheckoutRoute", null));
        }

    }
}