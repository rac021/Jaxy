#/bin/bash

DOCKER_LOGER="/app/jaxy/docker/docker.log"

PWD_URL_LINE=`grep -m 1 'GET http://ip.*./v1' $DOCKER_LOGER |  sed 's/\/v1.*//' | sed 's/^.*http:\/\///' | sed 's/*-*//'`

PWD_URL=`echo "${PWD_URL_LINE%-*}"`

JAXY_PORT="8181"

KEYCLOAK_PORT="8180"

JAXY_URL="http://$PWD_URL-$JAXY_PORT.direct.labs.play-with-docker.com"

KEYCLOAK_URL="http://$PWD_URL-$KEYCLOAK_PORT.direct.labs.play-with-docker.com"

export JAXY_URL="$JAXY_URL"

export KEYCLOAK_URL="$KEYCLOAK_URL"

./run.sh $1 

