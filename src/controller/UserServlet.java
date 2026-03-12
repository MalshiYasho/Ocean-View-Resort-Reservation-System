package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.userDAO;
import model.User;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

    private userDAO dao = new userDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if ("edit".equals(action) && idParam != null) {
            int id = Integer.parseInt(idParam);
            User user = dao.getUserById(id);
            request.setAttribute("user", user);
            request.getRequestDispatcher("user-form.jsp").forward(request, response);
            return;
        }

        if ("delete".equals(action) && idParam != null) {
            int id = Integer.parseInt(idParam);
            dao.deleteUser(id);
            response.sendRedirect("manage-users.jsp");
            return;
        }

        response.sendRedirect("manage-users.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (idParam == null || idParam.isEmpty()) {
    
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setRole(role);
            dao.addUser(newUser);
            
        } else {
          
            int id = Integer.parseInt(idParam);
            User existingUser = new User();
            existingUser.setUserId(id);
            existingUser.setUsername(username);
            existingUser.setPassword(password);
            existingUser.setRole(role);
            dao.updateUser(existingUser);
        }

        response.sendRedirect("manage-users.jsp");
    }
}

