<%--
  Created by IntelliJ IDEA.
  User: akint
  Date: 26/01/2025
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="productSearch" method="get">
    <input type="text" name="searchTerm" placeholder="Search for products">
    <button type="submit">Search</button>
</form>

<%-- Display search results --%>
<% List<Product> products = (List<Product>) request.getAttribute("products"); %>
<% for (Product product : products) { %>
<div>
    <img src="<%= product.getImage() %>" alt="<%= product.getName() %>">
    <h4><%= product.getName() %></h4>
    <p><%= product.getPrice() %></p>
    <button onclick="addToCart(<%= product.getId() %>)">Add to Cart</button>
</div>
<% } %>
</body>
</html>
