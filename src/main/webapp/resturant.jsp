
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Resturant"%>

<%
    List<Resturant> allResturant =
        (List<Resturant>) request.getAttribute("allResturant");

    if (allResturant == null) {
        allResturant = new java.util.ArrayList<Resturant>();
    }

    com.tap.model.User loggedInUser =
        (com.tap.model.User) session.getAttribute("loggedInUser");
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/darkmode.css">
<script src="${pageContext.request.contextPath}/js/darkmode.js"></script>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Foodies | Restaurants</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/resturant.css">


    <!-- =================================================
         NAVBAR + 4 COLUMN RESTAURANT OVERRIDE
         ================================================= -->

    <style>

* {
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    margin: 0;
    padding: 0;
    font-family: Arial, Helvetica, sans-serif;
    background-color: #FBF1E1;
    color: #07352f;
}


/* =================================================
   NAVBAR
   ================================================= */

.navbar {

    width: 100%;

    min-height: 82px;

    padding: 0 55px;

    display: flex;

    align-items: center;

    justify-content: space-between;

    background: #07352f;

    border-bottom: 2px solid #d9a441;

    box-shadow:
        0 5px 0 rgba(0, 0, 0, 0.08),
        0 10px 25px rgba(0, 0, 0, 0.15);

    position: relative;

    z-index: 1000;
}


/* LOGO */

.logo {

    color: #ffffff;

    font-size: 30px;

    font-weight: 800;

    letter-spacing: 1px;

    text-decoration: none;

    text-shadow:
        0 2px 0 #04231f,
        0 4px 8px rgba(0, 0, 0, 0.30);
}

.logo span {
    color: #d9a441;
}


/* NAV LINKS */

.nav-links {

    display: flex;

    align-items: center;

    gap: 10px;
}

.nav-links a {

    min-height: 42px;

    padding: 0 17px;

    display: flex;

    align-items: center;

    justify-content: center;

    color: #ffffff;

    text-decoration: none;

    font-size: 15px;

    font-weight: 600;

    border-radius: 12px;

    transition: all 0.25s ease;
}

.nav-links a:hover {

    color: #07352f;

    background: #d9a441;

    transform: translateY(-3px);

    box-shadow:
        0 5px 0 #9c7427,
        0 9px 15px rgba(0, 0, 0, 0.20);
}


/* CART */

.nav-links a[href*="cart"] {

    background: rgba(255,255,255,0.08);

    border: 1px solid rgba(255,255,255,0.15);

    box-shadow:
        inset 0 1px 0 rgba(255,255,255,0.10),
        0 3px 0 rgba(0,0,0,0.18);
}


/* LOGIN */

.login-btn {

    background: #d9a441 !important;

    color: #07352f !important;

    font-weight: 700 !important;

    border-radius: 12px !important;

    box-shadow:
        0 5px 0 #9c7427,
        0 8px 15px rgba(0,0,0,0.20) !important;
}

.login-btn:hover {

    background: #e5b452 !important;

    transform: translateY(-3px);

    box-shadow:
        0 7px 0 #9c7427,
        0 12px 20px rgba(0,0,0,0.25) !important;
}


/* LOGOUT */

.logout-btn {

    background: #ffffff !important;

    color: #07352f !important;

    font-weight: 700 !important;

    border: 1px solid #d9a441 !important;

    border-radius: 12px !important;

    box-shadow:
        0 4px 0 rgba(0,0,0,0.15);
}

.logout-btn:hover {

    background: #d9a441 !important;

    color: #07352f !important;

    transform: translateY(-3px);

    box-shadow:
        0 6px 0 #9c7427,
        0 10px 18px rgba(0,0,0,0.20);
}


/* =================================================
   HERO
   ================================================= */

.hero {

    width: 90%;

    max-width: 1450px;

    min-height: 610px;

    margin: 0 auto;

    display: grid;

    grid-template-columns: 1fr 1fr;

    align-items: center;

    gap: 70px;

    padding: 65px 0;
}


/* HERO TEXT */

.hero-content {

    display: flex;

    flex-direction: column;

    justify-content: center;

    padding-left: 25px;
}

