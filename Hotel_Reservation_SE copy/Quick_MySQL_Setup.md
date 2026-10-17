# Quick MySQL Setup for Hotel Reservation System

## Option 1: Install MySQL (Recommended)

### macOS:
```bash
# Install MySQL using Homebrew
brew install mysql

# Start MySQL service
brew services start mysql

# Set root password (you'll be prompted)
mysql_secure_installation
```

### Windows:
1. Download MySQL Installer from: https://dev.mysql.com/downloads/installer/
2. Run installer and set root password during installation
3. Start MySQL service

### Linux (Ubuntu/Debian):
```bash
sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation
```

## Option 2: Use Docker MySQL (Easiest)

```bash
# Run MySQL in Docker
docker run --name mysql-hotel \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=hotel_reservation_db \
  -p 3306:3306 \
  -d mysql:8.0

# Verify it's running
docker ps
```

## Option 3: Use Default MySQL Credentials

If you already have MySQL installed, try these common default passwords:
- Empty password (no password)
- "root"
- "password"
- "123456"

## Test MySQL Connection

After installation, test the connection:

```bash
# Connect to MySQL
mysql -u root -p

# If successful, create the database
CREATE DATABASE hotel_reservation_db;
```

## Update Application Configuration

Once MySQL is working, update the password in `application.properties`:

```properties
# If your MySQL root password is different, update this line:
spring.datasource.password=YOUR_MYSQL_PASSWORD
```

## Quick Test Commands

```bash
# Check if MySQL is running
brew services list | grep mysql  # macOS
sudo systemctl status mysql      # Linux

# Connect to MySQL
mysql -u root -p

# Create database
CREATE DATABASE hotel_reservation_db;
SHOW DATABASES;
```

## Troubleshooting

1. **"Access denied" error**: Wrong password - try empty password or common passwords
2. **"Connection refused"**: MySQL not running - start the service
3. **"Command not found"**: MySQL not installed - install it first

## Next Steps

1. Install MySQL using one of the options above
2. Set root password to "password" (or update application.properties)
3. Run the application: `./mvnw spring-boot:run`
4. Check MySQL Workbench to see the created tables and data
