#!/bin/bash
chown -R mysql:mysql /var/lib/mysql /var/run/mysql
/etc/init.d/mysql start

ENV_PROPS=/var/lib/tomcat7/webapps/ScadaLTS/WEB-INF/classes/env.properties

# create database scadalts if not exist
sleep 10
mysql -uroot -proot -e "create database if not exists scadalts"

# Update the IP in the env.properties
sed -i 's/localhost:8090/'`echo $DOCKER_HOST_IP`:8090'/g' $ENV_PROPS

# Start the tomcat server
/etc/init.d/tomcat7 start

# Output the log
tail -f /var/log/tomcat7/catalina.out
