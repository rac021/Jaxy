#/bin/bash

DOCKER_LOGER="/app/jaxy/docker/docker.log"

JAXY_PORT="8181"

KEYCLOAK_PORT="8180"

WHOAMI_PORT=${WHOAMI_PORT:-"8080"} 

exportEnvirVariable()  {

   echo "export $1=$2" >> ~/.bashrc
   source ~/.bashrc

}
 
if [ ! -f ~/.bashrc ]; then
    touch ~/.bashrc
fi
 
echo 

PWD_SUB_URL=""

COUNT=0

MAX_ATTEMPT=100

while [[ ! -n  "$PWD_SUB_URL"  ]] &&  [ $COUNT -lt $MAX_ATTEMPT ] ; do           

    while read -r url ; do 
	
       SUB_URL=`echo "${url%-*}"`
       TEST_URL="$SUB_URL-$WHOAMI_PORT.direct.labs.play-with-docker.com"
       echo " -- Check URL : $TEST_URL"   
       
       CODE_RESPONSE=`curl -s -o /dev/null -w "%{http_code}" $TEST_URL`

       if [ "$CODE_RESPONSE" -ne "000" ] ; then 
	     PWD_SUB_URL="$SUB_URL"
	     break 
       fi
            
    done < <(  grep -m 10 'GET http://ip.*./v1' $DOCKER_LOGER | sed 's/\/v1.*//'  |  \
                                                sed 's/^.*http:\/\///'            |  \
                                                sed 's/*-*//'                     |  \
                                                sort --unique                     )
    sleep 3
    let "COUNT++"            
    
done

if [[ ! -n "$PWD_SUB_URL" ]] ; then 
    echo
    echo " NO PWD_URL EXTRACTED ! "
    echo " Exit ... " ; echo 
    exit     
fi

echo ; echo " PWD_URL --> $PWD_URL" 
echo ; echo 

# Export Values 

JAXY_URL="$PWD_SUB_URL-$JAXY_PORT.direct.labs.play-with-docker.com"

KEYCLOAK_URL="$PWD_SUB_URL-$KEYCLOAK_PORT.direct.labs.play-with-docker.com"

exportEnvirVariable "JAXY_PORT"     "$JAXY_PORT"

exportEnvirVariable "KEYCLOAK_PORT" "$KEYCLOAK_PORT"

exportEnvirVariable "JAXY_URL"      "$JAXY_URL"

exportEnvirVariable "KEYCLOAK_URL"  "$KEYCLOAK_URL"

echo 
echo " ============================== "
echo " - JAXY_URL     : $JAXY_URL     "
echo " - KEYCLOAK_URL : $KEYCLOAK_URL "
echo " ============================== "
echo

./run.sh $1 