.small-title {

    margin-bottom: 15px;

    color: #9c7427;

    font-size: 14px;

    font-weight: 800;

    letter-spacing: 2px;
}

.hero-title {

    margin: 0;

    font-family: Georgia, "Times New Roman", serif;

    font-size: clamp(52px, 5.5vw, 82px);

    line-height: 0.98;

    letter-spacing: -3px;

    color: #07352f;
}

.hero-title .gold {

    color: #bd8a22;
}

.hero-description {

    max-width: 580px;

    margin: 28px 0;

    color: #52605c;

    font-size: 16px;

    line-height: 1.7;
}


/* HERO BUTTONS */

.hero-buttons {

    display: flex;

    align-items: center;

    gap: 18px;

    margin-top: 8px;
}

.explore-btn,
.watch-btn {

    display: inline-flex;

    align-items: center;

    justify-content: center;

    min-height: 54px;

    padding: 0 25px;

    border-radius: 12px;

    text-decoration: none;

    font-size: 15px;

    font-weight: 800;

    transition: all 0.25s ease;
}

.explore-btn {

    background: #d9a441;

    color: #07352f;

    box-shadow:
        0 5px 0 #9c7427,
        0 10px 20px rgba(0,0,0,0.12);
}

.watch-btn {

    background: #07352f;

    color: #ffffff;

    box-shadow:
        0 5px 0 #04231f,
        0 10px 20px rgba(0,0,0,0.12);
}

.explore-btn:hover,
.watch-btn:hover {

    transform: translateY(-4px);
}

.explore-btn:hover {

    background: #e5b452;
}

.watch-btn:hover {

    background: #0b463f;
}


/* =================================================
   HERO IMAGE
   ================================================= */

.hero-image-area {

    min-height: 500px;

    display: flex;

    align-items: center;

    justify-content: center;

    position: relative;
}


/* SQUARE / ROUNDED IMAGE FRAME */

.food-circle {

    width: 400px;

    height: 450px;

    position: relative;

    overflow: hidden;

    border-radius: 30px;

    background: #07352f;

    border: 8px solid #ffffff;

    box-shadow:
        0 10px 0 rgba(7,53,47,0.12),
        0 25px 50px rgba(0,0,0,0.18);
}


/* FOOD IMAGE */

.hero-image {

    width: 100%;

    height: 100%;

    display: block;

    object-fit: cover;

    opacity: 1;

    transition: opacity 0.4s ease;
}


/* FOOD BADGE */

.food-badge {

    position: absolute;

    right: 10px;

    bottom: 45px;

    min-width: 135px;

    display: flex;

    align-items: center;

    gap: 10px;

    padding: 12px 16px;

    background: #ffffff;

    border-radius: 14px;

    box-shadow:
        0 6px 0 rgba(7,53,47,0.10),
        0 12px 25px rgba(0,0,0,0.15);
}

.food-badge span {

    font-size: 25px;

    color: #d9a441;
}

.food-badge b {

    display: block;

    color: #07352f;

    font-size: 18px;
}

.food-badge small {

    display: block;

    margin-top: 2px;

    color: #68716e;

    font-size: 11px;
}


/* =================================================
   RESTAURANT SECTION
   ================================================= */

.restaurant-section {

    width: 100%;

    padding: 75px 6%;

    background-color: #FBF1E1;
}


/* SECTION HEADING */

.section-heading {

    display: flex;

    align-items: end;

    justify-content: space-between;

    margin-bottom: 35px;
}

.section-small {

    margin: 0 0 8px;

    color: #bd8a22;

    font-size: 13px;

    font-weight: 800;

    letter-spacing: 2px;
}

.section-title {

    margin: 0;

    color: #07352f;

    font-family: Georgia, "Times New Roman", serif;

    font-size: 42px;
}


/* VIEW ALL */

.view-all {

    color: #07352f;

    text-decoration: none;

    font-size: 15px;

    font-weight: 800;
}

.view-all:hover {

    color: #bd8a22;
}


/* =================================================
   RESTAURANT GRID
   ================================================= */

.restaurant-grid {

    width: 100%;

    display: grid;

    grid-template-columns:
        repeat(4, minmax(0, 1fr));

    gap: 28px;

    align-items: stretch;
}


