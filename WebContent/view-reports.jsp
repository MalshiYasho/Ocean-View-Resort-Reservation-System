<!DOCTYPE html>
<html>
<head>
<title>System Reports - Admin</title>

<style>

*{
   margin: 0;
   padding:0;
   box-sizing:border-box;
   font-family:'Segoe UI', sans-serif;
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

.main{
   flex:1;
   background:#f4f6f9;
   padding:40px;
   overflow:auto;
}

.main h1{
   font-size:28px;
   color:#333;
   margin-bottom:30px;
}

.report-container{
   display:flex;
   gap:25px;
   flex-wrap:wrap;
   margin-bottom:40px;
}

.report-card{
   width:240px;
   height:120px;
   background:white;
   border-radius:10px;
   box-shadow:0 5px 15px rgba(0,0,0,0.08);
   display:flex;
   align-items:center;
   justify-content:center;
   text-align:center;
   cursor:pointer;
   transition:0.3s;
}

.report-card:hover{
   background:#0093E9;
   color:white;
   transform:translateY(-5px);
}

.report-display{
   background:white;
   padding:30px;
   border-radius:10px;
   box-shadow:0 5px 15px rgba(0,0,0,0.08);
   display:none;  
}

.report-display h2{
   margin-bottom:20px;
   color:#333;
}

table{
   width:100%;
   border-collapse:collapse;
}

th,td{
   padding:12px;
   border:1px solid #ddd;
   text-align:center;
}

th{
   background:#1e1e2f;
   color:white;
}

</style>

<script>
function showReport(type){

   const reportSection = document.getElementById("reportSection");
   const reportTitle = document.getElementById("reportTitle");
   const reportContent = document.getElementById("reportContent");

   reportSection.style.display = "block";

   if(type === "daily"){
      reportTitle.innerText = "Daily Revenue Report";
      reportContent.innerHTML = `
         <table>
            <tr>
               <th>Date</th>
               <th>Total Revenue (Rs.)</th>
            </tr>
            <tr>
               <td>2026-03-03</td>
               <td>75,000</td>
            </tr>
         </table>`;
   }

   if(type === "monthly"){
      reportTitle.innerText = "Monthly Revenue Report";
      reportContent.innerHTML = `
         <table>
            <tr>
               <th>Month</th>
               <th>Total Revenue (Rs.)</th>
            </tr>
            <tr>
               <td>March 2026</td>
               <td>1,250,000</td>
            </tr>
         </table>`;
   }

   if(type === "history"){
      reportTitle.innerText = "Customer Booking History";
      reportContent.innerHTML = `
         <table>
            <tr>
               <th>Customer Name</th>
               <th>Room</th>
               <th>Check-in</th>
               <th>Check-out</th>
            </tr>
            <tr>
               <td>Kamal Perera</td>
               <td>Deluxe</td>
               <td>2026-03-01</td>
               <td>2026-03-03</td>
            </tr>
         </table>`;
   }

   if(type === "pending"){
      reportTitle.innerText = "Pending Reservations";
      reportContent.innerHTML = `
         <table>
            <tr>
               <th>Reservation ID</th>
               <th>Customer</th>
               <th>Status</th>
            </tr>
            <tr>
               <td>R102</td>
               <td>Nimal Silva</td>
               <td>Pending</td>
            </tr>
         </table>`;
   }
}
</script>

</head>

<body>

<div class="container">

   <div class="sidebar">
      <h2>Ocean View Resort</h2>
      <a href="admin-dashboard.jsp">Dashboard</a>
      <a href="manage-rooms.jsp">Manage Rooms</a>
      <a href="manage-users.jsp">Manage Users</a>
      <a href="view-reports.jsp">View Reports</a>
      <a href="help.jsp">Help</a>
      <a href="LogoutServlet">Logout</a>
   </div>

   <div class="main">

      <h1>System Reports</h1>

      <div class="report-container">
         <div class="report-card" onclick="showReport('daily')">
            Daily Revenue Report
         </div>

         <div class="report-card" onclick="showReport('monthly')">
            Monthly Revenue Report
         </div>

         <div class="report-card" onclick="showReport('history')">
            Customer Booking History
         </div>

         <div class="report-card" onclick="showReport('pending')">
            Pending Reservations
         </div>
      </div>

      <div id="reportSection" class="report-display">
         <h2 id="reportTitle"></h2>
         <div id="reportContent"></div>
      </div>

   </div>

</div>

</body>
</html>