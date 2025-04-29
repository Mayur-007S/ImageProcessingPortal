<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Decode Results - Steganography Tool</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Decoded Hidden Content</h1>
            <p>Successfully extracted hidden information from the image</p>
        </header>
        
        <nav class="main-nav">
            <ul>
                <li><a href="index.jsp">Encode</a></li>
                <li><a href="decode.jsp">Decode</a></li>
            </ul>
        </nav>
        
        <main>
            <%
                String decodedContent = (String) request.getAttribute("decodedContent");
                String contentType = (String) request.getAttribute("contentType");
                String fileName = (String) request.getAttribute("fileName");
                
                if (decodedContent == null) {
                    response.sendRedirect(request.getContextPath() + "/decode.jsp");
                    return;
                }
            %>
            
            <section class="card">
                <h2>Decoded Content</h2>
                
                <div class="result-info">
                    <div class="decoded-content">
                        <h3>Hidden Content Found</h3>
                        <p><strong>Content Type:</strong> <%= contentType.substring(0, 1).toUpperCase() + contentType.substring(1) %></p>
                        
                        <% if ("link".equals(contentType)) { %>
                            <div class="content-box link-box">
                                <p><strong>URL:</strong> <a href="<%= decodedContent %>" target="_blank"><%= decodedContent %></a></p>
                                <div class="alert info">
                                    <p>This is a clickable link that was hidden in the image.</p>
                                </div>
                            </div>
                        <% } else if ("file".equals(contentType)) { %>
                            <div class="content-box file-box">
                                <p><strong>File Reference:</strong> <%= fileName != null ? fileName : "Unknown file" %></p>
                                <div class="alert info">
                                    <p>This is a reference to a file that was encoded in the image.</p>
                                </div>
                            </div>
                        <% } else { %>
                            <div class="content-box text-box">
                                <div class="text-content">
                                    <%= decodedContent %>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
                
                <div class="actions">
                    <a href="decode.jsp" class="btn primary">Decode Another Image</a>
                    <a href="index.jsp" class="btn secondary">Go to Encoder</a>
                </div>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2023 Image Steganography Tool</p>
        </footer>
    </div>
</body>
</html>