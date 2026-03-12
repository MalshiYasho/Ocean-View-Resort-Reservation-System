package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Room;
import util.dbconnection;

public class RoomDAO {

    public boolean addRoom(Room room) {
        boolean success = false;
        try (Connection con = dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO rooms (room_type, price_per_night, status) VALUES (?, ?, ?)")) {

            ps.setString(1, room.getType());
            ps.setDouble(2, room.getPrice());
            ps.setString(3, room.getStatus());

            success = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean updateRoom(Room room) {
        boolean success = false;
        try (Connection con = dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "UPDATE rooms SET room_type=?, price_per_night=?, status=? WHERE room_id=?")) {

            ps.setString(1, room.getType());
            ps.setDouble(2, room.getPrice());
            ps.setString(3, room.getStatus());
            ps.setInt(4, room.getRoomId());

            success = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean deleteRoom(int roomId) {
        boolean success = false;
        try (Connection con = dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM rooms WHERE room_id=?")) {

            ps.setInt(1, roomId);
            success = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public Room getRoomById(int roomId) {
        Room room = null;
        try (Connection con = dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM rooms WHERE room_id=?")) {

            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                room = new Room(
                        rs.getInt("room_id"),
                        rs.getString("room_type"),
                        rs.getDouble("price_per_night"),
                        rs.getString("status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return room;
    }

    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        try (Connection con = dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM rooms")) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rooms.add(new Room(
                        rs.getInt("room_id"),
                        rs.getString("room_type"),
                        rs.getDouble("price_per_night"),
                        rs.getString("status")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }
}
