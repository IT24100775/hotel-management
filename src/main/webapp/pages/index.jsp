<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home - The Seabreeze Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="./CSS/index.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

</head>
<body>
<jsp:include page="/pages/reusableComponents/navbar.jsp" />

<div class="content1">
     <img src="images/seabreeze.png" alt="Hotel Image" width="100%" height="auto"><br><br><br>
    </div>
<section id="AboutUs">
<div class="content2" style="font-family: 'Carla Sans', serif; color: #006994; line-height: 1.8; font-size:x-large;">
    <p><b>WELCOME TO THE SEABREEZE HOTEL!</b><br>
        <i>Where Coastal Comfort Meets Elegant Escape</i>
    </p>
</div>


<div class="content3" style="font-family: 'Carla Sans', serif; color:black; line-height: 1.8; font-size:x-large;">
    Set along the tranquil shoreline, Seabreeze offers oceanfront luxury with relaxed charm. Whether for a peaceful escape or a scenic business stay, our boutique hotel features elegant rooms, thoughtful service, and coastal-inspired comfort. Wake to the sound of waves, savor a fresh seaside breakfast, and enjoy moments made to be remembered.
</div>

</section>
<img src="images/White%20and%20Gold%20Minimalist%20Feminine%20Hotel%20Logo%20(1).png" class="image-right">
<div id="map"></div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const map = L.map('map').setView([7.2486, 79.8417], 15); // Coordinates for Negombo Beach

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        L.marker([7.2486, 79.8417]).addTo(map)
            .bindPopup('The Seabreeze Hotel<br>Negombo Beach, Sri Lanka')
            .openPopup();
    });
</script>
<jsp:include page="/pages/reusableComponents/footer.jsp" />

</body>
</html>