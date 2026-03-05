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

        input, select {
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

        <h2>Add New Room</h2>

        <form action="RoomServlet" method="post">

            <input type="hidden" name="action" value="insert">

            <input type="text" name="type" placeholder="Room Type" required>

            <input type="number" name="price" placeholder="Price" required>

            <select name="status">
                <option value="Available">Available</option>
                <option value="Booked">Booked</option>
            </select>

            <button type="submit">Add Room</button>

        </form>
        
        <a href="manage-rooms.jsp">Back to Rooms</a>

    </div>

</body>
</html>