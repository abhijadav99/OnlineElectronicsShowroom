<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OnlineElectronicsShowroom.Cart" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">Shopping Cart</h2>
    <div class="table-responsive">
   
        <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="false" 
            DataKeyNames="ProductID" OnRowCommand="gvCart_RowCommand"
            CssClass="table table-striped" OnRowDataBound="gvCart_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="Product Image">
                    <ItemTemplate>
                        <img src='<%# Eval("ImageURL") %>' alt='<%# Eval("Name") %>' 
                            class="img-thumbnail" style="max-width: 100px;"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Product" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" 
                            Text='<%# Eval("Quantity") %>' TextMode="Number" 
                            Width="60" CssClass="form-control" AutoPostBack="true" 
                            OnTextChanged="txtQuantity_TextChanged" />
                        <asp:RangeValidator runat="server" ControlToValidate="txtQuantity" 
                            MinimumValue="1" MaximumValue="99" Type="Integer" 
                            ErrorMessage="Must be 1-99" Display="Dynamic" CssClass="text-danger" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total">
                        <ItemTemplate>
                            <asp:Label ID="lblTotal" runat="server" 
                                Text='<%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button runat="server" CommandName="Remove" Text="Remove" 
                            CommandArgument='<%# Eval("ProductID") %>' 
                            CssClass="btn btn-danger" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div class="text-end mt-4">
        <h4>Total: <asp:Literal ID="ltTotal" runat="server"/></h4>
        <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" 
            CssClass="btn btn-primary btn-lg" OnClick="btnCheckout_Click"/>
    </div>
</asp:Content>

