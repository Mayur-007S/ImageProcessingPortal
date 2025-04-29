<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Steganography Tool</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Error Occurred</h1>
            <p>Something went wrong with your request</p>
        </header>
        
        <nav class="main-nav">
            <ul>
                <li><a href="index.jsp">Encode</a></li>
                <li><a href="decode.jsp">Decode</a></li>
            </ul>
        </nav>
        
        <main>
            <section class="card">
                <h2>Error Details</h2>
                <div class="alert error">
                    <% 
                        String errorMessage = (String) request.getAttribute("errorMessage");
                        if (errorMessage != null && !errorMessage.isEmpty()) {
                            out.println("<p>" + errorMessage + "</p>");
                        } else {
                            out.println("<p>An unknown error occurred. Please try again.</p>");
                        }
                    %>
                </div>
                
                <div class="actions">
                    <a href="javascript:history.back()" class="btn secondary">Go Back</a>
                    <a href="index.jsp" class="btn primary">Go to Homepage</a>
                </div>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2023 Image Steganography Tool</p>
        </footer>
    </div>
</body>
</html>