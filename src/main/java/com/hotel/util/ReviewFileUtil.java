package com.hotel.util;

import com.hotel.model.Review;
import java.io.*;
import java.util.*;

public class ReviewFileUtil {
    private static final String BASE_PATH = "C:/Users/rozan/Desktop/Practice OOP/hotel-management/reviews/";

    public static List<Review> getReviews(int hotelId) {
        List<Review> reviews = new ArrayList<>();
        File file = new File(BASE_PATH + "hotel_" + hotelId + ".txt");
        if (!file.exists()) return reviews;
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split("\\|", 3);
                if (parts.length == 3) {
                    reviews.add(new Review(parts[0], Integer.parseInt(parts[1]), parts[2]));
                }
            }
        } catch (IOException e) { e.printStackTrace(); }
        return reviews;
    }

    public static void addReview(int hotelId, Review review) {
        File file = new File(BASE_PATH + "hotel_" + hotelId + ".txt");
        file.getParentFile().mkdirs();
        try (PrintWriter pw = new PrintWriter(new FileWriter(file, true))) {
            pw.println(review.getReviewer() + "|" + review.getRating() + "|" + review.getComment().replaceAll("\\r?\\n", " "));
        } catch (IOException e) { e.printStackTrace(); }
    }

    public static void saveAllReviews(int hotelId, List<Review> reviews) {
        File file = new File(BASE_PATH + "hotel_" + hotelId + ".txt");
        file.getParentFile().mkdirs();
        try (PrintWriter pw = new PrintWriter(new FileWriter(file, false))) {
            for (Review review : reviews) {
                pw.println(review.getReviewer() + "|" + review.getRating() + "|" + review.getComment().replaceAll("\r?\n", " "));
            }
        } catch (IOException e) { e.printStackTrace(); }
    }
} 