#!/bin/bash
if [ "$1" = "on" ]; then
sed -i "s/autoindex [onf]*/autoindex on/" /etc/nginx/sites-available/localhost
echo 'autoindex enable'
service nginx restart
fi
if [ "$1" = "off" ]; then
sed -i "s/autoindex [onf]*/autoindex off/" /etc/nginx/sites-available/localhost
echo 'autoindex disable'
service nginx restart
fi
grep -w "autoindex" /etc/nginx/sites-available/localhost
