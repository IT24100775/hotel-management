package com.hotel.servlet;

import com.hotel.model.Review;
import com.hotel.util.ReviewFileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ReviewServlet extends HttpServlet {
    private HotelDemo hotelDemo;

    @Override
    public void init() throws ServletException {
        hotelDemo = new HotelDemo();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String hotelIdParam = request.getParameter("hotelId");
        if (hotelIdParam == null || hotelIdParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hotel ID is required.");
            return;
        }
        try {
            int hotelId = Integer.parseInt(hotelIdParam);
            request.setAttribute("hotel", hotelDemo.getHotel(hotelId));
            List<Review> reviews = ReviewFileUtil.getReviews(hotelId);
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/reviews.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Hotel ID format.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("deleteIndex") != null) {
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            int deleteIndex = Integer.parseInt(request.getParameter("deleteIndex"));
            List<Review> reviews = ReviewFileUtil.getReviews(hotelId);
            if (deleteIndex >= 0 && deleteIndex < reviews.size()) {
                String username = (String) request.getSession().getAttribute("username");
                if (username != null && username.equals(reviews.get(deleteIndex).getReviewer())) {
                    reviews.remove(deleteIndex);
                    ReviewFileUtil.saveAllReviews(hotelId, reviews);
                }
            }
            response.sendRedirect("reviews?hotelId=" + hotelId);
            return;
        }
        int hotelId = Integer.parseInt(request.getParameter("hotelId"));
        String reviewer = request.getParameter("reviewer");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");
        ReviewFileUtil.addReview(hotelId, new Review(reviewer, rating, comment));
        response.sendRedirect("reviews?hotelId=" + hotelId);
    }
} 