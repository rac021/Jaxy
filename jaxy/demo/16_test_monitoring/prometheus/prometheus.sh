#!/bin/bash

 help() {
 
    echo
    echo " ./prometheus.sh help                                                                                                        "
    echo
    echo " ./prometheus.sh jaxy_transport=http               : Start Prometheus with HTTP  Configuration                               "
    echo
    echo " ./prometheus.sh jaxy_transport=https              : Start Prometheus with HTTPS Configuration                               "
    echo
    echo " ./prometheus.sh monitoring_path=MY_PATH_DIRECTORY : path of the directory wich contains the monitoring Folder : datasources "
    echo
    echo " ./prometheus.sh jaxy_host=localhost               : url of Jaxy server ( in order to collect metrics )                      "
    echo
    echo " ./prometheus.sh scrape_interval=35s               : scrape interval                                                         "
    echo ; echo 
 }

 function replaceInFile() {

   old="$1"
   new="$2"
   file="$3"
 
   sed -i "s~$1~$2~g" $3
 }

 function killPrometheus()  {
	
    fuser -k 9090/tcp    
 }

 while [[ "$#" > "0" ]] ; do

     case $1 in

         (*=*) KEY=${1%%=*}
               VALUE=${1#*=}
               
               case "$KEY" in
               
                    ("jaxy_transport")   TRANSPORT=$VALUE   
                    ;; 
                    ("monitoring_path")  MONITORING_PATH=$VALUE   
                    ;;
    		    ("jaxy_host")        JAXY_HOST=$VALUE   
                    ;;
                    ("jaxy_port")        JAXY_PORT=$VALUE   
                    ;;
                    ("scrape_interval")  SCRAPE_INTERVAL=$VALUE
               esac
         ;;

         help)  help ;
                exit ;
         ;;

         stop) echo ; killPrometheus ; exit 
     esac
     shift
 done 
 
 if [ -n "$MONITORING_PATH" ] ; then 

    JAXY_MONITORING_FILES_PATH="$MONITORING_PATH"

 else 

    JAXY_MONITORING_FILES_PATH="../../monitoring_jaxy/provisioning"
 fi


 TRANSPORT=${TRANSPORT:-"http"}
 
 JAXY_HOST=${JAXY_HOST:-"localhost"} 

 JAXY_PORT=${JAXY_PORT:-"8181"} 

 SCRAPE_INTERVAL=${SCRAPE_INTERVAL:-"1s"} 

 echo ;  echo " Transport Mode  => $TRANSPORT "   

 echo ;  echo " MONITORING_PATH => $JAXY_MONITORING_FILES_PATH" ; echo 

 PROMETHEUS_PATH="prometheus-2.12.0.darwin-amd64"

 PROMETHEUS_CONF="conf/prometheus"
 

 if [ "$WANT" == "help" ] ; then
    help 
    exit 
 fi 

 
 if [ ! -d "$PROMETHEUS_PATH" ]; then
 
    echo
    echo " Oupss ! Prometheus Server not found at path [ $PROMETHEUS_PATH ] "
    echo ; exit 
 fi  

 killPrometheus

 echo

 echo
 echo " ==================================== "
 echo " ==================================== "
 echo " Starting Prometheus                  "
 echo " ==================================== "
 echo
 echo " Prometheus : http://localhost:9090   "
 echo
 echo "   MONITORING_PATH : $MONITORING_PATH "
 echo "   JAXY_TRANSPORT  : $TRANSPORT       "
 echo "   JAXY_HOST       : $JAXY_HOST       "
 echo "   JAXY_PORT       : $JAXY_PORT       "
 echo "   SCRAPE_INTERVAL : $SCRAPE_INTERVAL "
 echo
 echo " ==================================== "
 
 echo
 
 sleep 2
 
 
 if [ "$TRANSPORT" == "https" ] ; then
 
    ## HTTPS MODE 
    
    # Download the jaxy certificate that will be trusted by Prometheus
    # the "jaxy.cert" name is used in the prometheus_https.yml file  
    echo " Get JAXY Certificate to trust... "
    echo "Q" | openssl s_client -host $JAXY_HOST -port $JAXY_PORT -prexit -showcerts >  jaxy.cert
    
    # Copy the prometheus_https.yml configuration into the Prometheus dolfer
    cp $PROMETHEUS_CONF/prometheus_https.yml $PROMETHEUS_PATH 
    
    # Rename prometheus_https.yml to prometheus.yml
    mv $PROMETHEUS_PATH/prometheus_https.yml $PROMETHEUS_PATH/prometheus.yml
 
 else
 
    ## HTTP MODE 
    
    # Copy the prometheus_http.yml configuration into the Prometheus dolfer
    cp $PROMETHEUS_CONF/prometheus_http.yml $PROMETHEUS_PATH 
    
    # Rename prometheus_http.yml to prometheus.yml
    mv $PROMETHEUS_PATH/prometheus_http.yml $PROMETHEUS_PATH/prometheus.yml
 
 fi
 
 echo 


 replaceInFile  "scheme:.*"           "scheme: $TRANSPORT"                   $PROMETHEUS_PATH/prometheus.yml

 replaceInFile  "scrape_interval:.*"  "scrape_interval: $SCRAPE_INTERVAL"    $PROMETHEUS_PATH/prometheus.yml

 replaceInFile  "- targets: \[.*"     "- targets: ['$JAXY_HOST:$JAXY_PORT']" $PROMETHEUS_PATH/prometheus.yml


 cd $PROMETHEUS_PATH  && ./prometheus --config.file=prometheus.yml & # --log.level=debug



