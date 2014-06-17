from ubuntu:14.04

# make sure the package repository is up to date
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

# automatically accept oracle license
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
# and install java 7 oracle jdk
RUN apt-get -y install oracle-java7-installer && apt-get clean
RUN update-alternatives --display java
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment

RUN apt-get clean

ADD http://www.camunda.org/release/camunda-bpm/tomcat/7.1/camunda-bpm-tomcat-7.1.0-Final.tar.gz /var/www/
WORKDIR /var/www
RUN tar xf camunda-bpm-tomcat-7.1.0-Final.tar.gz

EXPOSE 8080

CMD ["/bin/bash", "server/apache-tomcat-7.0.50/bin/catalina.sh", "run"]
