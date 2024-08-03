/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author PHUCANH
 */
@WebServlet(name = "ProcessCreateUser", urlPatterns = {"/create-user"})
public class ProcessCreateUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmpassword = request.getParameter("confirm-password");
        
        boolean isValid = true;
        String message = null;
        //Kiem tra password = confirmpassword
        if (!password.equals(confirmpassword)){
            //response loi
            message = "Mat khau khong trung";
            isValid = false;
        }
        //Kiem tra trung username
        boolean isExistUsername = UserDAO.isExistUsername(username);
        if(isExistUsername){
            //response loi
            message = "Tai khoan da ton tai";
            isValid = false;
        }
        
        User user = new User(username, password);
        boolean isCreated = UserDAO.insertUser(user);
        if(!isCreated){
            message = "Server error";
            isValid = false;
        }
        if(!isValid){
            request.setAttribute("message", message);
            RequestDispatcher dis = request.getRequestDispatcher("register.jsp");
            dis.forward(request, response);
        } else {
            response.sendRedirect("./login");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