/* =================================================
   RESTAURANT CARD
   ================================================= */

.restaurant-card {

    width: 100%;

    background: #ffffff;

    border-radius: 20px;

    overflow: hidden;

    border: 1px solid rgba(7,53,47,0.08);

    box-shadow:
        0 8px 0 rgba(7,53,47,0.06),
        0 15px 30px rgba(0,0,0,0.10);

    transition:
        transform 0.25s ease,
        box-shadow 0.25s ease;
}

.restaurant-card:hover {

    transform: translateY(-7px);

    box-shadow:
        0 10px 0 rgba(7,53,47,0.08),
        0 20px 35px rgba(0,0,0,0.16);
}


/* IMAGE */

.restaurant-image-wrapper {

    position: relative;

    width: 100%;

    height: 210px;

    overflow: hidden;
}

.restaurant-card-image {

    width: 100%;

    height: 100%;

    object-fit: cover;

    display: block;

    transition: transform 0.4s ease;
}

.restaurant-card:hover .restaurant-card-image {

    transform: scale(1.05);
}


/* RATING */

.rating-badge {

    position: absolute;

    top: 12px;

    right: 12px;

    padding: 7px 10px;

    background: #07352f;

    color: #ffffff;

    border-radius: 10px;

    font-size: 13px;

    font-weight: 700;

    box-shadow:
        0 4px 0 rgba(0,0,0,0.20);
}


/* CARD CONTENT */

.restaurant-card-content {

    padding: 20px;
}

.restaurant-card-content h3 {

    margin: 0 0 8px;

    color: #07352f;

    font-size: 21px;

    font-weight: 800;
}

.restaurant-cuisine {

    color: #b38325;

    font-size: 14px;

    font-weight: 700;

    margin-bottom: 9px;
}

.restaurant-address {

    color: #666666;

    font-size: 13px;

    line-height: 1.5;

    min-height: 40px;

    margin-bottom: 13px;
}


/* INFO */

.restaurant-info {

    display: flex;

    justify-content: space-between;

    align-items: center;

    padding-top: 12px;

    border-top: 1px solid #eeeeee;

    color: #555555;

    font-size: 13px;
}

.restaurant-rating {

    color: #b38325;

    font-weight: 700;
}


/* VIEW MENU */

.menu-btn {

    display: flex;

    align-items: center;

    justify-content: space-between;

    width: 100%;

    margin-top: 16px;

    padding: 12px 15px;

    background: #07352f;

    color: #ffffff;

    text-decoration: none;

    border-radius: 11px;

    font-size: 14px;

    font-weight: 700;

    box-shadow:
        0 4px 0 #04231f;

    transition: all 0.2s ease;
}

.menu-btn span {

    color: #d9a441;

    font-size: 18px;
}

.menu-btn:hover {

    background: #d9a441;

    color: #07352f;

    transform: translateY(-2px);

    box-shadow:
        0 6px 0 #9c7427;
}


/* NO DATA */

.no-data {

    grid-column: 1 / -1;

    text-align: center;

    padding: 50px;

    background: #ffffff;

    border-radius: 20px;
}


/* =================================================
   SPECIAL SECTION
   ================================================= */

.special-section {

    width: 100%;

    padding: 80px 6%;

    text-align: center;

    background: rgba(255,255,255,0.45);
}

.special-grid {

    max-width: 1200px;

    margin: 40px auto 0;

    display: grid;

    grid-template-columns: repeat(3, 1fr);

    gap: 25px;
}

.special-card {

    background: #ffffff;

    padding: 30px;

    border-radius: 20px;

    box-shadow:
        0 7px 0 rgba(7,53,47,0.05),
        0 12px 25px rgba(0,0,0,0.07);
}

.special-icon {

    font-size: 40px;

    margin-bottom: 12px;
}

.special-card h3 {

    color: #07352f;

    margin: 10px 0;
}

.special-card p {

    color: #68716e;

    line-height: 1.6;
}


/* =================================================
   RESPONSIVE
   ================================================= */

