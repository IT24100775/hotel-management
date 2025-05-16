package com.hotel.model;

public class Review {
    private String reviewer;
    private int rating;
    private String comment;

    public Review(String reviewer, int rating, String comment) {
        this.reviewer = reviewer;
        this.rating = rating;
        this.comment = comment;
    }

    public String getReviewer() {
        return reviewer;
    }
    public int getRating() {
        return rating;
    }
    public String getComment() {
        return comment;
    }
} 