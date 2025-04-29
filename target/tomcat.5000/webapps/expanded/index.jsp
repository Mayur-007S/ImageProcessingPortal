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
        
        <nav class="main-nav">
            <ul>
                <li><a href="index.jsp" class="active">Encode</a></li>
                <li><a href="decode.jsp">Decode</a></li>
            </ul>
        </nav>
        
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
                <h2>Step 2: Select Encoding Type</h2>
                <form action="encode" method="post" id="encodeForm" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="encodingType">Encoding Type:</label>
                        <select id="encodingType" name="encodingType" required onchange="showEncodingForm()">
                            <option value="">-- Select Encoding Type --</option>
                            <option value="text">Text Encoding</option>
                            <option value="file">File Encoding</option>
                            <option value="link">Link Encoding</option>
                            <option value="video">Video Encoding</option>
                            <option value="apk">APK Encoding</option>
                            <option value="malware">Malware Encoding</option>
                        </select>
                    </div>
                    
                    <!-- Text Encoding Form -->
                    <div id="textEncodingForm" class="encoding-form" style="display: none;">
                        <div class="form-group">
                            <label for="textMessage">Enter your text message:</label>
                            <textarea id="textMessage" name="textMessage" rows="4"></textarea>
                        </div>
                    </div>
                    
                    <!-- File Encoding Form -->
                    <div id="fileEncodingForm" class="encoding-form" style="display: none;">
                        <div class="form-group">
                            <label for="fileUpload">Select a file to encode:</label>
                            <input type="file" id="fileUpload" name="fileUpload">
                        </div>
                    </div>
                    
                    <!-- Link Encoding Form -->
                    <div id="linkEncodingForm" class="encoding-form" style="display: none;">
                        <div class="form-group">
                            <label for="linkUrl">Enter URL:</label>
                            <input type="url" id="linkUrl" name="linkUrl" placeholder="https://example.com">
                        </div>
                    </div>
                    
                    <!-- Video Encoding Form -->
                    <div id="videoEncodingForm" class="encoding-form" style="display: none;">
                        <div class="form-group">
                            <label for="videoUpload">Select a video file to encode:</label>
                            <input type="file" id="videoUpload" name="videoUpload" accept="video/*">
                        </div>
                    </div>
                    
                    <!-- APK Encoding Form -->
                    <div id="apkEncodingForm" class="encoding-form" style="display: none;">
                        <div class="form-group">
                            <label for="apkUpload">Select an APK file to encode:</label>
                            <input type="file" id="apkUpload" name="apkUpload" accept=".apk">
                        </div>
                    </div>
                    
                    <!-- Malware Encoding Form -->
                    <div id="malwareEncodingForm" class="encoding-form" style="display: none;">
                        <div class="form-group">
                            <label for="malwareUpload">Select a file to encode:</label>
                            <input type="file" id="malwareUpload" name="malwareUpload">
                        </div>
                        <div class="alert warning">
                            <p>Warning: Encoding malware or harmful content is for educational purposes only. Use responsibly and legally.</p>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn primary" id="encodeButton" disabled>Encode</button>
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