@media (max-width: 1200px) {

    .navbar {

        padding: 0 30px;
    }

    .hero {

        gap: 35px;
    }

    .restaurant-grid {

        grid-template-columns:
            repeat(3, minmax(0, 1fr));
    }
}


@media (max-width: 900px) {

    .navbar {

        min-height: auto;

        padding: 18px 25px;

        flex-direction: column;

        gap: 15px;
    }

    .nav-links {

        flex-wrap: wrap;

        justify-content: center;
    }

    .hero {

        grid-template-columns: 1fr;

        text-align: center;

        padding: 50px 0;
    }

    .hero-content {

        padding-left: 0;

        align-items: center;
    }

    .hero-description {

        margin-left: auto;

        margin-right: auto;
    }

    .hero-buttons {

        justify-content: center;
    }

    .hero-image-area {

        min-height: auto;
    }

    .restaurant-grid {

        grid-template-columns:
            repeat(2, minmax(0, 1fr));
    }

    .special-grid {

        grid-template-columns: 1fr;
    }
}


@media (max-width: 550px) {

    .hero-title {

        font-size: 52px;
    }

    .food-circle {

        width: 320px;

        height: 380px;
    }

    .hero-buttons {

        flex-direction: column;
    }

    .explore-btn,
    .watch-btn {

        width: 220px;
    }

    .restaurant-grid {

        grid-template-columns: 1fr;
    }

    .section-heading {

        flex-direction: column;

        align-items: flex-start;

        gap: 15px;
    }
}

    </style>

</head>


<body>


<!-- =================================================
     NAVBAR
     ================================================= -->

<nav class="navbar">

    <a href="<%= request.getContextPath() %>/resturant"
       class="logo">

        Food<span>ies</span>

    </a>


    <div class="nav-links">

        <a href="<%= request.getContextPath() %>/resturant">
            🏠 Home
        </a>

        <a href="<%= request.getContextPath() %>/resturant">
            🍴 Restaurants
        </a>

        <a href="<%= request.getContextPath() %>/resturant#restaurants">
            📋 Menu
        </a>

        <a href="<%= request.getContextPath() %>/cart"
           class="cart-link">
            🛒 Cart
        </a>

        <a href="<%= request.getContextPath() %>/myOrders"
           class="my-orders-link">
            📦 My Orders
        </a>


        <% if (loggedInUser == null) { %>

            <!-- NOT LOGGED IN -->

            <a href="<%= request.getContextPath() %>/login.html"
               class="login-btn">

                👤 Login

            </a>


        <% } else { %>

            <!-- LOGGED IN -->

            <a href="<%= request.getContextPath() %>/myOrders"
               class="login-btn">

                👤 <%= loggedInUser.getUsername() %>

            </a>


            <a href="<%= request.getContextPath() %>/logout"
               class="logout-btn">

                🚪 Logout

            </a>

        <% } %>


    </div>

</nav>


<!-- =================================================
     HERO
     ================================================= -->

<section class="hero">

    <div class="hero-content">

        <div class="small-title">

            WELCOME TO FOODIES

        </div>


        <h1 class="hero-title">

            Good Food.

            <br>

            <span class="gold">

                Great Mood.

            </span>

            <br>

            Unforgettable.

        </h1>


        <p class="hero-description">

            Discover delicious food from the best restaurants
            around Bangalore. Fresh taste, fast delivery and
            unforgettable moments.

        </p>


        <div class="hero-buttons">

            <a href="#restaurants"
               class="explore-btn">

                Explore Restaurants →

            </a>


            <a href="#restaurants"
               class="watch-btn">

                View Menu

            </a>

        </div>

    </div>


    <!-- ================= LOOP IMAGE ================= -->

    <div class="hero-image-area">

        <div class="food-circle">

            <img
                id="heroFoodImage"
                src="https://images.unsplash.com/photo-1563379091339-03246963d51a"
                alt="Food"
                class="hero-image">

        </div>


        <div class="food-badge">

            <span>★</span>

            <div>

                <b>4.8</b>

                <small>
                    Food Rating
                </small>

            </div>

        </div>

    </div>

</section>


<!-- =================================================
     RESTAURANTS
     ================================================= -->

