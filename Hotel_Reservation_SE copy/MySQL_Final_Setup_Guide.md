# 🎯 MySQL Database Setup - Complete Guide

## Current Status
✅ **Application is working** with H2 database (temporary)  
✅ **All features functional** - Event Management, User Registration, etc.  
✅ **MySQL is installed** and running on your system  
❌ **MySQL authentication** needs to be configured  

## 🚀 Quick Setup Steps

### Step 1: Configure MySQL Authentication

**Option A: Set Root Password to "password"**
```bash
# Connect to MySQL (try different passwords)
mysql -u root -p
# Try passwords: (empty), root, password, 123456

# Once connected, set password:
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EXIT;
```

**Option B: Use Docker MySQL (Easiest)**
```bash
# Run MySQL in Docker
docker run --name mysql-hotel \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=hotel_reservation_db \
  -p 3306:3306 \
  -d mysql:8.0
```

### Step 2: Test MySQL Connection
```bash
# Test connection
mysql -u root -p
# Password: password

# Create database
CREATE DATABASE hotel_reservation_db;
SHOW DATABASES;
```

### Step 3: Switch Application to MySQL

**Update `src/main/resources/application.properties`:**
```properties
# Comment out H2 section and uncomment MySQL section:

# MySQL Database Configuration
spring.datasource.url=jdbc:mysql://localhost:3306/hotel_reservation_db?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.driverClassName=com.mysql.cj.jdbc.Driver
spring.datasource.username=root
spring.datasource.password=password
spring.datasource.platform=mysql

# JPA/Hibernate Configuration
spring.jpa.hibernate.ddl-auto=update
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQLDialect
spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect
```

### Step 4: Restart Application
```bash
./mvnw spring-boot:run
```

**Expected Output:**
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

## 🔧 IntelliJ IDEA Integration

### Connect Database to IntelliJ:
1. **View** → **Tool Windows** → **Database**
2. Click **"+"** → **Data Source** → **MySQL**
3. Configure:
   - **Host**: localhost
   - **Port**: 3306
   - **Database**: hotel_reservation_db
   - **User**: root
   - **Password**: password
4. Click **"Test Connection"** → **"OK"**

### MySQL Workbench Setup:
1. Open MySQL Workbench
2. Create new connection:
   - **Connection Name**: Hotel Reservation DB
   - **Hostname**: localhost
   - **Port**: 3306
   - **Username**: root
   - **Password**: password
3. Click **"Test Connection"** → **"OK"**

## ✅ Verification Steps

### 1. Check Database Tables
In MySQL Workbench or IntelliJ Database tool, you should see:
- `roles`
- `users`
- `user_roles`
- `hotels`
- `rooms`
- `events`
- `reservations`
- `payments`

### 2. Test User Registration
1. Go to http://localhost:8080/register
2. Create a new user account
3. Check MySQL Workbench - user should be saved in `users` table

### 3. Test Data Persistence
1. Stop the application (Ctrl+C)
2. Restart: `./mvnw spring-boot:run`
3. All users and data should persist (not lost like with H2)

## 🎉 Benefits of MySQL Integration

✅ **Permanent Storage**: All guest and admin accounts saved permanently  
✅ **Data Persistence**: Data survives application restarts  
✅ **Professional Database**: Production-ready MySQL database  
✅ **IntelliJ Integration**: Direct database access from IDE  
✅ **MySQL Workbench**: Visual database management  
✅ **Backup & Recovery**: Standard database backup procedures  
✅ **Scalability**: Better performance for large datasets  
✅ **Multi-user Access**: Multiple applications can access the same data  

## 🆘 Troubleshooting

### Common Issues:

1. **"Access denied"**: Wrong password - try reset steps above
2. **"Connection refused"**: MySQL not running - start the service
3. **"Database not found"**: Application will create it automatically
4. **"Port 3306 in use"**: Another MySQL instance running

### Useful Commands:
```bash
# Check MySQL status
brew services list | grep mysql  # macOS
sudo systemctl status mysql      # Linux

# Restart MySQL
brew services restart mysql      # macOS
sudo systemctl restart mysql    # Linux

# Check MySQL processes
ps aux | grep mysql
```

## 📁 Files Created

I've created these helpful files for you:
- `Complete_MySQL_Setup.md` - Detailed setup instructions
- `Quick_MySQL_Setup.md` - Quick setup options
- `MySQL_Installation_Guide.md` - Installation instructions
- `database_setup.sql` - SQL script to create database
- `application.properties.backup` - Backup configuration

## 🎯 Next Steps

1. **Set up MySQL authentication** using one of the options above
2. **Test MySQL connection** with the provided commands
3. **Update application.properties** to use MySQL
4. **Restart the application** and verify it connects to MySQL
5. **Check MySQL Workbench** to see the created tables and data
6. **Test user registration** to verify data persistence
7. **Restart the application** to confirm data survives restarts

Once MySQL is working, all guest and admin accounts will be permanently saved in the database! 🚀

## 📞 Need Help?

If you encounter any issues:
1. Check the troubleshooting section above
2. Try the Docker MySQL option (easiest)
3. Verify MySQL is running and accessible
4. Check the application logs for specific error messages

The application is currently working perfectly with H2, so you can continue development while setting up MySQL! 🎉
