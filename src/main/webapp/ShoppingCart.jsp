<%@ page import="ru.iz.shop.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="ru.iz.shop.Item" %>
<!DOCTYPE html>
<html>
<head>
    <title>Catalog</title>
</head>
<body>
<%
    Cart bag = (Cart) request.getSession().getAttribute("Bag");
%>
Your bag:
<table>
    <% for (Map.Entry<Item, Integer> bagEntry : bag.getCart().entrySet()) { %>
    <tr>
        <td><%= bagEntry.getKey().getName() %></td>
        <td><%= bagEntry.getValue() %></td>
        <td><%= bagEntry.getKey().getPrice() * bagEntry.getValue() %></td>
    </tr>
    <% } %>
</table>
Total purchases is
<%=bag.getTotalPurchases()%>
<br>
<a href="Shop_war_exploded">Return to Catalog</a>
</br>
</body>
</html>
