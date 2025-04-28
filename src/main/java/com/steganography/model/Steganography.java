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

    // Method to save the image
    public static void saveImage(BufferedImage image, String filePath) throws IOException {
        File outputFile = new File(filePath);
        ImageIO.write(image, "png", outputFile);
    }
}
