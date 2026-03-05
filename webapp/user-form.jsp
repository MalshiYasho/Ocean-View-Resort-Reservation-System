<%@ page import="model.User" %>
    <% User user=(User) request.getAttribute("user"); boolean isEdit=user !=null; %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>
                <%= isEdit ? "Edit User" : "Add User" %>
            </title>
            <style>
                body {
                    font-family: Segoe UI;
                    margin: 0;
                    padding: 0;
                    background: #f4f6f9;
                }

                .container {
                    width: 400px;
                    margin: 80px auto;
                    padding: 30px;
                    background: white;
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                    border-radius: 8px;
                }

                h2 {
                    text-align: center;
                    color: #333;
                    margin-bottom: 30px;
                }

                input,
                select {
                    width: 100%;
                    padding: 10px;
                    margin-bottom: 15px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                }

                button {
                    width: 100%;
                    padding: 10px;
                    background: #0093E9;
                    color: white;
                    border: none;
                    border-radius: 4px;
                    font-weight: 500;
                    cursor: pointer;
                }

                button:hover {
                    background: #0077c0;
                }

                a {
                    display: block;
                    text-align: center;
                    margin-top: 10px;
                    color: #0093E9;
                    text-decoration: none;
                }

                a:hover {
                    color: #0077c0;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <h2>
                    <%= isEdit ? "Edit User" : "Add User" %>
                </h2>
                <form action="user" method="post">
                    <% if(isEdit){ %>
                        <input type="hidden" name="userId" value="<%=user.getUserId()%>">
                        <% } %>
                            <input type="text" name="username" placeholder="Username"
                                value="<%= isEdit ? user.getUsername() : "" %>" required>
                            <input type="password" name="password" placeholder="Password"
                                value="<%= isEdit ? user.getPassword() : "" %>" required>
                            <select name="role" required>
                                <option value="">Select Role</option>
                                <option value="Admin" <%=isEdit && user.getRole().equals("Admin") ? "selected" : "" %>
                                    >Admin</option>
                                <option value="Staff" <%=isEdit && user.getRole().equals("Staff") ? "selected" : "" %>
                                    >Staff</option>
                            </select>
                            <button type="submit">
                                <%= isEdit ? "Update User" : "Add User" %>
                            </button>
                </form>
                <a href="manage-users.jsp">Back to Users</a>
            </div>
        </body>

        </html>