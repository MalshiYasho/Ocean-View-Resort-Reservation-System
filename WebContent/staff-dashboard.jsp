<!DOCTYPE html>
<html>
<head>
<title>Staff Dashboard - Ocean View Resort</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family: 'Segoe UI', sans-serif;
}

.container{
    display:flex;
    height:100vh;
}

.sidebar{
    width:250px;
    background:#1e1e2f;
    padding:25px;
    color:white;
}

.sidebar h2{
    margin-bottom:35px;
    font-size:22px;
    color:#0093E9; 
}

.sidebar a{
    display:block;
    padding:12px 15px;
    margin-bottom:12px;
    text-decoration:none;
    color:#ccc;
    border-radius:6px;
    transition:0.3s;
}

.sidebar a:hover{
    background:#0093E9;
    color:white;
}

.main{
    flex:1;
    background:#f4f6f9;
    padding:40px;
}

.top-bar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:40px;
}

.top-bar h1{
    font-size:28px;
    color:#333;
}

.top-bar .welcome{
    font-size:20px;
    font-weight:500;
    color:#0e0e0e;
}

.cards{
    display:flex;
    gap:30px;
    justify-content:flex-start;
}

.card{
    width:280px;
    height:170px;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,0.08);
    display:flex;
    flex-direction:column;
    justify-content:center;
    text-align:center;
    transition:0.3s;
}

.card:hover{
    transform:translateY(-5px);
}

.card h3{
    margin-bottom:10px;
    color:#0093E9;
}

.card p{
    font-size:15px;
    color:#555;
}

</style>
</head>

<body>

<div class="container">

    <div class="sidebar">
        <h2>Ocean View Resort</h2>
        <a href="staff-dashboard.jsp">Dashboard</a>
        <a href="add-reservation.jsp">Add Reservation</a>
        <a href="view-reservation.jsp">View Reservations</a>
        <a href="calculate-bill.jsp">Calculate Bill</a>
        <a href="print-bill.jsp">Print Bill</a>
        <a href="help.jsp">Help</a>
        <a href="LogoutServlet">Logout</a>
    </div>

    <div class="main">

        <div class="top-bar">
            <h1>Dashboard</h1>
            <div class="welcome">Welcome, Staff</div>
        </div>

        <div class="cards">

            <div class="card" onclick="location.href='add-reservation.jsp'">
                <h3>Add New Reservation</h3>
                <p>Create new room bookings for customers.</p>
            </div>

            <div class="card" onclick="location.href='view-reservation.jsp'">
                <h3>Display Reservations</h3>
                <p>Search and view reservation details.</p>
            </div>

            <div class="card" onclick="location.href='calculate-bill.jsp'">
                <h3>Calculate & Print Bill</h3>
                <p>Generate final bill and print invoice.</p>
            </div>

        </div>

    </div>

</div>

</body>
</html>