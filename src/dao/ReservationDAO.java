package dao;

import java.sql.*;
import model.Reservation;
import util.dbconnection;

public class ReservationDAO {

    public boolean addReservation(Reservation r) {

        boolean status = false;

        try {

            Connection con = dbconnection.getConnection();
            
            String sql = "INSERT INTO reservations(guest_name, address, contact_number, room_id, check_in_date, check_out_date, total_amount) VALUES(?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, r.getGuestName());
            ps.setString(2, r.getAddress());
            ps.setString(3, r.getContactNumber());
            ps.setInt(4, r.getRoomId());
            ps.setString(5, r.getCheckIn());
            ps.setString(6, r.getCheckOut());
            ps.setDouble(7, r.getTotalAmount());

            int result = ps.executeUpdate();
            if (result > 0) {
                status = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("SQL ERROR: " + e.getMessage());
        }

        return status;

    }

    public ResultSet getReservation(int id) {

        ResultSet rs = null;

        try {

            Connection con = dbconnection.getConnection();
            
            String sql = "SELECT * FROM reservations WHERE reservation_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            rs = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;

    }
    
}