package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.ReservationDAO;
import model.Reservation;

@WebServlet("/ReservationServlet")

public class ReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    doPost(request, response);

}

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action.equals("add")) {

            Reservation r = new Reservation();

            r.setGuestName(request.getParameter("guest_name"));
            r.setAddress(request.getParameter("address"));
            r.setContactNumber(request.getParameter("contact_number"));

            String roomIdStr = request.getParameter("room_id");
            if (roomIdStr != null) {
                r.setRoomId(Integer.parseInt(roomIdStr)); 
            }

            r.setCheckIn(request.getParameter("check_in_date"));
            r.setCheckOut(request.getParameter("check_out_date"));


            String totalStr = request.getParameter("total_amount"); 
            if (totalStr != null) {
                r.setTotalAmount(Double.parseDouble(totalStr));
            }

            ReservationDAO dao = new ReservationDAO();

            boolean status = dao.addReservation(r);

            if (status) {

                response.sendRedirect("add-reservation.jsp?msg=success");

            } else {

                response.sendRedirect("add-reservation.jsp?msg=error");

            }

        }
        
        else if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                
                ReservationDAO dao = new ReservationDAO();
                if (dao.deleteReservation(id, roomId)) {
                    response.sendRedirect("view-reservation.jsp?msg=deleted");
                } else {
                    response.sendRedirect("view-reservation.jsp?msg=del_error");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("view-reservation.jsp?msg=exception");
            }
        }
    }
    
}

