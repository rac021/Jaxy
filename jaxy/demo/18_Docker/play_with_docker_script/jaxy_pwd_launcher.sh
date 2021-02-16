#!/bin/bash

###################################################
### THIS SCRIPT IS A SIMPLE HACK WHICH ALLOWS #####
### DEPLOYING JAXY ON PWD WITH ONE CLICK     ######
###################################################

 ARG="$1"
 
 while [[ "$#" > "0" ]] ; do
 
  case $1 in
  
      (*=*) KEY=${1%%=*}
      
            VALUE=${1#*=}
            
            case "$KEY" in
                               
                ("serviceConf") serviceConf=$VALUE
                
            esac
      ;;
      
  esac
  
  shift
  
 done   
 
 echo ; echo " #### serviceConf : $serviceConf " ; echo
 
 DOCKER_LOGER="/app/jaxy/docker/docker.log"

 if [[ -n "$SESSION_ID" ]] && [[ -n "$PWD_HOST_FQDN" ]]  && [[ -n "$DIND_COMMIT" ]] ; then # IN PWD
	
	 echo ; echo " In Play With Docker .. " ; echo  
	 COUNT=0
	 MAX_ATTEMPT=15
 
	while [ ! -f "$DOCKER_LOGER" ]  &&  [ $COUNT -lt $MAX_ATTEMPT ] ; do
	   sleep 1
	   let "COUNT++" 
	done
  
  	if [ ! -f "$DOCKER_LOGER" ] ; then 
	     echo " NO DOCKER LOG FILE FOUND !"
	     echo ; echo " Exit ... " ; echo
	     exit
	fi
	
	JAXY_PORT=${JAXY_PORT:-"8181"} 

	exportEnvirVariable()   {

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

	MAX_ATTEMPT=60

	while [[ ! -n  "$PWD_SUB_URL"  ]] &&  [ $COUNT -lt $MAX_ATTEMPT ] ; do           

	    while read -r url ; do 

               if [[ "$url" == *"$SESSION_ID"* ]]; then # URL Contains SESSION_ID ?
	       
		  SUB_URL=`echo "${url%-*}"`
         	  PWD_SUB_URL="$SUB_URL"
	          break 
	       fi	       

	    done < <(  grep -m 10 'GET http://ip.*./v1' $DOCKER_LOGER | sed 's/\/v1.*//'  | \
						        sed 's/^.*http:\/\///'            | \
						        sed 's/*-*//'                     | \
						        sort --unique                     )
	    sleep 1
	    let "COUNT++"            

	done

	if [[ ! -n "$PWD_SUB_URL" ]] ; then 
	    echo
	    echo " NO PWD_URL EXTRACTED ! "
	    echo " Exit ... " ; echo 
	    exit     
	fi

	# Export Values 

	JAXY_URL="$PWD_SUB_URL-$JAXY_PORT.direct.labs.play-with-docker.com"
	
	exportEnvirVariable "JAXY_PORT"  "$JAXY_PORT"
	exportEnvirVariable "JAXY_URL"   "$JAXY_URL"

	# Override MANAGEMENT_ALLOWED_ORIGIN in $serviceConf
        replaceInFile "MANAGEMENT_ALLOWED_ORIGIN.*:.*"                \
		      "MANAGEMENT_ALLOWED_ORIGIN  : http://$JAXY_URL" \
		      $serviceConf
				 
	echo 
	echo " =================================== "
	echo 
	echo " - JAXY_URL     : $JAXY_URL          "
	
	if [[ -n  "$KEYCLOAK_PORT"  ]] ; then 

	  KEYCLOAK_URL="http://$PWD_SUB_URL-$KEYCLOAK_PORT.direct.labs.play-with-docker.com"

	  HttpkeycloakFileLocation="demo/18_Docker/jaxy_test_for_docker/sso_keycloak_auth/keyCloak/keyCloak_http.json"
	  HttspkeycloakFileLocation="demo/18_Docker/jaxy_test_for_docker/sso_keycloak_auth/keyCloak/keyCloak_https.json"

	  if [[ -f $serviceConf ]] ; then 

	 	  replaceInFile "http://.*/protocol/openid-connect/token"                          \
				"$KEYCLOAK_URL/auth/realms/my_realm/protocol/openid-connect/token" \
				 $serviceConf
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

	  echo ; echo " - KEYCLOAK_URL : $KEYCLOAK_URL "
	  
	fi
	
	 echo ; echo " =================================== " ; echo
	 
	 ( . ./run.sh $ARG )
 
 else 
 	echo ; echo " Docker-compose .. " ; echo 

	( . ./run.sh $ARG )
 fi

