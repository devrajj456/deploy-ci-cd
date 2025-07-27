#!/bin/bash

# Validate that Apache is running and serving content
echo "Validating Apache service..."

# Check if Apache is running
if ! systemctl is-active --quiet httpd; then
    echo "ERROR: Apache is not running"
    exit 1
fi

# Check if the web content is accessible
if curl -f http://localhost/ > /dev/null 2>&1; then
    echo "SUCCESS: Web server is responding"
else
    echo "ERROR: Web server is not responding"
    exit 1
fi

echo "Validation completed successfully"