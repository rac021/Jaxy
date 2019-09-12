 #########################
 # Step : Package image ##
 #########################

 FROM debian:buster-slim

 ENV DEBIAN_FRONTEND noninteractive

 ENV DEBCONF_NOWARNINGS yes

 COPY . /app/

 WORKDIR /app/

 RUN apt-get upgrade              && \
     apt-get update               && \
     apt-get install -y apt-utils && \
     apt-get install -y psmisc

 ADD https://dl.grafana.com/oss/release/grafana-6.3.5.linux-amd64.tar.gz /app/

 RUN tar -zxf /app/grafana-6.3.5.linux-amd64.tar.gz && rm /app/grafana-6.3.5.linux-amd64.tar.gz

 ENTRYPOINT ["/bin/bash", "-c", "/app/grafana.sh && tail -f /dev/null "]

 CMD []

