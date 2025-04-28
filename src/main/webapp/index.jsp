<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Image Steganography Tool</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Image Steganography Tool</h1>
            <p>Hide text or links within your images</p>
        </header>
        
        <main>
            <section class="card">
                <h2>Step 1: Upload an Image</h2>
                <form action="upload" method="post" enctype="multipart/form-data" id="uploadForm">
                    <div class="form-group">
                        <label for="image">Select an image file:</label>
                        <input type="file" id="image" name="image" accept="image/*" required>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn primary">Upload Image</button>
                    </div>
                </form>
                
                <%-- Display upload success message if any --%>
                <% if (session.getAttribute("uploadSuccess") != null) { %>
                    <div class="alert success">
                        <%= session.getAttribute("uploadSuccess") %>
                        <% session.removeAttribute("uploadSuccess"); %>
                    </div>
                <% } %>
            </section>
            
            <section class="card">
                <h2>Step 2: Encode Your Message</h2>
                <form action="encode" method="post" id="encodeForm">
                    <div class="form-group">
                        <label for="messageType">Message Type:</label>
                        <select id="messageType" name="messageType" required>
                            <option value="text">Text</option>
                            <option value="link">Link</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="message">Enter your message:</label>
                        <textarea id="message" name="message" rows="4" required></textarea>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn primary">Encode Message</button>
                    </div>
                </form>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2023 Image Steganography Tool</p>
        </footer>
    </div>
    
    <script src="js/script.js"></script>
</body>
</html>
