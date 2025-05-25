package RoomManagement;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class RoomFileHandler {

    private static final String FILE_NAME = "rooms.txt";

    public static List<Room> loadRooms() {
        List<Room> rooms = new ArrayList<>();
        System.out.println("Reading from: " + new File(FILE_NAME).getAbsolutePath());

        try (BufferedReader br = new BufferedReader(new FileReader(FILE_NAME))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 3) {
                    String roomID = parts[0];
                    String type = parts[1];
                    boolean available = Boolean.parseBoolean(parts[2]);
                    rooms.add(new Room(roomID, type, available));
                }
            }
        } catch (IOException e) {
            System.out.println("Could not load rooms: " + e.getMessage());
        }
        return rooms;
    }

    public  void addRoom(Room room) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_NAME, true))) {
            bw.write(room.getRoomID() + "," + room.getType() + "," + room.isAvailable());
            bw.newLine();
        } catch (IOException e) {
            System.out.println("Could not add room: " + e.getMessage());
        }
    }

    public static void saveRooms(List<Room> rooms) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_NAME))) {
            for (Room room : rooms) {
                // Write in CSV format, not toString()
                bw.write(room.getRoomID() + "," + room.getType() + "," + room.isAvailable());
                bw.newLine();
            }
        } catch (IOException e) {
            System.out.println("Could not save rooms: " + e.getMessage());
        }
    }

    // Return all rooms (for servlet)
    public List<Room> getAllRooms() {
        return loadRooms();
    }

    // Update room (by roomID)
    public void updateRoom(Room updatedRoom) {
        List<Room> rooms = loadRooms();
        for (int i = 0; i < rooms.size(); i++) {
            if (rooms.get(i).getRoomID().equals(updatedRoom.getRoomID())) {
                rooms.set(i, updatedRoom);
                break;
            }
        }
        saveRooms(rooms);
    }

    // Delete room by ID
    public void deleteRoom(String roomID) {
        List<Room> rooms = loadRooms();
        rooms.removeIf(room -> room.getRoomID().equals(roomID));
        saveRooms(rooms);
    }

    // Get single room by ID
    public Room getRoomByID(String roomID) {
        List<Room> rooms = loadRooms();
        for (Room room : rooms) {
            if (room.getRoomID().equals(roomID)) {
                return room;
            }
        }
        return null;
    }
}
