<!DOCTYPE html>
<html>
<head>
    <title>Make Reservation - GrandStay</title>
</head>
<body>
    <h1>Make Reservation</h1>
    <p>Book your perfect stay at GrandStay</p>
    
    <div id="hotelsList">
        <p>Loading hotels...</p>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            fetch('/api/hotels')
                .then(response => response.json())
                .then(hotels => {
                    const hotelsList = document.getElementById('hotelsList');
                    hotelsList.innerHTML = '';
                    hotels.forEach(hotel => {
                        const div = document.createElement('div');
                        div.innerHTML = '<h3>' + hotel.name + '</h3><p>' + hotel.location + '</p>';
                        hotelsList.appendChild(div);
                    });
                })
                .catch(error => {
                    document.getElementById('hotelsList').innerHTML = '<p>Error: ' + error.message + '</p>';
                });
        });
    </script>
</body>
</html>