#!/bin/bash
yum update -y

# Install CodeDeploy agent
yum install -y ruby wget
cd /home/ec2-user
wget https://aws-codedeploy-${AWS_DEFAULT_REGION}.s3.${AWS_DEFAULT_REGION}.amazonaws.com/latest/install
chmod +x ./install
./install auto

# Install Apache web server
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Create a simple index page
echo "<h1>Welcome to ${project_name}</h1>" > /var/www/html/index.html
echo "<p>Server deployed successfully!</p>" >> /var/www/html/index.html
echo "<p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>" >> /var/www/html/index.html

# Set proper permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Start CodeDeploy agent
service codedeploy-agent start
chkconfig codedeploy-agent on