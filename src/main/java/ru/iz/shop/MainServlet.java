package ru.iz.shop;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Arrays;
import java.util.HashMap;

@WebServlet(name = "MainServlet", value = "/MainServlet")
public class MainServlet extends HttpServlet {
    String url = "jdbc:postgresql://localhost:5432/postgres";
    String username = "selectel";
    String password = "selectel";
    HashMap<String, Item> itemHashMap = new HashMap<String, Item>();
    Cart cart = new Cart();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = null;
        try{
            con = DriverManager.getConnection(url, username, password);
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from catalog1");
            while (rs.next()){
                itemHashMap.put(rs.getString("article"), new Item(rs.getString("name"), rs.getString("article"), rs.getDouble("price")));
            }
        } catch ( Exception e){
            e.printStackTrace();
        }
        finally {
            try{
                if (con != null) {
                    con.close();
                }
            } catch (Exception e){
                e.printStackTrace();
            }

        }
        request.setAttribute("Items", itemHashMap);
        request.getSession().setAttribute("Bag", cart);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String article = request.getParameter("articleAjax");
        Item item = itemHashMap.get(article);
        int count = Integer.parseInt(request.getParameter("countAjax"));
        cart.addItem(item, count);
        request.getSession().setAttribute("Bag", cart);
        request.setAttribute("Items", itemHashMap);
        response.setContentType("text/plain");
        response.getWriter().write(Integer.toString(cart.getSize()) + " " + Integer.toString(cart.getTotalPurchases()));
    }
}
