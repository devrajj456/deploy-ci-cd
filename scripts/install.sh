#!/bin/bash

# Update system packages
yum update -y

# Install Apache if not already installed
if ! command -v httpd &> /dev/null; then
    echo "Installing Apache web server..."
    yum install -y httpd
fi

# Create web directory if it doesn't exist
mkdir -p /var/www/html

# Set proper permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Create a default index.html if application files don't include one
if [ ! -f /var/www/html/index.html ]; then
    echo "<h1>Welcome to the Application</h1>" > /var/www/html/index.html
    echo "<p>Deployment successful!</p>" >> /var/www/html/index.html
    chown apache:apache /var/www/html/index.html
    chmod 644 /var/www/html/index.html
fi

echo "Dependencies installed successfully"