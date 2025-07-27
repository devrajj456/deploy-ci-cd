#!/bin/bash
yum update -y

# Get current AWS region
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/region)

# Install CodeDeploy agent
yum install -y ruby wget
cd /home/ec2-user

# Download and install CodeDeploy agent
wget https://aws-codedeploy-$REGION.s3.$REGION.amazonaws.com/latest/install
chmod +x ./install
./install auto

# Start and enable CodeDeploy agent
service codedeploy-agent start
chkconfig codedeploy-agent on

# Verify CodeDeploy agent is running
sleep 10
if ! service codedeploy-agent status; then
    echo "CodeDeploy agent failed to start, trying manual start..."
    /opt/codedeploy-agent/bin/codedeploy-agent start
fi

# Install Apache web server
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Create a simple index page
echo "<h1>Welcome to ${project_name}</h1>" > /var/www/html/index.html
echo "<p>Server deployed successfully!</p>" >> /var/www/html/index.html
echo "<p>Instance ID: $(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id)</p>" >> /var/www/html/index.html
echo "<p>Region: $REGION</p>" >> /var/www/html/index.html

# Set proper permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Log the completion
echo "User data script completed at $(date)" >> /var/log/userdata.log