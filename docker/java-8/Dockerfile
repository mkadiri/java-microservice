FROM alpine:3.7

ENV \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

RUN \
		apk --update add \
			openjdk8-jre \
		    mysql-client \
  			ca-certificates && \
	\
        update-ca-certificates && \
	\
		rm -rf \
			/tmp/* \
			/var/cache/apk/*

EXPOSE 8080

COPY java-microservice-0.1.0.jar application.jar

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

CMD ["/startup.sh"]