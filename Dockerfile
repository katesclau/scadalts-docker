FROM ubuntu:16.04

MAINTAINER Diego Ferreira version: 0.1

RUN apt-get update && apt-get install -y openjdk-8-jre  mysql-client mariadb-server tomcat7 && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV TOMCAT_RUN_USER tomcat7
ENV TOMCAT_RUN_GROUP tomcat7
ENV TOMCAT_LOG_DIR /var/log/tomcat7
ENV CATALINA_HOME /var/lib/tomcat7

ADD ./scadalts-setup.sh /tmp/scadalts-setup.sh
ADD ./ScadaBR.war /tmp/ScadaBR.war
ADD ./ScadaLTS.war /tmp/ScadaLTS.war
ADD ./start.sh /tmp/start.sh

EXPOSE 8090

CMD /tmp/start.sh
