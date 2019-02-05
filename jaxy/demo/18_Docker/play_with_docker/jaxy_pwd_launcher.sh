#/bin/bash

DOCKER_LOGER="/app/jaxy/docker/docker.log"

exportEnvirVariable()  {

   echo "export $1=$2" >> ~/.bashrc
   source ~/.bashrc

}
 
if [ ! -f ~/.bashrc ]; then
    touch ~/.bashrc
fi
 
echo 

PWD_URL=""

COUNT=10

MAX_ATTEMP=20

while [[ ! -n  "$PWD_URL"  ]] &&  [ $COUNT -lt $MAX_ATTEMP ] ; do           

    while read -r url ; do 
	
       URL=`echo "${url%-*}"`
	    URL="$URL-5432.direct.labs.play-with-docker.com"
   	 echo " -- Check URL : $URL"   
       
       CODE_RESPONSE=`curl -s -o /dev/null -w "%{http_code}" $URL` ;

       if [ "$CODE_RESPONSE" -ne "000" ] ; then 
		        PWD_URL="$URL"
		        break 
       fi
            
    done < <(  grep -m 10 'GET http://ip.*./v1' $DOCKER_LOGER | sed 's/\/v1.*//'  |  \
                                                sed 's/^.*http:\/\///'            |  \
                                                sed 's/*-*//'                     |  \
                                                sort --unique                     )
    sleep 3
    let "COUNT++"            
    
done

if [[ ! -n "$PWD_URL" ]] ; then 
      echo
      echo " NO PWD_URL EXTRACTED ! "
      echo " Exit ... " ; echo 
      exit     
fi
       
echo ; echo " PWD_URL --> $PWD_URL" 
echo ; echo 

# Export Values 

exportEnvirVariable "JAXY_PORT"     "8181"

exportEnvirVariable "KEYCLOAK_PORT" "8180"

exportEnvirVariable "JAXY_URL"      "$PWD_URL-$JAXY_PORT.direct.labs.play-with-docker.com"

exportEnvirVariable "KEYCLOAK_URL"  "$PWD_URL-$KEYCLOAK_PORT.direct.labs.play-with-docker.com"

echo 
echo " ============================== "
echo " - JAXY_URL     : $JAXY_URL     "
echo " - KEYCLOAK_URL : $KEYCLOAK_URL "
echo " ============================== "
echo

./run.sh $1 

