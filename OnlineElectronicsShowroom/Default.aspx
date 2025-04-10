<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="OnlineElectronicsShowroom._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Sales Banner -->
    <div class="hero-banner text-white text-center d-flex align-items-center">      
    </div>

    <!-- Featured Categories -->
    <div class="container py-5">
        <h2 class="text-center fw-bold mb-5">Explore Popular Categories</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 shadow category-card">
                    <img src="Images/category-laptop.jpg" class="card-img-top" alt="Laptops">
                    <div class="card-body">
                        <h5 class="card-title">Laptops</h5>
                        <p class="card-text">Latest models from top brands at unbeatable prices.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 shadow category-card">
                    <img src="Images/category-smartphones.jpg" class="card-img-top" alt="Smartphones">
                    <div class="card-body">
                        <h5 class="card-title">Smartphones</h5>
                        <p class="card-text">Discover the latest tech in mobile innovation.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 shadow category-card">
                    <img src="Images/category-home-appliances.jpg" class="card-img-top" alt="Home Appliances">
                    <div class="card-body">
                        <h5 class="card-title">Home Appliances</h5>
                        <p class="card-text">Make life easier with smart home gadgets.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Offers -->
    <section class="bg-light py-5">
        <div class="container">
            <h2 class="text-center fw-bold mb-5">Recent Offers</h2>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4">
                    <div class="offer-card shadow-sm p-3 h-100">
                        <img src="Images/offer-tv.jpg" class="img-fluid rounded mb-3" alt="4K TV Offer">
                        <h5>4K Smart TVs</h5>
                        <p class="mb-0">Get up to 40% OFF on selected models. Limited time only!</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="offer-card shadow-sm p-3 h-100">
                        <img src="Images/offer-headphones.jpg" class="img-fluid rounded mb-3" alt="Headphone Offer">
                        <h5>Wireless Headphones</h5>
                        <p class="mb-0">Buy 1 Get 1 Free on Noise-Cancelling Series.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="offer-card shadow-sm p-3 h-100">
                        <img src="Images/offer-gaming.jpg" class="img-fluid rounded mb-3" alt="Gaming Offer">
                        <h5>Gaming Bundles</h5>
                        <p class="mb-0">Get exclusive gaming combo deals with every console purchase.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>



