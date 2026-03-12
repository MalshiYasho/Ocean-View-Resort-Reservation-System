<%@ page import="model.Room" %>
<%Room room = (Room) request.getAttribute("room"); boolean isEditRoom = (room != null); %>

<!DOCTYPE html>
<html>

<head>
    <title>Add Room</title>

    <style>
        body {
            font-family: Segoe UI;
            background: #f4f6f9;
        }

        .form-box {
            width: 400px;
            margin: 80px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        input,
        select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 10px;
            background: #0093E9;
            border: none;
            color: white;
            border-radius: 6px;
            cursor: pointer;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #0093E9;
            text-decoration: none;
        }

    </style>
</head>

<body>

    <div class="form-box">

        <h2><%= isEditRoom ? "Edit Room" : "Add New Room" %></h2>

        <form action="RoomServlet" method="post">
            
            <% Room r =(Room) request.getAttribute("room"); %>
                <input type="hidden" name="action" value="<%= (room != null) ? "update" : "insert" %>">
                <% if (room !=null) { %>
                    <input type="hidden" name="roomId" value="<%= r.getRoomId() %>"><% } %>    
                    
                    <input type="text" name="type" placeholder="Room Type" value="<%= (r != null) ? r.getType() : "" %>" required>

                    <input type="number" name="price" placeholder="Price" value="<%= (r != null) ? r.getPrice() : "" %>" required>
                       
                    <select name="status">
                        <option value="Available" <%= (r != null && "Available".equals(r.getStatus())) ? "selected" : "" %>>Available</option>
                        <option value="Booked" <%= (r != null && "Booked".equals(r.getStatus())) ? "selected" : "" %>>Booked</option>
                    </select>

                    <button type="submit"><%= (r != null) ? "Update Room" : "Add Room" %></button>

        </form>

        <a href="manage-rooms.jsp">Back to Rooms</a>

    </div>

</body>

</html>