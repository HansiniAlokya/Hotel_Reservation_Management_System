# Hotel Reservation System for Special Events

A comprehensive web-based hotel reservation system designed specifically for managing special events, built with Spring Boot and MySQL.

## Features

### Core Functionalities
- **User Management**: Complete user registration, authentication, and role-based access control
- **Event Management**: Create, update, and manage special events with capacity tracking
- **Payment Management**: Secure payment processing with multiple payment methods
- **Reservation Management**: Full reservation lifecycle from booking to check-out
- **Guest Portal**: Dedicated portal for guests to manage their reservations
- **Report & Analysis**: Comprehensive reporting and analytics dashboard

### Technical Features
- RESTful API architecture
- JWT-based authentication
- MySQL database with JPA/Hibernate
- Responsive web interface with Bootstrap
- Real-time availability checking
- Payment gateway integration
- Comprehensive error handling
- Data validation and security

## Technology Stack

### Backend
- **Java 21**
- **Spring Boot 3.5.6**
- **Spring Security** - Authentication and authorization
- **Spring Data JPA** - Data persistence
- **Hibernate** - ORM framework
- **MySQL** - Database
- **JWT** - Token-based authentication
- **Maven** - Dependency management

### Frontend
- **HTML5/CSS3**
- **Bootstrap 5** - Responsive UI framework
- **JavaScript (ES6+)**
- **Font Awesome** - Icons
- **Thymeleaf** - Template engine

## Project Structure

```
hotel-reservation-system/
├── pom.xml                                   # Maven dependencies
├── src/
│   ├── main/
│   │   ├── java/com/hotelreservation/
│   │   │   ├── HotelReservationApplication.java   # Main entry point
│   │   │   ├── config/                          # Security & Config
│   │   │   │   ├── WebSecurityConfig.java
│   │   │   │   └── DataSourceConfig.java
│   │   │   ├── controller/                      # MVC Controllers
│   │   │   │   ├── UserController.java
│   │   │   │   ├── EventController.java
│   │   │   │   ├── PaymentController.java
│   │   │   │   ├── ReservationController.java
│   │   │   │   ├── GuestController.java
│   │   │   │   └── ReportController.java
│   │   │   ├── dto/                             # DTOs
│   │   │   │   ├── UserDTO.java
│   │   │   │   ├── EventDTO.java
│   │   │   │   ├── PaymentDTO.java
│   │   │   │   ├── ReservationDTO.java
│   │   │   │   └── GuestDTO.java
│   │   │   ├── exception/                       # Custom Exceptions
│   │   │   │   ├── ResourceNotFoundException.java
│   │   │   │   ├── PaymentFailedException.java
│   │   │   │   ├── ReservationConflictException.java
│   │   │   │   └── GlobalExceptionHandler.java
│   │   │   ├── model/                           # JPA Entities
│   │   │   │   ├── User.java
│   │   │   │   ├── Role.java
│   │   │   │   ├── Event.java
│   │   │   │   ├── Payment.java
│   │   │   │   ├── Reservation.java
│   │   │   │   └── Guest.java
│   │   │   ├── repository/                      # Repositories
│   │   │   │   ├── UserRepository.java
│   │   │   │   ├── EventRepository.java
│   │   │   │   ├── PaymentRepository.java
│   │   │   │   ├── ReservationRepository.java
│   │   │   │   └── GuestRepository.java
│   │   │   ├── service/                         # Business Logic
│   │   │   │   ├── UserService.java
│   │   │   │   ├── EventService.java
│   │   │   │   ├── PaymentService.java
│   │   │   │   ├── ReservationService.java
│   │   │   │   ├── GuestService.java
│   │   │   │   └── ReportService.java
│   │   │   └── util/                            # Utilities
│   │   │       ├── DateUtils.java
│   │   │       └── PaymentGatewaySimulator.java
│   │   └── resources/
│   │       ├── application.properties       # Configuration
│   │       ├── static/                      # Static files
│   │       │   ├── css/style.css
│   │       │   ├── js/main.js
│   │       │   └── images/
│   │       ├── templates/                   # JSP pages
│   │       │   ├── layout/
│   │       │   ├── index.jsp
│   │       │   ├── login.jsp
│   │       │   ├── register.jsp
│   │       │   ├── dashboard.jsp
│   │       │   ├── events.jsp
│   │       │   ├── reservations.jsp
│   │       │   ├── payments.jsp
│   │       │   ├── reports.jsp
│   │       │   └── guestPortal.jsp
│   │       └── db/                          # SQL files
│   │           ├── schema.sql
│   │           └── data.sql
│   └── test/java/com/hotelreservation/      # Tests
│       ├── UserServiceTest.java
│       ├── EventServiceTest.java
│       ├── ReservationServiceTest.java
│       └── PaymentServiceTest.java
└── README.md
```

