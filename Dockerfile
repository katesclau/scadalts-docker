FROM ubuntu:16.04

MAINTAINER Diego Ferreira version: 0.1

RUN apt-get update && apt-get install -y dos2unix unzip openjdk-8-jre  mariadb-client-10.0 mariadb-server-10.0 tomcat7 && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV TOMCAT_RUN_USER tomcat7
ENV TOMCAT_RUN_GROUP tomcat7
ENV TOMCAT_LOG_DIR /var/log/tomcat7
ENV CATALINA_HOME /var/lib/tomcat7

ADD ./ScadaBR.war /tmp/ScadaBR.war
ADD ./ScadaLTS.war /tmp/ScadaLTS.war
ADD ./context.xml /var/lib/tomcat7/conf
ADD ./mysql-connector-java-3.1.8-bin.jar /usr/share/tomcat7/lib/
ADD ./mysql-connector-java-5.1.7-bin.jar /usr/share/tomcat7/lib/
ADD ./mysql-connector-java-5.1.38-bin.jar /usr/share/tomcat7/lib/
ADD ./start.sh /tmp/start.sh

# Ensures that our script is runnable
RUN dos2unix /tmp/start.sh

EXPOSE 8080

CMD /tmp/start.sh
