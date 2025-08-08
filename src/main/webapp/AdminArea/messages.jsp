<%@ page import="java.util.List" %>
<%
    // Retrieve the list of messages stored in the application context
    List<String> messages = (List<String>) application.getAttribute("messages");
%>
<!DOCTYPE html>
<html lang="en">
<head>

<style >

body {
    font-family: Arial, sans-serif;
    background-color: #f7f9fc;
    margin: 20px;
    color: #333;
}

h2 {
    color: #2c3e50;
    border-bottom: 2px solid #3498db;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

p {
    font-size: 1.1em;
    color: #666;
}

ul {
    list-style-type: none;
    padding: 0;
    max-width: 600px;
    margin: 0 auto;
}

ul li {
    background-color: #ffffff;
    margin-bottom: 10px;
    padding: 15px 20px;
    border-radius: 6px;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    font-size: 1em;
    line-height: 1.4;
    color: #444;
    word-wrap: break-word;
}
</style>

    <meta charset="UTF-8" />
    <title>Admin - Contact Messages</title>
</head>
<body>
    <h2>Contact Messages Received</h2>

    <% if (messages == null || messages.isEmpty()) { %>
        <p>No messages yet.</p>
    <% } else { %>
        <ul>
            <% for (String msg : messages) { %>
                <li><%= msg %></li>
            <% } %>
        </ul>
    <% } %>
</body>
</html>
