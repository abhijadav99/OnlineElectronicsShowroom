<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineElectronicsShowroom.Login" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex justify-content-center align-items-center" style="min-height: 100vh; background: linear-gradient(to right, #f8e1e7, #ffe6ec);">
        <div class="col-md-4 col-sm-8 py-3">
            <div class="card shadow-lg border-0 rounded-4" style="backdrop-filter: blur(10px); background-color: rgba(255, 255, 255, 0.75);">
                <div class="card-header text-center rounded-top-4 py-4" style="background-color: var(--primary-color); color: #fff;">
                    <h3 class="mb-0 fw-semibold">Welcome Back</h3>
                    <p class="mb-0 small">Login to your account</p>
                </div>
                <div class="card-body p-4 d-flex flex-column justify-content-center align-items-center">
                    <div class="mb-3 w-100">
                        <label class="form-label fw-semibold">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control w-100 rounded-pill shadow-sm" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername"
                            ErrorMessage="Please enter the correct User name" CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <div class="mb-3 w-100">
                        <label class="form-label fw-semibold">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control w-100 rounded-pill shadow-sm" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Please Enter correct password" CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Sign In"
                        CssClass="btn w-100 rounded-pill text-white shadow-sm mt-2"
                        Style="background-color: var(--primary-color);" OnClick="loginButton" />
                    
                    <div class="text-center mt-3">
                        <span class="small">Don't have an account? <a href="Register.aspx" class="text-decoration-none" style="color: var(--accent-color); font-weight: 500;">Sign Up</a></span>
                    </div>
                    <asp:Literal ID="ltMessage" runat="server" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
