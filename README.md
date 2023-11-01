# :pushpin: Основные понятия zabbix:

| Zabbix | Это мощная система мониторинга и управления сетями, серверами и приложениями. Она предоставляет возможность отслеживать производительность и доступность различных компонентов вашей инфраструктуры, а также предупреждать о проблемах и автоматически реагировать на них. |
| :---: | :---: |
| **Сервер Zabbix** | Это центральная часть системы Zabbix, которая отвечает за сбор, хранение и анализ данных мониторинга. Сервер Zabbix обрабатывает запросы от агентов и веб-интерфейса, а также отправляет уведомления о событиях. |
| **Агенты Zabbix** | Это центральная часть системы Zabbix, которая отвечает за сбор, хранение и анализ данных мониторинга. Сервер Zabbix обрабатывает запросы от агентов и веб-интерфейса, а также отправляет уведомления о событиях. |
| **Шаблоны** | Это наборы предопределенных параметров мониторинга, которые можно применить к одному или нескольким узлам. Шаблоны определяют, какие параметры следует мониторить и какие действия предпринимать при возникновении определенных событий. |
| **Триггеры** | Это условия, которые определяют, когда должно быть сгенерировано событие или уведомление. Они могут быть настроены на основе данных, полученных от агентов, и могут активироваться при превышении определенных пороговых значений или при выполнении других условий. |
| **Графики** | Позволяют визуализировать данные мониторинга в виде графиков. Они могут отображать изменение параметров во времени и помогать в анализе производительности и доступности системы. |
| **Уведомления** | Предоставляет возможность настройки уведомлений о событиях, таких как отказы, предупреждения или другие важные события. Уведомления могут быть отправлены по электронной почте, SMS или другими способами связи. |
| **Панель управления** | Это Веб-интерфейс Zabbix предоставляет панель управления, через которую можно настраивать и контролировать систему мониторинга. Он предоставляет доступ к данным мониторинга, настройкам уведомлений, графикам и другим функциям системы. |

![Screenshot](Zabbix_Architecture.png)

# :computer: Инструкция по установке Zabbix на Linux:

```bash
# Установка репозитория Zabbix:
$ apt update
$ apt upgrade
$ wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu20.04_all.deb  # Скачивание архива zabbix
$ sudo dpkg -i zabbix-release_6.4-1+ubuntu20.04_all.deb  # Распаковываем из архива
$ apt update

# Установка Zabbix сервера, веб-интерфейса и агента:
$ apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# Установка MySQL сервера:
$ cd /tmp
$ wget https://dev.mysql.com/get/mysql-apt-config_0.8.26-1_all.deb
$ apt install gnupg
$ dpkg -i mysql-apt-config_0.8.26-1_all.deb  # <OK>
$ apt install default-mysql-server
$ mysql -uroot -p  # Заходим на SQL-server. Password от твоего рута

# Создание БД:
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;  # Создаём БД
mysql> create user zabbix@localhost identified by 'zabbix';               # Создаём пользака и пароль
mysql> grant all privileges on zabbix.* to zabbix@localhost;              # Даём привелегии пользаку
mysql> set global log_bin_trust_function_creators = 1;                    # Включаем опцию логирования
mysql> quit;                                                              # Выходим

# Перенос файла server.sql.gz из забикса в таблицу БД:
$ zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix  # Пароль вводим от zabbix
$ mysql -uroot -p                                       # Опять заходим на SQL-server. Password от твоего рута
mysql> set global log_bin_trust_function_creators = 0;  # Выключаем опцию логирования
mysql> quit;                                            # Выходим

# Подправим конфигурацию Zabbix сервера:
$ nano /etc/zabbix/zabbix_server.conf  # Ставим пароль zabbix юзеру - DBPassword=zabbix

# Рестартуем процессы Zabbix сервера и агента:
$ systemctl restart zabbix-server zabbix-agent apache2

# Запускаем процессы Zabbix сервера и агента, и настраиваем их запуск при загрузке ОС:
$ systemctl enable zabbix-server zabbix-agent apache2

# Проверяем статусы процессов Zabbix сервера и агента:
$ systemctl status zabbix-server zabbix-agent apache2

$ ip -c a  #  Смотрим IP адрес (В моём случае это 192.168.197.132)

# Идём в браузер и заходим в UI Zabbix:
http://192.168.197.132/zaabbix

# Если хотим руссифицировать Zabbix:
$ apt install locales       # Скачиваем языки
$ dpkg-reconfigure locales  # Выбираем [*] ru_RU.UTF-8 UTF-8. Далее выбираем ru_RU.UTF-8
$ systemctl reboot          # Перезапускаем сервер, чтобы появился выбор языка

# Настройка UI Zabbix:
1. Выбираем язык и нажимаем [Далее]
2. Проверка предварительных условий: Проверяем что всё ОК и нажимаем [Далее]
3. Настройка подключения к БД: Вводим Пароль - zabbix
4. Настройки: Вводим Имя сервера Zabbix - Zabbix. Часовой пояс по умолчанию: (UTC+03:00) Europe/Moscow
5. Проверяем и нажимаем [Далее]

Далее логинимся под админом:
Login: Admin
Password: zabbix
```






