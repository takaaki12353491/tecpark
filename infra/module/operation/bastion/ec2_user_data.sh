#!/bin/bash
# MySQLクライアントをインストール
sudo dnf update -y
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
sudo dnf install -y https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
sudo dnf install -y mysql-community-client

# MySQLに接続するスクリプトを作成
cat <<EOF > /home/ec2-user/connect_mysql.sh
#!/bin/bash
# MySQLに接続するスクリプト
MYSQL_HOST=\$(aws ssm get-parameter --name "MAIN_DB_HOST" --query "Parameter.Value" --output text --with-decryption)
MYSQL_PORT=\$(aws ssm get-parameter --name "MAIN_DB_PORT" --query "Parameter.Value" --output text --with-decryption)
MYSQL_DATABASE=\$(aws ssm get-parameter --name "MAIN_DB_DATABASE" --query "Parameter.Value" --output text --with-decryption)
MYSQL_USERNAME=\$(aws ssm get-parameter --name "MAIN_DB_USERNAME" --query "Parameter.Value" --output text --with-decryption)
MYSQL_PASSWORD=\$(aws secretsmanager get-secret-value --secret-id "MAIN_DB_PASSWORD" --query "SecretString" --output text)

mysql -h \$MYSQL_HOST -P \$MYSQL_PORT -u \$MYSQL_USERNAME -p\$MYSQL_PASSWORD -D \$MYSQL_DATABASE
EOF

chmod +x /home/ec2-user/connect_mysql.sh
