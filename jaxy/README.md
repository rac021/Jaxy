# Jax-Y  <img src="https://cloud.githubusercontent.com/assets/7684497/25315596/e191fb00-2857-11e7-99bf-8e233b4eb795.jpg" width="50"> [![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT) 


| Branch    | build status  |
|-----------|---------------|
| [master](https://github.com/rac021/Jaxy/tree/master)  |[![Build Status](https://travis-ci.org/ontop/ontop.svg?branch=master)](https://travis-ci.org/rac021/Jaxy)|



 **Jax-Y** is Generic Jax-Rs web Service based over yaml configuration implementing the project  **[jaxy-Api]( https://github.com/rac021/Jaxy/tree/master/src/dependencies/jaxy-api)**

**SourceForge Download Link** : **[https://sourceforge.net/projects/jax-y/?source=typ_redirect]( https://sourceforge.net/projects/jax-y/?source=typ_redirect)** 


------------------------------------------------------

**Linked Projects :** 

- **Api :**
   * [https://github.com/rac021/Jaxy/tree/master/src/dependencies/jaxy-api]( https://github.com/rac021/Jaxy/tree/master/src/dependencies/01_jaxy-api)

- **Default Service Discovery Implementation :**
   * [https://github.com/rac021/Jaxy/tree/master/src/dependencies/jaxy-service-discovery]( https://github.com/rac021/Jaxy/tree/master/src/dependencies/03_jaxy-service-discovery) 

- **Default Security Provider Implementation :**
   * [https://github.com/rac021/Jaxy/tree/master/src/dependencies/jaxy-security-provider]( https://github.com/rac021/Jaxy/tree/master/src/dependencies/02_jaxy-security-provider) 
   
- **GUI :**
   * [https://github.com/rac021/Jaxy/tree/master/src/bonus/JaxyClientUi]( https://github.com/rac021/Jaxy/tree/master/src/bonus/JaxyClientUi) 


**Requirements :**

-    `JAVA 8`
    
-    `MAVEN 3.3.9 + `
   
-    `Postgres | mySql `

-----------------------------------------------------

## installation

```xml
  mvn clean package 
```  
------------------------------------------------------

## Demo 

```xml
  
  cp target/jax-y-swarm.jar demo/
  
  cd demo/
  
  chmod +x db-script/db-planes.sh
  
  ./db-script/db-planes.sh 
  
  java -jar jax-y-swarm.jar
  
```  
