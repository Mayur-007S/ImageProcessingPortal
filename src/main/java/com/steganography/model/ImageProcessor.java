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
        
        // Read the image from input stream
        BufferedImage originalImage = ImageIO.read(imageInputStream);
        
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
        
        return outputFileName;
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
