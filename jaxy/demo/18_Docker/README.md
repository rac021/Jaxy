

* **Create Network** 

```
 sudo docker network create jaxy_net
```

* **In order to access the container by its hostname and container name from a host machine**

```
   docker run -d                                   \
          -v /var/run/docker.sock:/tmp/docker.sock \
          -v /etc/hosts:/tmp/hosts                 \
          --name docker-hoster                     \
          dvdarias/docker-hoster
```

## 1. **Using Docker Hub :**


* **Run Docker Jaxy-DataBase** 

  ( by copying the  [ ( db/init.sql ) ](https://github.com/rac021/Jaxy/blob/master/jaxy/demo/18_Docker/db/init.sql) file into the  **docker-entrypoint-initdb.d** folder of the container )

```
   docker run -d                                          \
              -e POSTGRES_USER=jaxy                       \
              -e POSTGRES_PASSWORD=jaxy                   \
              -e POSTGRES_DB=aviation                     \
              -v $(pwd)/db/:/docker-entrypoint-initdb.d/  \
              -p 7777:5432                                \
              --name jaxy_db                              \
              --network jaxy_net                          \
              postgres:9.6.11-alpine
```
* **Test Jaxy-DataBase**

``` 
   psql -h localhost -p 7777 -U jaxy -d aviation
 
```

* **Run Docker Jaxy-App**

```
   docker run --name jaxy -d -P                           \
              --network jaxy_net                          \
              --hostname jaxy                             \
              --network-alias "jaxy.com"                  \
              -v $(pwd)/jaxy_test_for_docker:/app/service rac021/jaxy 
```

* **Check Logs**

```
   docker container logs -f jaxy
```

----
----

## 2. **Build the docker image of Jaxy from scratch :**

``` 
     docker build -t jaxy -f Dockerfile ../../ 
     
```
