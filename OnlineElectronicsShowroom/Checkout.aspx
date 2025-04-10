<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="OnlineElectronicsShowroom.Checkout" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <div class="row g-4">
            <!-- Shipping Information Card -->
            <div class="col-lg-6">
                <div class="card shadow-sm rounded-4">
                    <div class="card-body">
                        <h4 class="card-title mb-4 text-primary">Shipping Information</h4>

                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Full Name" />
                            <label for="txtFullName">Full Name</label>
                        </div>

                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Street Address" />
                            <label for="txtAddress">Street Address</label>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City" />
                                    <label for="txtCity">City</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <asp:TextBox ID="txtState" runat="server" CssClass="form-control" placeholder="State" />
                                    <label for="txtState">State</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" placeholder="Zip Code" />
                                    <label for="txtZip">Zip Code</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Summary Card -->
            <div class="col-lg-6">
                <div class="card shadow-sm rounded-4">
                    <div class="card-body">
                        <h4 class="card-title mb-4 text-primary">Order Summary</h4>

                        <asp:Repeater ID="rptOrderSummary" runat="server">
                            <ItemTemplate>
                                <div class="d-flex justify-content-between py-1 border-bottom">
                                    <span><%# Eval("Name") %> x <%# Eval("Quantity") %></span>
                                    <span class="text-end">₹ <%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %></span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <hr class="my-3" />
                        <div class="d-flex justify-content-between fw-bold fs-5">
                            <span>Total:</span>
                            <asp:Literal ID="ltTotal" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Place Order Button -->
        <div class="text-end mt-4">
            <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" 
                CssClass="btn btn-success btn-lg px-5" OnClick="btnPlaceOrder_Click" />
        </div>
    </div>
</asp:Content>

