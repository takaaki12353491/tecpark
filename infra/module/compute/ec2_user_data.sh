#!/bin/bash
# MySQLクライアントをインストール
sudo yum update -y
sudo dnf install -y https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
sudo dnf install -y mysql-community-client

cat <<EOF > /home/ec2-user/connect_mysql.sh
#!/bin/bash
# MySQLに接続するスクリプト
RDS_MAIN_HOST=\$(aws ssm get-parameter --name "RDS_MAIN_HOST" --query "Parameter.Value" --output text --with-decryption)
RDS_MAIN_PORT=\$(aws ssm get-parameter --name "RDS_MAIN_PORT" --query "Parameter.Value" --output text --with-decryption)
RDS_MAIN_DATABASE=\$(aws ssm get-parameter --name "RDS_MAIN_DATABASE" --query "Parameter.Value" --output text --with-decryption)
RDS_MAIN_USERNAME=\$(aws ssm get-parameter --name "RDS_MAIN_USERNAME" --query "Parameter.Value" --output text --with-decryption)
RDS_MAIN_PASSWORD=$(aws ssm get-parameter --name "RDS_MAIN_PASSWORD" --query "Parameter.Value" --output text --with-decryption)

mysql -h \$RDS_MAIN_HOST -P \$RDS_MAIN_PORT -u \$RDS_MAIN_USERNAME -p -D \$RDS_MAIN_DATABASE
EOF