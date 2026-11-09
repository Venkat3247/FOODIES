
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.tap.model.Resturant"%>
<%@ page import="com.tap.model.User"%>

<%
    List<Resturant> allResturant =
        (List<Resturant>) request.getAttribute("allResturant");

    if (allResturant == null) {
        allResturant = new ArrayList<Resturant>();
    }

    User loggedInUser =
        (User) session.getAttribute("loggedInUser");

    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Foodies | Restaurants</title>

<link rel="stylesheet" href="<%= ctx %>/css/resturant.css">

<style>
* {
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
    background-color: #FBF1E1 !important;
}

body {
    margin: 0;
    padding: 0;
    font-family: Arial, Helvetica, sans-serif;
    background-color: #FBF1E1 !important;
    color: #07352f;
}

/* Keep all main sections in light mode */
.restaurant-section,
.special-section {
    background-color: #FBF1E1 !important;
    color: #07352f;
}

/* ================= NAVBAR ================= */

.navbar {
    width: 100%;
    min-height: 65px;
    padding: 0 5%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    background: #07352f;
    border-bottom: 2px solid #d9a441;
    box-shadow: 0 5px 20px rgba(0,0,0,.15);
    position: relative;
    z-index: 1000;
}

.logo {
    flex-shrink: 0;
    color: #fff;
    font-size: 27px;
    font-weight: 800;
    text-decoration: none;
}

.logo span {
    color: #d9a441;
}

.nav-links {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    flex-wrap: wrap;
    gap: 5px;
}

.nav-links a {
    min-height: 40px;
    padding: 0 12px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    border-radius: 9px;
    transition: .2s ease;
}

.nav-links a:hover {
    background: #d9a441;
    color: #07352f;
}

.nav-links .login-btn {
    background: #d9a441;
    color: #07352f;
    font-weight: 800;
}

.nav-links .logout-btn {
    border: 1px solid #d9a441;
}

/* ================= HERO SLIDESHOW ================= */

.restaurant-hero {
    position: relative;
    width: 100%;
    min-height: 430px;
    padding: 45px 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    isolation: isolate;
    background: #173c32;
}

.hero-slideshow {
    position: absolute;
    inset: 0;
    z-index: -2;
    overflow: hidden;
    background: #173c32;
}

.hero-slide {
    position: absolute;
    inset: 0;
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
    opacity: 0;
    transform: scale(1);
    transition: opacity 1s ease-in-out, transform 4s ease-in-out;
}

.hero-slide.active {
    opacity: 1;
    transform: scale(1.05);
}

.hero-overlay {
    position: absolute;
    inset: 0;
    z-index: -1;
    background: linear-gradient(
        90deg,
        rgba(0,0,0,.68),
        rgba(0,0,0,.36),
        rgba(0,0,0,.58)
    );
}

.restaurant-hero-content {
    position: relative;
    width: 100%;
    max-width: 850px;
    text-align: center;
      color: #000000;
}

.hero-subtitle {
    margin: 0 0 14px;
    color: #f0c15c;
    font-size: 12px;
    font-weight: 800;
    letter-spacing: 3px;
}

.restaurant-hero-content h1 {
    margin: 0;
    color: #fff;
    font-size: clamp(30px, 4.5vw, 50px);
    font-weight: 800;
    line-height: 1.2;
    text-shadow: 0 3px 12px rgba(0,0,0,.6);
}

.restaurant-hero-content h1 span {
    color: #f0c15c;
}

.hero-description {
    max-width: 600px;
    margin: 18px auto 24px;
    color: #fff;
    font-size: 15px;
    line-height: 1.7;
}

/* ================= SEARCH ================= */

.hero-search {
    display: flex;
    align-items: center;
    width: 100%;
    max-width: 520px;
    height: 50px;
    margin: 0 auto;
    overflow: hidden;
    background: #fff;
    border: 2px solid rgba(255,255,255,.8);
    border-radius: 12px;
    box-shadow: 0 8px 25px rgba(0,0,0,.25);
}

.hero-search input {
    flex: 1;
    width: 0;
    min-width: 0;
    height: 100%;
    padding: 0 15px;
    border: none;
    outline: none;
    color: #07352f;
    background: #fff;
    font-size: 13px;
}

