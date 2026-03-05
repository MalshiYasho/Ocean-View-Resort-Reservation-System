package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.ReservationDAO;
import model.Reservation;

public class ReservationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action.equals("add")) {

            Reservation r = new Reservation();

            r.setGuestName(request.getParameter("guest_name"));
            r.setAddress(request.getParameter("address"));
            r.setContactNumber(request.getParameter("contact_number"));
            r.setRoomType(request.getParameter("room_type"));
            r.setCheckIn(request.getParameter("check_in"));
            r.setCheckOut(request.getParameter("check_out"));

            ReservationDAO dao = new ReservationDAO();

            boolean status = dao.addReservation(r);

            if (status) {

                response.sendRedirect("add-reservation.jsp?msg=success");

            } else {

                response.sendRedirect("add-reservation.jsp?msg=error");

            }

        }

    }

}