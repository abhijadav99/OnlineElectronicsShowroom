<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="OnlineElectronicsShowroom.AdminDashboard" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid admin-dashboard">
        <!-- Product Management Section -->
        <div class="card shadow-lg mb-4">
            <div class="card-header admin-header" style="background-color: var(--primary-color) !important; color: var(--secondary-color) !important;">
                <h4 class="mb-0"><i class="bi bi-cpu me-2"></i>Product Management</h4>
            </div>
            <div class="card-body">
                <asp:GridView ID="gridViewProducts" runat="server" 
                    CssClass="table table-hover align-middle admin-table"
                    GridLines="None" 
                    AutoGenerateColumns="false"
                    DataKeyNames="ProductID"
                    OnRowEditing="gridViewProductsRowEditing"
                    OnRowUpdating="gridViewProductsRowUpdating"
                    OnRowCancelingEdit="gridViewProductsRowCancelingEdit" 
                    OnRowDeleting="gridViewProductsRowDeleting">
                    <Columns>
                         
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-sm" />
                                    <asp:LinkButton runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-sm"
                                        OnClientClick="return confirm('Are you sure?');" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton runat="server" CommandName="Update" Text="Update" 
                                        ValidationGroup="EditProduct" CssClass="btn btn-sm" />
                                    <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" 
                                        CausesValidation="false" CssClass="btn btn-sm" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                        <asp:TemplateField HeaderText="Image" HeaderStyle-CssClass="ps-3">
                            <ItemTemplate>
                                <div class="product-image-container">
                                    <img src='<%# Eval("ImageURL") %>' alt="Product" class="product-thumbnail"/>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtImageURL" runat="server" 
                                    Text='<%# Bind("ImageURL") %>' CssClass="form-control form-control-sm"/>
                            </EditItemTemplate>
                        </asp:TemplateField>

                                  <asp:TemplateField HeaderText="Product Name">
               <ItemTemplate>
                   <%# Eval("Name") %>
               </ItemTemplate>
               <EditItemTemplate>
                   <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control"/>
               </EditItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="Description">
               <ItemTemplate>
                   <%# Eval("Description") %>
               </ItemTemplate>
               <EditItemTemplate>
                   <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' 
                       TextMode="MultiLine" CssClass="form-control"/>
               </EditItemTemplate>
           </asp:TemplateField>
               <asp:TemplateField HeaderText="Price">
                   <ItemTemplate>
                       <%# Eval("Price", "{0:C}") %>
                   </ItemTemplate>
                   <EditItemTemplate>
                       <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' 
                           CssClass="form-control"/>
                       <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrice"
                           ErrorMessage="Required" ValidationGroup="EditProduct"
                           CssClass="text-danger" Display="Dynamic"/>
                       <asp:CompareValidator runat="server" ControlToValidate="txtPrice"
                           Type="Currency" Operator="DataTypeCheck" ValidationGroup="EditProduct"
                           ErrorMessage="Invalid" CssClass="text-danger" Display="Dynamic"/>
                   </EditItemTemplate>
               </asp:TemplateField>
                   <asp:TemplateField HeaderText="Category">
                       <ItemTemplate>
                           <%# Eval("CategoryName") %>
                       </ItemTemplate>
                        <EditItemTemplate>
                <asp:DropDownList ID="ddlCategories" runat="server"
                    DataSourceID="SqlDataSource1" DataTextField="CategoryName" 
                    DataValueField="CategoryID" SelectedValue='<%# Bind("CategoryID") %>'
                    CssClass="form-select"/>
            </EditItemTemplate>
           </asp:TemplateField>
      
                        
                    </Columns>
                    <HeaderStyle CssClass="admin-table-header" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:OnlineElectronicsShowroomDB %>"
                    SelectCommand="SELECT * FROM Categories"></asp:SqlDataSource>
                </div>
                <!-- Add Product Form -->
                <div class="card add-item-card mt-4">
                    <div class="card-body">
                        <h5 class="card-title mb-4"><i class="bi bi-plus-circle me-2"></i>Add New Product</h5>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Product Name"/>
                                    <label for="txtName">Product Name</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtPrice" runat="server" placeholder="Price" CssClass="form-control"/>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrice"
                                    ErrorMessage="Price required" ValidationGroup="AddProduct"
                                    CssClass="text-danger" Display="Dynamic"/>
                                <asp:CompareValidator runat="server" ControlToValidate="txtPrice"
                                    Type="Currency" Operator="DataTypeCheck" ValidationGroup="AddProduct"
                                    ErrorMessage="Invalid price format" CssClass="text-danger" Display="Dynamic"/>
                            </div>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddlCategory" runat="server" 
                                    DataSourceID="SqlDataSource1" DataTextField="CategoryName" 
                                    DataValueField="CategoryID" CssClass="form-select"/>
                            </div>
                            <div class="col-12">
                                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3"
                                    placeholder="Description" CssClass="form-control"/>
                            </div>
                            <div class="col-12">
                                <asp:TextBox ID="txtImageURL" runat="server" 
                                    placeholder="Image URL" CssClass="form-control"/>
                            </div>
                            <div class="col-md-12">
                                <asp:Button ID="btnAddProduct" runat="server" Text="Add Product" 
                                    CssClass="btn btn-primary" ValidationGroup="AddProduct"
                                    OnClick="btnAddProduct_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Management Section -->
        <div class="card shadow-lg mb-4">
            <div class="card-header admin-header">
                <h4 class="mb-0"><i class="bi bi-clipboard me-2"></i>Order Management</h4>
            </div>
            <div class="card-body">
                <asp:GridView ID="gridViewOrders" runat="server" 
    AutoGenerateColumns="false"
    DataKeyNames="OrderID"
    OnRowEditing="gridViewOrdersRowEditing"
    OnRowUpdating="gridViewOrdersRowUpdating"
    OnRowCancelingEdit="gridViewOrdersRowCancelingEdit"
    CssClass="table table-striped">
    <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-sm" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:LinkButton runat="server" CommandName="Update" Text="Update" 
                        ValidationGroup="EditOrder" CssClass="btn btn-sm" />
                    <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" 
                        CausesValidation="false" CssClass="btn btn-sm" />
                </EditItemTemplate>
        </asp:TemplateField>

            <asp:BoundField DataField="OrderID" HeaderText="Order ID" ReadOnly="true" />
            <asp:BoundField DataField="Username" HeaderText="Customer" ReadOnly="true" />
            <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:d}" ReadOnly="true" />
            <asp:BoundField DataField="TotalAmount" HeaderText="Total" DataFormatString="{0:C}" ReadOnly="true" />
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <%# Eval("OrderStatus") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select"
                        SelectedValue='<%# Bind("OrderStatus") %>'>
                        <asp:ListItem>Pending</asp:ListItem>
                        <asp:ListItem>Shipped</asp:ListItem>
                        <asp:ListItem>Delivered</asp:ListItem>
                        <asp:ListItem>Cancelled</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Shipping Info">
                <ItemTemplate>
                    <div class="small">
                        <%# Eval("ShippingName") %><br />
                        <%# Eval("ShippingAddress") %><br />
                        <%# Eval("ShippingCity") %>, <%# Eval("ShippingState") %> <%# Eval("ShippingZip") %>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
                    <HeaderStyle CssClass="admin-table-header" />