.hero-search button {
    flex-shrink: 0;
    width: 55px;
    height: 100%;
    border: none;
    background: #d9a441;
    color: #07352f;
    font-size: 19px;
    cursor: pointer;
}

.hero-search button:hover {
    background: #efbd52;
}

.hero-explore-btn {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    margin-top: 22px;
    padding: 13px 22px;
    border-radius: 10px;
    background: #d9a441;
    color: #07352f;
    text-decoration: none;
    font-size: 14px;
    font-weight: 800;
    transition: .2s ease;
}

.hero-explore-btn:hover {
    background: #efbd52;
    transform: translateY(-3px);
}

/* ================= RESTAURANT SECTION ================= */

.restaurant-section {
    width: 100%;
    padding: 60px 5%;
}

.section-heading {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 20px;
    margin-bottom: 30px;
}

.section-small {
    margin: 0 0 10px;
    color: #b38325;
    font-size: 12px;
    font-weight: 800;
    letter-spacing: 2px;
}

.section-title {
    margin: 0;
      color: #000000;
    font-size: 30px;
    text-align: center;
}

.view-all {
    color: #07352f;
    font-weight: 700;
    text-decoration: none;
}

.view-all:hover {
    color: #b38325;
}

/* ================= RESTAURANT GRID ================= */

.restaurant-grid {
    display: grid;
    grid-template-columns: repeat(4, minmax(0, 1fr));
    gap: 24px;
    align-items: stretch;
}

/

/* ===== RESTAURANT CARDS ===== */

.restaurant-card {
    display: flex !important;
    flex-direction: column;
    width: 100%;
    min-width: 0;
    height: 100%;
    overflow: hidden;

    background: #FFF9EF !important;
    color: #29231C !important;
    border: 1px solid #EADBC2 !important;
    border-radius: 18px !important;
    box-shadow: 0 8px 22px rgba(85, 60, 25, 0.10) !important;

    transition: transform 0.25s ease, box-shadow 0.25s ease;
}

.restaurant-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 14px 30px rgba(85, 60, 25, 0.16) !important;
}

/* Restaurant image */
.restaurant-image-wrapper {
    position: relative;
    height: 220px;
    flex-shrink: 0;
    overflow: hidden;
    background: #EADBC2 !important;
}

.restaurant-card-image {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
    transition: transform 0.4s ease;
}

.restaurant-card:hover .restaurant-card-image {
    transform: scale(1.05);
}

/* Rating badge */
.restaurant-card .rating-badge {
    position: absolute;
    top: 12px;
    right: 12px;
    padding: 8px 11px;

    background: #174A3A !important;
    color: #FFFFFF !important;
    border: 1px solid #D6A84F;
    border-radius: 10px;

    font-size: 13px;
    font-weight: 700;
}

/* Card content */
.restaurant-card-content {
    display: flex;
    flex-direction: column;
    flex: 1;
    min-width: 0;
    padding: 20px !important;

    background: #FFF9EF !important;
    color: #29231C !important;
}

/* Restaurant name */
.restaurant-card-content h3 {
    margin: 0 0 12px;
    min-height: 46px;

    color: #29231C !important;
    font-size: 21px;
    font-weight: 800;
    line-height: 1.35;

    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
    overflow-wrap: anywhere;
}

/* Cuisine type */
.restaurant-card .restaurant-cuisine {
    min-height: 20px;
    margin-bottom: 12px;

    color: #B8872D !important;
    font-size: 14px;
    font-weight: 700;
}

/* Address */
.restaurant-card .restaurant-address {
    min-height: 58px;
    margin-bottom: 12px;

    color: #756B5D !important;
    font-size: 13px;
    line-height: 1.6;
    overflow: hidden;
    overflow-wrap: anywhere;
}

/* Delivery time and rating */
.restaurant-card .restaurant-info {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 8px;

    min-height: 42px;
    margin-top: auto;
    padding: 10px 0;

    border-top: 1px solid #EADBC2 !important;
    color: #756B5D !important;
    font-size: 13px;
}

.restaurant-card .restaurant-rating {
    flex-shrink: 0;
    color: #B8872D !important;
    font-weight: 800;
}

