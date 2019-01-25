

```
 sudo docker network create jaxy_net
```

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

```
   docker run --name jaxy    \
              --net jaxy_net \
              -p 8443:8443   \
              -p 8181:8181   \
              -v $(pwd)/jaxy_test_for_docker:/app/service jaxy 
```

``` 
   psql -h localhost -p 7777 -U jaxy -d aviation
 
 ```
