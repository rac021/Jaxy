
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

**1.1 -  Custom-Sign-On Demo [ ( custom_signon_auth ) ](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/18_Docker/jaxy_test_for_docker/custom_signon_auth) :** 

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

**1.2 -  Single-Sing-On Demo [ ( sso_keycloak_auth ) ](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/18_Docker/jaxy_test_for_docker/sso_keycloak_auth) :**

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
              
* **Note :** For keycloak docker image refer to [ KeycloakMe ]( https://github.com/rac021/KeycloakMe/tree/master/script_version#using-docker--dockerfile-- ) Project 

```
   docker run -d  -p 8180:8180           \
                  --hostname keycloakme  \
                  -e "TRANSPORT=http"    \
                  -e "MODE=DEMO"         \
                  --network jaxy_net     \
                  --name keycloakme      \
                  rac021/jaxy-keycloakme
```

```
   docker run --name jaxy -d -P                                             \
              --hostname jaxy                                               \
              -p 8181:8181                                                  \
              --network-alias "jaxy.com"                                    \
              -v $(pwd)/jaxy_test_for_docker/sso_keycloak_auth:/app/service \
              -v $(pwd)/monitoring_jaxy:/app/jaxy/monitoring_jaxy           \
              -v $(pwd)/logs:/app/jaxy/logs                                 \
              --network jaxy_net                                            \
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

 * Using : [docker-compose-cso.yml](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/docker-compose-cso.yml) file ( Custom Sing-On Auth Demo )

```
     docker-compose -f docker-compose-sco.yml up
```

* Using : [docker-compose-sso.yml](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/docker-compose-sso.yml) file ( Single Sing-On : Keycloak Demo )

```
     docker-compose -f docker-compose-sso.yml up
```


---

## 4. **Try Play With Docker :**


| **Auth** |  docker-compose file | play-with-docker |
|:-------------|:-------------|:-------------|
| **Custom Sign-On Auth Demo** |  [docker-compose-cso.yml](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/docker-compose-cso.yml)         | [![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/rac021/Jaxy/master/jaxy/demo/18_Docker/docker-compose-cso.yml) |
| **Single Sign-On Auth Demo** |  [docker-compose-sso.yml](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/docker-compose-sso.yml)         | [![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/rac021/Jaxy/master/jaxy/demo/18_Docker/docker-compose-sso.yml) |

```
      Jaxy app   server  :  Port  8181 ( LOGIN / PASSWORD : jaxy / jaxy )     
     
      Grafana    server  :  Port  3000 ( LOGIN/PASSWORD : admin / admin )   ¯\
                                                                              | => Monitoring
      Prometheus server  :  Port  9090 ( No PASSWORD                    )   _/

```

 In the **Single Sign-On Auth Demo**, Keycloak server is launched ( Project [ KeycloakMe ]( https://github.com/rac021/KeycloakMe/tree/master/script_version#using-docker--dockerfile-- ) ) :
  
```
      Keycloak   server  :  Port  8180 ( LOGIN/PASSWORD : admin / admin )
      
         ** Creates :
          
             - REALM            : my_realm
             - CLIENT_ID        : my_app
             - CLIENT_SECRET_ID : my_secret
             - USER_1           : with login admin  / password admin
             - USER_2           : with login public / password public
             - ROLE             : manager
             - Affect the Role "Manager" to the Client "my_app" 
             - Affect the Role "Manager" to the user Admin 
```

 **Note :** In the **Single Sign-On Auth Demo**, for the keycloak docker image, refer to [ KeycloakMe ]( https://github.com/rac021/KeycloakMe/tree/master/script_version#using-docker--dockerfile-- ) Project

---

####  Docker images are pulled from : [ Docker-Hub ](https://hub.docker.com/r/rac021/jaxy)

---

* **Note** : it seems there's a bug in **play-with-docker** when **deploying grafana** :  [Reported bug](https://github.com/play-with-docker/play-with-docker/issues/318)

