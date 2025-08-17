<%@ page import="java.util.List" %>
<%
    // Retrieve the list of messages stored in the application context
    List<String> messages = (List<String>) application.getAttribute("messages");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin - Contact Messages</title>
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4cc9f0;
            --danger-color: #f72585;
            --warning-color: #f8961e;
            --info-color: #560bad;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 2rem;
            color: var(--dark-color);
            line-height: 1.6;
        }
        
        .container {
            max-width: 900px;
            margin: 0 auto;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 2.5rem;
            position: relative;
            overflow: hidden;
        }
        
        h2 {
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            font-size: 2rem;
            position: relative;
            padding-bottom: 0.5rem;
        }
        
        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            border-radius: 2px;
        }
        
        .no-messages {
            text-align: center;
            padding: 2rem;
            color: var(--dark-color);
            font-size: 1.1rem;
            background-color: rgba(248, 249, 250, 0.7);
            border-radius: 8px;
            border: 1px dashed #ccc;
        }
        
        .messages-container {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        .message-item {
            display: flex;
            gap: 1rem;
            position: relative;
        }
        
        .message-number {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            border-radius: 50%;
            font-weight: bold;
            flex-shrink: 0;
            font-size: 0.9rem;
        }
        
        .message-content-wrapper {
            flex-grow: 1;
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.25rem;
            border-left: 4px solid var(--accent-color);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        
        .message-content-wrapper:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .message-text {
            font-size: 1rem;
            color: #555;
            line-height: 1.7;
            white-space: pre-wrap;
            word-break: break-word;
        }
        
        .message-meta {
            display: flex;
            justify-content: space-between;
            margin-top: 0.75rem;
            font-size: 0.8rem;
            color: #888;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
            }
            
            h2 {
                font-size: 1.5rem;
            }
            
            .message-item {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .message-number {
                align-self: flex-start;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Contact Messages Received</h2>

        <% if (messages == null || messages.isEmpty()) { %>
            <div class="no-messages">
                <p>No messages have been received yet.</p>
            </div>
        <% } else { %>
            <div class="messages-container">
                <% for (int i = 0; i < messages.size(); i++) { %>
                    <div class="message-item">
                        <div class="message-number"><%= i + 1 %></div>
                        <div class="message-content-wrapper">
                            <div class="message-text"><%= messages.get(i) %></div>
                            <div class="message-meta">
                                <span>Message #<%= i + 1 %></span>
                                <span>Received: Just now</span>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>