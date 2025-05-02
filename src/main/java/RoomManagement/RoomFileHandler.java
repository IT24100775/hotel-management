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

        public static void saveRooms(List<Room> rooms) {
            try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_NAME))) {
                for (Room room : rooms) {
                    bw.write(room.toString());
                    bw.newLine();
                }
            } catch (IOException e) {
                System.out.println("Could not save rooms: " + e.getMessage());
            }
        }
    }

