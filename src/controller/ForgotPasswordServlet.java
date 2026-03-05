package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.userDAO;
import model.User;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        userDAO userDao = new userDAO();
        User user = userDao.getUserByUsername(username);

        if (user != null) {
            
            request.setAttribute("message", "Your password is: " + user.getPassword());
        } else {
            request.setAttribute("message", "Username not found!");
        }
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }
}
