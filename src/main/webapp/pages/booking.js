document.addEventListener('DOMContentLoaded', function() {
    // Booking Page Functionality
    if (document.getElementById('searchForm')) {
        // Set minimum date for check-in to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('checkInDate').min = today;

        // Set minimum check-out date to check-in date
        document.getElementById('checkInDate').addEventListener('change', function() {
            document.getElementById('checkOutDate').min = this.value;
        });

        // Handle book now buttons
        const bookButtons = document.querySelectorAll('.book-btn');
        bookButtons.forEach(button => {
            button.addEventListener('click', function() {
                const roomId = this.getAttribute('data-room-id');
                const roomType = this.getAttribute('data-room-type');
                const roomPrice = this.getAttribute('data-room-price');

                document.getElementById('modalRoomId').value = roomId;
                document.getElementById('modalRoomType').value = roomType;
                document.getElementById('modalRoomPrice').value = roomPrice;

                const modal = new bootstrap.Modal(document.getElementById('bookingModal'));
                modal.show();
            });
        });
    }

    // Cancel Booking Page Functionality
    if (document.querySelector('.cancel-btn')) {
        const cancelButtons = document.querySelectorAll('.cancel-btn');
        cancelButtons.forEach(button => {
            button.addEventListener('click', function() {
                const bookingId = this.getAttribute('data-booking-id');

                document.getElementById('cancelBookingId').textContent = bookingId;
                document.getElementById('cancelIdInput').value = bookingId;

                const modal = new bootstrap.Modal(document.getElementById('cancelModal'));
                modal.show();
            });
        });
    }

    // Form validation for booking form
    if (document.getElementById('bookingForm')) {
        document.getElementById('bookingForm').addEventListener('submit', function(e) {
            const guestName = document.getElementById('guestName').value.trim();
            const guestEmail = document.getElementById('guestEmail').value.trim();

            if (!guestName || !guestEmail) {
                e.preventDefault();
                alert('Please fill in all required fields.');
            }
        });
    }
});