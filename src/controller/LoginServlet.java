package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.userDAO;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        userDAO userDao = new userDAO();
        User user = userDao.login(username, password);

        if (user != null) {
            
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            session.setAttribute("role", user.getRole());   

            if ("on".equals(remember)) {
                Cookie userCookie = new Cookie("username", username);
                Cookie passCookie = new Cookie("password", password);
                userCookie.setMaxAge(7 * 24 * 60 * 60); 
                passCookie.setMaxAge(7 * 24 * 60 * 60);
                response.addCookie(userCookie);
                response.addCookie(passCookie);
            } else {
                
                Cookie userCookie = new Cookie("username", "");
                Cookie passCookie = new Cookie("password", "");
                userCookie.setMaxAge(0);
                passCookie.setMaxAge(0);
                response.addCookie(userCookie);
                response.addCookie(passCookie);
            }

           
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admin-dashboard.html");
            } else if ("staff".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("staff-dashboard.html");
            } else {
                request.setAttribute("errorMessage", "Role not defined!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
           request.setAttribute("errorMessage", "Invalid username or password");
           request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}