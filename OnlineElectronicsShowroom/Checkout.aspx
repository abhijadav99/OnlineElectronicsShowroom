<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="OnlineElectronicsShowroom.Checkout" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">Checkout</h2>
    
    <div class="row g-3">
        <div class="col-md-6">
            <h4 class="mb-3">Shipping Information</h4>
            <div class="form-group mb-2">
                <asp:TextBox ID="txtFullName" runat="server" placeholder="Full Name" 
                    CssClass="form-control" Required="true"/>
            </div>
            <div class="form-group mb-2">
                <asp:TextBox ID="txtAddress" runat="server" placeholder="Street Address" 
                    CssClass="form-control" Required="true" TextMode="MultiLine" Rows="2"/>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:TextBox ID="txtCity" runat="server" placeholder="City" 
                        CssClass="form-control" Required="true"/>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtState" runat="server" placeholder="State" 
                        CssClass="form-control" Required="true"/>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtZip" runat="server" placeholder="Zip Code" 
                        CssClass="form-control" Required="true"/>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <h4>Order Summary</h4>
            <asp:Repeater ID="rptOrderSummary" runat="server">
                <ItemTemplate>
                    <div class="d-flex justify-content-between">
                        <span><%# Eval("Name") %> x <%# Eval("Quantity") %></span>
                        <span><%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %></span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <hr />
            <div class="d-flex justify-content-between fw-bold">
                <span>Total:</span>
                <asp:Literal ID="ltTotal" runat="server"/>
            </div>
        </div>
    </div>
    
    <div class="mt-4 text-end">
        <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" 
            CssClass="btn btn-primary btn-lg" OnClick="btnPlaceOrder_Click"/>
    </div>
</asp:Content>

