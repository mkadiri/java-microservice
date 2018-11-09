#!/usr/bin/env bash

BASE_DIRECTORY=$PWD
JAVA_BUILDER_IMAGE=mkadiri/java-builder
JAVA_APP_IMAGE=mkadiri/java-microservice
JAR_FILE=java-microservice-0.1.0.jar


if [[ "$(docker images -q $JAVA_BUILDER_IMAGE 2> /dev/null)" == "" ]]; then
    echo "************************************************************"
    echo "$JAVA_BUILDER_IMAGE image doesn't exist, build it"
    echo "************************************************************"
    cd $BASE_DIRECTORY/docker/java-maven-build-tool
    docker build -t $JAVA_BUILDER_IMAGE .
fi


echo "************************************************************"
echo "Package artifact using the java-maven-build-tool container"
echo "************************************************************"

cd $BASE_DIRECTORY

docker run -ti --rm --name app \
    -v "$PWD"/pom.xml:/code/pom.xml \
    -v "$PWD"/src:/code/src \
    -v "$PWD"/target:/code/target \
    -v "$HOME"/.m2:/root/.m2 \
    $JAVA_BUILDER_IMAGE package


echo "Build docker $JAVA_APP_IMAGE image"

echo "Copy artifact to /docker/java-8 folder"
cp target/$JAR_FILE docker/java-8

cd $BASE_DIRECTORY/docker/java-8
docker build -t $JAVA_APP_IMAGE .

echo "Delete artifact"
rm $BASE_DIRECTORY/docker/java-8/$JAR_FILE

# docker volume spits out a read-only target folder, you'll be prompted for a password to delete the target folder
#sudo rm -r $BASE_DIRECTORY/target
