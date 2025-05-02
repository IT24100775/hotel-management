package org.example.hotelmanagement;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Booking implements Serializable {
    private String bookingId;
    private String userId;
    private String roomId;
    private Date checkInDate;
    private Date checkOutDate;
    private int guests;
    private String status; // CONFIRMED/CANCELLED

    public Booking(String bookingId, String roomId, String userId,
                   Date checkInDate, Date checkOutDate, int guests) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.userId = userId;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.guests = guests;

    }

    public Booking(String bookingId, String part, Date parse, Date parse1, int i) {

    }

    // Serialization format: BK-123|user1|101|2023-11-15|2023-11-20|2|CONFIRMED
    @Override
    public String toString() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return String.join("|",
                bookingId,
                userId,
                roomId,
                sdf.format(checkInDate),
                sdf.format(checkOutDate),
                String.valueOf(guests),
                status
        );
    }

    public static Booking fromString(String line) {
        String[] parts = line.split("\\|");
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Booking booking = new Booking(
                    parts[1], // userId
                    parts[2], // roomId
                    sdf.parse(parts[3]), // checkInDate
                    sdf.parse(parts[4]), // checkOutDate
                    Integer.parseInt(parts[5]) // guests
            );
            booking.bookingId = parts[0];
            booking.status = parts[6];
            return booking;
        } catch (Exception e) {
            throw new IllegalArgumentException("Invalid booking string: " + line);
        }
    }

    // Business methods
    public boolean cancel() {
        if ("CONFIRMED".equals(status)) {
            status = "CANCELLED";
            return true;
        }
        return false;
    }

    // Getters and setters
    public String getBookingId() { return bookingId; }
    public String getUserId() { return userId; }
    public String getRoomId() { return roomId; }
    public Date getCheckInDate() { return checkInDate; }
    public Date getCheckOutDate() { return checkOutDate; }
    public int getGuests() { return guests; }
    public String getStatus() { return status; }
}