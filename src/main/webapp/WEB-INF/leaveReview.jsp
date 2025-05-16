<%--
  Created by IntelliJ IDEA.
  User: rozanna
  Date: 4/25/2025
  Time: 1:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Leave a Review</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col items-center justify-center p-6">

<div class="bg-white p-8 rounded-2xl shadow-lg w-full max-w-xl">
    <h2 class="text-2xl font-semibold text-gray-800 mb-4 text-center">Leave a Review</h2>

    <!-- Feedback Messages -->

        <div class="bg-green-100 text-green-700 p-3 mb-4 rounded">${message}</div>



        <div class="bg-red-100 text-red-700 p-3 mb-4 rounded">${error}</div>


    <!-- Review Form -->
    <form action="submitReview" method="post" class="space-y-4">
        <input type="hidden" name="roomId" value="${param.roomId}" />

        <!-- Username -->
        <div>
            <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Your Name</label>
            <input type="text" id="username" name="username" required class="w-full border rounded-lg p-2" />
        </div>

        <!-- Rating -->
        <div>
            <label for="rating" class="block text-sm font-medium text-gray-700 mb-1">Rating (1 to 5)</label>
            <select id="rating" name="rating" class="w-full border rounded-lg p-2">
                <c:forEach var="i" begin="1" end="5">
                    <option value="${i}">${i}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Review Text -->
        <div>
            <label for="comment" class="block text-sm font-medium text-gray-700 mb-1">Your Review</label>
            <textarea id="comment" name="comment" rows="4" required
                      class="w-full border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
        </div>

        <!-- Submit Button -->
        <div class="flex justify-end">
            <button type="submit"
                    class="bg-blue-600 text-white px-6 py-2 rounded-xl hover:bg-blue-700 transition">
                Submit Review
            </button>
        </div>
    </form>
</div>

</body>
</html>
