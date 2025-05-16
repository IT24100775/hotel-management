<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hotel Reviews</title>
    <style>
        :root {
            --primary-color: #0673a3;
            --secondary-color: #ffd700;
            --text-color: #333;
            --light-bg: #f8fafc;
            --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --hover-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: url('images/1.png') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-color);
            line-height: 1.6;
        }

        .navbar {
            width: 100%;
            background: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 40px;
            height: 80px;
            box-sizing: border-box;
            position: fixed;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-left {
            display: flex;
            align-items: center;
        }

        .navbar-logo {
            height: 48px;
            transition: transform 0.3s ease;
        }

        .navbar-logo:hover {
            transform: scale(1.05);
        }

        .navbar-center {
            display: flex;
            flex: 1;
            justify-content: center;
            gap: 48px;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 32px;
        }

        .nav-link {
            color: #fff;
            text-decoration: none;
            font-size: 1.1em;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 8px 16px;
            border-radius: 20px;
        }

        .nav-link:hover {
            color: var(--secondary-color);
            background: rgba(255, 255, 255, 0.1);
        }

        .main-content {
            margin-top: 100px;
            padding: 20px;
        }

        .main-title {
            text-align: center;
            font-size: 2.8em;
            margin: 20px 0;
            color: #FFF;
            font-weight: 700;
            letter-spacing: 1px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .reviews-section {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            padding: 40px;
            backdrop-filter: blur(10px);
        }

        .reviews-header {
            text-align: center;
            font-size: 2em;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 40px;
            position: relative;
        }

        .reviews-header:after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: var(--secondary-color);
            margin: 10px auto;
            border-radius: 2px;
        }

        .review-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .review-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .review-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .reviewer {
            font-weight: 600;
            color: var(--primary-color);
            font-size: 1.2em;
        }

        .review-date {
            color: #888;
            font-size: 0.9em;
        }

        .review-rating {
            color: var(--secondary-color);
            font-size: 1.4em;
            margin: 10px 0;
        }

        .review-comment {
            color: #444;
            font-size: 1.1em;
            line-height: 1.6;
            margin-top: 15px;
        }

        .delete-btn {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9em;
            cursor: pointer;
            transition: all 0.3s ease;
            position: absolute;
            bottom: 20px;
            right: 20px;
        }

        .delete-btn:hover {
            background: #c0392b;
            transform: scale(1.05);
        }

        .add-review-form {
            background: var(--light-bg);
            padding: 30px;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            max-width: 800px;
            margin: 40px auto;
        }

        .form-row {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary-color);
            font-weight: 500;
        }

        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e1e1e1;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
        }

        .form-input:focus, .form-select:focus, .form-textarea:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(6, 115, 163, 0.1);
            outline: none;
        }

        .submit-btn {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 1.1em;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: block;
            margin: 20px auto 0;
        }

        .submit-btn:hover {
            background: #056292;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .nav-btn {
            background: var(--secondary-color);
            color: var(--primary-color);
            border: none;
            border-radius: 25px;
            font-size: 1em;
            font-weight: 500;
            padding: 8px 20px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .nav-btn:hover {
            background: #fff;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 900px) {
            .navbar {
                flex-direction: column;
                height: auto;
                padding: 10px 0;
            }
            .navbar-center, .navbar-right {
                flex-direction: column;
                gap: 12px;
                margin: 10px 0;
            }
            .review-list {
                grid-template-columns: 1fr;
            }
            .main-content {
                margin-top: 140px;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="navbar-left">
            <img src="images/2.png" alt="Seabreeze Hotels" class="navbar-logo">
        </div>
        <div class="navbar-center">
            <a href="#" class="nav-link">Home</a>
            <a href="#" class="nav-link">About Us</a>
            <a href="#" class="nav-link">Rooms</a>
            <a href="book-now.jsp" class="nav-link">Book Now</a>
            <a href="reviews?hotelId=1" class="nav-link">Reviews</a>
        </div>
        <div class="navbar-right">
            <c:choose>
                <c:when test="${empty sessionScope.username}">
                    <a href="login.jsp" class="nav-link">Login</a>
                    <a href="signup.jsp" class="nav-link">Sign Up</a>
                </c:when>
                <c:otherwise>
                    <span class="nav-link">Welcome, ${sessionScope.username}</span>
                    <form action="logout" method="post" style="display:inline;">
                        <button type="submit" class="nav-btn">Logout</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="main-content">
        <div class="main-title">Hotel Reviews</div>
        <div class="reviews-section">
            <div class="reviews-header">Customer Reviews</div>
            <div class="review-list">
                <c:choose>
                    <c:when test="${empty reviews}">
                        <div style="text-align:center;color:#666;grid-column:1/-1;padding:40px;">
                            No reviews yet. Be the first to review!
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="review" items="${reviews}" varStatus="status">
                            <div class="review-card">
                                <div class="review-header">
                                    <span class="reviewer">${review.reviewer}</span>
                                </div>
                                <div class="review-rating">
                                    <c:forEach begin="1" end="5" var="star">
                                        <span>${star <= review.rating ? "★" : "☆"}</span>
                                    </c:forEach>
                                </div>
                                <div class="review-comment">${review.comment}</div>
                                <c:if test="${sessionScope.username == review.reviewer}">
                                    <form method="post" action="reviews?hotelId=${hotel.id}&deleteIndex=${status.index}" style="display:inline;">
                                        <button type="submit" class="delete-btn">Delete</button>
                                    </form>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:choose>
                <c:when test="${empty sessionScope.username}">
                    <div class="reviews-header" style="margin-top:40px;">
                        Please <a href="login.jsp" style="color:var(--primary-color);text-decoration:none;">login</a> to add a review
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="reviews-header" style="margin-top:40px;">Add Your Review</div>
                    <form class="add-review-form" method="post" action="reviews?hotelId=${hotel.id}">
                        <input type="hidden" name="reviewer" value="${sessionScope.username}">
                        <div class="form-row">
                            <label class="form-label" for="rating">Rating</label>
                            <select class="form-select" id="rating" name="rating" required>
                                <option value="">Select Rating</option>
                                <option value="5">5 - Excellent</option>
                                <option value="4">4 - Very Good</option>
                                <option value="3">3 - Good</option>
                                <option value="2">2 - Fair</option>
                                <option value="1">1 - Poor</option>
                            </select>
                        </div>
                        <div class="form-row">
                            <label class="form-label" for="comment">Comment</label>
                            <textarea class="form-textarea" id="comment" name="comment" required 
                                      placeholder="Share your experience..." rows="4"></textarea>
                        </div>
                        <button class="submit-btn" type="submit">Submit Review</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html> 