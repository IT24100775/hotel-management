package com.RoomManagement.model;

public class Room {

        private String roomID;
        private String type;
        private String availability;

        public Room(String roomID, String type, String availability) {
            this.roomID = roomID;
            this.type = type;
            this.availability = availability;
        }

        // Getters and Setters
        public String getRoomID() {
            return roomID;
        }

        public void setRoomID(String roomID) {
            this.roomID = roomID;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getAvailability() {
            return availability;
        }

        public void setAvailability(String availability) {
            this.availability = availability;
        }
    }


