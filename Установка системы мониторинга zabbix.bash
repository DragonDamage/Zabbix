Установка системы мониторинга zabbix:
sudo apt update
wget https://repo.zabbix.com/zabbix/5.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.4-1+ubuntu20.04_all.deb
dpkg -i zabbix-release_5.4-1+ubuntu20.04_all.deb
sudo apt update
sudo apt install apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo apt install php php-mbstring php-gd php-xml php-bcmath php-ldap php-mysql
nano /etc/php/7.4/apache2/php.ini  # поменять конфиги сервера, если надо
sudo systemctl restart apache2
sudo apt install mariadb-server
sudo mysql_secure_installation
sudo mysql -u root –p
 CREATE DATABASE zabbix character set utf8 collate utf8_bin;
 CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'P@ssword321’;
 GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost' WITH GRANT OPTION;
 FLUSH PRIVILEGES;

sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
zcat /usr/share/doc/zabbix-sql-scripts/mysql/create.sql.gz | mysql –u root -p zabbix
nano /etc/zabbix/zabbix_server.conf
 DBPassword=password
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2

log/pass - Admin/zabbix

