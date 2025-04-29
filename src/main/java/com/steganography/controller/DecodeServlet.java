package com.steganography.controller;

import com.steganography.model.Steganography;
import java.io.IOException;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class DecodeServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get the file part from the request
            Part filePart = request.getPart("imageToDecodeFile");
            
            // Validate file is present
            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("errorMessage", "Please select an image file to decode.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Validate file is an image
            String contentType = filePart.getContentType();
            if (!contentType.startsWith("image/")) {
                request.setAttribute("errorMessage", "Only image files are allowed.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Read the image
            BufferedImage image = ImageIO.read(filePart.getInputStream());
            
            if (image == null) {
                request.setAttribute("errorMessage", "Failed to read image. Unsupported format or corrupted file.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Decode the hidden data
            String decodedContent = Steganography.decode(image);
            
            if (decodedContent == null || decodedContent.trim().isEmpty()) {
                request.setAttribute("errorMessage", "No hidden data found in the image.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Determine content type
            String contentTypeAttribute = "text";
            if (Steganography.isLink(decodedContent)) {
                contentTypeAttribute = "link";
            } else if (Steganography.isFileReference(decodedContent)) {
                contentTypeAttribute = "file";
                // Extract file name for display
                String fileName = Steganography.extractFileName(decodedContent);
                if (fileName != null) {
                    request.setAttribute("fileName", fileName);
                }
            }
            
            // Set attributes for the decode result page
            request.setAttribute("decodedContent", decodedContent);
            request.setAttribute("contentType", contentTypeAttribute);
            
            // Forward to the decode result page
            request.getRequestDispatcher("/decode-result.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error decoding image: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}