/* Golden View Menu button */
.restaurant-card .menu-btn {
    display: flex;
    align-items: center;
    justify-content: space-between;

    width: 100%;
    min-height: 48px;
    margin-top: 12px;
    padding: 12px 16px;

    background: linear-gradient(135deg, #E5B653, #C4912D) !important;
    color: #29231C !important;

    border: 1px solid #D6A84F !important;
    border-radius: 11px !important;
    box-shadow: 0 3px 0 #8E6726;

    text-decoration: none;
    font-size: 15px;
    font-weight: 800;

    transition: background 0.2s ease, transform 0.2s ease;
}

.restaurant-card .menu-btn span {
    color: #29231C !important;
    font-size: 20px;
}

.restaurant-card .menu-btn:hover {
    background: #F0C96F !important;
    color: #29231C !important;
    transform: translateY(-2px);
}

.restaurant-card .menu-btn:hover span {
    color: #29231C !important;
}

/* Responsive images */
@media (max-width: 550px) {
    .restaurant-image-wrapper {
        height: 220px;
    }

    .restaurant-card-content {
        padding: 18px !important;
    }
}

/* ================= SPECIALITIES ================= */

.special-section {
    padding: 65px 5%;
    text-align: center;
}

.special-grid {
    max-width: 1200px;
    margin: 35px auto 0;
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 24px;
}

.special-card {
    padding: 28px 22px;
    background: #fff !important;
    border-radius: 17px;
    box-shadow: 0 10px 25px rgba(0,0,0,.06);
}

.special-icon {
    margin-bottom: 12px;
    font-size: 38px;
}

.special-card h3 {
    margin: 10px 0;
    color: #07352f;
}

.special-card p {
    margin-bottom: 0;
    color: #68716e;
    font-size: 14px;
    line-height: 1.7;
}

/* ================= RESPONSIVE ================= */

@media (max-width: 1200px) {
    .restaurant-grid {
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 20px;
    }

    .navbar {
        padding: 12px 3%;
    }
}

@media (max-width: 900px) {
    .navbar {
        flex-direction: column;
        gap: 10px;
        padding: 15px 12px;
    }

    .nav-links {
        justify-content: center;
    }

    .restaurant-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 18px;
    }

    .special-grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 550px) {
    .nav-links {
        gap: 3px;
    }

    .nav-links a {
        min-height: 36px;
        padding: 0 8px;
        font-size: 12px;
    }

    .logo {
        font-size: 25px;
    }

    .restaurant-hero {
        min-height: 380px;
        padding: 40px 16px;
    }

    .hero-subtitle {
        font-size: 10px;
        letter-spacing: 2px;
    }

    .restaurant-hero-content h1 {
        font-size: 30px;
    }

    .hero-description {
        font-size: 13px;
    }

    .hero-search {
        height: 46px;
    }

    .hero-search input {
        padding: 0 10px;
        font-size: 12px;
    }

    .restaurant-section,
    .special-section {
        padding: 45px 5%;
    }

    .restaurant-grid {
        grid-template-columns: 1fr;
        gap: 20px;
    }

    .restaurant-image-wrapper {
        height: 220px;
    }

    .section-heading {
        align-items: flex-start;
        flex-direction: column;
    }

    .section-title {
        font-size: 29px;
        color:black;
    }
}
</style>
</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">
    <a href="<%= ctx %>/resturant" class="logo">
        Food<span>ies</span>
    </a>

    <div class="nav-links">
        <a href="<%= ctx %>/resturant">🏠 Home</a>
        <a href="<%= ctx %>/resturant#restaurants">🍴 Restaurants</a>
        <a href="<%= ctx %>/resturant#restaurants">📋 Menu</a>
        <a href="<%= ctx %>/cart" class="cart-link">🛒 Cart</a>
        <a href="<%= ctx %>/myOrders" class="my-orders-link">📦 My Orders</a>

        <% if (loggedInUser == null) { %>
            <a href="<%= ctx %>/login.html" class="login-btn">👤 Login</a>
        <% } else { %>
            <a href="<%= ctx %>/myOrders" class="login-btn">
                👤 <%= loggedInUser.getUsername() %>
            </a>
            <a href="<%= ctx %>/logout" class="logout-btn">🚪 Logout</a>
        <% } %>
    </div>
</nav>

<!-- ================= HERO ================= -->

