
## 1. **Using Docker Hub images :**

* **Create Network** 

```
 sudo docker network create jaxy_net
```

* **In order to access the container by its hostname and container name from a host machine**    
    Run the following command ( **Optional** ) :

```
   docker run -d                                   \
          -v /var/run/docker.sock:/tmp/docker.sock \
          -v /etc/hosts:/tmp/hosts                 \
          --name docker-hoster                     \
          dvdarias/docker-hoster
```
---

**1.1 -  CustomSignon Demo [ ( custom_signon_auth ) ](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/18_Docker/jaxy_test_for_docker/custom_signon_auth) :** 

* **Run Docker Jaxy-DataBase :** 

  ( by copying the  [ ( db/init.sql ) ](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/db/init.sql) file into the  **docker-entrypoint-initdb.d** folder of the container )

```
   docker run -d                                          \
              -e POSTGRES_USER=jaxy                       \
              -e POSTGRES_PASSWORD=jaxy                   \
              -e POSTGRES_DB=aviation                     \
              --name jaxy_db                              \
              -v $(pwd)/db/:/docker-entrypoint-initdb.d/  \
              -p 7777:5432                                \
              --network jaxy_net                          \
              postgres:9.6.11-alpine
```
* **Test Jaxy-DataBase :**

``` 
   psql -h localhost -p 7777 -U jaxy -d aviation
 
```

* **Run Docker Jaxy-App :**

```
   docker run --name jaxy -d -P                                              \
              --hostname jaxy                                                \
              --network-alias "jaxy.com"                                     \
              -v $(pwd)/jaxy_test_for_docker/custom_signon_auth:/app/service \
              -v $(pwd)/monitoring_jaxy:/app/jaxy/monitoring_jaxy            \
              -v $(pwd)/logs:/app/jaxy/logs                                  \
              --network jaxy_net                                             \
              rac021/jaxy               
```
---

**1.2 -  SSO Demo [ ( sso_keycloak_auth ) ](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/18_Docker/jaxy_test_for_docker/sso_keycloak_auth) :**

```
   docker run --name jaxy -d -P                                              \
              --hostname jaxy                                                \
              --network-alias "jaxy.com"                                     \
              -v $(pwd)/jaxy_test_for_docker/sso_keycloak:/app/service       \
              -v $(pwd)/monitoring_jaxy:/app/jaxy/monitoring_jaxy            \
              -v $(pwd)/logs:/app/jaxy/logs                                  \
              --network jaxy_net                                             \
              rac021/jaxy               
```

---

* **Check Logs :**

```
   docker container logs -f jaxy
```

----
----

## 2. **Build the docker image of Jaxy from scratch : [Dockerfile](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/Dockerfile)**

``` 
     docker build -t jaxy -f Dockerfile ../../      
```
---
---


## 3. **Docker Compose :**  

 * Using : [docker-compose-cso.yml](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/docker-compose_cso.yml) file ( Custom Sing-On Auth Demo )

```
     docker-compose -f docker-compose-sco.yml up
```

* Using : [docker-compose-sso.yml](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/docker-compose_sso.yml) file ( Single Sing-On : Keycloak Demo )

```
     docker-compose -f docker-compose-sso.yml up
```


---

## 4. **Try Play With Docker :**

 #### ***Custom Sig-On* Auth Demo : Using [docker-compose-cso.yml](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/docker-compose-cso.yml) file** [![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/rac021/Jaxy/master/jaxy/demo/18_Docker/docker-compose-cso.yml)  


      Jaxy app          :   Port  8181 
     
      Grafana server    :   Port  3000 
     
      Prometheus server :   Port  9090     


 #### ***Single Sign-On* ( Keycloak ) Demo : Using [docker-compose-sso.yml](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/docker-compose-sso.yml) file** [![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/rac021/Jaxy/master/jaxy/demo/18_Docker/docker-compose-sso.yml)  


      Jaxy app          :   Port  8181 
     
      Grafana server    :   Port  3000 
     
      Prometheus server :   Port  9090     
  
---

* **Note** : it seems there's a bug in **play-with-docker** when **deploying grafana** :  [Reported bug](https://github.com/play-with-docker/play-with-docker/issues/318)



