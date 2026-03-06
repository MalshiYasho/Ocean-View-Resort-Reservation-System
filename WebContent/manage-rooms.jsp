<%@ page import="java.util.List" %>
<%@ page import="dao.RoomDAO" %>
<%@ page import="model.Room" %>

<%
    RoomDAO dao = new RoomDAO();
    List<Room> rooms = dao.getAllRooms();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Rooms - Ocean View Resort</title>
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
            flex-shrink: 0;
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
            overflow-y: auto;
        }

        .top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }

        .top h1 {
            font-size: 26px;
            color: #333;
        }

        .btn-add {
            background: #0093E9;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            display: inline-block;
        }

        .btn-add:hover {
            opacity: 0.9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background: #1e1e2f;
            color: white;
            padding: 16px;
            text-align: center;
            font-weight: 600;
        }

        td {
            padding: 16px;
            border-bottom: 1px solid #eee;
            text-align: center;
        }

        .actions button {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
            font-weight: 600;
            margin: 0 5px;
        }

        .edit-btn { background: #0093E9; }
        .delete-btn { background: #ff0000; }

    </style>
</head>
<body>

    <div class="container">
        <div class="sidebar">
            <h2>Ocean View Resort</h2>
            <a href="admin-dashboard.jsp">Dashboard</a>
            <a href="manage-rooms.jsp">Manage Rooms</a>
            <a href="manage-users.jsp">Manage Users</a>
            <a href="view-reports.jsp">Reports</a>
            <a href="help.jsp">Help</a>
            <a href="LogoutServlet">Logout</a>
        </div>

        <div class="main">
            <div class="top">
                <h1>Manage Rooms</h1>
                <a href="add-room.jsp" class="btn-add">Add New Room</a>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Type</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(rooms != null) {
                        for(Room r : rooms){ %>
                    <tr>
                        <td>#<%= r.getRoomId() %></td>
                        <td><%= r.getType() %></td>
                        <td><%= r.getPrice() %></td>
                        <td><%= r.getStatus() %></td>
                        <td class="actions">
                            <a href="edit-room.jsp?id=<%=r.getRoomId()%>">
                                <button class="edit-btn">Edit</button>
                            </a>
                            <a href="RoomServlet?action=delete&id=<%=r.getRoomId()%>">
                                <button class="delete-btn">Delete</button>
                            </a>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>