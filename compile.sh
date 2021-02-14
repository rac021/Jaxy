#!/bin/bash

  CURRENT_LOCATION=`pwd`/src
  
  DEMO_PATH="jaxy"

  cd $CURRENT_LOCATION/dependencies/01_jaxy-api && mvn clean install -Dmaven.test.skip=true -Dhttps.protocols=TLSv1.2
  
  if [[ "$?" -ne 0 ]] ; then
     echo 'Could not perform mvn clean install -Dmaven.test.skip=true'
     exit $rc
  else 
     mvn clean 
  fi
  
  cd $CURRENT_LOCATION/dependencies/02_jaxy-security-provider && mvn clean install -Dmaven.test.skip=true 
  
  if [[ "$?" -ne 0 ]] ; then
     echo 'Could not perform mvn clean install -Dmaven.test.skip=true'
     exit $rc
  else 
     mvn clean 
  fi
  
  cd $CURRENT_LOCATION/dependencies/03_jaxy-service-discovery &&  mvn clean install -Dmaven.test.skip=true 
  
  if [[ "$?" -ne 0 ]] ; then
     echo 'Could not perform mvn clean install -Dmaven.test.skip=true'
     exit $rc
  else 
     mvn clean 
  fi  

  ## Compile certMe for generating letsEncrypt Certificates
  
  cd $CURRENT_LOCATION/dependencies/04_certMe &&  mvn clean install assembly:single -Dmaven.test.skip=true

  CERT_ME_PATH="../../../$DEMO_PATH/lib"

  if [ ! -d "$CERT_ME_PATH" ]; then
 
    mkdir $CERT_ME_PATH
 
  fi
    
  mv target/certMe.jar $CERT_ME_PATH/certMe.jar
  
  rm -rf $CURRENT_LOCATION/dependencies/04_certMe/target

  ## Compile jaxyClient ( that will be downloaded by users from UI ) 
  
  cd $CURRENT_LOCATION/dependencies/05_jaxyClient &&  mvn clean install assembly:single -Dmaven.test.skip=true
  
  if [[ "$?" -ne 0 ]] ; then
     echo 'Could not perform mvn clean install assembly:single -Dmaven.test.skip=true'
     exit $rc
  else 
     mvn clean 
  fi

  if [ ! -d "../../jaxy/src/main/resources/jaxy-client/" ]; then
  
    mkdir ../../jaxy/src/main/resources/jaxy-client/ # Create the directory jaxy-client in the jaxy project
  
  fi
  
  mv target/jaxyClient.jar ../../jaxy/src/main/resources/jaxy-client/jaxyClient.jar
  
  rm -rf $CURRENT_LOCATION/dependencies/05_jaxyClient/target

  
  cd $CURRENT_LOCATION/jaxy/
  
  if [ "$1" == "m2repo" ]; then
  
      # Compile m2repo Profile 
  
      mvn clean package -Pm2repo -Dmaven.test.skip=true
    
  else
  
    # FatJar Compilation
     
     mvn clean package -Dmaven.test.skip=true
  
  fi
  
  if [[ "$?" -ne 0 ]] ; then
     echo 'Could not perform mvn clean install -Dmaven.test.skip=true'
     exit $rc
  else 
     mvn clean 
  fi 
  
  # Copy jaxy-thorntail to $DEMO_PATH
  
  if [ -f "$CURRENT_LOCATION/jaxy/target/jaxy-thorntail.jar" ]; then
 
    if [ -f "$DEMO_PATH/jaxy-thorntail.jar" ]; then
    
        rm $DEMO_PATH/jaxy-thorntail.jar
    
    fi
    
    mv $CURRENT_LOCATION/jaxy/target/jaxy-thorntail.jar ../../$DEMO_PATH/jaxy-thorntail.jar
 
    rm -rf $CURRENT_LOCATION/jaxy/target
 
  fi

