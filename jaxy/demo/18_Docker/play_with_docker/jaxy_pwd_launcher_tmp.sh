#/bin/bash

###################################################
### THIS SCRIPT IS A SIMPLE HACK WHICH ALLOWS #####
### DEPLOYING JAXY ON PWD WITH ONE CLICK     ######
###################################################

 DOCKER_LOGER="/app/jaxy/docker/docker.log"

 COUNT=0

 MAX_ATTEMPT=6

 while [ ! -f "$DOCKER_LOGER" ]  &&  [ $COUNT -lt $MAX_ATTEMPT ] ; do
   sleep 1
   let "COUNT++" 
 done
  
 if [ -f "$DOCKER_LOGER" ] ; then 

	JAXY_PORT=${JAXY_PORT:-"8181"} 

	WHOAMI_PORT=${WHOAMI_PORT:-"8080"} 

	exportEnvirVariable()  {

	   echo "export $1=$2" >> ~/.bashrc
	   source ~/.bashrc
	}

	function replaceInFile() {

	   old="$1"
	   new="$2"
	   file="$3"

	   sed -i "s~$1~$2~g" $3
	}

	if [ ! -f ~/.bashrc ]; then
	    touch ~/.bashrc
	fi

	echo 

	PWD_SUB_URL=""

	COUNT=0

	MAX_ATTEMPT=30

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

	    done < <(  grep -m 10 'GET http://ip.*./v1' $DOCKER_LOGER | sed 's/\/v1.*//'  | \
							sed 's/^.*http:\/\///'            | \
							sed 's/*-*//'                     | \
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
	exportEnvirVariable "JAXY_PORT"  "$JAXY_PORT"
	exportEnvirVariable "JAXY_URL"   "$JAXY_URL"

	echo 
	echo " ============================== "
	echo " - JAXY_URL     : $JAXY_URL     "


	if [[ -n  "$KEYCLOAK_PORT"  ]] ; then 

	  KEYCLOAK_URL="http://$PWD_SUB_URL-$KEYCLOAK_PORT.direct.labs.play-with-docker.com"

	  serviceConfLocation="jaxy/demo/18_Docker/jaxy_test_for_docker/sso_keycloak_auth/serviceConf.yaml"
	  HttpkeycloakFileLocation="jaxy/demo/18_Docker/jaxy_test_for_docker/sso_keycloak_auth/keyCloak/keyCloak_http.json"
	  HttspkeycloakFileLocation="jaxy/demo/18_Docker/jaxy_test_for_docker/sso_keycloak_auth/keyCloak/keyCloak_https.json"

	  if [[ -f $serviceConfLocation ]] ; then 

		  replaceInFile "http://.*/protocol/openid-connect/token"                          \
				"$KEYCLOAK_URL/auth/realms/my_realm/protocol/openid-connect/token" \
				 $serviceConfLocation           
	      fi 

	      if [[ -f $HttpkeycloakFileLocation ]] ; then 

		  replaceInFile  "\"auth-server-url\":.*"                         \
				 "\"auth-server-url\": \"$KEYCLOAK_URL/auth\" , " \
				 $HttpkeycloakFileLocation         
	      fi 

	      if [[ -f $HttpskeycloakFileLocation ]] ; then 

		   replaceInFile  "\"auth-server-url\":.*"                         \
				  "\"auth-server-url\": \"$KEYCLOAK_URL/auth\" , " \
				  $HttpskeycloakFileLocation        
	  fi 


	  echo " - KEYCLOAK_URL : $KEYCLOAK_URL "

	fi 

	echo " ============================== " ; echo

	./run.sh $1 
 else 
 
	./run.sh $1 
 fi
