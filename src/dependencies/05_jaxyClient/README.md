# G-Jax-Client [![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT) 


| Branch    | build status  |
|-----------|---------------|
| [master](https://github.com/rac021/G-Jax-Client/tree/master)  |[![Build Status](https://travis-ci.org/ontop/ontop.svg?branch=master)](https://travis-ci.org/rac021/G-Jax-Client)|



**jaxyClient-Api** is an add-on for the projects **[JaxY]( https://github.com/rac021/Jaxy)**  and **[Jax-D]( https://github.com/rac021/Jax-D)** 

## installation

```xml
  mvn clean compile assembly:single
```  
```xml
  java -jar target/jaxyClient.jar
```  

-------------------------------------

#### Sample customSingOn Client

```xml

java -jar jaxyClient.jar confPath jaxy_conf.txt \
                         password admin         \
                         login    admin        

```
-------------------------------------

#### Sample KeyCloak Client

```xml
java -jar jaxyClient.jar confPath            jaxy_conf.txt \
                         keycloak_client_id  my_app        \
                         keycloak_secret_id  my_secret     \
                         keycloak_login      admin         \
                         keycloak_password   password      \
                         out outputData.txt
```             

