<%-- 
    Document   : product-detail
    Created on : Feb 24, 2024, 8:29:09 PM
    Author     : User
--%>

<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.CurrencyHelper"%>
<%@page import="model.Product"%>
<%@page import="model.Comment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <style>
            .input-group{
                padding:100px 92px 50px;
                max-width: 1000px;
            }
            .comment-container{
                padding-left: 20px;
                margin: -23px 92px 30px;
                border: 1px solid #333;
            }
            .comment-author{
                color:#007bff;
                font-weight:600;
                min-width: 97px;
            }
        </style>
    </head>
    <body>
        <div class ="container">
            <h1>Product Detail</h1>
            <% Product product = (Product)request.getAttribute("product"); %>
            <% ArrayList<String> images = product.getImages();%>
            <% for(String image : images){%>
                <img src="<%= image %>"></img>
            <%}%>
            <h2><%= product.getTitle() %></h2>
            <h2><%= product.getDescription() %></h2>
            <h3><%= CurrencyHelper.format(product.getPrice()) %></h3>
        </div>
        <% ArrayList<Comment> comments = product.getComments();%>
        <% User user = (User)session.getAttribute("user");%>
        <form method="POST" action="./product-detail?id=<%= product.getId()%>">
            <div class="input-group">
                <span class="input-group-text"><%= user.getFullName()%></span>
                <input style="display:none;" name="product_id" value="<%= product.getId()%>"></input>
                <input name="comment" class="form-control" aria-label="With textarea"></input>
                <button type="submit" class="btn btn-primary">Post</button>
            </div>
        </form>
        <div class="comment-container">
            <% for(Comment comment : comments) { %>
                <div class="comment">
                    <label class="comment-author"><%= comment.getUser().getFullName() %></label>
                    <span class="comment-text"><%= comment.getContent() %></span>
                </div>
            <% } %>
        </div>
        
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