<section class="restaurant-section"
         id="restaurants">


    <div class="section-heading">

        <div>

            <p class="section-small">

                DISCOVER & ENJOY

            </p>


            <h2 class="section-title">

                Explore Restaurants

            </h2>

        </div>


        <a href="#restaurants"
           class="view-all">

            View All →

        </a>

    </div>


    <!-- =================================================
         RESTAURANT GRID — 4 IN ONE ROW
         ================================================= -->

    <div class="restaurant-grid">


        <%

            if (allResturant.isEmpty()) {

        %>

            <div class="no-data">

                <h3>
                    No restaurants available
                </h3>

                <p>
                    Please add restaurants to the database.
                </p>

            </div>

        <%

            }


            for (Resturant r : allResturant) {

        %>


        <!-- ================= RESTAURANT CARD ================= -->

        <div class="restaurant-card">


            <div class="restaurant-image-wrapper">

                <img
                    src="<%= r.getImagePath() %>"
                    class="restaurant-card-image"
                    alt="<%= r.getR_name() %>">


                <div class="rating-badge">

                    ★ <%= r.getRating() %>

                </div>

            </div>


            <div class="restaurant-card-content">


                <h3>

                    <%= r.getR_name() %>

                </h3>


                <div class="restaurant-cuisine">

                    <%= r.getR_cuisineType() %>

                </div>


                <div class="restaurant-address">

                    📍 <%= r.getR_address() %>

                </div>


                <div class="restaurant-info">

                    <span>

                        🕒 <%= r.getDeliveryTime() %> min

                    </span>


                    <span class="restaurant-rating">

                        ★ <%= r.getRating() %>

                    </span>

                </div>


                <!-- VIEW MENU -->

                <a
                    href="<%= request.getContextPath() %>/menu?resturantId=<%= r.getResturantid() %>"
                    class="menu-btn">

                    View Menu

                    <span>→</span>

                </a>


            </div>

        </div>


        <%

            }

        %>


    </div>

</section>


<!-- =================================================
     SPECIALITIES
     ================================================= -->

<section class="special-section">


    <p class="section-small">

        WHY FOODIES

    </p>


    <h2 class="section-title">

        Made For Food Lovers

    </h2>


    <div class="special-grid">


        <div class="special-card">

            <div class="special-icon">

                🍽️

            </div>

            <h3>

                Delicious Food

            </h3>

            <p>

                Fresh and delicious meals prepared
                by talented chefs.

            </p>

        </div>


        <div class="special-card">

            <div class="special-icon">

                🚴

            </div>

            <h3>

                Fast Delivery

            </h3>

            <p>

                Get your favourite food delivered
                quickly to your doorstep.

            </p>

        </div>


        <div class="special-card">

            <div class="special-icon">

                ⭐

            </div>

            <h3>

                Best Restaurants

            </h3>

            <p>

                Explore highly rated restaurants
                around Bangalore.

            </p>

        </div>


    </div>

</section>


<!-- =================================================
     HERO IMAGE LOOP
     ================================================= -->

<script>

const foodImages = [

    "<%= request.getContextPath() %>/images/0fa50d999107a706471179939d00c788.jpg",

    "<%= request.getContextPath() %>/images/6d67e226a3bcc908edd573bd876cdbdb.jpg",

    "<%= request.getContextPath() %>/images/a120e6a1599c6c202b3362ba14d9bb01.jpg",

    "<%= request.getContextPath() %>/images/97d3470eba3744ccfffaaa84a10f749a.jpg",

    "<%= request.getContextPath() %>/images/78aa5c027f0fb7150c532e0cc703d248.jpg",

    "<%= request.getContextPath() %>/images/19b1d1de8401c5288a7e61ced33cba99.jpg"

];


let currentImage = 0;


setInterval(function() {

    currentImage++;


    if (currentImage >= foodImages.length) {

        currentImage = 0;

    }


    const image =
        document.getElementById("heroFoodImage");


    image.style.opacity = "0";


    setTimeout(function() {

        image.src = foodImages[currentImage];

        image.style.opacity = "1";

    }, 400);


}, 3000);

</script>


</body>

</html>

