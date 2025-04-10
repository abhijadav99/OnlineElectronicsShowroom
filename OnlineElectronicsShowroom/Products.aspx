<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="OnlineElectronicsShowroom.Products" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Header Section -->
    <section class="text-center my-5">
        <h1 class="fw-bold display-5 text-gradient">Discover Top Deals</h1>
        <p class="lead text-muted">Find the perfect gadget that fits your lifestyle</p>
    </section>

    <!-- Category Filter -->
    <div class="row justify-content-center mb-4">
        <div class="col-md-6 col-sm-10">
            <asp:DropDownList 
                ID="ddlCategories" 
                runat="server" 
                AutoPostBack="True" 
                OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged"
                CssClass="form-select form-select-lg category-select shadow-sm">
            </asp:DropDownList>
        </div>
    </div>

    <!-- Message Display -->
    <asp:Literal ID="ltMessage" runat="server" EnableViewState="false" />

    <!-- Products Grid -->
    <div class="row g-4 mb-4">
        <asp:Repeater ID="rptProducts" runat="server">
            <ItemTemplate>
                <div class="col-md-4 col-sm-6">
                    <div class="card product-card h-100">
                        <div class="position-relative">
                            <img src='<%# Eval("ImageURL") %>' alt='<%# Eval("Name") %>' class="img-fluid" style="height: 300px; object-fit: cover;" />
                            <span class="badge bg-success position-absolute top-0 end-0 m-2 px-3 py-2">New</span>
                        </div>
                        <div class="card-body d-flex flex-column justify-content-between">
                            <div>
                                <h5 class="fw-semibold mb-2"><%# Eval("Name") %></h5>
                                <p class="text-muted small mb-3" style="min-height: 60px;"><%# Eval("Description") %></p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-auto">
                                <span class="h5 fw-bold" style="color: var(--primary-color);">$<%# Eval("Price", "{0:F2}") %></span>
                                <asp:Button 
                                    runat="server" 
                                    Text="Add to Cart" 
                                    CommandArgument='<%# Eval("ProductID") %>' 
                                    CssClass="custom-btn"
                                    OnClick="btnAddToCart_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>


