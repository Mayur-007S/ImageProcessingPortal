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
                request.setAttribute("errorMessage", "Only image files are allowed. Your file type was: " + contentType);
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Ensure the image is of a supported format (png, jpg, jpeg, gif, bmp)
            String fileName = getSubmittedFileName(filePart);
            
            // Check if filename contains an extension
            if (!fileName.contains(".")) {
                request.setAttribute("errorMessage", "Image file missing extension. Please use PNG, JPG, JPEG, GIF, or BMP formats.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
            if (!isValidImageFormat(fileExtension)) {
                request.setAttribute("errorMessage", "Unsupported image format: " + fileExtension + 
                    ". Please use PNG, JPG, JPEG, GIF, or BMP formats.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Store the file in session to be used by the encode servlet
            request.getSession().setAttribute("imagePart", filePart);
            
            // Redirect to encode page with success message
            request.getSession().setAttribute("uploadSuccess", "Image uploaded successfully. You can now select an encoding type.");
            response.sendRedirect(request.getContextPath() + "/encode-page.jsp");
            
        } catch (Exception e) {
            // Log the error for server-side debugging
            e.printStackTrace();
            
            // Provide user-friendly error message
            String errorMsg = "Error uploading file: " + e.getMessage();
            request.setAttribute("errorMessage", errorMsg);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    // Helper method to get the submitted filename from a Part
    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "unknown_file";
    }
    
    // Helper method to validate image format
    private boolean isValidImageFormat(String extension) {
        if (extension == null || extension.isEmpty()) {
            return false;
        }
        
        // List of supported image formats by ImageIO
        String[] supportedFormats = {"png", "jpg", "jpeg", "gif", "bmp"};
        
        for (String format : supportedFormats) {
            if (extension.equalsIgnoreCase(format)) {
                return true;
            }
        }
        
        return false;
    }
}
