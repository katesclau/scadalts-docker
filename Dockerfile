FROM ubuntu:16.04

MAINTAINER Diego Ferreira version: 0.1

RUN ls -la
COPY ScadaBR.war /tmp/ScadaBR.war
COPY ScadaLTS.war /tmp/ScadaLTS.war
COPY context.xml /var/lib/tomcat7/conf
COPY mysql_connectors/* /usr/share/tomcat7/lib/
COPY start.sh /tmp/start.sh

RUN apt-get update && apt-get install -y \
  dos2unix \
  unzip \
  openjdk-8-jre \
  mariadb-client-10.0 \
  mariadb-server-10.0 \
  tomcat7 \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

ENV TOMCAT_RUN_USER tomcat7
ENV TOMCAT_RUN_GROUP tomcat7
ENV TOMCAT_LOG_DIR /var/log/tomcat7
ENV CATALINA_HOME /var/lib/tomcat7
ENV SCADALTS_VERSION 0.0.9.4

# Ensures that our script is runnable
RUN dos2unix /tmp/start.sh

EXPOSE 8080

ENTRYPOINT /tmp/start.sh
