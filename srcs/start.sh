#start services
service nginx start
service php7.3-fpm start
service mysql start

#create database
mysql -e "CREATE USER 'kwillum'@'localhost' IDENTIFIED BY 'admin';"
mysql -e "CREATE DATABASE kwillum_database;"
mysql -e "GRANT ALL PRIVILEGES ON kwillum_database.* TO 'kwillum'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

#wp installation
my_email="daniilxod@gmail.com"
curl --data "weblog_title=Kwillum site&user_name=admin&admin_password=admin&admin_password2=admin&admin_email=$my_email" localhost/wp-admin/install.php?step=2

#create loop
bash
