package org.example.hotelmanagement;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BookingFileHandler {
    private static final String FILE_PATH = "resources/bookings.txt";
    private static final Object fileLock = new Object();

    public static void saveBooking(Booking booking) throws IOException {
        synchronized (fileLock) {
            ensureFileExists();
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
                writer.write(booking.toString());
                writer.newLine();
            }
        }
    }

    public static List<Booking> getAllBookings() throws IOException {
        synchronized (fileLock) {
            ensureFileExists();
            List<Booking> bookings = new ArrayList<>();

            try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.trim().isEmpty()) {
                        try {
                            bookings.add(Booking.fromString(line));
                        } catch (IllegalArgumentException e) {
                            System.err.println("Skipping invalid booking record: " + line);
                        }
                    }
                }
            }
            return bookings;
        }
    }

    public static List<Booking> getUserBookings(String userId) throws IOException {
        List<Booking> allBookings = getAllBookings();
        List<Booking> userBookings = new ArrayList<>();

        for (Booking booking : allBookings) {
            if (booking.getUserId().equals(userId)) {
                userBookings.add(booking);
            }
        }
        return userBookings;
    }

    public static void updateBooking(Booking updatedBooking) throws IOException {
        synchronized (fileLock) {
            List<Booking> bookings = getAllBookings();
            boolean found = false;

            for (int i = 0; i < bookings.size(); i++) {
                if (bookings.get(i).getBookingId().equals(updatedBooking.getBookingId())) {
                    bookings.set(i, updatedBooking);
                    found = true;
                    break;
                }
            }

            if (found) {
                writeAllBookings(bookings);
            }
        }
    }

    public static void cancelBooking(String bookingId) throws IOException {
        synchronized (fileLock) {
            List<Booking> bookings = getAllBookings();
            boolean updated = false;

            for (Booking booking : bookings) {
                if (booking.getBookingId().equals(bookingId) && booking.cancel()) {
                    updated = true;
                    break;
                }
            }

            if (updated) {
                writeAllBookings(bookings);
            }
        }
    }

    private static void ensureFileExists() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
    }

    private static void writeAllBookings(List<Booking> bookings) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Booking booking : bookings) {
                writer.write(booking.toString());
                writer.newLine();
            }
        }
    }
}