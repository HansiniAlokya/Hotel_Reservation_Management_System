# MySQL Database Setup Guide for Hotel Reservation System

## Prerequisites
- MySQL Server installed and running
- MySQL Workbench installed
- IntelliJ IDEA with Database tools

## Step 1: MySQL Server Setup

### 1.1 Start MySQL Server
Make sure MySQL server is running on your system:
- **Windows**: Start MySQL service from Services or use MySQL Workbench
- **macOS**: `brew services start mysql` or start from System Preferences
- **Linux**: `sudo systemctl start mysql`

### 1.2 Verify MySQL is Running
```bash
mysql --version
```

## Step 2: MySQL Workbench Configuration

### 2.1 Create Database Connection
1. Open MySQL Workbench
2. Click on the "+" next to "MySQL Connections"
3. Configure connection:
   - **Connection Name**: Hotel Reservation DB
   - **Hostname**: localhost
   - **Port**: 3306
   - **Username**: root
   - **Password**: [your MySQL root password]
4. Click "Test Connection" to verify
5. Click "OK" to save

### 2.2 Create Database
1. Connect to your MySQL server
2. Run this SQL command:
```sql
CREATE DATABASE IF NOT EXISTS hotel_reservation_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
```

### 2.3 Create User (Optional but Recommended)
```sql
-- Create a dedicated user for the application
CREATE USER 'hotelapp'@'localhost' IDENTIFIED BY 'hotelapp123';
GRANT ALL PRIVILEGES ON hotel_reservation_db.* TO 'hotelapp'@'localhost';
FLUSH PRIVILEGES;
```

## Step 3: IntelliJ IDEA Database Integration

### 3.1 Connect Database to IntelliJ
1. Open IntelliJ IDEA
2. Go to **View** → **Tool Windows** → **Database**
3. Click the "+" button → **Data Source** → **MySQL**
4. Configure connection:
   - **Host**: localhost
   - **Port**: 3306
   - **Database**: hotel_reservation_db
   - **User**: root (or hotelapp if you created a dedicated user)
   - **Password**: [your MySQL password]
5. Click "Test Connection"
6. Click "OK" to save

### 3.2 Verify Connection
- You should see the database in the Database tool window
- Expand the database to see tables (they will be created when you run the application)

## Step 4: Application Configuration

### 4.1 Update Database Credentials (if needed)
If you created a dedicated user, update `application.properties`:
```properties
spring.datasource.username=hotelapp
spring.datasource.password=hotelapp123
```

### 4.2 Default Configuration
The application is configured with these default settings:
- **Database**: hotel_reservation_db
- **Username**: root
- **Password**: password
- **Port**: 3306

## Step 5: Run the Application

### 5.1 Start the Application
```bash
./mvnw spring-boot:run
```

### 5.2 Verify Database Creation
1. Check MySQL Workbench or IntelliJ Database tool
2. You should see these tables created automatically:
   - `roles`
   - `users`
   - `user_roles`
   - `hotels`
   - `rooms`
   - `events`
   - `reservations`
   - `payments`

### 5.3 Verify Data Population
The application will automatically create:
- **Roles**: ADMIN, STAFF, GUEST
- **Test Users**:
  - Admin: admin@grandstay.com / admin123
  - Staff: staff@grandstay.com / staff123
  - Guest: test@example.com / password123
- **Sample Hotels**: GrandStay Resort, Urban GrandStay, Mountain GrandStay
- **Sample Events**: Various events across all hotels

## Step 6: Testing Persistent Storage

### 6.1 Create New User
1. Go to http://localhost:8080/register
2. Create a new user account
3. Check in MySQL Workbench that the user was saved

### 6.2 Restart Application
1. Stop the application (Ctrl+C)
2. Restart with `./mvnw spring-boot:run`
3. Verify that all users and data persist

## Troubleshooting

### Common Issues:

1. **Connection Refused**
   - Ensure MySQL server is running
   - Check if port 3306 is available
   - Verify MySQL credentials

2. **Access Denied**
   - Check username/password
   - Ensure user has proper privileges
   - Try connecting with root user first

3. **Database Not Found**
   - The application will create the database automatically
   - Ensure `createDatabaseIfNotExist=true` is in the URL

4. **SSL Issues**
   - The configuration includes `useSSL=false` for local development
   - For production, enable SSL

### Useful MySQL Commands:
```sql
-- Check if database exists
SHOW DATABASES;

-- Check tables in database
USE hotel_reservation_db;
SHOW TABLES;

-- Check users table
SELECT * FROM users;

-- Check roles
SELECT * FROM roles;
```

## Production Considerations

For production deployment:
1. Change default passwords
2. Enable SSL connections
3. Use environment variables for sensitive data
4. Set up proper database backups
5. Configure connection pooling appropriately

## Benefits of MySQL Integration

✅ **Persistent Storage**: All user accounts and data survive application restarts
✅ **Data Integrity**: ACID compliance and foreign key constraints
✅ **Scalability**: Better performance for large datasets
✅ **Backup & Recovery**: Standard database backup procedures
✅ **Multi-user Access**: Multiple applications can access the same data
✅ **Advanced Queries**: Complex reporting and analytics capabilities
