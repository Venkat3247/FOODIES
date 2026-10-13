<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Menu"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Foodies - Delicious Menu</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/darkmode.css">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, Helvetica, sans-serif;
    background: #FBF1E1;
    color: #2D2418;
    transition: background .25s, color .25s;
}

/* NAVBAR */
.navbar {
    width: 100%;
    min-height: 72px;
    background: #174A3A;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    padding: 12px 5%;
    border-bottom: 2px solid #D6A84F;
    box-shadow: 0 3px 12px rgba(0,0,0,.15);
    position: sticky;
    top: 0;
    z-index: 1000;
}

.logo {
    text-decoration: none;
    font-size: 30px;
    font-weight: 800;
    color: #FFFFFF;
    letter-spacing: .5px;
    white-space: nowrap;
}

.logo span {
    color: #D6A84F;
}

.nav-links {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 10px;
    flex-wrap: wrap;
}

.nav-link, .cart-btn {
    text-decoration: none;
    color: #FFFFFF;
    font-size: 14px;
    font-weight: 600;
    padding: 11px 14px;
    border-radius: 8px;
}

.nav-link:hover {
    background: rgba(255,255,255,.12);
    color: #F2C66D;
}

.cart-btn {
    border: 1px solid #D6A84F;
}

.cart-count {
    display: inline-flex;
    min-width: 20px;
    height: 20px;
    padding: 0 5px;
    align-items: center;
    justify-content: center;
    margin-left: 4px;
    border-radius: 50px;
    background: #D6A84F;
    color: #174A3A;
    font-size: 12px;
    font-weight: bold;
}

.login-btn, .dark-mode-toggle {
    color: #174A3A;
    background: #D6A84F;
    border: 1px solid #B98A32;
    border-radius: 8px;
    padding: 11px 14px;
    font-size: 14px;
    font-weight: 700;
    text-decoration: none;
    white-space: nowrap;
    cursor: pointer;
}

.login-btn:hover, .dark-mode-toggle:hover {
    background: #E6BB63;
}

/* MAIN CONTAINER */
.menu-container {
    width: 92%;
    max-width: 1300px;
    margin: 35px auto 60px;
}

/* HERO */
.menu-hero {
    position: relative;
    min-height: 200px;
    display: flex;
    align-items: center;
    overflow: hidden;
    border-radius: 18px;
    border: 1px solid #E6CFA9;
    background: linear-gradient(135deg,#FFF9EF,#F9E9D3 55%,#F3DCC0);
    box-shadow: 0 8px 22px rgba(75,50,20,.10);
    margin-bottom: 30px;
}

.menu-hero::before {
    content: "";
    position: absolute;
    left: 0;
    top: 22px;
    bottom: 22px;
    width: 9px;
    background: #C98B20;
    border-radius: 0 8px 8px 0;
    z-index: 3;
}

.menu-hero-content {
    position: relative;
    z-index: 5;
    width: 60%;
    padding: 25px 20px 25px 45px;
}

.menu-label {
    color: #B87916;
    font-size: 11px;
    font-weight: 800;
    letter-spacing: 2.5px;
    margin-bottom: 10px;
}

.menu-hero h1 {
    font-size: 36px;
    line-height: 1.15;
    margin-bottom: 10px;
}

.menu-title-line {
    width: 80px;
    height: 4px;
    background: #C98B20;
    margin-bottom: 12px;
}

.menu-hero-description {
    font-size: 14px;
    line-height: 1.6;
    margin-bottom: 10px;
}

.menu-features {
    font-size: 12px;
    font-weight: bold;
    color: #174A3A;
}

.menu-hero-image {
    position: absolute;
    right: 0;
    top: 0;
    width: 42%;
    height: 100%;
    overflow: hidden;
}

.menu-hero-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}

.menu-hero-image::before {
    content: "";
    position: absolute;
    inset: 0 auto 0 0;
    width: 35%;
    background: linear-gradient(to right,#F8E8D1,transparent);
    z-index: 1;
}

.good-food {
    position: absolute;
    right: 28%;
    top: 35px;
    font-size: 15px;
    line-height: 1.4;
    z-index: 6;
}

/* MENU GRID */
.menu-grid {
    display: grid;
    grid-template-columns: repeat(4,minmax(0,1fr));
    gap: 25px;
}

.menu-card {
    background: #FFF9EF;
    border: 1px solid #EADBC2;
    border-radius: 14px;
    overflow: hidden;
    box-shadow: 0 7px 18px rgba(65,45,20,.08);
    transition: transform .25s, box-shadow .25s;
    display: flex;
    flex-direction: column;
    min-width: 0;
}

.menu-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 25px rgba(65,45,20,.14);
}

