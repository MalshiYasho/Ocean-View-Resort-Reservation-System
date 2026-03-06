<%@ page import="java.sql.*" %>
<%@ page import="util.dbconnection" %>

<!DOCTYPE html>
<html>
<head>
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
            height: 100vh;
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

        .top-bar {
            margin-bottom: 40px;
        }

        .top-bar h1 {
            font-size: 28px;
            color: #333;
        }

        .search-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .search-container label {
            font-weight: 600;
            color: #555;
        }

        input[type="text"] {
            padding: 10px;
            width: 200px;
            border-radius: 6px;
            border: 1px solid #ccc;
            outline: none;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background: #0093E9;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
        }

        input[type="submit"]:hover {
            background: #007bb5;
        }

        .result {
            margin-top: 25px;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            line-height: 1.8;
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
            <div class="top-bar">
                <h1>View Reservation</h1>
            </div>

            <form method="get" class="search-container">
                <label>Reservation ID:</label>
                <input type="text" name="reservation_id" required>
                <input type="submit" value="View Details">
            </form>

            <% 
                String resId = request.getParameter("reservation_id"); 
                if(resId != null && !resId.isEmpty()){ 
                    try { 
                        Connection con = util.dbconnection.getConnection(); 
                        String sql = "SELECT * FROM reservation WHERE reservation_id=?"; 
                        PreparedStatement ps = con.prepareStatement(sql); 
                        ps.setString(1, resId); 
                        ResultSet rs = ps.executeQuery();

                        if(rs.next()){ 
            %>
            <div class="result">
                <p><strong>Guest Name:</strong> <%= rs.getString("guest_name") %></p>
                <p><strong>Address:</strong> <%= rs.getString("address") %></p>
                <p><strong>Contact:</strong> <%= rs.getString("contact_number") %></p>
                <p><strong>Room Type:</strong> <%= rs.getString("room_type") %></p>
                <p><strong>Check-In:</strong> <%= rs.getDate("check_in") %></p>
                <p><strong>Check-Out:</strong> <%= rs.getDate("check_out") %></p>
            </div>
            <% 
                        } else { 
            %>
            <div class="result" style="color: #e74c3c;">
                No reservation found with ID: <strong><%= resId %></strong>
            </div>
            <% 
                        } 
                        rs.close(); 
                        ps.close(); 
                        con.close(); 
                    } catch(Exception e){ 
                        out.println("<div class='result'>Error: " + e.getMessage() + "</div>");
                    }
                }
            %>
        </div>
    </div>
</body>
</html>