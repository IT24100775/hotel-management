// Package: ReviewRating

// --- Model Classes (same as before) ---
package ReviewRating;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ReviewAndRating {
    public String username;
    public String reviewText;
    public int rating;
    public boolean isApproved;

    public ReviewAndRating(String username, String reviewText, int rating) {
        this.username = username;
        this.reviewText = reviewText;
        this.rating = rating;
        this.isApproved = false;
    }

    public void approveReview() {
        this.isApproved = true;
    }

    @Override
    public String toString() {
        return "User: " + username + "\nReview: " + reviewText + "\nRating: "
                + "★". repeat(rating) + "☆".repeat(5 - rating) + "\n";
    }
}

class Hotel {
    public String name;
    public List<ReviewAndRating> reviews;

    public Hotel(String name) {
        this.name = name;
        this.reviews = new ArrayList<>();
    }

    public void addReview(ReviewAndRating review) {
        reviews.add(review);
    }

    public double calculateAverageRating() {
        double totalRating = 0;
        int count = 0;
        for (ReviewAndRating review : reviews) {
            if (review.isApproved) {
                totalRating += review.rating;
                count++;
            }
        }
        return count == 0 ? 0 : totalRating / count;
    }
}

class Room {
    public String roomName;
    public List<ReviewAndRating> reviews;

    public Room(String roomName) {
        this.roomName = roomName;
        this.reviews = new ArrayList<>();
    }

    public void addReview(ReviewAndRating review) {
        reviews.add(review);
    }

    public double calculateAverageRating() {
        double totalRating = 0;
        int count = 0;
        for (ReviewAndRating review : reviews) {
            if (review.isApproved) {
                totalRating += review.rating;
                count++;
            }
        }
        return count == 0 ? 0 : totalRating / count;
    }
}

// --- Servlet Classes ---


@WebServlet("/submitReview")
class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String reviewText = request.getParameter("reviewText");
        int rating = Integer.parseInt(request.getParameter("rating"));

        ReviewAndRating review = new ReviewAndRating(username, reviewText, rating);

        ServletContext context = getServletContext();
        Hotel hotel = (Hotel) context.getAttribute("hotel");
        Room room = (Room) context.getAttribute("room");

        if (hotel == null) {
            hotel = new Hotel("Ocean View Resort");
            room = new Room("Deluxe Ocean Room");
            context.setAttribute("hotel", hotel);
            context.setAttribute("room", room);
        }

        hotel.addReview(review);
        room.addReview(review);

        request.setAttribute("message", "Review submitted successfully. Pending admin approval.");
        request.getRequestDispatcher("reviewResult.jsp").forward(request, response);
    }
}

@WebServlet("/approveReviews")
class AdminApprovalServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Hotel hotel = (Hotel) getServletContext().getAttribute("hotel");
        if (hotel != null) {
            for (ReviewAndRating review : hotel.reviews) {
                if (!review.isApproved) {
                    review.approveReview();
                }
            }
        }
        request.setAttribute("message", "All reviews approved.");
        request.getRequestDispatcher("reviewResult.jsp").forward(request, response);
    }
}

@WebServlet("/viewReviews")
class ViewReviewsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Hotel hotel = (Hotel) getServletContext().getAttribute("hotel");
        Room room = (Room) getServletContext().getAttribute("room");

        request.setAttribute("hotelReviews", hotel != null ? hotel.reviews : null);
        request.setAttribute("roomReviews", room != null ? room.reviews : null);
        request.getRequestDispatcher("displayReviews.jsp").forward(request, response);
    }
}

// --- HTML + JSP Pages ---

// submitReview.html
/*
<form action="submitReview" method="post">
    <input type="text" name="username" placeholder="Your Name" required><br>
    <textarea name="reviewText" placeholder="Write your review" required></textarea><br>
    <input type="number" name="rating" min="1" max="5" required><br>
    <input type="submit" value="Submit Review">
</form>
*/

// displayReviews.jsp
/*
<%@ page import="ReviewRating.ReviewAndRating" %>
<%@ page import="java.util.List" %>
<h2>Approved Reviews</h2>
<%
    List<ReviewAndRating> hotelReviews = (List<ReviewAndRating>) request.getAttribute("hotelReviews");
    if (hotelReviews != null) {
        for (ReviewAndRating review : hotelReviews) {
            if (review.isApproved) {
%>
<p><strong><%= review.username %></strong>: <%= review.reviewText %> (<%= review.rating %> stars)</p>
<%
            }
        }
    } else {
%>
<p>No reviews yet.</p>
<%
    }
%>
*/

// reviewResult.jsp
/*
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Result</title></head>
<body>
    <p><%= request.getAttribute("message") %></p>
    <a href="submitReview.html">Submit Another Review</a> |
    <a href="viewReviews">View Reviews</a> |
    <a href="approveReviews">Approve All (Admin)</a>
</body>
</html>
*/
