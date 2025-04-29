<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Encode Data - Steganography Tool</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Image Steganography Tool</h1>
            <p>Hide text or links within your images</p>
        </header>
        
        <nav class="main-nav">
            <ul>
                <li><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="encode-page.jsp" class="active"><i class="fas fa-lock"></i> Encode</a></li>
                <li><a href="decode.jsp"><i class="fas fa-unlock-alt"></i> Decode</a></li>
            </ul>
        </nav>
        
        <main>
            <section class="card">
                <h2><i class="fas fa-lock"></i> Step 1: Upload an Image</h2>
                <form action="upload" method="post" enctype="multipart/form-data" id="uploadForm">
                    <div class="form-group">
                        <label for="image">Select an image file:</label>
                        <input type="file" id="image" name="image" accept="image/*" required>
                    </div>
                    <div class="form-note">
                        <p>Choose a high-quality image with complex patterns for better steganography results. Supported formats: PNG, JPG, JPEG.</p>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn primary"><i class="fas fa-upload"></i> Upload Image</button>
                    </div>
                </form>
                
                <%-- Display upload success message if any --%>
                <% if (session.getAttribute("uploadSuccess") != null) { %>
                    <div class="alert success">
                        <i class="fas fa-check-circle"></i> <%= session.getAttribute("uploadSuccess") %>
                        <% session.removeAttribute("uploadSuccess"); %>
                    </div>
                <% } %>
            </section>
            
            <section class="card">
                <h2><i class="fas fa-cog"></i> Step 2: Select Encoding Type</h2>
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
                            <textarea id="textMessage" name="textMessage" rows="4" placeholder="Type your secret message here..."></textarea>
                        </div>
                    </div>
                    
                    <!-- File Encoding Form -->
                    <div id="fileEncodingForm" class="encoding-form" style="display: none;">
                        <div class="form-group">
                            <label for="fileUpload">Select a file to encode:</label>
                            <input type="file" id="fileUpload" name="fileUpload">
                        </div>
                        <div class="form-note">
                            <p>The file reference will be encoded into the image. For larger files, consider using a cloud storage link.</p>
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
                        <div class="form-note">
                            <p>A reference to the video file will be encoded into the image.</p>
                        </div>
                    </div>
                    
                    <!-- APK Encoding Form -->
                    <div id="apkEncodingForm" class="encoding-form" style="display: none;">
                        <div class="form-group">
                            <label for="apkUpload">Select an APK file to encode:</label>
                            <input type="file" id="apkUpload" name="apkUpload" accept=".apk">
                        </div>
                        <div class="form-note">
                            <p>A reference to the APK file will be encoded into the image.</p>
                        </div>
                    </div>
                    
                    <!-- Malware Encoding Form -->
                    <div id="malwareEncodingForm" class="encoding-form" style="display: none;">
                        <div class="form-group">
                            <label for="malwareUpload">Select a file to encode:</label>
                            <input type="file" id="malwareUpload" name="malwareUpload">
                        </div>
                        <div class="alert warning">
                            <i class="fas fa-exclamation-triangle"></i> <strong>Warning:</strong> Encoding malware or harmful content is for educational purposes only. Use responsibly and legally.
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn primary" id="encodeButton" disabled><i class="fas fa-lock"></i> Encode Data</button>
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