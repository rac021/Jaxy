#!/bin/bash

 help() {
 
    echo
    echo "  ./grafana.sh help  : display help                                                                                                 "
    echo
    echo "  ./grafana    stop  : Stop Grafana server                                                                                          "

    echo "  ./grafana MONITORING_PATH=MY_PATH_DIRECTORY : path of the directory wich contains the monitoring files : dashboards + datasources "
    echo "    Ex => ./grafana MONITORING_PATH=monitoring_jaxy/provisioning                                                                    " 
    echo
    echo "  ./grafana PROMETHEUS_URL=Prometheus_URL : provide the URL of Prometheus server                                                    "
    echo "    Ex => ./grafana PROMETHEUS_URL=http://localhost:9090                                                                            " 
    echo
 }

 function killGrafana()  {
	
    fuser -k 3000/tcp    
 }

 function replaceInFile() {

   old="$1"
   new="$2"
   file="$3"
 
   sed -i "s~$1~$2~g" $3
 }

 while [[ "$#" > "0" ]] ; do

     case $1 in

         (*=*) KEY=${1%%=*}
               VALUE=${1#*=}
               
               case "$KEY" in
               
                    ("MONITORING_PATH") MONITORING_PATH=$VALUE   
                    ;; 
                    ("prometheus_url")  PROMETHEUS_URL=$VALUE   
                    ;;                    
               esac
         ;;

         help)  help ;
                exit ;
         ;;

         stop) echo ; killGrafana ; exit 
     esac
     shift
  done   


 if [ -n "$MONITORING_PATH" ] ; then # Docker deployment 

    JAXY_MONITORING_FILES_PATH="$MONITORING_PATH"

 else 

    JAXY_MONITORING_FILES_PATH="../../monitoring_jaxy/provisioning"
 fi

 echo ;  echo " MONITORING_PATH => $JAXY_MONITORING_FILES_PATH" ; echo 

 GRAFANA_PATH="grafana-6.3.5"

 GRAFANA_CONF="conf/grafana"

 JAXY_PROVISIONING_DASHBOARD_PATH="provisioning/dashboards"

 JAXY_PROVISIONING_DATASOURCE_PATH="provisioning/datasources"

 GRAFANA_DATASOURCE_FILE="jaxy_grafana_datasource.yaml"

 JAXY_PROVISIONING_DATASOURCE_GRAFANA=$GRAFANA_PATH/conf/$JAXY_PROVISIONING_DATASOURCE_PATH"/$GRAFANA_DATASOURCE_FILE"

 
 PROMETHEUS_URL=${PROMETHEUS_URL:-"http://localhost:9090"} 

 if [ "$WANT" == "help" ] ; then # SET VIA ENVIRONNEMENT VARIABLE 
    help ;  exit 
 fi 

 if [ ! -d "$GRAFANA_PATH" ]; then
 
    echo
    echo " Oupss ! Grafana Server not found at path [ $GRAFANA_PATH ] "
    echo ; exit 
 fi
 
 # kill grafana service 
 killGrafana
 
 COUNT=0 # Wait For jaxy to Provide the Provisioning Directory ( Max : 150 * 2 seconds ) 
 
 # Wait until Jaxy Creates TWO directories : "datasources" AND "dashboard" in the Folder $JAXY_MONITORING_FILES_PATH

 while [ "$( find $JAXY_MONITORING_FILES_PATH -mindepth 1 -maxdepth 1 -type d 2>&1 | wc -l)" -ne 2 ] && 
       [ $COUNT -lt 150 ] ; do
    
     sleep 2
     let   "COUNT++"            
     echo  " Wait for The Provisioning Directory : [ $JAXY_MONITORING_FILES_PATH ] ... "
 done
  
 sleep 2 
 
 if [ ! -d "$JAXY_MONITORING_FILES_PATH" ]; then
 
    echo
    echo " No provisioning where generated ! "
    echo ; exit 
 fi
 
 if [ -d "provisioning" ]; then
 
    rm -rf provisioning 
 fi
 
 cp -r $JAXY_MONITORING_FILES_PATH .
 
 echo

 if [ -d "$JAXY_PROVISIONING_DASHBOARD_PATH" ]; then
 
    echo " ++ Installing [ $JAXY_PROVISIONING_DASHBOARD_PATH ] "
    cp $JAXY_PROVISIONING_DASHBOARD_PATH/*.*  \
       $GRAFANA_PATH/conf/$JAXY_PROVISIONING_DASHBOARD_PATH/
 else  
    echo 
    echo " ++ Folder [ $JAXY_PROVISIONING_DASHBOARD_PATH ] NOT FOUND ! "
    echo
 fi

 if [ -d "$JAXY_PROVISIONING_DATASOURCE_PATH" ]; then
 
    echo " ++ Installing [ $JAXY_PROVISIONING_DATASOURCE_PATH ] "
    
    cp $JAXY_PROVISIONING_DATASOURCE_PATH/*.* \
       $GRAFANA_PATH/conf/$JAXY_PROVISIONING_DATASOURCE_PATH/
 else 
 
    echo 
    echo " ++ Folder [ $JAXY_PROVISIONING_DATASOURCE_PATH ] NOT FOUND ! "
    echo
 fi

 if [ -f "$GRAFANA_CONF/sample.yaml" ]; then 
 
    echo 
    cp $GRAFANA_CONF/sample.yaml $GRAFANA_PATH/conf/$JAXY_PROVISIONING_DASHBOARD_PATH
 fi

 if [ -f "$JAXY_PROVISIONING_DATASOURCE_GRAFANA" ] &&  [ -n "$PROMETHEUS_URL" ] ; then 
 
    # Update URL OF Prometheus in the file $GRAFANA_DATASOURCE_FILE 
    # Must be provided via environnement variable : PROMETHEUS_URL 

    replaceInFile "url:.*" "url: $PROMETHEUS_URL" $JAXY_PROVISIONING_DATASOURCE_GRAFANA
 fi
 
 echo
 echo " ======================================= "
 echo " ======================================= "
 echo " Starting Grafana                        "
 echo " ======================================= "
 echo

 echo " Grafana        : http://localhost:3000  "
 echo " Prometheus URL : $PROMETHEUS_URL        "
 echo
 echo " ======================================= "
 echo
 
 sleep 2
   
 echo 
 
 cd $GRAFANA_PATH/bin && ./grafana-server &
 
 