## Database Schema

The system uses MySQL with the following main entities:

- **Users**: System users with role-based access
- **Roles**: User roles (Admin, Manager, Receptionist, Guest)
- **Events**: Special events with capacity and pricing
- **Guests**: Guest information and preferences
- **Reservations**: Event reservations with status tracking
- **Payments**: Payment records and transaction history

## Installation & Setup

### Prerequisites
- Java 21 or higher
- Maven 3.6 or higher
- MySQL 8.0 or higher
- Git

### Database Setup
1. Create MySQL database:
```sql
CREATE DATABASE hotel_reservation_db;
```

2. Update database credentials in `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/hotel_reservation_db
spring.datasource.username=your_username
spring.datasource.password=your_password
```

### Application Setup
1. Clone the repository:
```bash
git clone <repository-url>
cd hotel-reservation-system
```

2. Build the project:
```bash
mvn clean install
```

3. Run the application:
```bash
mvn spring-boot:run
```

4. Access the application:
- Web Interface: http://localhost:8080
- API Documentation: http://localhost:8080/api

## API Endpoints

### Events
- `GET /api/events` - Get all events
- `GET /api/events/active` - Get active events
- `GET /api/events/{id}` - Get event by ID
- `POST /api/events` - Create new event
- `PUT /api/events/{id}` - Update event
- `DELETE /api/events/{id}` - Delete event

### Reservations
- `GET /api/reservations` - Get all reservations
- `GET /api/reservations/{id}` - Get reservation by ID
- `POST /api/reservations` - Create new reservation
- `PUT /api/reservations/{id}` - Update reservation
- `PUT /api/reservations/{id}/confirm` - Confirm reservation
- `PUT /api/reservations/{id}/cancel` - Cancel reservation

### Users
- `GET /api/users` - Get all users
- `GET /api/users/{id}` - Get user by ID
- `POST /api/users` - Create new user
- `PUT /api/users/{id}` - Update user
- `DELETE /api/users/{id}` - Delete user

## Default Users

The system comes with pre-configured users:

- **Admin**: username: `admin`, password: `admin123`
- **Manager**: username: `manager1`, password: `manager123`
- **Receptionist**: username: `reception1`, password: `reception123`

## Features Overview

### User Management
- Role-based access control (Admin, Manager, Receptionist, Guest)
- User registration and authentication
- Profile management
- Password encryption

### Event Management
- Create and manage special events
- Real-time capacity tracking
- Event status management
- Pricing and location details

### Reservation System
- Complete reservation lifecycle
- Guest information management
- Special requirements handling
- Reservation status tracking

### Payment Processing
- Multiple payment methods
- Secure transaction processing
- Payment status tracking
- Refund management

### Reporting & Analytics
- Revenue reports
- Occupancy statistics
- Guest analytics
- Event performance metrics

## Security Features

- JWT-based authentication
- Password encryption with BCrypt
- Role-based authorization
- CORS configuration
- Input validation
- SQL injection prevention

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please contact the development team or create an issue in the repository.

## Future Enhancements

- Real-time notifications
- Mobile application
- Advanced reporting dashboard
- Integration with external payment gateways
- Email notifications
- Calendar integration
- Multi-language support
