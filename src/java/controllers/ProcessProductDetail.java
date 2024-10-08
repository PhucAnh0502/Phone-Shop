/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import DAO.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Product;
import model.User;

/**
 *
 * @author PHUCANH
 */
@WebServlet(name = "ProcessProductDetail", urlPatterns = {"/product-detail"})
public class ProcessProductDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("id");
        Product product = ProductDAO.getProductById(Integer.parseInt(id));
        if(product != null){
            request.setAttribute("product", product);
        } else {
            request.setAttribute("message", "Cannot find item");
        }
        RequestDispatcher dis = request.getRequestDispatcher("product-detail.jsp");
        dis.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int productId = Integer.parseInt(request.getParameter("product_id"));
        String comment = request.getParameter("comment");
        
        HttpSession session = request.getSession();
        User userInfo = (User)session.getAttribute("user");
        if(userInfo==null){
            response.sendRedirect("./home");
            return;
        }
        boolean isSuccess = ProductDAO.createComment(userInfo.getId(), productId, comment);
        response.sendRedirect("./product-detail?id=" + productId);
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
