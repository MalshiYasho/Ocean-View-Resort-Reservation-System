<%@ page session="true" %>

<%
    String role = (String) session.getAttribute("role");

    if(role == null){
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Help - Ocean View Resort</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Segoe UI;
        }

        body {
            background: #f4f6f9;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background: #1e1e2f;
            color: white;
            padding: 25px;
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
        }

        .sidebar h2 {
            color: #0093E9;
            margin-bottom: 35px;
        }

        .sidebar a {
            display: block;
            padding: 12px 15px;
            margin-bottom: 10px;
            text-decoration: none;
            color: #ccc;
            border-radius: 6px;
        }

        .sidebar a:hover {
            background: #0093E9;
            color: white;
        }

        /* Main */
        .main {
            margin-left: 250px;
            padding: 40px;
            width: 100%;
        }

        h1 {
            margin-bottom: 30px;
        }

        /* Help Box */
        .help-box {
            background: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }

        .help-box h3 {
            color: #0093E9;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>

    <div class="container">

        <div class="sidebar">

            <h2>Ocean View Resort</h2>

            <% if(role != null && role.equalsIgnoreCase("admin")){ %>

            <a href="admin-dashboard.jsp">Dashboard</a>
            <a href="manage-rooms.jsp">Manage Rooms</a>
            <a href="manage-users.jsp">Manage Users</a>
            <a href="view-reports.jsp">View Reports</a>
            <a href="help.jsp">Help</a>
            <a href="LogoutServlet">Logout</a>

            <% } else { %>

            <a href="staff-dashboard.jsp">Dashboard</a>
            <a href="add-reservation.jsp">Add Reservation</a>
            <a href="view-reservations.jsp">View Reservations</a>
            <a href="calculate-bill.jsp">Calculate Bill</a>
            <a href="print-bill.jsp">Print Bill</a>
            <a href="help.jsp">Help</a>
            <a href="LogoutServlet">Logout</a>

            <% } %>

        </div>


        <div class="main">

            <h1>Help Guide</h1>

            <% if(role != null && role.equalsIgnoreCase("admin")){ %>

            <div class="help-box">
                <h3>Manage Rooms</h3>
                <p>Add, update, and delete room information.</p>
            </div>

            <div class="help-box">
                <h3>Manage Users</h3>
                <p>Create and manage staff accounts.</p>
            </div>

            <div class="help-box">
                <h3>View Reports</h3>
                <p>View system reports and booking summaries.</p>
            </div>

            <% } else { %>

            <div class="help-box">
                <h3>Add Reservation</h3>
                <p>Create new customer reservations.</p>
            </div>

            <div class="help-box">
                <h3>View Reservations</h3>
                <p>Check and manage existing reservations.</p>
            </div>

            <div class="help-box">
                <h3>Calculate Bill</h3>
                <p>Calculate room charges and customer payments.</p>
            </div>

            <div class="help-box">
                <h3>Print Bill</h3>
                <p>Generate and print customer bills.</p>
            </div>

            <% } %>

        </div>

    </div>

</body>
</html>