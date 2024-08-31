<%-- 
    Document   : home
    Created on : Feb 18, 2024, 7:36:49 PM
    Author     : User
--%>

<%@page import="model.Supplier"%>
<%@page import="utils.CurrencyHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Product"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <style>
            .home-container{
                background-color: #f5f5f5
            }
            .nav-link{
                font-weight: 700;
            }
            .filter-item{
                border: 1px solid rgba(0, 0, 0, 0.125);
                border-radius: 5px;
                display: inline-block;
                text-align: center;
                padding: 16px;
                background-color: #fff
            }
            .supplier-heading{
                border-bottom: 1px solid rgba(0, 0, 0, 0.125);
                padding: 0 0 4px 0;
            }
            .btn--supplier{
                background-color: #007bff;
                color: #fff;
                min-width: 92px;
                margin: 5px 10px;
                padding: 5px 5px;
            }
            .product-list {
                flex: 8;
                float: left;
            }
            .sort-container{
                margin-left: 10px;
            }
            .product {
                width: 20%;
                display: inline-block;
                margin: 10px 10px;
            }

            .strike {
                text-decoration: line-through;
            }

            .home-container {
                display: flex;
                padding-left: 150px;
                padding-right: 150px;
                padding-top: 50px;
            }
            .filter-container {
                flex: 2;
            }
            .supplier_link{
                text-decoration: none;
            }
            .selected {
                font-weight: 700;
                text-decoration: none;
            }
            .card-title {
                min-height: 70px;
                overflow: hidden;
                display: -webkit-box;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 2;
            }
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    </head>
    <body>
        <% User user = (User) session.getAttribute("user"); %>

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
<!--            <a class="navbar-brand" href="#">Navbar w/ text</a>-->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Pricing</a>
                    </li>
                </ul>
                <span class="navbar-text">
                    <% if (user != null) {%>
                    <h4><%= user.getLastName() + " " + user.getFirstName()%></h4>
                    <% }%> 
                </span>
            </div>
        </nav>

        <div class="home-container">
            <div class="filter-container">
                <div class="filter-item">
                    <h5 class="supplier-heading">Suppliers</h5>
                    <% String seletedSupplierId = (String) request.getParameter("supplierId");  %>
                    <div class="">
                        <% ArrayList<Supplier> supplierList = (ArrayList<Supplier>) request.getAttribute("supplierList"); %>
                        <% for (Supplier supplier : supplierList) {%>
                        <div class="supplier-item">
                            <a class="<%= seletedSupplierId != null && supplier.getId() == Integer.parseInt(seletedSupplierId) ? "selected" : "supplier_link"%>" href="./home?supplierId=<%= supplier.getId()%>" class="btn"><%= supplier.getCompanyName()%></a>
                        </div>
<!--                        <button class="btn btn--supplier" onclick="handleFilterBySupplier(<%= supplier.getId()%>)"><%= supplier.getCompanyName()%></button>-->
                        <br>
                        <% } %>
                    </div>
                </div>
            </div>
            <div class="product-list">
                <div class="sort-container">
                    <a href="./home?sortBy=title&order=asc" class="btn btn-primary">Sort by title</a>
                    <a href="./home?sortBy=price&order=asc" class="btn btn-info">Sort by price</a>
                    <a href="./home?sortBy=sale_rate&order=desc" class="btn btn-secondary">Sort by sale</a>
                </div>
                <br>
                <% ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("productList"); %>
                <% for (Product product : productList) {%>
                <div class="card product">
                    <img class="card-img-top" src="<%= product.getImages().get(0)%>" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getTitle()%></h5>
                        <h5 class="card-text strike"><%= CurrencyHelper.format(product.getCompareAtPrice())%></h5>
                        <h4 class="card-text"><%= CurrencyHelper.format(product.getPrice())%></h4>
                        <h3 class="card-text" style="color: red;">SALE <%= (int) product.getSaleRate()%>%</h3>
                        <a href="/project_web/product-detail?id=<%= product.getId()%>" class="btn btn-primary">Detail</a>
                    </div>
                </div>
                <% }%>
            </div>
        </div>
        <div class = "container" style="display:flex; justify-content: center; margin-top: 20px;">
            <nav aria-label="...">
                <ul class="pagination">
                    <%int totalPages = (int)request.getAttribute("totalPages");%>
                    <%int currentPage = (int)request.getAttribute("currentPage");%>
                    <li class="page-item disabled">
                        <a class="page-link" href="./home?page=<%= currentPage - 1 %>">Previous</a>
                    </li>
                    <% for(int i = 1; i<=totalPages; i++){ %>
                        <li class="page-item <%= (i==currentPage ? " active" : "") %>"><a class="page-link" href="./home?page=<%= i %>"><%= i %></a></li>
                    <%}%>
                    <li class="page-item">
                        <a class="page-link" href="./home?page=<%= currentPage + 1 %>">Next</a>
                    </li>
                </ul>
            </nav>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>
            function handleFilterBySupplier(id) {
                $.ajax({
                    url: "./home",
                    type: "get", //send it through get method
                    data: {
                        supplierId: id,
                    },
                    success: function (data) {
                        console.log(">>> data", data);
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });
            }
            
//            setInterval(() => {callApi()}, 5000);
//            function callApi(){
//                $.ajax({
//                    url: "https://jsonplaceholder.typicode.com/users",
//                    type: "get", //send it through get method
//                    data: {
//                        
//                    },
//                    success: function (data) {
//                        console.log(">>> data", data);
//                    },
//                    error: function (xhr) {
//                        //Do Something to handle error
//                    }
//                });
//            }
        </script>
    </body>
</html>
