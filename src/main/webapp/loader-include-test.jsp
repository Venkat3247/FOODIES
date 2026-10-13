<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Foodies Loader Include Test</title>

</head>

<body>

    <%@ include file="common/loader.jsp" %>

    <div style="
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #090909;
        color: white;
        font-family: Arial, sans-serif;
    ">
        <h1>Foodies Page Loaded</h1>
    </div>

</body>
</html>