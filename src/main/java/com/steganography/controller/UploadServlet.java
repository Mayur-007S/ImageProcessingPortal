package com.steganography.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/* Servlet mapping defined in web.xml */
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class UploadServlet extends HttpServlet {
    
    private static final String UPLOAD_DIRECTORY = "temp";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Create the upload directory if it doesn't exist
        File uploadDir = new File(UPLOAD_DIRECTORY);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        try {
            // Get the file part from the request
            Part filePart = request.getPart("image");
            
            // Validate file is present
            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("errorMessage", "Please select an image file to upload.");
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
            
            // Store the file in session to be used by the encode servlet
            request.getSession().setAttribute("imagePart", filePart);
            
            // Redirect to encode page with success message
            request.getSession().setAttribute("uploadSuccess", "Image uploaded successfully. You can now select an encoding type.");
            response.sendRedirect(request.getContextPath() + "/encode-page.jsp");
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error uploading file: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
