        <!-- Main content ends here -->
        
        <div class="dashboard-footer">
            <p>&copy; ${java.time.Year.now().getValue()} Hotel Reservation System - Admin Module. All rights reserved.</p>
        </div>
    </div> <!-- End of content div -->
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Close notification when close button is clicked
            document.querySelectorAll('.close-notification').forEach(button => {
                button.addEventListener('click', function() {
                    this.parentElement.style.display = 'none';
                });
            });
            
            // Add active class to current menu item based on URL
            const currentPath = window.location.pathname;
            document.querySelectorAll('.sidebar ul li a').forEach(link => {
                if (currentPath.includes(link.getAttribute('href').split('/').pop())) {
                    link.parentElement.classList.add('active');
                }
            });
        });
    </script>
</body>
</html> 