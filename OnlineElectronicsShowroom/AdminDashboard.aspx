<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="OnlineElectronicsShowroom.AdminDashboard" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        

    <div class="container-fluid">
       
            <!-- Products CARD -->
            <div class="card">
                <div class="card-header mb-3"  style="background-color: var(--primary-color) !important; color: var(--secondary-color) !important;">
                    <h4>Product Management</h4>
                </div>
               
                
                <asp:GridView ID="gridViewProducts" runat="server" 
                    OnRowEditing="gridViewProductsRowEditing"
                    OnRowUpdating="gridViewProductsRowUpdating"
                    OnRowCancelingEdit="gridViewProductsRowCancelingEdit" 
                    OnRowDeleting="gridViewProductsRowDeleting"
                    AutoGenerateColumns="false"
                    DataKeyNames="ProductID"
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
                                   ValidationGroup="EditProduct" CssClass="btn btn-sm" />
                               <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" 
                                   CausesValidation="false" CssClass="btn btn-sm" />
                           </EditItemTemplate>
                       </asp:TemplateField>
                           <asp:TemplateField HeaderText="Image">
                               <ItemTemplate>
                                   <img src='<%# Eval("ImageURL") %>' alt="Product Image" style="max-width: 100px;"/>
                               </ItemTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox ID="txtImageURL" runat="server" 
                                       Text='<%# Bind("ImageURL") %>' CssClass="form-control"/>
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
                </asp:GridView>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:OnlineElectronicsShowroomDB %>"
                    SelectCommand="SELECT * FROM Categories"></asp:SqlDataSource>
                </div>
        <div class="card">
            <div class="card-header mb-3"  style="background-color: var(--primary-color) !important; color: var(--secondary-color) !important;">
                <h4>Add New Product</h4>
            </div>
                <div class="row g-3 m-2">
                    <div class="col-md-4">
                        <asp:TextBox ID="txtName" runat="server" placeholder="Product Name" CssClass="form-control"/>
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
            <!-- Orders Tab -->
             <div class="card">
                 <div class="card-header mb-3"  style="background-color: var(--primary-color) !important; color: var(--secondary-color) !important;">
                        <h4>Order Management</h4>
                    </div>
                
                <!-- Order GridView -->
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
                </asp:GridView>
            </div>

            <!-- Users Tab -->
             <div class="card">
                 <div class="card-header  mb-2"  style="background-color: var(--primary-color) !important; color: var(--secondary-color) !important;">
                       <h4>User Management</h4>
                   </div>
                
                   <asp:GridView ID="gridViewUsers" runat="server"
                    AutoGenerateColumns="false"
                    DataKeyNames="UserID"
                    OnRowEditing="gridViewUsers_RowEditing"
                    OnRowUpdating="gridViewUsers_RowUpdating"
                    OnRowCancelingEdit="gridViewUsers_RowCancelingEdit"
                    OnRowDeleting="gridViewUsers_RowDeleting"
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
                </asp:GridView>
                 </div>
                 <div class="card">
                     <div class="card-header  mb-2"  style="background-color: var(--primary-color) !important; color: var(--secondary-color) !important;">
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
                        <!-- Add this new dropdown -->
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


</asp:Content>
