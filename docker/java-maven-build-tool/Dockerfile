FROM openjdk:8-jdk-alpine

ENV \
    MAVEN_HOME=/usr/share/java/maven-3 \
    MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"

RUN \
    apk --update add \
    maven \
    curl \
    tar \
    bash

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

RUN mkdir -p /root/.m2

RUN mkdir -p /code
WORKDIR /code