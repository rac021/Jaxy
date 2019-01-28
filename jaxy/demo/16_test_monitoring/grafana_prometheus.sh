#!/bin/bash

 # Example Cmd  : ./grafana_prometheus.sh help  # Print Help
 
 ## Example Cmd : ./grafana_prometheus.sh http  # Start Prometheus with Http  Configuration then grafana

 ## Example Cmd : ./grafana_prometheus.sh https # Start Prometheus with Https Configuration then grafana 

 ## Example Cmd : ./grafana_prometheus.sh stop  # Stop  Prometheus then grafana
 
 echo ;  echo " Transport Mode  => $TRANSPORT "   

 echo ;  echo " MONITORING_PATH => $MONITORING_PATH" ; echo 
 
 if [ -n "$WAIT" ] ; then
    
   SLEEP=$(($WAIT * 1))
   echo " Wait for Jaxy. $WAIT s... " ; echo ; sleep $SLEEP
 
 fi

 if [ -n "$MONITORING_PATH" ] ; then # Docker deployment 

    JAXY_MONITORING_FILES_PATH="$MONITORING_PATH"

 else 

    JAXY_MONITORING_FILES_PATH="../../monitoring_jaxy/provisioning"
 fi


 GRAFANA_PATH="grafana-5.4.3"

 PROMETHEUS_PATH="prometheus-2.6.0.linux-amd64"

 JAXY_PROVISIONING_DASHBOARD_PATH="provisioning/dashboards"

 JAXY_PROVISIONING_DATASOURCE_PATH="provisioning/datasources"

 PROMETHEUS_CONF="conf/prometheus"
 
 GRAFANA_CONF="conf/grafana"
 
 help() {
 
    echo
    echo " ./grafana_prometheus.sh http  : Start Prometheus with HTTP  Configuration Then Grafana "
    echo
    echo " ./grafana_prometheus.sh https : Start Prometheus with HTTPS Configuration Then Grafana "
    echo
    echo " ./grafana_prometheus.sh stop  : Stop  Prometheus Then Grafana                          "
    echo
 }

 if [ "$1" == "help" ] || [ "$WANT" == "help" ] ; then
    help 
    exit 
 fi 

 if [ ! -d "$GRAFANA_PATH" ]; then
 
    echo
    echo " Oupss ! Grafana Server not found at path [ $GRAFANA_PATH ] "
    echo ; exit 
 fi
 
  if [ ! -d "$PROMETHEUS_PATH" ]; then
 
    echo
    echo " Oupss ! Prometheus Server not found at path [ $PROMETHEUS_PATH ] "
    echo ; exit 
 fi
 
  
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

 
 if [ "$1" == "stop" ] ; then
    
    echo
    
    # kill prometheus service
    fuser -k 9090/tcp
 
    # kill grafana service 
    fuser -k 3000/tcp
 
    exit 
 fi 
   
 # kill prometheus service
 fuser -k 9090/tcp
 
 # kill grafana service 
 fuser -k 3000/tcp
 
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
    cp $GRAFANA_CONF/sample.yaml $GRAFANA_PATH/conf/provisioning/dashboards/
 fi

 echo
 echo " =================================== "
 echo " =================================== "
 echo " Starting Prometheus + Grafana       "
 echo " =================================== "
 echo
 
 echo " Prometheus : http://localhost:9090  "
 echo " Grafana    : http://localhost:3000  "
 echo
 
 sleep 2
 
 
 if [ "$1" == "https" ] || [ "$TRANSPORT" == "https" ] ; then
 
    ## HTTPS MODE 
    
    # Download the jaxy certificate that will be trusted by Prometheus
    # the "jaxy.cert" name is used in the prometheus_https.yml file  
    echo "Q" | openssl s_client -host localhost -port 8443 -prexit -showcerts >  jaxy.cert
    
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
 
 cd $PROMETHEUS_PATH  && ./prometheus --config.file=prometheus.yml & # --log.level=debug

 
 if [ -n "$MONITORING_PATH" ] ; then # Docker deployment 

     cd $GRAFANA_PATH/bin && ./grafana-server 

 else 

     cd $GRAFANA_PATH/bin && ./grafana-server &

 fi
