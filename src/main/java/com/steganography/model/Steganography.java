package com.steganography.model;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class Steganography {

    // Method to encode text into an image
    public static BufferedImage encodeText(BufferedImage image, String text) {
        // Convert text to binary
        String binaryText = textToBinary(text) + "1111111111111110"; // End of text marker
        int dataIndex = 0;

        for (int y = 0; y < image.getHeight(); y++) {
            for (int x = 0; x < image.getWidth(); x++) {
                int pixel = image.getRGB(x, y);
                int newPixel = pixel;

                // Modify the least significant bit if there's still data to encode
                if (dataIndex < binaryText.length()) {
                    int bit = Character.getNumericValue(binaryText.charAt(dataIndex));
                    newPixel = (pixel & 0xFFFFFFFE) | bit; // Set the LSB
                    dataIndex++;
                }

                image.setRGB(x, y, newPixel);
                if (dataIndex >= binaryText.length()) {
                    return image; // Return the image once all data is encoded
                }
            }
        }
        return image; // Return the modified image
    }

    // Method to encode a link into an image
    public static BufferedImage encodeLink(BufferedImage image, String link) {
        return encodeText(image, link); // Reuse the text encoding method for links
    }

    // Method to convert text to binary
    private static String textToBinary(String text) {
        StringBuilder binary = new StringBuilder();
        for (char character : text.toCharArray()) {
            String bin = Integer.toBinaryString(character);
            while (bin.length() < 8) {
                bin = "0" + bin; // Pad with leading zeros
            }
            binary.append(bin);
        }
        return binary.toString();
    }

    // Method to decode hidden data from an image
    public static String decode(BufferedImage image) {
        StringBuilder binaryData = new StringBuilder();
        StringBuilder decodedText = new StringBuilder();
        
        // Read the least significant bit of each pixel
        outerLoop:
        for (int y = 0; y < image.getHeight(); y++) {
            for (int x = 0; x < image.getWidth(); x++) {
                int pixel = image.getRGB(x, y);
                int bit = pixel & 1; // Extract the least significant bit
                binaryData.append(bit);
                
                // Check if we have 8 bits (a byte)
                if (binaryData.length() % 8 == 0 && binaryData.length() > 0) {
                    // Convert 8 bits to a character
                    String byteStr = binaryData.substring(binaryData.length() - 8);
                    
                    // Check for end marker (16 bits of 1s followed by 0s)
                    if (binaryData.length() >= 16) {
                        String last16Bits = binaryData.substring(binaryData.length() - 16);
                        if (last16Bits.equals("1111111111111110")) {
                            // End marker found, remove it from the result
                            decodedText.setLength(decodedText.length() - 1);
                            break outerLoop;
                        }
                    }
                    
                    int charCode = Integer.parseInt(byteStr, 2);
                    decodedText.append((char) charCode);
                }
                
                // To prevent excessive processing, set a reasonable limit
                if (binaryData.length() > 1000000) { // 1 million bits should be enough for most messages
                    break outerLoop;
                }
            }
        }
        
        return decodedText.toString();
    }
    
    // Method to determine if decoded content is likely a link
    public static boolean isLink(String decodedText) {
        return decodedText.startsWith("http://") || decodedText.startsWith("https://");
    }
    
    // Method to determine if decoded content is a file reference
    public static boolean isFileReference(String decodedText) {
        return decodedText.startsWith("FILE:");
    }
    
    // Method to extract file name from a file reference
    public static String extractFileName(String fileReference) {
        if (fileReference.startsWith("FILE:")) {
            String[] parts = fileReference.split(":", 3);
            if (parts.length >= 2) {
                return parts[1];
            }
        }
        return null;
    }

    // Method to save the image
    public static void saveImage(BufferedImage image, String filePath) throws IOException {
        File outputFile = new File(filePath);
        ImageIO.write(image, "png", outputFile);
    }
}
