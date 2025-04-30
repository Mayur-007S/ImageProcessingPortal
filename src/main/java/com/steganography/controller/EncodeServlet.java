package com.steganography.controller;

import com.steganography.model.ImageProcessor;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/* Servlet mapping defined in web.xml */
@MultipartConfig
public class EncodeServlet extends HttpServlet {
    
    private static final String TEMP_DIR = "temp";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Retrieve the image part from session
            Part imagePart = (Part) request.getSession().getAttribute("imagePart");
            
            // Check if image was uploaded
            if (imagePart == null) {
                request.setAttribute("errorMessage", "Please upload an image first.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Get encoding type
            String encodingType = request.getParameter("encodingType");
            if (encodingType == null || encodingType.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please select an encoding type.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Variable to store the content to encode
            String contentToEncode = "";
            boolean isLink = false;
            String contentDescription = "";
            
            // Process based on encoding type
            switch (encodingType) {
                case "text":
                    contentToEncode = request.getParameter("textMessage");
                    if (contentToEncode == null || contentToEncode.trim().isEmpty()) {
                        request.setAttribute("errorMessage", "Please enter a text message to encode.");
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                        return;
                    }
                    contentDescription = "Text message";
                    break;
                    
                case "link":
                    contentToEncode = request.getParameter("linkUrl");
                    if (contentToEncode == null || contentToEncode.trim().isEmpty()) {
                        request.setAttribute("errorMessage", "Please enter a URL to encode.");
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                        return;
                    }
                    if (!contentToEncode.trim().matches("^https?://.+")) {
                        request.setAttribute("errorMessage", "Please enter a valid URL starting with http:// or https://");
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                        return;
                    }
                    isLink = true;
                    contentDescription = "Link: " + contentToEncode;
                    break;
                    
                case "file":
                case "video":
                case "apk":
                case "malware":
                    Part filePart = request.getPart(encodingType + "Upload");
                    if (filePart == null || filePart.getSize() == 0) {
                        request.setAttribute("errorMessage", "Please select a file to encode.");
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                        return;
                    }
                    
                    // Save the file temporarily and encode its path or content
                    String fileName = getSubmittedFileName(filePart);
                    
                    // Create temporary directory if it doesn't exist
                    Files.createDirectories(Paths.get(TEMP_DIR));
                    String tempFilePath = TEMP_DIR + "/" + System.currentTimeMillis() + "_" + fileName;
                    
                    // Save file to disk
                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, Paths.get(tempFilePath), StandardCopyOption.REPLACE_EXISTING);
                    }
                    
                    // For demonstration purposes: 
                    // In a real application, we would read the file content for binary files
                    // and encode that, or create a reference to the file location
                    contentToEncode = "FILE:" + fileName + ":" + tempFilePath;
                    contentDescription = encodingType.substring(0, 1).toUpperCase() + 
                                       encodingType.substring(1) + ": " + fileName;
                    break;
                    
                default:
                    request.setAttribute("errorMessage", "Invalid encoding type selected.");
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                    return;
            }
            
            // Process the image and encode the content
            ImageProcessor processor = new ImageProcessor();
            String outputFileName = processor.processImage(imagePart.getInputStream(), contentToEncode, isLink);
            
            // Store the results in session for the result page
            request.getSession().setAttribute("encodedFileName", outputFileName);
            request.getSession().setAttribute("encodedMessage", contentToEncode);
            request.getSession().setAttribute("encodedMessageType", encodingType);
            request.getSession().setAttribute("contentDescription", contentDescription);
            
            // Remove the temporary uploaded image part from session
            request.getSession().removeAttribute("imagePart");
            
            // Redirect to the result page
            response.sendRedirect(request.getContextPath() + "/result.jsp");
            
        } catch (Exception e) {
            // Log the error for server-side debugging
            e.printStackTrace();
            
            // Provide user-friendly error message
            String errorMsg = "Error encoding content: " + e.getMessage();
            
            // Add more detailed information for specific error types
            if (e.getMessage() != null && e.getMessage().contains("Failed to read image")) {
                errorMsg += ". Please ensure you are uploading a valid image file (JPG, PNG, GIF, BMP) and try again.";
            }
            
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
}