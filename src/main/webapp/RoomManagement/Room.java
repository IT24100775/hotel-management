package RoomManagement;

public class Room {
    private String roomID;
    private String type;
    private boolean available;

    // Constructor to initialize the room details
    public Room(String roomID, String type, boolean available) {
        this.roomID = roomID;
        this.type = type;
        this.available = available;
    }

    // Getter for room ID
    public String getRoomID() {

        return roomID;
    }

    // Setter for room ID
    public void setRoomID(String roomID) {

        this.roomID = roomID;
    }

    // Getter for type of room
    public String getType() {

        return type;
    }

    // Setter for room type
    public void setType(String type) {

        this.type = type;
    }

    // Getter for room availability
    public boolean isAvailable() {

        return available;
    }

    // Setter for room availability (optional)
    public void setAvailable(boolean available) {

        this.available = available;
    }

    // toString method to return a string representation of the room
    @Override
    public String toString() {

        return "RoomID: " + roomID + ", Type: " + type + ", Available: " + available;
    }


}

