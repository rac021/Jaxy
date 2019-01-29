
 #########################
 # Step : Package image ##
 #########################

 FROM debian:buster-slim

 ENV DEBIAN_FRONTEND noninteractive

 ENV DEBCONF_NOWARNINGS yes

 COPY . /app/

 WORKDIR /app/

 RUN apt-get upgrade             && \
     apt-get update              && \
     apt-get install -y apt-util && \
     apt-get install -y psmisc

 ADD https://dl.grafana.com/oss/release/grafana-5.4.3.linux-amd64.tar.gz /app/

 ADD https://github.com/prometheus/prometheus/releases/download/v2.7.0/prometheus-2.7.0.linux-amd64.tar.gz /app/

 RUN tar -zxf /app/grafana-5.4.3.linux-amd64.tar.gz && rm /app/grafana-5.4.3.linux-amd64.tar.gz

 RUN tar -zxf /app/prometheus-2.7.0.linux-amd64.tar.gz && rm /app/prometheus-2.7.0.linux-amd64.tar.gz


 ENTRYPOINT ["/bin/bash", "-c", "/app/grafana_prometheus.sh && tail -f /dev/null "]

 CMD []

