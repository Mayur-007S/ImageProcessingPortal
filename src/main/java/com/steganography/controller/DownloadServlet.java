package com.steganography.controller;

import com.steganography.model.ImageProcessor;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/* Servlet mapping defined in web.xml */
public class DownloadServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String fileName = (String) session.getAttribute("encodedFileName");
        
        if (fileName == null || fileName.trim().isEmpty()) {
            request.setAttribute("errorMessage", "No encoded image available for download.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
        
        // Get the file path
        String filePath = ImageProcessor.getFilePath(fileName);
        File file = new File(filePath);
        
        // Check if file exists
        if (!file.exists()) {
            request.setAttribute("errorMessage", "The requested file no longer exists.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
        
        // Set response headers
        response.setContentType("image/png");
        response.setHeader("Content-Disposition", "attachment; filename=\"steganography_image.png\"");
        
        // Copy the file to the response output stream
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error downloading file: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}