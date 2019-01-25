
########################
# Step : Compile Jaxy ##
########################

FROM maven:3.6.0-jdk-8-alpine as compilation_stage

ADD src/ /tmp/src

ADD jaxy/ /tmp/jaxy

COPY compile.sh /tmp/

WORKDIR /tmp

RUN ./compile.sh 


#########################
# Step : Package image ##
#########################

FROM openjdk:8u181-jdk-stretch

COPY run.sh /app/

WORKDIR /app/

COPY --from=compilation_stage /tmp/jaxy/ /app/jaxy


ENTRYPOINT ["/bin/bash", "-c", "/app/run.sh serviceConf=service/serviceConf.yaml"]

CMD []

# docker build -t jaxy .
# docker run --net=host -v $(pwd)/jaxy_test_for_docker:/app/service jaxy 
