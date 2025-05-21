package com.RoomManagement.Servlet;

import com.RoomManagement.model.Room;
import com.RoomManagement.util.RoomFileHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

    @WebServlet("/RoomServlet")
    public class RoomServlet extends HttpServlet {
        private RoomFileHandler roomFileHandler;

        public void init() throws ServletException {
            roomFileHandler = new RoomFileHandler(); // Initialize RoomFileHandler
        }

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            String action = request.getParameter("action");

            if (action == null) action = "view";
            switch (action) {
                case "delete":
                    deleteRoom(request, response);
                    break;
                case "edit":
                    getRoomForEdit(request, response);
                    break;
                default:
                    listRooms(request, response);
                    break;
            }
        }
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            String action = request.getParameter("action");
            if (action == null) action = "add"; // Default action is to add a new room

            switch (action) {
                case "add":
                    addRoom(request, response);
                    break;
                case "update":
                    updateRoom(request, response);
                    break;
                default:
                    listRooms(request, response);
                    break;
            }
        }

        // List all rooms
        private void listRooms(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            List<Room> rooms = roomFileHandler.getAllRooms(); // Fetch all rooms
            request.setAttribute("rooms", rooms); // Set rooms as request attribute
            request.getRequestDispatcher("roomManagement.jsp").forward(request, response); // Forward to roomManagement.jsp
        }

        // Add a new room
        private void addRoom(HttpServletRequest request, HttpServletResponse response)
                throws IOException {
            String roomID = request.getParameter("roomID");
            String type = request.getParameter("type");
            String availability = request.getParameter("availability");

            Room newRoom = new Room(roomID, type, availability); // Create a new room
            roomFileHandler.addRoom(newRoom); // Add the room using RoomFileHandler
            response.sendRedirect("RoomServlet"); // Redirect to RoomServlet (list rooms)
        }

        // Update an existing room
        private void updateRoom(HttpServletRequest request, HttpServletResponse response)
                throws IOException {
            String roomID = request.getParameter("roomID");
            String type = request.getParameter("type");
            String availability = request.getParameter("availability");

            Room updatedRoom = new Room(roomID, type, availability); // Update room details
            roomFileHandler.updateRoom(updatedRoom); // Update the room
            response.sendRedirect("RoomServlet"); // Redirect to RoomServlet (list rooms)
        }

        // Delete a room
        private void deleteRoom(HttpServletRequest request, HttpServletResponse response)
                throws IOException {
            String roomID = request.getParameter("roomID"); // Get room ID to delete
            roomFileHandler.deleteRoom(roomID); // Delete the room using RoomFileHandler
            response.sendRedirect("RoomServlet"); // Redirect to RoomServlet (list rooms)
        }

        // Fetch a room to edit
        private void getRoomForEdit(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            String roomID = request.getParameter("roomID"); // Get room ID to edit
            Room room = roomFileHandler.getRoomByID(roomID); // Fetch room by ID
            request.setAttribute("room", room); // Set room as request attribute
            request.getRequestDispatcher("editRoom.jsp").forward(request, response); // Forward to editRoom.jsp for editing
        }
    }


