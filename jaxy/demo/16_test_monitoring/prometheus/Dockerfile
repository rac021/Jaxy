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
     apt-get install -y openssl   && \
     apt-get install -y psmisc

 ADD https://github.com/prometheus/prometheus/releases/download/v2.12.0/prometheus-2.12.0.linux-amd64.tar.gz /app/

 RUN tar -zxf /app/prometheus-2.12.0.linux-amd64.tar.gz && rm /app/prometheus-2.12.0.linux-amd64.tar.gz


 ENTRYPOINT ["/bin/bash", "-c", "/app/prometheus.sh && tail -f /dev/null "]

 CMD []