.menu-image {
    width: 100%;
    height: 210px;
    object-fit: cover;
    display: block;
    background: #EADBC2;
}

.menu-content {
    padding: 18px;
    display: flex;
    flex-direction: column;
    flex: 1;
}

.food-name {
    font-size: 19px;
    color: #2D2418;
    font-weight: 700;
    margin-bottom: 7px;
    line-height: 1.3;
}

.food-price {
    font-size: 18px;
    color: #B8872D;
    font-weight: 800;
    margin-bottom: 9px;
}

.food-description {
    font-size: 14px;
    color: #756B5D;
    line-height: 1.5;
    min-height: 42px;
    margin-bottom: 14px;
}

.available {
    display: inline-block;
    width: fit-content;
    font-size: 12px;
    font-weight: 700;
    color: #174A3A;
    background: #E5F0E8;
    border: 1px solid #BFD8C7;
    padding: 5px 10px;
    border-radius: 20px;
    margin-bottom: 15px;
}

.cart-control-area {
    width: 150px;
    min-height: 42px;
    margin-top: auto;
}

.add-btn {
    width: 150px;
    height: 42px;
    border: none;
    border-radius: 8px;
    background: linear-gradient(180deg,#D9AD55,#B8872D);
    color: #FFFFFF;
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
    box-shadow: 0 3px 0 #76551C;
}

.add-btn:hover {
    background: linear-gradient(180deg,#E6BB63,#C59636);
}

.add-btn:disabled {
    opacity: .5;
    cursor: not-allowed;
    box-shadow: none;
}

.quantity-control {
    width: 150px;
    height: 42px;
    display: flex;
    align-items: center;
    overflow: hidden;
    border-radius: 8px;
    background: linear-gradient(180deg,#D9AD55,#B8872D);
    box-shadow: 0 3px 0 #76551C;
}

.quantity-btn {
    width: 42px;
    min-width: 42px;
    height: 42px;
    border: none;
    background: transparent;
    color: #FFFFFF;
    font-size: 20px;
    font-weight: 800;
    cursor: pointer;
}

.quantity-number {
    flex: 1;
    height: 42px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #174A3A;
    color: #FFFFFF;
    font-size: 17px;
    font-weight: 800;
    user-select: none;
}

.no-menu {
    text-align: center;
    background: #FFF9EF;
    border: 1px solid #EADBC2;
    border-radius: 14px;
    padding: 45px;
    color: #756B5D;
    font-size: 16px;
}

/* DARK MODE */
body.dark-mode {
    background: #121816 !important;
    color: #F4F1E8 !important;
}

body.dark-mode .menu-container {
    color: #F4F1E8;
}

body.dark-mode .menu-hero {
    background: linear-gradient(135deg,#202B27,#263831) !important;
    border-color: #37463F;
    color: #F4F1E8;
}

body.dark-mode .menu-hero h1,
body.dark-mode .menu-hero-description,
body.dark-mode .good-food {
    color: #F4F1E8;
}

body.dark-mode .menu-hero-image::before {
    background: linear-gradient(to right,#202B27,transparent);
}

body.dark-mode .menu-card,
body.dark-mode .no-menu {
    background: #202B27 !important;
    color: #F4F1E8 !important;
    border-color: #37463F !important;
}

body.dark-mode .food-name,
body.dark-mode .food-description {
    color: #F4F1E8 !important;
}

body.dark-mode .food-price {
    color: #E6BB63 !important;
}

body.dark-mode .available {
    background: #263831;
    color: #C8E6D0;
    border-color: #52645A;
}

/* RESPONSIVE */
@media (max-width: 1100px) {
    .menu-grid {
        grid-template-columns: repeat(3,minmax(0,1fr));
    }
    .good-food {
        display: none;
    }
}

@media (max-width: 850px) {
    .menu-grid {
        grid-template-columns: repeat(2,minmax(0,1fr));
    }
    .navbar {
        flex-wrap: wrap;
    }
    .nav-links {
        justify-content: flex-start;
    }
}

@media (max-width: 650px) {
    .navbar {
        padding: 12px 4%;
    }
    .logo {
        font-size: 24px;
    }
    .nav-link {
        display: none;
    }
    .nav-links {
        gap: 6px;
    }
    .login-btn, .dark-mode-toggle, .cart-btn {
        padding: 9px 10px;
        font-size: 12px;
    }
    .menu-container {
        width: 94%;
        margin-top: 25px;
    }
    .menu-hero {
        min-height: 400px;
        align-items: flex-start;
    }
    .menu-hero-content {
        width: 100%;
        padding: 30px 25px;
    }
    .menu-hero h1 {
        font-size: 32px;
    }
    .menu-hero-image {
        top: auto;
        bottom: 0;
        width: 100%;
        height: 170px;
    }
    .menu-hero-image::before {
        width: 100%;
        background: linear-gradient(to bottom,#F8E8D1,transparent);
    }
    body.dark-mode .menu-hero-image::before {
        background: linear-gradient(to bottom,#202B27,transparent);
    }
    .menu-features {
        display: none;
    }
    .menu-grid {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">
    <a href="<%= request.getContextPath() %>/resturant" class="logo">
        Food<span>ies</span>
    </a>

    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/resturant" class="nav-link">Home</a>
        <a href="<%= request.getContextPath() %>/resturant" class="nav-link">Restaurants</a>
        <a href="<%= request.getContextPath() %>/resturant" class="nav-link">Menu</a>

        <a href="<%= request.getContextPath() %>/cart" class="cart-btn">
            🛒 Cart <span class="cart-count" id="cartCount">0</span>
        </a>

        <a href="<%= request.getContextPath() %>/login.html" class="login-btn">
            Login
        </a>

        <!-- DARK MODE BUTTON: inside navbar -->
        <button type="button"
                id="darkModeToggle"
                class="dark-mode-toggle"
                aria-pressed="false">
            🌙 Dark Mode
        </button>
    </div>
</nav>

<!-- MAIN -->
<div class="menu-container">

    <section class="menu-hero">
        <div class="menu-hero-content">
            <div class="menu-label">👨‍🍳 FOODIES MENU</div>
            <h1>Delicious Menu</h1>
            <div class="menu-title-line"></div>
            <p class="menu-hero-description">
                Explore delicious dishes from your selected restaurant
                and add your favourite food to the cart.
            </p>
            <div class="menu-features">Fresh &nbsp; • &nbsp; Tasty &nbsp; • &nbsp; Local</div>
        </div>

        <div class="good-food">
            Good Food<br>
            Brings People<br>
            Together ♡
        </div>

        <div class="menu-hero-image">
            <img
                src="<%= request.getContextPath() %>/images/485a3163001b4c7ad2f9efa27f7584f8.jpg"
                alt="Delicious Food">
        </div>
    </section>

    <%
        List<Menu> allmenu =
            (List<Menu>) request.getAttribute("allmenu");

        // Backup image used when imagepath is empty, broken or an old loremflickr link
        final String FALLBACK_IMG =
            "https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=500&q=70&auto=format&fit=crop";
    %>

    <% if (allmenu != null && !allmenu.isEmpty()) { %>

        <div class="menu-grid">
            <% for (Menu menu : allmenu) {
                String available = menu.getAvailable();
                boolean isAvailable = available != null
                    && available.equalsIgnoreCase("yes");

                String description = menu.getDescription();

                // ---- IMAGE PATH HANDLING ----
                String imgSrc = menu.getImagepath();

                if (imgSrc == null
                        || imgSrc.trim().isEmpty()
                        || imgSrc.trim().equals("...")
                        || imgSrc.contains("loremflickr")) {
                    imgSrc = FALLBACK_IMG;
                } else {
                    imgSrc = imgSrc.trim();
                    if (!imgSrc.startsWith("http")) {
                        // local file inside the web app, e.g. images/biryani.jpg
                        imgSrc = request.getContextPath() + "/" + imgSrc;
                    }
                }
            %>

                <div class="menu-card">
                    <img class="menu-image"
                         src="<%= imgSrc %>"
                         alt="<%= menu.getFoodname() %>"
                         loading="lazy"
                         referrerpolicy="no-referrer"
                         onerror="this.onerror=null;this.src='<%= FALLBACK_IMG %>';">

                    <div class="menu-content">
                        <div class="food-name"><%= menu.getFoodname() %></div>

                        <div class="food-price">₹<%= menu.getPrice() %></div>

                        <div class="food-description">
                            <% if (description != null
                                    && !description.trim().isEmpty()) { %>
                                <%= description %>
                            <% } else { %>
                                Delicious food prepared specially for you.
                            <% } %>
                        </div>

                        <% if (isAvailable) { %>
                            <span class="available">Available</span>
                        <% } else { %>
                            <span class="available"
                                  style="color:#8A3B2F;background:#F8E5E0;border-color:#E6C0B8;">
                                Currently Unavailable
                            </span>
                        <% } %>

                        <div id="cart-control-<%= menu.getMenuid() %>"
                             class="cart-control-area">
                            <% if (isAvailable) { %>
                                <button type="button"
                                        class="add-btn"
                                        onclick="addToCart(<%= menu.getMenuid() %>)">
                                    + Add
                                </button>
                            <% } else { %>
                                <button type="button" class="add-btn" disabled>
                                    Unavailable
                                </button>
                            <% } %>
                        </div>
                    </div>
                </div>

            <% } %>
        </div>

    <% } else { %>
        <div class="no-menu">
            No menu items available for this restaurant.
        </div>
    <% } %>
</div>

<script>
/* ADD TO CART */
function addToCart(menuId) {
    const formData = new URLSearchParams();
    formData.append("action", "add");
    formData.append("menuId", menuId);

    fetch("<%= request.getContextPath() %>/cart", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: formData.toString()
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Cart request failed");
        }
        showQuantityControl(menuId, 1);
        updateCartCount();
    })
    .catch(error => console.error("Unable to add item:", error));
}

/* DISPLAY QUANTITY CONTROLS */
function showQuantityControl(menuId, quantity) {
    const control = document.getElementById("cart-control-" + menuId);
    if (!control) return;

    control.innerHTML =
        '<div class="quantity-control">' +
            '<button type="button" class="quantity-btn" ' +
                'onclick="changeQuantity(' + menuId + ',-1)">−</button>' +
            '<div class="quantity-number" id="quantity-' + menuId + '">' +
                quantity +
            '</div>' +
            '<button type="button" class="quantity-btn" ' +
                'onclick="changeQuantity(' + menuId + ',1)">+</button>' +
        '</div>';
}

/* CHANGE QUANTITY */
function changeQuantity(menuId, change) {
    const quantityElement =
        document.getElementById("quantity-" + menuId);

    if (!quantityElement) return;

    const currentQuantity =
        parseInt(quantityElement.textContent.trim(), 10) || 1;

    const newQuantity = currentQuantity + change;
    const action = change === 1 ? "plus" : "minus";

    sendCartRequest(menuId, action)
    .then(() => {
        if (newQuantity <= 0) {
            restoreAddButton(menuId);
        } else {
            quantityElement.textContent = newQuantity;
        }
        updateCartCount();
    })
    .catch(error => console.error("Unable to update quantity:", error));
}

/* SEND CART REQUEST */
function sendCartRequest(menuId, action) {
    const formData = new URLSearchParams();
    formData.append("action", action);
    formData.append("menuId", menuId);

    return fetch("<%= request.getContextPath() %>/cart", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: formData.toString()
    }).then(response => {
        if (!response.ok) {
            throw new Error("Cart request failed");
        }
        return response;
    });
}

/* RESTORE ADD BUTTON */
function restoreAddButton(menuId) {
    const control = document.getElementById("cart-control-" + menuId);
    if (!control) return;

    control.innerHTML =
        '<button type="button" class="add-btn" ' +
        'onclick="addToCart(' + menuId + ')">+ Add</button>';
}

/* UPDATE CART COUNT FROM CART PAGE */

/* UPDATE CART COUNT */
function updateCartCount() {
    fetch("<%= request.getContextPath() %>/cart?action=count", {
        method: "GET",
        cache: "no-store"
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Unable to get cart count");
        }
        return response.text();
    })
    .then(count => {
        const countElement = document.getElementById("cartCount");

        if (countElement) {
            countElement.textContent = count.trim();
        }
    })
    .catch(error => console.error("Unable to refresh cart count:", error));
}
                  document.addEventListener("DOMContentLoaded", updateCartCount);
</script>


<script>
(function () {
    const button = document.getElementById("darkModeToggle");

    function applyDarkMode(enabled) {
        document.body.classList.toggle("dark-mode", enabled);

        if (button) {
            button.textContent = enabled
                ? "☀️ Light Mode"
                : "🌙 Dark Mode";

            button.setAttribute("aria-pressed", String(enabled));
        }
    }

    let enabled = false;

    try {
        enabled = localStorage.getItem("foodies-dark-mode") === "true";
    } catch (e) {
        console.warn("Dark mode preference storage unavailable.");
    }

    applyDarkMode(enabled);

    if (button) {
        button.addEventListener("click", function () {
            enabled = !document.body.classList.contains("dark-mode");
            applyDarkMode(enabled);

            try {
                localStorage.setItem("foodies-dark-mode", String(enabled));
            } catch (e) {
                console.warn("Could not save dark mode preference.");
            }
        });
    }
})();
</script>

</body>
</html>
