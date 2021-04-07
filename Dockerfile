FROM ubuntu:20.04
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt dist-upgrade -y
RUN apt install wget
RUN apt install git -y
RUN apt install default-jdk -y
RUN apt install maven -y
WORKDIR /var/opt/
RUN wget https://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-10/v10.0.5/bin/apache-tomcat-10.0.5.tar.gz
RUN tar -xvf apache-tomcat-10.0.5.tar.gz
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
RUN cd /boxfuse-sample-java-war-hello && mvn package
RUN rm -rf /var/opt/tomcat-10.0.5/webapps/*
RUN cp /var/opt/boxfuse-sample-java-war-hello/target/hello-1.0.war /var/opt/tomcat-10.0.5/webapps/
EXPOSE 8080
CMD ["/var/opt/tomcat-10.0.5/bin/catalina.sh", "start"]