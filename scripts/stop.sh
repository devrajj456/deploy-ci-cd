#!/bin/bash

# Stop Apache web server gracefully
if systemctl is-active --quiet httpd; then
    echo "Stopping Apache web server..."
    systemctl stop httpd
    
    # Wait for Apache to stop
    sleep 5
    
    if systemctl is-active --quiet httpd; then
        echo "Apache did not stop gracefully, forcing stop..."
        systemctl kill httpd
    else
        echo "Apache stopped successfully"
    fi
else
    echo "Apache is not running"
fi

echo "Application stopped"