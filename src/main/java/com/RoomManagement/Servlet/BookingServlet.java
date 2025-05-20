package com.RoomManagement.Servlet;

import RoomManagement.Room;
import RoomManagement.RoomFileHandler;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BookingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Load the available rooms from rooms.txt
        List<Room> rooms = RoomFileHandler.loadRooms();

        // Filter available rooms
        List<Room> availableRooms = new ArrayList<>();
        for (Room room : rooms) {
            if (room.isAvailable()) {
                availableRooms.add(room);
            }
        }

        // Set the available rooms as an attribute to be accessed in JSP
        request.setAttribute("availableRooms", availableRooms);

        // Forward the request to the booking page (bookingPage.jsp)
        RequestDispatcher dispatcher = request.getRequestDispatcher("bookingPage.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get roomID and user details from the request
        String roomID = request.getParameter("roomID");
        String userID = request.getParameter("userID");

        // Load the rooms and find the selected room
        List<Room> rooms = RoomFileHandler.loadRooms();
        Room selectedRoom = null;

        for (Room room : rooms) {
            if (room.getRoomID().equals(roomID) && room.isAvailable()) {
                selectedRoom = room;
                break;
            }
        }

        if (selectedRoom != null) {
            // Room is available, proceed with booking
            selectedRoom.setAvailable(false);  // Mark the room as unavailable

            // Save the updated rooms back to rooms.txt
            RoomFileHandler.saveRooms(rooms);

            // Send a confirmation message to the user
            request.setAttribute("confirmationMessage", "Room " + roomID + " has been successfully booked.");
        } else {
            // Room is not available
            request.setAttribute("confirmationMessage", "Room " + roomID + " is not available for booking.");
        }

        // Forward to a confirmation page (confirmation.jsp)
        RequestDispatcher dispatcher = request.getRequestDispatcher("confirmation.jsp");
        dispatcher.forward(request, response);
    }
}

