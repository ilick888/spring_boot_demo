FROM maven:3.6.1-jdk-8 as builder
RUN mkdir -p /opt/java/src
COPY . /opt/java/
RUN cd /opt/java && mvn install

FROM openjdk:8-jre-alpine
RUN mkdir -p /opt/app/
COPY --from=builder /opt/java/target/hello-world-0.0.1.jar /opt/app/
EXPOSE 8080
CMD  ["java","-jar","/opt/app/hello-world-0.0.1.jar"]
