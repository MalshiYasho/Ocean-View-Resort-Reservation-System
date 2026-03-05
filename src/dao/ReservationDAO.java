package dao;

import java.sql.*;
import model.Reservation;
import util.dbconnection;

public class ReservationDAO {

    public boolean addReservation(Reservation r) {

        boolean status = false;

        try {

            Connection con = dbconnection.getConnection();

            String sql = "INSERT INTO reservation(guest_name,address,contact_number,room_type,check_in,check_out) VALUES(?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, r.getGuestName());
            ps.setString(2, r.getAddress());
            ps.setString(3, r.getContactNumber());
            ps.setString(4, r.getRoomType());
            ps.setString(5, r.getCheckIn());
            ps.setString(6, r.getCheckOut());

            ps.executeUpdate();

            status = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;

    }

    public ResultSet getReservation(int id) {

        ResultSet rs = null;

        try {

            Connection con = dbconnection.getConnection();

            String sql = "SELECT * FROM reservation WHERE reservation_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            rs = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;

    }

}