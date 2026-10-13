
/* ================= NAVBAR ================= */

.navbar {

    width: 100%;

    height: 82px;

    display: flex;

    align-items: center;

    justify-content: space-between;

    padding: 0 55px;

    box-sizing: border-box;

    background: #07352f;

    border-bottom: 1px solid rgba(255, 255, 255, 0.12);

    box-shadow:
        0 5px 0 rgba(0, 0, 0, 0.08),
        0 10px 25px rgba(0, 0, 0, 0.12);

    position: relative;

    z-index: 1000;
}


/* ================= FOODIES LOGO ================= */

.logo {

    display: block;

    font-size: 30px;

    font-weight: 800;

    color: #ffffff;

    letter-spacing: 1px;

    text-decoration: none;

    text-shadow:
        0 2px 0 #04231f,
        0 4px 8px rgba(0, 0, 0, 0.25);
}

.logo span {

    color: #d9a441;
}


/* ================= NAV LINKS ================= */

.nav-links {

    display: flex;

    align-items: center;

    gap: 12px;
}


/* ================= NORMAL LINKS ================= */

.nav-links a {

    display: flex;

    align-items: center;

    justify-content: center;

    min-height: 42px;

    padding: 0 18px;

    color: #ffffff;

    text-decoration: none;

    font-size: 15px;

    font-weight: 600;

    border-radius: 12px;

    transition: all 0.25s ease;
}


/* ================= 3D HOVER ================= */

.nav-links a:hover {

    color: #07352f;

    background: #d9a441;

    transform: translateY(-3px);

    box-shadow:
        0 5px 0 #9c7427,
        0 9px 15px rgba(0, 0, 0, 0.20);
}


/* ================= CART ================= */

.nav-links a[href*="cart"] {

    background: rgba(255, 255, 255, 0.08);

    border: 1px solid rgba(255, 255, 255, 0.14);

    box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.12),
        0 3px 0 rgba(0, 0, 0, 0.18);
}


/* ================= MY ORDERS ================= */

.nav-links a[href*="myOrders"] {

    background: rgba(255, 255, 255, 0.08);

    border: 1px solid rgba(255, 255, 255, 0.14);

    box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.12),
        0 3px 0 rgba(0, 0, 0, 0.18);
}


/* ================= LOGIN ================= */

.login-btn {

    background: #d9a441 !important;

    color: #07352f !important;

    font-weight: 700 !important;

    border-radius: 12px !important;

    box-shadow:
        0 5px 0 #9c7427,
        0 8px 15px rgba(0, 0, 0, 0.20) !important;
}

.login-btn:hover {

    transform: translateY(-3px);

    background: #e5b452 !important;

    box-shadow:
        0 7px 0 #9c7427,
        0 12px 20px rgba(0, 0, 0, 0.25) !important;
}


/* ================= MOBILE ================= */

@media (max-width: 800px) {

    .navbar {

        height: auto;

        padding: 18px 25px;

        flex-direction: column;

        gap: 15px;
    }

    .nav-links {

        flex-wrap: wrap;

        justify-content: center;
    }

    .nav-links a {

        padding: 0 12px;
    }
}


**Important:** This CSS only styles the button. You still need the actual link in your JSP navbar:


<a href="<%= request.getContextPath() %>/myOrders">
    My Orders
</a>


Put that inside your existing `<div class="nav-links">`.

After that, **don't create the controller yet**. First check that **My Orders appears in the navbar**.
