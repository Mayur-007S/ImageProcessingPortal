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
                String contentDescription = (String) session.getAttribute("contentDescription");
                
                if (encodedFileName == null || encodedMessage == null) {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    return;
                }
                
                // Default to content description if not present (for backward compatibility)
                if (contentDescription == null) {
                    if ("link".equals(encodedMessageType)) {
                        contentDescription = "Link: " + encodedMessage;
                    } else {
                        contentDescription = "Text message";
                    }
                }
                
                // Determine the encoding type header
                String encodingTypeHeader = "Text";
                if (encodedMessageType != null) {
                    switch (encodedMessageType) {
                        case "link":
                            encodingTypeHeader = "Link";
                            break;
                        case "file":
                            encodingTypeHeader = "File";
                            break;
                        case "video":
                            encodingTypeHeader = "Video";
                            break;
                        case "apk":
                            encodingTypeHeader = "APK";
                            break;
                        case "malware":
                            encodingTypeHeader = "File";
                            break;
                        default:
                            encodingTypeHeader = "Text";
                    }
                }
                
                // Determine if we should display the full content
                boolean showFullContent = "text".equals(encodedMessageType) || "link".equals(encodedMessageType);
                
                // For file type encodings, extract the filename
                String fileName = "";
                if (encodedMessage != null && encodedMessage.startsWith("FILE:")) {
                    String[] parts = encodedMessage.split(":", 3);
                    if (parts.length >= 2) {
                        fileName = parts[1];
                    }
                }
            %>
            
            <section class="card">
                <h2>Encoding Result</h2>
                
                <div class="result-info">
                    <div class="message-details">
                        <h3>Hidden Content</h3>
                        <p><strong>Type:</strong> <%= encodingTypeHeader %> Encoding</p>
                        
                        <% if (showFullContent) { %>
                            <p><strong>Content:</strong> <%= encodedMessage %></p>
                        <% } else if (fileName.length() > 0) { %>
                            <p><strong>File:</strong> <%= fileName %></p>
                        <% } %>
                        
                        <div class="warning">
                            <p>Your content is now hidden in the image. To anyone else, it will appear as a normal image.</p>
                            <% if ("malware".equals(encodedMessageType)) { %>
                                <p class="important">Remember that this content should be used responsibly and legally.</p>
                            <% } %>
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