#/bin/bash

exportEnvirVariable()  {

   echo "export $1=$2" >> ~/.bashrc
   source ~/.bashrc

}
 
if [ ! -f ~/.bashrc ]; then
    touch ~/.bashrc
fi

DOCKER_LOGER="/app/jaxy/docker/docker.log"

PWD_URL_LINE=`grep -m 1 'GET http://ip.*./v1' $DOCKER_LOGER | sed 's/\/v1.*//' | sed 's/^.*http:\/\///' | sed 's/*-*//'`

PWD_URL=`echo "${PWD_URL_LINE%-*}"`

# Export Values 

exportEnvirVariable "JAXY_PORT"     "8181"

exportEnvirVariable "KEYCLOAK_PORT" "8180"

exportEnvirVariable "JAXY_URL"      "$PWD_URL-$JAXY_PORT.direct.labs.play-with-docker.com"

exportEnvirVariable "KEYCLOAK_URL"  "http://$PWD_URL-$KEYCLOAK_PORT.direct.labs.play-with-docker.com"

echo 
echo " ============================== "
echo " - JAXY_URL     : $JAXY_URL     "
echo " - KEYCLOAK_URL : $KEYCLOAK_URL "
echo " ============================== "
echo

./run.sh $1 

