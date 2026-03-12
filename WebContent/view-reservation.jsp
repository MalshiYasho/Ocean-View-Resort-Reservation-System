<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, util.dbconnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Reservation - Ocean View Resort</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background: #1e1e2f;
            padding: 25px;
            color: white;
            position: fixed;
            height: 100%;
        }

        .sidebar h2 {
            margin-bottom: 35px;
            font-size: 22px;
            color: #0093E9;
        }

        .sidebar a {
            display: block;
            padding: 12px 15px;
            margin-bottom: 12px;
            text-decoration: none;
            color: #ccc;
            border-radius: 6px;
            transition: 0.3s;
        }

        .sidebar a:hover {
            background: #0093E9;
            color: white;
        }

        .main {
            flex: 1;
            background: #f4f6f9;
            padding: 40px;
            margin-left: 250px;
        }

        h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        .table-container {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            overflow-x: auto;
        }

        .search-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            align-items: center;
        }

        input[type="text"] {
            padding: 10px;
            width: 300px;
            border-radius: 6px;
            border: 1px solid #ddd;
            outline: none;
        }

        .btn-search {
            background: #0093E9;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th {
            background: #1e1e2f;
            color: white;
            text-align: left;
            padding: 12px;
            border-bottom: 2px solid #eee;
            font-size: 14px;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            color: #444;
            font-size: 14px;
        }

        .btn-delete {
            background: #ff4757;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h2>Ocean View Resort</h2>
            <a href="staff-dashboard.jsp">Dashboard</a>
            <a href="add-reservation.jsp">Add Reservation</a>
            <a href="view-reservation.jsp" style="background: #0093E9; color: white;">View Reservation</a>
            <a href="calculate-bill.jsp">Calculate Bill</a>
            <a href="print-bill.jsp">Print Bill</a>
            <a href="help.jsp">Help</a>
            <a href="LogoutServlet">Logout</a>
        </div>

        <div class="main">
            <h1>View Reservation</h1>
            <div class="table-container">
                <form method="get" class="search-bar">
                    <input type="text" name="search" placeholder="Search Guest Name or ID..." 
                           value="<%= (request.getParameter("search") != null) ? request.getParameter("search") : "" %>">
                    <button type="submit" class="btn-search">Search</button>
                    <a href="view-reservation.jsp" style="text-decoration:none; color:#666; margin-left:10px;">Reset</a>
                </form>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Guest Name</th>
                            <th>Contact</th>
                            <th>Room</th>
                            <th>Check-In</th>
                            <th>Check-Out</th>
                            <th>Total (LKR)</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection con = null;
                            try {
                                con = dbconnection.getConnection();
                                String search = request.getParameter("search");
                                String sql = "SELECT * FROM reservations";

                                if (search != null && !search.trim().isEmpty()) {
                                    sql += " WHERE guest_name LIKE ? OR reservation_id = ?";
                                }

                                PreparedStatement ps = con.prepareStatement(sql);
                                if (search != null && !search.trim().isEmpty()) {
                                    ps.setString(1, "%" + search + "%");
                                    ps.setString(2, search.matches("\\d+") ? search : "-1");
                                }

                                ResultSet rs = ps.executeQuery();
                                boolean hasData = false;
                                while (rs.next()) {
                                    hasData = true;
                        %>
                        <tr>
                            <td><strong><%= rs.getInt("reservation_id") %></strong></td>
                            <td><%= rs.getString("guest_name") %></td>
                            <td><%= rs.getString("contact_number") %></td>
                            <td>Unit <%= rs.getInt("room_id") %></td>
                            <td><%= rs.getString("check_in_date") %></td>
                            <td><%= rs.getString("check_out_date") %></td>
                            <td><%= String.format("%.2f", rs.getDouble("total_amount")) %></td>
                            <td>
                                <a href="ReservationServlet?action=delete&id=<%= rs.getInt("reservation_id") %>&roomId=<%= rs.getInt("room_id") %>" 
                                   class="btn-delete" onclick="return confirm('Cancel this reservation?')">Cancel</a>
                            </td>
                        </tr>
                        <%
                                }
                                if (!hasData) {
                        %>
                        <tr><td colspan="8" style="text-align:center; padding:20px;">No reservations found.</td></tr>
                        <%
                                }
                            } catch (Exception e) {
                        %>
                        <tr><td colspan="8" style="color:red; text-align:center;">Error: <%= e.getMessage() %></td></tr>
                        <%
                            } finally {
                                if (con != null) con.close();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>