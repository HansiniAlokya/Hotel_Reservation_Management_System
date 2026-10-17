# 🚀 Complete MySQL Setup Guide for Hotel Reservation System

## Current Status
✅ MySQL is installed and running on your system  
❌ MySQL requires authentication (password)  
❌ Application cannot connect due to access denied  

## Quick Solution Options

### Option 1: Set MySQL Root Password (Recommended)

#### Step 1: Connect to MySQL
```bash
# Try connecting with common passwords
mysql -u root -p
# When prompted, try these passwords:
# - (empty - just press Enter)
# - root
# - password
# - 123456
```

#### Step 2: If you can connect, set password to "password"
```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```

#### Step 3: If you can't connect, reset password
```bash
# Stop MySQL
sudo brew services stop mysql  # macOS
# OR
sudo systemctl stop mysql      # Linux

# Start MySQL in safe mode
sudo mysqld_safe --skip-grant-tables &

# Connect without password
mysql -u root

# Reset password
USE mysql;
UPDATE user SET authentication_string=PASSWORD('password') WHERE User='root';
FLUSH PRIVILEGES;
EXIT;

# Restart MySQL normally
sudo brew services start mysql  # macOS
# OR
sudo systemctl start mysql      # Linux
```

### Option 2: Use Docker MySQL (Easiest)

```bash
# Install Docker if not already installed
# Then run MySQL in Docker
docker run --name mysql-hotel \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=hotel_reservation_db \
  -p 3306:3306 \
  -d mysql:8.0

# Verify it's running
docker ps
```

### Option 3: Create New MySQL User

```sql
-- Connect to MySQL as root
mysql -u root -p

-- Create new user
CREATE USER 'hotelapp'@'localhost' IDENTIFIED BY 'hotelapp123';
GRANT ALL PRIVILEGES ON *.* TO 'hotelapp'@'localhost';
FLUSH PRIVILEGES;
```

Then update `application.properties`:
```properties
spring.datasource.username=hotelapp
spring.datasource.password=hotelapp123
```

## Test MySQL Connection

After setting up MySQL, test the connection:

```bash
# Test connection
mysql -u root -p
# Enter password: password

# Create database
CREATE DATABASE hotel_reservation_db;
SHOW DATABASES;
```

## Run the Application

Once MySQL is configured:

```bash
./mvnw spring-boot:run
```

You should see:
```
✅ MySQL Connection Successful
✅ Connected to database: hotel_reservation_db
✅ MySQL Version: 8.0.x
Created role: ADMIN
Created role: STAFF  
Created role: GUEST
Created test user: testuser
Created admin user: admin
Created staff user: staff
Created sample hotels and rooms
Created sample events
```

## Verify Data Persistence

1. **Check MySQL Workbench**:
   - Connect to `localhost:3306`
   - Database: `hotel_reservation_db`
   - You should see tables: `users`, `roles`, `hotels`, `events`, etc.

2. **Test User Registration**:
   - Go to http://localhost:8080/register
   - Create a new user
   - Check MySQL Workbench - user should be saved

3. **Restart Application**:
   - Stop the application (Ctrl+C)
   - Restart: `./mvnw spring-boot:run`
   - All users and data should persist

## Troubleshooting

### Common Issues:

1. **"Access denied"**: Wrong password - try the reset steps above
2. **"Connection refused"**: MySQL not running - start the service
3. **"Database not found"**: Application will create it automatically
4. **"Port 3306 in use"**: Another MySQL instance running

### Useful Commands:

```bash
# Check MySQL status
brew services list | grep mysql  # macOS
sudo systemctl status mysql      # Linux

# Check MySQL processes
ps aux | grep mysql

# Check port usage
lsof -i :3306

# Restart MySQL
brew services restart mysql      # macOS
sudo systemctl restart mysql    # Linux
```

## Benefits of MySQL Integration

✅ **Persistent Storage**: All user accounts survive application restarts  
✅ **Data Integrity**: ACID compliance and foreign key constraints  
✅ **Scalability**: Better performance for large datasets  
✅ **Backup & Recovery**: Standard database backup procedures  
✅ **Multi-user Access**: Multiple applications can access the same data  
✅ **Advanced Queries**: Complex reporting and analytics capabilities  
✅ **IntelliJ Integration**: Direct database access from IDE  
✅ **MySQL Workbench**: Visual database management  

## Next Steps

1. **Set up MySQL** using one of the options above
2. **Test the connection** with the provided commands
3. **Run the application** and verify it connects to MySQL
4. **Check MySQL Workbench** to see the created tables and data
5. **Test user registration** to verify data persistence
6. **Restart the application** to confirm data survives restarts

Once MySQL is working, all guest and admin accounts will be permanently saved in the database! 🎉
