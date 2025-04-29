<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Decode Results - Steganography Tool</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Decoded Hidden Content</h1>
            <p>Successfully extracted hidden information from the image</p>
        </header>
        
        <nav class="main-nav">
            <ul>
                <li><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="encode-page.jsp"><i class="fas fa-lock"></i> Encode</a></li>
                <li><a href="decode.jsp" class="active"><i class="fas fa-unlock-alt"></i> Decode</a></li>
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
                <h2><i class="fas fa-unlock-alt"></i> Decoded Content</h2>
                
                <div class="result-info">
                    <div class="decoded-content">
                        <h3><i class="fas fa-search-plus"></i> Hidden Content Found</h3>
                        <p><strong>Content Type:</strong> 
                            <% if ("text".equals(contentType)) { %>
                                <span class="badge text"><i class="fas fa-font"></i> Text</span>
                            <% } else if ("link".equals(contentType)) { %>
                                <span class="badge link"><i class="fas fa-link"></i> Link</span>
                            <% } else if ("file".equals(contentType)) { %>
                                <span class="badge file"><i class="fas fa-file"></i> File</span>
                            <% } %>
                        </p>
                        
                        <% if ("link".equals(contentType)) { %>
                            <div class="content-box link-box">
                                <p><strong><i class="fas fa-link"></i> URL:</strong> <a href="<%= decodedContent %>" target="_blank"><%= decodedContent %></a></p>
                                <div class="alert info">
                                    <p><i class="fas fa-info-circle"></i> This is a clickable link that was hidden in the image.</p>
                                </div>
                            </div>
                        <% } else if ("file".equals(contentType)) { %>
                            <div class="content-box file-box">
                                <p><strong><i class="fas fa-file"></i> File Reference:</strong> <%= fileName != null ? fileName : "Unknown file" %></p>
                                <div class="alert info">
                                    <p><i class="fas fa-info-circle"></i> This is a reference to a file that was encoded in the image.</p>
                                </div>
                                <div class="download-section">
                                    <a href="<%= request.getContextPath() %>/temp/<%= fileName %>" class="btn success" download><i class="fas fa-download"></i> Download File</a>
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
                    <a href="decode.jsp" class="btn primary"><i class="fas fa-redo"></i> Decode Another Image</a>
                    <a href="encode-page.jsp" class="btn secondary"><i class="fas fa-lock"></i> Go to Encoder</a>
                    <a href="index.jsp" class="btn secondary"><i class="fas fa-home"></i> Back to Home</a>
                </div>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2023 Image Steganography Tool</p>
        </footer>
    </div>
</body>
</html>