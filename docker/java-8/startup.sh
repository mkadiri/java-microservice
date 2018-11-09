#!/bin/sh


echo "Starting application"


while ! mysqladmin ping -h $MYSQL_HOST -u $MYSQL_USER -P $MYSQL_PORT --password=$MYSQL_PASSWORD --silent; do
    echo "Waiting for mysql to wake up, checking port $MYSQL_PORT"
    sleep 5
done


echo "Execute jar"
cd /

# enable remote debugging
#
# optimise JVM
# https://github.com/dsyer/spring-boot-memory-blog/blob/master/cf.md
# run `java -X`
# -Xms<size>        set initial Java heap size
# -Xmx<size>        set maximum Java heap size
# -Xss<size>        set java thread stack size
# -XX:MetaspaceSize sets the size of the allocated class metadata space that will trigger a garbage collection the first time it is exceeded.
#                   This threshold for a garbage collection is increased or decreased depending on the amount of metadata used.
#
# https://stackoverflow.com/questions/44491257/how-to-reduce-spring-boot-memory-usage
# -XX:+UseSerialGC  This will perform garbage collection inline with the thread allocating the heap memory instead of a dedicated GC thread(s)
# -XX:MaxRAM=72m This will restrict the JVM's calculations for the heap and non heap managed memory to be within the limits of this value.
#
# for improvements look possibly at https://medium.com/@matt_rasband/dockerizing-a-spring-boot-application-6ec9b9b41faf
JAVA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=8001,server=y,suspend=n \
    -Xms50m \
    -Xmx54613K \
    -Xss568K \
    -XX:MetaspaceSize=64M \
    -XX:+UseSerialGC \
    -XX:MaxRAM=72m"

java $JAVA_OPTS -jar application.jar -e