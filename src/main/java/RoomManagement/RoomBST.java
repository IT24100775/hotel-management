package RoomManagement;

import java.util.ArrayList;
import java.util.List;


    public class RoomBST {
        public void update(Room updatedRoom) {
        }

        public void delete(String r001) {
        }

        private class Node {
            Room room;
            Node left, right;

            Node(Room room) {
                this.room = room;
            }
        }

        private Node root;

        public void insert(Room room) {
            root = insertRec(root, room);
        }

        private Node insertRec(Node root, Room room) {
            if (root == null) return new Node(room);
            if (room.getRoomID().compareTo(root.room.getRoomID()) < 0)
                root.left = insertRec(root.left, room);
            else
                root.right = insertRec(root.right, room);
            return root;
        }

        public Room search(String roomID) {
            return searchRec(root, roomID);
        }

        private Room searchRec(Node root, String roomID) {
            if (root == null) return null;
            if (roomID.equals(root.room.getRoomID())) return root.room;
            return roomID.compareTo(root.room.getRoomID()) < 0
                    ? searchRec(root.left, roomID)
                    : searchRec(root.right, roomID);
        }

        public List<Room> inOrderTraversal() {
            List<Room> rooms = new ArrayList<>();
            inOrderRec(root, rooms);
            return rooms;
        }

        private void inOrderRec(Node node, List<Room> list) {
            if (node != null) {
                inOrderRec(node.left, list);
                list.add(node.room);
                inOrderRec(node.right, list);
            }
        }
        public class RoomTest {

            public void main(String[] args) {
                RoomManagement.RoomBST bst = new RoomManagement.RoomBST();

                // Create some rooms
                Room room1 = new Room("R102", "Study", true);
                Room room2 = new Room("R101", "Lab", false);
                Room room3 = new Room("R103", "Conference", true);

                // Insert into BST
                bst.insert(room1);
                bst.insert(room2);
                bst.insert(room3);

                // Search test
                Room searchResult = bst.search("R101");
                System.out.println("Search Result: " + (searchResult != null ? searchResult.toString() : "Not found"));

                // In-order traversal test
                System.out.println("All Rooms (Sorted):");
                for (Room r : bst.inOrderTraversal()) {
                    System.out.println(r);
                }
            }
        }

    }




