<%-- =====================================================
     FOODIES - LOADING SCREEN
     Step 4
===================================================== --%>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/loader.css">

<div id="foodies-loader"
     class="foodies-loader"
     role="status"
     aria-label="Loading Foodies">

    <div id="container">

        <div id="ring"></div>
        <div id="ring"></div>
        <div id="ring"></div>
        <div id="ring"></div>

        <div id="h3">loading</div>

    </div>

</div>

<script src="<%= request.getContextPath() %>/js/loader.js"></script>