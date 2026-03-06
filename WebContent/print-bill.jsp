<%@ page import="java.sql.*, java.util.Date, util.dbconnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Print Bill - Ocean View Resort</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, sans-serif;
        }

        body {
            background: #f4f6f9;
            color: #333;
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
        }

        .sidebar a:hover {
            background: #0093E9;
            color: white;
        }

        .main {
            flex: 1;
            padding: 40px;
            margin-left: 250px;
        }

        .top-bar {
            margin-bottom: 30px;
        }

        .top-bar h1 {
            font-size: 26px;
        }

        .search-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        input[type="text"] {
            padding: 10px;
            width: 220px;
            border: 1px solid #ddd;
            border-radius: 4px;
            outline: none;
        }

        .btn-blue {
            padding: 10px 20px;
            background: #0093E9;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .invoice-box {
            background: #fff;
            padding: 40px;
            border-radius: 8px;
            max-width: 800px;
            margin: 0 auto;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .invoice-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .invoice-header h2 {
            font-size: 28px;
            letter-spacing: 1px;
        }

        .invoice-header p {
            color: #777;
            font-size: 14px;
            margin-top: 5px;
        }

        .bill-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .bill-info strong {
            color: #000;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table th {
            background: #f8f9fa;
            text-align: left;
            padding: 12px;
            border-bottom: 2px solid #eee;
            color: #555;
        }

        table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }

        .text-right {
            text-align: right;
        }

        .total-row {
            font-size: 18px;
            font-weight: bold;
            background: #fdfdfd;
        }

        .footer-note {
            text-align: center;
            color: #888;
            margin-top: 30px;
            font-size: 13px;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-print {
            background: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        @media print {
            .sidebar, .search-container, .top-bar, .button-group {
                display: none;
            }
            .main {
                margin-left: 0;
                padding: 0;
            }
            .invoice-box {
                box-shadow: none;
                border: none;
                width: 100%;
                max-width: 100%;
            }
        }
    </style>
    <script>
        function printInvoice() {
            window.print();
        }
    </script>
</head>
<body>

<div class="container">
    <div class="sidebar">
        <h2>Ocean View Resort</h2>
        <a href="staff-dashboard.jsp">Dashboard</a>
        <a href="add-reservation.jsp">Add Reservation</a>
        <a href="view-reservation.jsp">View Reservation</a>
        <a href="calculate-bill.jsp">Calculate Bill</a>
        <a href="print-bill.jsp" style="background: #0093E9; color: white;">Print Bill</a>
        <a href="help.jsp">Help</a>
        <a href="login.jsp">Logout</a>
    </div>

    <div class="main">
        <div class="top-bar">
            <h1>Print Bill</h1>
        </div>

        <form method="get" class="search-container">
            <label>Reservation ID:</label>
            <input type="text" name="reservation_id" required>
            <input type="submit" class="btn-blue" value="Generate Invoice">
        </form>

        <%
            String id = request.getParameter("reservation_id");
            if(id != null && !id.isEmpty()){
                try {
                    Connection dbConn = util.dbconnection.getConnection();
                    PreparedStatement st = dbConn.prepareStatement("SELECT * FROM reservation WHERE reservation_id=?");
                    st.setString(1, id);
                    ResultSet data = st.executeQuery();
                    
                    if(data.next()){
                        Date inDate = data.getDate("check_in");
                        Date outDate = data.getDate("check_out");
                        long timeDiff = outDate.getTime() - inDate.getTime();
                        long stayDays = timeDiff / (1000 * 60 * 60 * 24);
                        if(stayDays <= 0) stayDays = 1;
                        
                        int dayRate = 5000;
                        long finalAmount = stayDays * dayRate;
        %>
            <div class="invoice-box">
                <div class="invoice-header">
                    <h2>Ocean View Resort</h2>
                    <p>Official Bill Receipt</p>
                </div>

                <div class="bill-info">
                    <div>
                        <p><strong>Billed To:</strong></p>
                        <p><%= data.getString("guest_name") %></p>
                        <p><%= data.getString("address") %></p>
                        <p>Tel: <%= data.getString("contact_number") %></p>
                    </div>
                    <div class="text-right">
                        <p><strong>Bill ID:</strong> #RES-<%= id %></p>
                        <p><strong>Date:</strong> <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()) %></p>
                    </div>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th class="text-right">Unit Price</th>
                            <th class="text-right">Days</th>
                            <th class="text-right">Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Accommodation - <%= data.getString("room_type") %> Room</td>
                            <td class="text-right">LKR <%= dayRate %>.00</td>
                            <td class="text-right"><%= stayDays %></td>
                            <td class="text-right">LKR <%= finalAmount %>.00</td>
                        </tr>
                        <tr class="total-row">
                            <td colspan="3" class="text-right">Total Amount</td>
                            <td class="text-right">LKR <%= finalAmount %>.00</td>
                        </tr>
                    </tbody>
                </table>

                <p class="footer-note">Thank you for staying with us!</p>

                <div class="button-group">
                    <button onclick="printInvoice()" class="btn-print">Print Receipt</button>
                </div>
            </div>
        <%
                    } else {
                        out.println("<p style='text-align:center; color:red;'>No record found for ID: " + id + "</p>");
                    }
                    dbConn.close();
                } catch(Exception err) {
                    out.println("Error: " + err.getMessage());
                }
            }
        %>
    </div>
</div>

</body>
</html>