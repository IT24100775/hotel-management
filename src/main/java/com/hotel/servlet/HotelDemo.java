package com.hotel.servlet;

import java.util.HashMap;
import java.util.Map;

public class HotelDemo {
    public Map<String, Object> getHotel(int hotelId) {
        Map<String, Object> hotel = new HashMap<>();
        if (hotelId == 1) {
            hotel.put("id", 1);
            hotel.put("name", "Grand Luxury Hotel");
            hotel.put("address", "123 Luxury Avenue, City Center");
            hotel.put("imageUrl", "hotel1.jpg");
        } else {
            hotel.put("id", 2);
            hotel.put("name", "Seaside Resort");
            hotel.put("address", "456 Beach Road, Coastal City");
            hotel.put("imageUrl", "hotel2.jpg");
        }



        return hotel;
    }
} 