<section class="restaurant-hero">
    <div class="hero-slideshow">
        <% for (int i = 0; i < allResturant.size(); i++) {
            Resturant restaurant = allResturant.get(i);
        %>
            <img
                src="<%= restaurant.getImagePath() %>"
                class="hero-slide <%= i == 0 ? "active" : "" %>"
                alt="<%= restaurant.getR_name() %>"
                loading="<%= i == 0 ? "eager" : "lazy" %>">
        <% } %>

        <% if (allResturant.isEmpty()) { %>
            <div class="hero-slide active hero-fallback"></div>
        <% } %>
    </div>

    <div class="hero-overlay"></div>

    <div class="restaurant-hero-content">
        <p class="hero-subtitle">WELCOME TO FOODIES</p>

        <h1>
            Discover the Best Restaurants
            <br>
            <span>in Bangalore</span>
        </h1>

        <p class="hero-description">
            Explore amazing restaurants, discover delicious food,
            and enjoy your favourite meals.
        </p>

        <form class="hero-search"
              action="<%= ctx %>/resturant"
              method="get">
            <input type="text"
                   name="search"
                   placeholder="Search for restaurants, cuisines..."
                   aria-label="Search restaurants and cuisines">
            <button type="submit" aria-label="Search">🔍</button>
        </form>

        <a href="#restaurants" class="hero-explore-btn">
            Explore Restaurants →
        </a>
    </div>
</section>

<!-- ================= RESTAURANTS ================= -->

<section class="restaurant-section" id="restaurants">
    <div class="section-heading">
        <div>
            <p class="section-small">DISCOVER &amp; ENJOY</p>
            <h2 class="section-title">Explore Restaurants</h2>
        </div>

        <a href="#restaurants" class="view-all">View All →</a>
    </div>

    <div class="restaurant-grid">
        <% if (allResturant.isEmpty()) { %>
            <div class="no-data">
                <h3>No restaurants available</h3>
                <p>Please add restaurants to the database.</p>
            </div>
        <% } else { %>
            <% for (Resturant r : allResturant) { %>
                <div class="restaurant-card">
                    <div class="restaurant-image-wrapper">
                        <img
                            src="<%= r.getImagePath() %>"
                            class="restaurant-card-image"
                            alt="<%= r.getR_name() %>"
                            loading="lazy">

                        <div class="rating-badge">
                            ★ <%= r.getRating() %>
                        </div>
                    </div>

                    <div class="restaurant-card-content">
                        <h3><%= r.getR_name() %></h3>

                        <div class="restaurant-cuisine">
                            <%= r.getR_cuisineType() %>
                        </div>

                        <div class="restaurant-address">
                            📍 <%= r.getR_address() %>
                        </div>

                        <div class="restaurant-info">
                            <span>🕒 <%= r.getDeliveryTime() %> min</span>
                            <span class="restaurant-rating">
                                ★ <%= r.getRating() %>
                            </span>
                        </div>

                        <a
                            href="<%= ctx %>/menu?resturantId=<%= r.getResturantid() %>"
                            class="menu-btn">
                            View Menu <span>→</span>
                        </a>
                    </div>
                </div>
            <% } %>
        <% } %>
    </div>
</section>

<!-- ================= SPECIALITIES ================= -->

<section class="special-section">
    <p class="section-small">WHY FOODIES</p>
    <h2 class="section-title">Made For Food Lovers</h2>

    <div class="special-grid">
        <div class="special-card">
            <div class="special-icon">🍽️</div>
            <h3>Delicious Food</h3>
            <p>
                Discover delicious meals and a variety of cuisines
                from your favourite restaurants.
            </p>
        </div>

        <div class="special-card">
            <div class="special-icon">🚴</div>
            <h3>Fast Delivery</h3>
            <p>
                Find meals you love and enjoy a convenient
                food ordering experience.
            </p>
        </div>

        <div class="special-card">
            <div class="special-icon">⭐</div>
            <h3>Best Restaurants</h3>
            <p>
                Explore highly rated restaurants and discover
                great food around Bangalore.
            </p>
        </div>
    </div>
</section>

<!-- ================= SLIDESHOW SCRIPT ================= -->

<script>
document.addEventListener("DOMContentLoaded", function () {
    const slides = document.querySelectorAll(".hero-slide");

    if (slides.length <= 1) {
        return;
    }

    let currentIndex = 0;

    setInterval(function () {
        slides[currentIndex].classList.remove("active");
        currentIndex = (currentIndex + 1) % slides.length;
        slides[currentIndex].classList.add("active");
    }, 3000);
});
</script>

</body>
</html>
