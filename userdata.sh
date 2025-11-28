#!/bin/bash
yum update -y &>/dev/null
yum install -y httpd &>/dev/null
systemctl start httpd
systemctl enable httpd

while true; do
  INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
  cat > /var/www/html/index.html << EOT
<!DOCTYPE html>
<html><head><title>TP Terraform</title></head>
<body style="font-family:Arial;text-align:center;padding:50px;">
<h1>🔥 Instance: $INSTANCE_ID</h1>
<p>Trigramme: ${trigramme}</p>
</body></html>
EOT
  sleep 10
done
