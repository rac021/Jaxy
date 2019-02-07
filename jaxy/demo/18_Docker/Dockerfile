
## Github Project : https://github.com/rac021/Jaxy

## Compile Jaxy with it's all dependencies 

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

# Script Used Only for Play With Docker #
# This script calls run.sh after setting some environnement variables 

COPY jaxy/demo/18_Docker/play_with_docker_script/jaxy_pwd_launcher.sh /app/

WORKDIR /app/

RUN chmod +x /app/*.sh

COPY --from=compilation_stage /tmp/jaxy/ /app/jaxy


ENTRYPOINT ["/app/run.sh"]

CMD ["serviceConf=service/serviceConf.yaml"]

