<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Foodies Loader Test</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/loader.css">

</head>

<body>

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

</body>
</html>