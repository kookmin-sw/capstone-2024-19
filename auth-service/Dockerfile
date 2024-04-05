FROM azul/zulu-openjdk:17
ENV PROFILE deploy
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-Dspring.profiles.active=${PROFILE}","-jar","/app.jar"]