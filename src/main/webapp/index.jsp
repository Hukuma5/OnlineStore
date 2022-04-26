<%@ page import="java.util.HashMap" %>
<%@ page import="ru.iz.shop.Item" %>
<%@ page import="java.util.Map" %>
<%@ page import="ru.iz.shop.Cart" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Catalog</title>
</head>
<style>
    body {margin: 0; }
    #cart {position: absolute; }
    #cart {overflow: auto; padding: 10px; }
    #cart {
        top: 0;
        left: 670px;
        bottom: 500px;
    }
</style>
<body>
<h1>"Welcome to online shop!"</h1>
<br/>
<%
    HashMap<String, Item> items = (HashMap) request.getAttribute("Items");
    Cart bag = (Cart) request.getSession().getAttribute("Bag");
%>
</br>
<script>
    function test(article_id){
        document.getElementById("article_id").value = article_id;
        document.getElementById("count_id").value = document.getElementsByName(article_id)[0].value;
        update();
    }
</script>
<table>
    <form method="post" action="/Shop_war_exploded/" id="myform">
        <p><input type="hidden" name="articleOfItem" id="article_id" /></p>
        <p><input type="hidden" name="count" id="count_id" /></p>
    </form>
    <% for (Map.Entry<String, Item> goodsEntry : items.entrySet()) { %>
    <tr>
        <td><%= goodsEntry.getValue().getArticleNumber() %></td>
        <td><%= goodsEntry.getValue().getName() %></td>
        <td><%= goodsEntry.getValue().getPrice() %></td>
        <td>
            <p>Enter number of goods<input type="number" min=1 id="count" name="<%= goodsEntry.getValue().getArticleNumber() %>" /></p>
        </td>
        <td><input type="submit" value="Add to shopping bag" onclick='test("<%= goodsEntry.getValue().getArticleNumber() %>")' />
        </td>
    </tr>
    <% } %>
</table>
<br>
<a href="ShoppingCart.jsp">Go to cart</a>
<div id="cart"><b>Shopping cart:</b>
    <p>Count of item: <input name="countOfItems" id="itemsCount" value="<%=bag.getSize() %>"></p>
    <p>Total purchases: <input name="total" id="totalPurchase" value="<%=bag.getTotalPurchases() %>"></p>
</div>
<script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js">
</script>
<script>
    function update(){
        $.ajax({
            type : "post",
            url : "MainServlet.java",
            data : { articleAjax : $('#article_id').val(),
                    countAjax : $('#count_id').val()
            },

            success:function (msg)
            {
                let answer = msg.split(" ");

                document.getElementById("itemsCount").value = answer[0];
                document.getElementById("totalPurchase").value = answer[1];
            },

            error:function (xhr)
            {
                alert("error");
            }


        });
    }
</script>
</br>
</body>
</html>