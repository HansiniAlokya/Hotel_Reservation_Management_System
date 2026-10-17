<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make Reservation Test - GrandStay</title>
</head>
<body>
    <h1>Make Reservation Test</h1>
    <p>This is a test page to check if JSP is working.</p>
    
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