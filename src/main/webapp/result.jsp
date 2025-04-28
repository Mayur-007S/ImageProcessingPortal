<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Steganography Result</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Steganography Complete</h1>
            <p>Your message has been hidden in the image</p>
        </header>
        
        <main>
            <%
                String encodedFileName = (String) session.getAttribute("encodedFileName");
                String encodedMessage = (String) session.getAttribute("encodedMessage");
                String encodedMessageType = (String) session.getAttribute("encodedMessageType");
                
                if (encodedFileName == null || encodedMessage == null) {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    return;
                }
                
                boolean isLink = "link".equals(encodedMessageType);
            %>
            
            <section class="card">
                <h2>Encoding Result</h2>
                
                <div class="result-info">
                    <div class="message-details">
                        <h3>Hidden Message</h3>
                        <p><strong>Type:</strong> <%= isLink ? "Link" : "Text" %></p>
                        <p><strong>Content:</strong> <%= encodedMessage %></p>
                        
                        <div class="warning">
                            <p>Your message is now hidden in the image. To anyone else, it will appear as a normal image.</p>
                        </div>
                    </div>
                    
                    <div class="image-preview">
                        <h3>Encoded Image</h3>
                        <img src="temp/<%= encodedFileName %>" alt="Encoded Image" style="max-width: 100%;">
                    </div>
                </div>
                
                <div class="actions">
                    <a href="download" class="btn primary">Download Encoded Image</a>
                    <a href="index.jsp" class="btn secondary">Create Another</a>
                </div>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2023 Image Steganography Tool</p>
        </footer>
    </div>
</body>
</html>