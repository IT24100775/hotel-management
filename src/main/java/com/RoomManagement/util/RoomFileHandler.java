package com.RoomManagement.util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;


import com.RoomManagement.model.Room;

public class RoomFileHandler {

        private static final String FILE_PATH = "rooms.txt"; // File path for storing rooms

        // Method to get all rooms from the file
        public List<Room> getAllRooms() {
            List<Room> rooms = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    rooms.add(new Room(parts[0], parts[1], parts[2])); // Create room from file line
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            return rooms;
        }

        // Method to add a room to the file
        public void addRoom(Room room) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
                writer.write(room.getRoomID() + "," + room.getType() + "," + room.getAvailability());
                writer.newLine(); // Add new room entry
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Method to update a room in the file
        public void updateRoom(Room updatedRoom) {
            List<Room> rooms = getAllRooms();
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                for (Room room : rooms) {
                    if (room.getRoomID().equals(updatedRoom.getRoomID())) {
                        writer.write(updatedRoom.getRoomID() + "," + updatedRoom.getType() + "," + updatedRoom.getAvailability());
                    } else {
                        writer.write(room.getRoomID() + "," + room.getType() + "," + room.getAvailability());
                    }
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Method to delete a room from the file
        public void deleteRoom(String roomID) {
            List<Room> rooms = getAllRooms();
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                for (Room room : rooms) {
                    if (!room.getRoomID().equals(roomID)) {
                        writer.write(room.getRoomID() + "," + room.getType() + "," + room.getAvailability());
                        writer.newLine();
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Method to get a room by its ID
        public Room getRoomByID(String roomID) {
            List<Room> rooms = getAllRooms();
            for (Room room : rooms) {
                if (room.getRoomID().equals(roomID)) {
                    return room;
                }
            }
            return null; // Return null if room not found
        }
    }


