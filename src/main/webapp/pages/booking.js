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

        // Handle book now buttons to show the modal
        const bookButtons = document.querySelectorAll('.book-btn');
        bookButtons.forEach(button => {
            button.addEventListener('click', function() {
                const roomId = this.getAttribute('data-room-id');
                const roomType = this.getAttribute('data-room-type');
                const roomPrice = this.getAttribute('data-room-price');
                const checkInDate = document.getElementById('checkInDate').value;
                const checkOutDate = document.getElementById('checkOutDate').value;
                const guests = document.getElementById('guests').value;

                // Set modal field values
                document.getElementById('modalRoomId').value = roomId;
                document.getElementById('modalRoomType').value = roomType;
                document.getElementById('modalRoomPrice').value = roomPrice;
                document.getElementById('checkInDisplay').value = checkInDate;
                document.getElementById('checkOutDisplay').value = checkOutDate;
                document.getElementById('checkIn').value = checkInDate;
                document.getElementById('checkOut').value = checkOutDate;
                document.getElementById('guests').value = guests;

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

    // Booking Form Validation and Submission
    let isSubmitting = false;
    if (document.getElementById('bookingForm')) {
        document.getElementById('bookingForm').addEventListener('submit', function(e) {
            e.preventDefault(); // Prevent the default form submission

            if (isSubmitting) {
                return;
            }

            const guestName = document.getElementById('guestName').value.trim();
            const guestEmail = document.getElementById('guestEmail').value.trim();

            if (!guestName || !guestEmail) {
                alert('Please fill in all required fields.');
                return;
            }

            isSubmitting = true;

            // Get all the booking details from the form
            const roomId = document.getElementById('modalRoomId').value;
            const roomType = document.getElementById('modalRoomType').value;
            const roomPrice = document.getElementById('modalRoomPrice').value;
            const checkInDate = document.getElementById('checkIn').value;
            const checkOutDate = document.getElementById('checkOut').value;
            const guests = document.getElementById('guests').value;

            //  No redirection here.  Form will be submitted, handled by servlet.

            // You could use AJAX to submit the form to the servlet, instead of a direct redirection.
            //  That's better, but to keep the changes minimal, I'm not changing that part.

            this.submit();  //  Make sure the form is submitted.
        });
    }
});
