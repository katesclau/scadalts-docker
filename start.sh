#!/bin/bash

# This script depends on DOCKER_HOST_IP
if [ -z "$DOCKER_HOST_IP" ]; then
    echo "Need to set DOCKER_HOST_IP"
    exit 1
fi

chown -R mysql:mysql /var/lib/mysql /var/run/mysql
/etc/init.d/mysql start

WEBAPPS=/var/lib/tomcat7/webapps
ENV_PROPS="$WEBAPPS/ScadaBR/WEB-INF/classes/env.properties"

# Unpack WAR files into webapps
# ScadaBR
mkdir /var/lib/tomcat7/webapps/ScadaBR
cd /var/lib/tomcat7/webapps/ScadaBR/
unzip /tmp/ScadaBR.war

# ScadaLTS
mkdir /var/lib/tomcat7/webapps/ScadaLTS
cd /var/lib/tomcat7/webapps/ScadaLTS/
unzip /tmp/ScadaLTS.war

# Grant permission
chown -R tomcat7.tomcat7 /var/lib/tomcat7/webapps

# create database scadalts if not exist
sleep 10
mysql -uroot -proot -e "create user 'scadalts'@'localhost' identified by 'scadalts'; \
    create database if not exists scadalts; \
    grant all privileges on scadalts.* to 'scadalts'@'localhost'; \
    flush privileges;"

# Update the IP in the env.properties
sed -i 's/localhost:8080/'`echo $DOCKER_HOST_IP`:8080'/g' $ENV_PROPS

# Start the tomcat server
/etc/init.d/tomcat7 start

# Output the log
tail -f /var/log/tomcat7/catalina.out
