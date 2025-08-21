FROM jenkins/jenkins:lts

# Отключаем setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Копируем список плагинов и устанавливаем их
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Копируем скрипты инициализации
COPY init.groovy.d /usr/share/jenkins/ref/init.groovy.d

FROM anapsix/alpine-java
LABEL maintainer="igorigoriak@gmail.com"
COPY /target/spring-petclinic-1.5.1.jar /home/spring-petclinic-1.5.1.jar
CMD ["java","-jar","/home/spring-petclinic-1.5.1.jar"]
