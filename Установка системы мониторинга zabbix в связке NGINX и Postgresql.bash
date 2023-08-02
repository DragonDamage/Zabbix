Установка системы мониторинга zabbix в связке NGINX и Postgresql:

# a. Установите репозиторий Zabbix
sudo wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1%2Bfocal_all.deb
sudo dpkg -i zabbix-release_5.0-1+focal_all.deb
sudo apt update

# b. Установите Zabbix сервер, веб-интерфейс и агент
sudo apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-nginx-conf zabbix-agent

# c. Создайте базу данных
Установите и запустите сервер базы данных.
Выполните следующие комманды на хосте, где будет распологаться база данных.
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
На хосте Zabbix сервера импортируйте начальную схему и данные. Вам будет предложено ввести недавно созданный пароль.
sudo zcat /usr/share/doc/zabbix-server-pgsql*/create.sql.gz | sudo -u zabbix psql zabbix

# d. Настройте базу данных для Zabbix сервера
Отредактируйте файл /etc/zabbix/zabbix_server.conf
DBPassword=password

# e. Настройте PHP для веб-интерфейса
Отредактируйте файл /etc/zabbix/nginx.conf раскомментируйте и настройте директивы 'listen' и 'server_name'.
listen 80;
server_name example.com;
Отредактируйте файл /etc/zabbix/php-fpm.conf раскомментируйте строку и укажите свой часовой пояс
; php_value[date.timezone] = Europe/Riga

# f. Запустите процессы Zabbix сервера и агента
Запустите процессы Zabbix сервера и агента и настройте их запуск при загрузке ОС.
systemctl restart zabbix-server zabbix-agent nginx php7.4-fpm
systemctl enable zabbix-server zabbix-agent nginx php7.4-fpm
























