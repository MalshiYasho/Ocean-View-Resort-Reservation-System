package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.RoomDAO;
import model.Room;

@WebServlet("/RoomServlet")
public class RoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RoomDAO roomDAO = new RoomDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteRoom(request, response);
                    break;
                default:
                    listRooms(request, response);
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("RoomServlet?action=list");
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null)
            return;

        try {
            switch (action) {
                case "insert":
                    insertRoom(request, response);
                    break;
                case "update":
                    updateRoom(request, response);
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("RoomServlet?action=list");
        }

    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Room> rooms = roomDAO.getAllRooms();
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("manage-rooms.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("roomId");
        if (idStr != null) {
            int roomId = Integer.parseInt(idStr);
            Room existingRoom = roomDAO.getRoomById(roomId);
            request.setAttribute("room", existingRoom);
        }
        request.getRequestDispatcher("add-room.jsp").forward(request, response);
    }

    private void insertRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String type = request.getParameter("type");
        String priceStr = request.getParameter("price");
        String status = request.getParameter("status");

        double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;

        Room room = new Room(0, type, price, status);
        roomDAO.addRoom(room);
        response.sendRedirect("RoomServlet?action=list");
    }

    private void updateRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("roomId");
        String type = request.getParameter("type");
        String priceStr = request.getParameter("price");
        String status = request.getParameter("status");

        int roomId = (idStr != null && !idStr.isEmpty()) ? Integer.parseInt(idStr) : 0;
        double price = (priceStr != null) ? Double.parseDouble(priceStr) : 0.0;

        Room room = new Room(roomId, type, price, status);
        roomDAO.updateRoom(room);
        response.sendRedirect("RoomServlet?action=list");
    }

    private void deleteRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("roomId");
        if (idStr != null) {
            roomDAO.deleteRoom(Integer.parseInt(idStr));
        }
        response.sendRedirect("RoomServlet?action=list");
    }
}




