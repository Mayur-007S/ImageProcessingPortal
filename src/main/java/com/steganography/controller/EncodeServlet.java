package com.steganography.controller;

import com.steganography.model.ImageProcessor;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/* Servlet mapping defined in web.xml */
public class EncodeServlet extends HttpServlet {
    
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
            
            // Get message type and content
            String messageType = request.getParameter("messageType");
            String message = request.getParameter("message");
            
            // Validate message
            if (message == null || message.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please enter a message to encode.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Validate message type
            boolean isLink = "link".equals(messageType);
            if (isLink && !message.trim().matches("^https?://.+")) {
                request.setAttribute("errorMessage", "Please enter a valid URL starting with http:// or https://");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Process the image and encode the message
            ImageProcessor processor = new ImageProcessor();
            String outputFileName = processor.processImage(imagePart.getInputStream(), message, isLink);
            
            // Store the results in session for the result page
            request.getSession().setAttribute("encodedFileName", outputFileName);
            request.getSession().setAttribute("encodedMessage", message);
            request.getSession().setAttribute("encodedMessageType", messageType);
            
            // Remove the temporary uploaded image part from session
            request.getSession().removeAttribute("imagePart");
            
            // Redirect to the result page
            response.sendRedirect(request.getContextPath() + "/result.jsp");
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error encoding message: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}