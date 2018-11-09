#!/bin/sh

keytool -genkey \
	-keyalg RSA \
	-dname "cn=Mohammed Kadiri, ou=Dev, o=mkadiri, c=IN" \
	-alias mkadiri \
	-keystore /code/src/main/resources/keystore.pfx \
	-storepass changeit \
	-validity 360 \
	-keysize 2048 \
	-storetype pkcs12

/usr/bin/mvn $1