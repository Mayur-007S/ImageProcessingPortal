<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Image Steganography Tool</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Image Steganography Tool</h1>
            <p>Securely hide and extract hidden data within images</p>
        </header>
        
        <nav class="main-nav">
            <ul>
                <li><a href="index.jsp" class="active"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="encode-page.jsp"><i class="fas fa-lock"></i> Encode</a></li>
                <li><a href="decode.jsp"><i class="fas fa-unlock-alt"></i> Decode</a></li>
            </ul>
        </nav>
        
        <main>
            <section class="card welcome-card">
                <h2>Welcome to Steganography</h2>
                <p class="intro-text">
                    Steganography is the practice of concealing information within other non-secret data or a physical object. 
                    This tool allows you to hide various types of content within images, making it invisible to the naked eye.
                </p>
                
                <div class="feature-buttons">
                    <a href="encode-page.jsp" class="feature-button encode">
                        <span class="icon"><i class="fas fa-lock"></i></span>
                        <h3>Encode Data</h3>
                        <p>Hide text, links, files, and more within an image</p>
                    </a>
                    
                    <a href="decode.jsp" class="feature-button decode">
                        <span class="icon"><i class="fas fa-unlock"></i></span>
                        <h3>Decode Data</h3>
                        <p>Extract hidden information from encoded images</p>
                    </a>
                </div>
            </section>
            
            <section class="card info-card">
                <h2>What Can You Hide?</h2>
                
                <div class="info-content">
                    <div class="info-item">
                        <h3><i class="fas fa-font"></i> Text Messages</h3>
                        <p>Hide private text messages within an image that only the recipient can decode.</p>
                    </div>
                    
                    <div class="info-item">
                        <h3><i class="fas fa-link"></i> URLs & Links</h3>
                        <p>Conceal website links within images for discreet sharing of resources.</p>
                    </div>
                    
                    <div class="info-item">
                        <h3><i class="fas fa-file"></i> Files & Documents</h3>
                        <p>Embed file references within images for secure file tracking and sharing.</p>
                    </div>
                </div>
                
                <div class="info-content">
                    <div class="info-item">
                        <h3><i class="fas fa-video"></i> Videos</h3>
                        <p>Hide video file references within images for layered content sharing.</p>
                    </div>
                    
                    <div class="info-item">
                        <h3><i class="fas fa-mobile-alt"></i> APK Files</h3>
                        <p>Embed Android application references for secure app distribution.</p>
                    </div>
                    
                    <div class="info-item">
                        <h3><i class="fas fa-shield-alt"></i> Security Research</h3>
                        <p>For educational purposes, explore steganographic techniques in cybersecurity research.</p>
                    </div>
                </div>
                
                <div class="actions">
                    <a href="encode-page.jsp" class="btn primary"><i class="fas fa-lock"></i> Start Encoding</a>
                    <a href="decode.jsp" class="btn secondary"><i class="fas fa-unlock"></i> Start Decoding</a>
                </div>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2023 Image Steganography Tool</p>
        </footer>
    </div>
    
    <script src="js/home.js"></script>
</body>
</html>
