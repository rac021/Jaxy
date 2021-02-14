
## Github Project : https://github.com/rac021/Jaxy

## Compile Jaxy with it's all dependencies 

########################
# Step : Compile Jaxy ##
########################

FROM maven:3.6.3-jdk-11-slim as compilation_stage

ADD src/ /tmp/src

ADD jaxy/ /tmp/jaxy

COPY compile.sh /tmp/

WORKDIR /tmp

RUN ./compile.sh 


#########################
# Step : Package image ##
#########################

FROM adoptopenjdk/openjdk11

COPY jaxy/run.sh /app/jaxy/

# Script Used Only for Play With Docker #
# This script calls run.sh after setting some environnement variables 

COPY jaxy/demo/18_Docker/play_with_docker_script/jaxy_pwd_launcher.sh /app/jaxy/

RUN chmod +x /app/jaxy/*.sh

COPY --from=compilation_stage /tmp/jaxy/ /app/jaxy/

RUN echo " + Content APP/JAXY : " ; ls /app/jaxy/

WORKDIR /app/jaxy

ENTRYPOINT ["/app/jaxy/run.sh"]

CMD ["serviceConf=service/serviceConf.yaml"]

