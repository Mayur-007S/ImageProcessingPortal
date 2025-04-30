package com.steganography.model;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

public class ImageProcessor {
    
    private static final String UPLOAD_DIRECTORY = "temp";
    
    // Process the image and encode the message
    public String processImage(InputStream imageInputStream, String messageToEncode, boolean isLink) 
            throws IOException {
        
        // Create temp directory if it doesn't exist
        File tempDir = new File(UPLOAD_DIRECTORY);
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }
        
        // Save the input stream to a temporary file first
        String tempFileName = System.currentTimeMillis() + "_temp.png";
        String tempFilePath = UPLOAD_DIRECTORY + File.separator + tempFileName;
        File tempFile = new File(tempFilePath);
        
        try {
            // Save the input stream to a temporary file
            java.nio.file.Files.copy(
                imageInputStream,
                tempFile.toPath(),
                java.nio.file.StandardCopyOption.REPLACE_EXISTING
            );
            
            // Read the image from the file
            BufferedImage originalImage = ImageIO.read(tempFile);
            
            if (originalImage == null) {
                throw new IOException("Failed to read image. Unsupported format or corrupted file.");
            }
            
            // Process the image based on the type
            BufferedImage encodedImage;
            if (isLink) {
                encodedImage = Steganography.encodeLink(originalImage, messageToEncode);
            } else {
                encodedImage = Steganography.encodeText(originalImage, messageToEncode);
            }
            
            // Generate a unique filename for the processed image
            String outputFileName = UUID.randomUUID().toString() + ".png";
            String outputPath = UPLOAD_DIRECTORY + File.separator + outputFileName;
            
            // Save the processed image
            Steganography.saveImage(encodedImage, outputPath);
            
            // Clean up temporary file
            tempFile.delete();
            
            return outputFileName;
        } catch (IOException e) {
            // Clean up temporary file if it exists
            if (tempFile.exists()) {
                tempFile.delete();
            }
            throw new IOException("Failed to process image: " + e.getMessage(), e);
        }
    }
    
    // Get absolute path for a file in the temp directory
    public static String getFilePath(String fileName) {
        return UPLOAD_DIRECTORY + File.separator + fileName;
    }
    
    // Clean up temporary files
    public static void cleanup(String fileName) {
        File file = new File(UPLOAD_DIRECTORY + File.separator + fileName);
        if (file.exists()) {
            file.delete();
        }
    }
}
