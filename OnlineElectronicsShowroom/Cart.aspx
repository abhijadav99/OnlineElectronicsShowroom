<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OnlineElectronicsShowroom.Cart" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="text-center mb-5 fw-bold">🛒 My Cart</h2>

    <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="false" 
        DataKeyNames="ProductID" OnRowCommand="gvCart_RowCommand"
        CssClass="table border-0 w-100" OnRowDataBound="gvCart_RowDataBound"
        GridLines="None" ShowHeader="False">

        <RowStyle CssClass="align-middle" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="card shadow-sm border-0 mb-4 rounded-4">
                        <div class="row g-0 p-3 align-items-center">
                            <div class="col-md-2 text-center">
                                <img src='<%# Eval("ImageURL") %>' alt='<%# Eval("Name") %>' 
                                    class="img-fluid rounded-3 border" style="height: 90px; object-fit: cover;" />
                            </div>

                            <div class="col-md-4">
                                <h5 class="fw-semibold mb-1"><%# Eval("Name") %></h5>
                                <p class="text-muted mb-0">Price: <strong>$<%# Eval("Price", "{0:F2}") %></strong></p>
                            </div>

                            <div class="col-md-2 text-center">
                                <asp:TextBox ID="txtQuantity" runat="server" 
                                    Text='<%# Eval("Quantity") %>' TextMode="Number" 
                                    CssClass="form-control form-control-sm text-center rounded-pill w-75 mx-auto" 
                                    AutoPostBack="true" OnTextChanged="txtQuantity_TextChanged" />
                                <asp:RangeValidator runat="server" ControlToValidate="txtQuantity" 
                                    MinimumValue="1" MaximumValue="99" Type="Integer" 
                                    ErrorMessage="Quantity" CssClass="text-danger small d-block" Display="Dynamic" />
                            </div>

                            <div class="col-md-2 text-center">
                                <asp:Label ID="lblTotal" runat="server" 
                                    CssClass="fw-bold" 
                                    Text='<%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %>' />
                            </div>

                            <div class="col-md-2 text-end">
                                <asp:Button runat="server" CommandName="Remove" Text="Remove" 
                                    CommandArgument='<%# Eval("ProductID") %>' 
                                    CssClass="btn btn-outline-danger btn-sm rounded-pill px-3" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <!-- Grand Total and Checkout Button -->
    <div class="d-flex justify-content-between align-items-center mt-4 border-top pt-4 mb-5">
        <h4 class="mb-0">Total Amount: <asp:Literal ID="ltTotal" runat="server" /></h4>
        <asp:Button ID="btnCheckout" runat="server" Text="Checkout Now" 
            CssClass="btn btn-lg btn-primary rounded-pill px-5" OnClick="btnCheckout_Click" />
    </div>
</asp:Content>


