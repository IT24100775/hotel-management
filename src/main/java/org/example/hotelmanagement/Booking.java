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

    // This constructor seems unused and might be a leftover
    public Booking(String bookingId, String part, Date parse, Date parse1, int i) {
        this.bookingId = bookingId;
        // It's unclear what 'part', 'parse', 'parse1', and 'i' are intended for
        // You might want to remove or properly implement this constructor
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
                    parts[0],             // bookingId
                    parts[2],             // roomId
                    parts[1],             // userId
                    sdf.parse(parts[3]), // checkInDate
                    sdf.parse(parts[4]), // checkOutDate
                    Integer.parseInt(parts[5])  // guests
            );
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
    public String getBookingId() {
        return bookingId;
    }

    public String getUserId() {
        return userId;
    }

    public String getRoomId() {
        return roomId;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public String getFormattedCheckInDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(this.checkInDate);
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public String getFormattedCheckOutDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(this.checkOutDate);
    }

    public int getGuests() {
        return guests;
    }

    public String getStatus() {
        return status;
    }

    // You should consider using actual types instead of Object if you know what these will be
    public Object getGuestEmail() {
        return null;
    }

    public Double getTotalPrice() {
        // Consider storing and returning the actual price as a Double
        return null;
    }

    public String getGuestName() {
        return null;
    }

    // Setter for totalPrice if you decide to store it
    public void setTotalPrice(Double totalPrice) {
        // this.totalPrice = totalPrice;
    }
}