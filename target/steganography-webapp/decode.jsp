<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Decode Hidden Data - Steganography Tool</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Image Steganography Decoder</h1>
            <p>Extract hidden information from images</p>
        </header>
        
        <nav class="main-nav">
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="encode-page.jsp">Encode</a></li>
                <li><a href="decode.jsp" class="active">Decode</a></li>
            </ul>
        </nav>
        
        <main>
            <section class="card">
                <h2><i class="fas fa-unlock"></i> Upload an Image to Decode</h2>
                <form action="decode" method="post" enctype="multipart/form-data" id="decodeForm">
                    <div class="form-group">
                        <label for="imageToDecodeFile">Select an image file:</label>
                        <input type="file" id="imageToDecodeFile" name="imageToDecodeFile" accept="image/*" required>
                    </div>
                    <div class="form-note">
                        <p>Upload an image that contains hidden data to reveal its secrets. The decoder will attempt to extract any text, links, or file references encoded within the image.</p>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn primary"><i class="fas fa-unlock-alt"></i> Decode Image</button>
                    </div>
                </form>
            </section>
            
            <section class="card info-card">
                <h2><i class="fas fa-info-circle"></i> What can be decoded?</h2>
                <div class="info-content">
                    <div class="info-item">
                        <h3><i class="fas fa-font"></i> Text Messages</h3>
                        <p>Hidden text will be displayed directly on the result page.</p>
                    </div>
                    <div class="info-item">
                        <h3><i class="fas fa-link"></i> Links</h3>
                        <p>URLs will be displayed as clickable links.</p>
                    </div>
                    <div class="info-item">
                        <h3><i class="fas fa-file"></i> File References</h3>
                        <p>Files that were encoded into the image will show file details.</p>
                    </div>
                </div>
                <div class="warning">
                    <p><i class="fas fa-exclamation-triangle"></i> Note: Only images encoded with this steganography tool can be properly decoded.</p>
                </div>
                
                <div class="actions">
                    <a href="index.jsp" class="btn secondary"><i class="fas fa-home"></i> Back to Home</a>
                    <a href="encode-page.jsp" class="btn primary"><i class="fas fa-lock"></i> Go to Encoder</a>
                </div>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2023 Image Steganography Tool</p>
        </footer>
    </div>
    
    <script src="js/decodeScript.js"></script>
</body>
</html>