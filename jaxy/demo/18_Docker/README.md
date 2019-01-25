

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
* **Run Docker Jaxy-DataBase**

```
   docker run -i -t                                       \
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
   docker run --name jaxy  -P                          \
              --network jaxy_net                       \
              --hostname jaxy                          \
              --network-alias "jaxy.com"               \
              -v $(pwd)/jaxy_test_for_docker:/app/service jaxy 
```

----
----

## **Build the docker image of Jaxy from scratch :**

``` 
     cd Jaxy 
     
     docker build -t jaxy -f jaxy/demo/18_Docker/Dockerfile . 
     
```
