# MySQL Installation Guide

## For macOS (using Homebrew):
```bash
# Install MySQL
brew install mysql

# Start MySQL service
brew services start mysql

# Secure installation (set root password)
mysql_secure_installation

# Connect to MySQL
mysql -u root -p
```

## For Windows:
1. Download MySQL Installer from: https://dev.mysql.com/downloads/installer/
2. Run the installer and follow the setup wizard
3. Set root password during installation
4. Start MySQL service from Services or MySQL Workbench

## For Linux (Ubuntu/Debian):
```bash
# Update package list
sudo apt update

# Install MySQL
sudo apt install mysql-server

# Start MySQL service
sudo systemctl start mysql
sudo systemctl enable mysql

# Secure installation
sudo mysql_secure_installation
```

## Alternative: Use Docker MySQL
If you prefer using Docker:

```bash
# Run MySQL in Docker
docker run --name mysql-hotel -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=hotel_reservation_db -p 3306:3306 -d mysql:8.0

# Connect to MySQL
docker exec -it mysql-hotel mysql -u root -p
```

## Verify Installation
After installation, verify MySQL is running:
```bash
mysql --version
mysql -u root -p
```

## Next Steps
1. Install MySQL using one of the methods above
2. Set root password to "password" (or update application.properties with your password)
3. Run the database setup script (database_setup.sql)
4. Start the Spring Boot application