</asp:GridView>
            </div>
        </div>

        <!-- User Management Section -->
        <div class="card shadow-lg">
            <div class="card-header admin-header">
                <h4 class="mb-0"><i class="bi bi-people me-2"></i>User Management</h4>
            </div>
            <div class="card-body">
                   <asp:GridView ID="gridViewUsers" runat="server"
                        AutoGenerateColumns="false"
                        DataKeyNames="UserID"
                        OnRowEditing="gridUserViewRowEditing"
                        OnRowUpdating="gridUserViewRowUpdating"
                        OnRowCancelingEdit="gridUserViewRowCancelingEdit"
                        OnRowDeleting="gridUserViewRowDeleting"
                        CssClass="table table-striped">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-sm" />
                                    <asp:LinkButton runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-sm"
                                        OnClientClick="return confirm('Are you sure?');" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton runat="server" CommandName="Update" Text="Update" 
                                        ValidationGroup="EditUser" CssClass="btn btn-sm" />
                                    <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" 
                                        CausesValidation="false" CssClass="btn btn-sm" />
                                </EditItemTemplate>
                            </asp:TemplateField>
    
                            <asp:TemplateField HeaderText="Username">
                                <ItemTemplate><%# Eval("Username") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtUsername" runat="server" Text='<%# Bind("Username") %>' 
                                        CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername"
                                        ErrorMessage="Required" ValidationGroup="EditUser"
                                        CssClass="text-danger" Display="Dynamic"/>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Email">
                                <ItemTemplate><%# Eval("Email") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' 
                                        CssClass="form-control" TextMode="Email"/>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                                        ErrorMessage="Required" ValidationGroup="EditUser"
                                        CssClass="text-danger" Display="Dynamic"/>
                                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        ErrorMessage="Invalid email" ValidationGroup="EditUser"
                                        CssClass="text-danger" Display="Dynamic"/>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Role">
                                <ItemTemplate><%# Eval("Role") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlRoles" runat="server" CssClass="form-select"
                                        SelectedValue='<%# Bind("Role") %>'>
                                        <asp:ListItem>Admin</asp:ListItem>
                                        <asp:ListItem>User</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                       <HeaderStyle CssClass="admin-table-header" />
                    </asp:GridView>
            </div>
            <div class="card">
    <div class="card-header mb-2">
         <h4>Add New User</h4>
     </div>
   <div class="row g-3 m-2">
       <div class="col-md-4">
           <asp:TextBox ID="txtNewUsername" runat="server" placeholder="Username" 
               CssClass="form-control"/>
           <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewUsername"
               ErrorMessage="Required" ValidationGroup="AddUser"
               CssClass="text-danger" Display="Dynamic"/>
       </div>
       <div class="col-md-4">
           <asp:TextBox ID="txtNewEmail" runat="server" placeholder="Email" 
               CssClass="form-control" TextMode="Email"/>
           <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewEmail"
               ErrorMessage="Required" ValidationGroup="AddUser"
               CssClass="text-danger" Display="Dynamic"/>
           <asp:RegularExpressionValidator runat="server" ControlToValidate="txtNewEmail"
               ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
               ErrorMessage="Invalid email" ValidationGroup="AddUser"
               CssClass="text-danger" Display="Dynamic"/>
       </div>
       <div class="col-md-4">
           <asp:TextBox ID="txtNewPassword" runat="server" placeholder="Password" 
               CssClass="form-control" TextMode="Password"/>
           <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewPassword"
               ErrorMessage="Required" ValidationGroup="AddUser"
               CssClass="text-danger" Display="Dynamic"/>
       </div>
       <div class="col-md-4">
           <asp:DropDownList ID="ddlNewRole" runat="server" CssClass="form-select"
               ValidationGroup="AddUser">
               <asp:ListItem Value="User">User</asp:ListItem>
               <asp:ListItem Value="Admin">Admin</asp:ListItem>
           </asp:DropDownList>
           <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlNewRole"
               ErrorMessage="Role required" ValidationGroup="AddUser"
               CssClass="text-danger" Display="Dynamic"/>
       </div>
       <div class="col-md-12">
           <asp:Button ID="btnAddUser" runat="server" Text="Add User" 
               CssClass="btn btn-primary" ValidationGroup="AddUser"
               OnClick="btnAddUser_Click"/>
       </div>
   </div>
        </div>
    </div>

    <style>
        .admin-dashboard {
            background: #f8f9fa;
            padding: 2rem 0;
        }

        .admin-header {
            background-color: var(--primary-color) !important;
            color: var(--secondary-color) !important;
            border-radius: 0.5rem 0.5rem 0 0 !important;
            padding: 1.25rem 1.5rem;
        }

        .admin-table {
            border-radius: 0.5rem;
            overflow: hidden;
        }

        .admin-table-header {
            background-color: var(--primary-color) !important;
            color: var(--secondary-color) !important;
            font-weight: 500;
        }

        .product-thumbnail {
            width: 80px;
            height: 80px;
            object-fit: contain;
            border-radius: 0.5rem;
            background: white;
            padding: 0.25rem;
            border: 1px solid #dee2e6;
        }

        .status-badge {
            padding: 0.35rem 0.75rem;
            border-radius: 1rem;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-badge.pending { background: #fff3cd; color: #856404; }
        .status-badge.shipped { background: #cfe2ff; color: #052c65; }
        .status-badge.delivered { background: #d1e7dd; color: #0a3622; }
        .status-badge.cancelled { background: #f8d7da; color: #58151c; }

        .btn-icon {
            padding: 0.375rem;
            margin: 0 0.25rem;
            line-height: 1;
        }

        .add-item-card {
            border: 1px dashed #dee2e6;
            background: rgba(236, 240, 241, 0.3);
        }

        .form-floating label {
            color: #7b8a8b;
            font-size: 0.9rem;
        }
    </style>
</asp:Content>
