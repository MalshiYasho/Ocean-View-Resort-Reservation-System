<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="util.dbconnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Calculate Bill - Ocean View Resort</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            line-height: 2.2;
            max-width: 600px;
        }

        .bill-row {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px dashed #eee;
        }

        .total-box {
            margin-top: 20px;
            padding-top: 10px;
            border-top: 2px solid #0093E9;
            font-size: 22px;
            font-weight: bold;
            color: #1e1e2f;
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h2>Ocean View Resort</h2>
            <a href="staff-dashboard.jsp">Dashboard</a>
            <a href="add-reservation.jsp">Add Reservation</a>
            <a href="view-reservation.jsp">View Reservation</a>
            <a href="calculate-bill.jsp" style="background: #0093E9; color: white;">Calculate Bill</a>
            <a href="print-bill.jsp">Print Bill</a>
            <a href="help.jsp">Help</a>
            <a href="LogoutServlet">Logout</a>
        </div>

        <div class="main">
            <div class="top-bar">
                <h1>Calculate Bill</h1>
            </div>

            <form method="get" class="search-container">
                <label>Reservation ID:</label>
                <input type="text" name="reservation_id" placeholder="Enter ID e.g. 4" required>
                <input type="submit" value="Calculate Amount">
            </form>

            <% 
                String id = request.getParameter("reservation_id"); 
                if(id != null && !id.isEmpty()){ 
                    try { 
                        Connection con = util.dbconnection.getConnection(); 
                        String sql = "SELECT r.*, rm.room_type FROM reservations r " +
                                     "JOIN rooms rm ON r.room_id = rm.room_id " +
                                     "WHERE r.reservation_id=?";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setString(1, id);
                        ResultSet rs = ps.executeQuery(); 
                        
                        if(rs.next()){ 
                            Date checkIn = rs.getDate("check_in_date");
                            Date checkOut = rs.getDate("check_out_date"); 
                            String roomType = rs.getString("room_type");
                            
                            long diff = checkOut.getTime() - checkIn.getTime(); 
                            long days = diff / (1000 * 60 * 60 * 24); 
                            if(days <= 0) days = 1; 
                            
                            double pricePerDay = 5000; 
                            
                            if(roomType != null) {
                                String typeLow = roomType.toLowerCase();
                                if(typeLow.contains("deluxe")) {
                                    pricePerDay = 15000;
                                } else if(typeLow.contains("sea view") || typeLow.contains("suite")) {
                                    pricePerDay = 22000;
                                } else if(typeLow.contains("double")) {
                                    pricePerDay = 12000;
                                } else if(typeLow.contains("family")) {
                                    pricePerDay = 18000;
                                }
                            }

                            double finalTotal = days * pricePerDay;
                            DecimalFormat df = new DecimalFormat("#,###.00");
            %>
            <div class="result">
                <div class="bill-row">
                    <span><strong>Guest Name:</strong></span>
                    <span><%= rs.getString("guest_name") %></span>
                </div>
                <div class="bill-row">
                    <span><strong>Room Category:</strong></span>
                    <span><%= roomType %></span>
                </div>
                <div class="bill-row">
                    <span><strong>Stay Duration:</strong></span>
                    <span><%= days %> Day(s)</span>
                </div>
                <div class="bill-row">
                    <span><strong>Rate per Day:</strong></span>
                    <span>LKR <%= df.format(pricePerDay) %></span>
                </div>
                
                <div class="total-box">
                    <span>Total Bill:</span>
                    <span>LKR <%= df.format(finalTotal) %></span>
                </div>
            </div>
            <% 
                        } else { 
            %>
            <div class="result" style="color: #e74c3c; text-align: center;">
                No reservation record found for ID: <strong><%= id %></strong>
            </div>
            <% 
                        }
                        con.close();
                    } catch(Exception e) { 
                        out.println("<div class='result' style='color:red;'>SQL Error: " + e.getMessage() + "</div>"); 
                    } 
                }
            %>
        </div>
    </div>
</body>
</html>