package RoomManagement;

import java.util.List;


    import java.util.List;

    public class RoomTest {
        public static void main(String[] args) {
            // Create sample Room objects
            Room room1 = new Room("R001", "Single", true);
            Room room2 = new Room("R002", "Double", true);
            Room room3 = new Room("R003", "Suite", false);

            // Create BST and insert rooms
            RoomBST bst = new RoomBST();
            bst.insert(room1);
            bst.insert(room2);
            bst.insert(room3);

            // Display rooms (In-Order Traversal of BST)
            System.out.println("Rooms in BST (In-order):");
            List<Room> roomList = bst.inOrderTraversal();
            for (Room r : roomList) {
                System.out.println(r);
            }

            // Save rooms to file
            RoomFileHandler.saveRooms(roomList);
            System.out.println("\nRooms saved to rooms.txt");

            // Load rooms from file
            System.out.println("\nRooms loaded from rooms.txt:");
            List<Room> loadedRooms = RoomFileHandler.loadRooms();
            for (Room r : loadedRooms) {
                System.out.println(r);
            }

            // Test Search
            System.out.println("\nSearching for Room R002:");
            Room searchResult = bst.search("R002");
            if (searchResult != null) {
                System.out.println("Found: " + searchResult);
            } else {
                System.out.println("Room R002 not found");
            }

            // Test Update
            System.out.println("\nUpdating Room R002 to 'Double Deluxe' and unavailable.");
            Room updatedRoom = new Room("R002", "Double Deluxe", false);
            bst.update(updatedRoom);
            RoomFileHandler.saveRooms(bst.inOrderTraversal());
            System.out.println("After update (R002):");
            for (Room r : RoomFileHandler.loadRooms()) {
                System.out.println(r);
            }

            // Test Delete
            System.out.println("\nDeleting Room R001:");
            bst.delete("R001");
            RoomFileHandler.saveRooms(bst.inOrderTraversal());
            System.out.println("After delete (R001):");
            for (Room r : RoomFileHandler.loadRooms()) {
                System.out.println(r);
            }
        }
    }

