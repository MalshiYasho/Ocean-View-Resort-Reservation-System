package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.User;
import util.dbconnection;

public class userDAO {

    public User login(String user, String pass) {
        User u = null;
        try {
            Connection con = dbconnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"), rs.getString("role"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public User getUserById(int id) {
        User u = null;
        try {
            Connection con = dbconnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE user_id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"), rs.getString("role"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public User getUserByUsername(String username) {
        User u = null;
        try {
            Connection con = dbconnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role")
                );
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public List<User> getAllUsers() {

        List<User> userList = new ArrayList<>();

        try {
            Connection con = dbconnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                
                userList.add(new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"), rs.getString("role")));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    public boolean addUser(User u) {
        boolean rowInserted = false;
        try {
            Connection con = dbconnection.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO users(username, password, role) VALUES(?,?,?)");
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getRole());
            rowInserted = ps.executeUpdate() > 0;
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public boolean updateUser(User u) {
        boolean rowUpdated = false;
        try {
            Connection con = dbconnection.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE users SET username=?, password=?, role=? WHERE user_id=?");
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getRole());
            ps.setInt(4, u.getUserId());
            rowUpdated = ps.executeUpdate() > 0;
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deleteUser(int id) {
        boolean rowDeleted = false;
        try {
            Connection con = dbconnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE user_id=?");
            ps.setInt(1, id);
            rowDeleted = ps.executeUpdate() > 0;
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
}