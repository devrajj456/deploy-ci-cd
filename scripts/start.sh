#!/bin/bash

# Start Apache web server
systemctl start httpd
systemctl enable httpd

# Check if Apache is running
if systemctl is-active --quiet httpd; then
    echo "Apache started successfully"
else
    echo "Failed to start Apache"
    exit 1
fi

# Set proper permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

echo "Application started successfully"