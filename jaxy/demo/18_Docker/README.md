
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
   docker run --name jaxy -d -P                                   \
              --hostname jaxy                                     \
              --network-alias "jaxy.com"                          \
              -v $(pwd)/jaxy_test_for_docker:/app/service         \
              -v $(pwd)/monitoring_jaxy:/app/jaxy/monitoring_jaxy \
              -v $(pwd)/logs:/app/jaxy/logs                       \
              --network jaxy_net                                  \
              rac021/jaxy               
```

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
*using the **Dockerfile** located in [play with docker ]( https://github.com/rac021/Jaxy/tree/master/jaxy/demo/18_Docker/play_with_docker ) Directory* 

```
     docker-compose -f play_with_docker/docker-compose.yml up
```
---

## 4. **Try Play With Docker** [![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/rac021/Jaxy/master/jaxy/demo/18_Docker/play_with_docker/docker-compose.yml)  Using : [docker-compose.yml](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/play_with_docker/docker-compose.yml) file


      Jaxy app          :   Port  8181 
     
      Grafana server    :   Port  3000 
     
      Prometheus server :   Port  9090     
     
---


## 5. **Try Play With Docker** [![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/rac021/Jaxy/master/jaxy/demo/18_Docker/play_with_docker/docker_compose_01.yml)  Using : [docker-compose_01.yml](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/play_with_docker/docker_compose_01.yml) file


