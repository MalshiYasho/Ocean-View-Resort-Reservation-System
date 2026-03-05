<%@ page language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Add Reservation - Ocean View Resort</title>

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
                background: #f4f6f9;
                padding: 40px;
            }

            .form-box {
                background: white;
                padding: 30px;
                width: 500px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            }

            .form-box input,
            .form-box select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
            }

            .form-box button {
                padding: 12px;
                background: #0093E9;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }
        </style>
    </head>

    <body>

        <div class="container">

            <div class="sidebar">
                <h2>Ocean View Resort</h2>
                <a href="staff-dashboard.html">Dashboard</a>
                <a href="add-reservation.jsp">Add Reservation</a>
                <a href="view-reservation.jsp">View Reservation</a>
                <a href="calculate-bill.jsp">Calculate Bill</a>
                <a href="help.html">Help</a>
                <a href="login.jsp">Logout</a>
            </div>

            <div class="main">

                <h1>Add New Reservation</h1>
                <br>

                <div class="form-box">

                    <form action="ReservationServlet" method="post">

                        <input type="hidden" name="action" value="add">

                        <input type="text" name="guest_name" placeholder="Guest Name" required>

                        <input type="text" name="address" placeholder="Address" required>

                        <input type="text" name="contact_number" placeholder="Contact Number" required>

                        <select name="room_type">
                            <option value="Single">Single</option>
                            <option value="Double">Double</option>
                            <option value="Deluxe">Deluxe</option>
                        </select>

                        <label>Check In</label>
                        <input type="date" name="check_in" required>

                        <label>Check Out</label>
                        <input type="date" name="check_out" required>

                        <button type="submit">Add Reservation</button>

                    </form>

                </div>

            </div>

        </div>

    </body>

    </html>