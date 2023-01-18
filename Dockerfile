FROM eclipse-temurin:latest
RUN mkdir /opt/app
COPY my-app-1.0-SNAPSHOT.jar /opt/app
CMD ["java", "-jar", "/opt/app/my-app-1.0-SNAPSHOT.jar"]
