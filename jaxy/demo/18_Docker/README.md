

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
   psql -h localhost -p 7777 -U jaxy -d aviation
 
```

```
   docker run --name jaxy  -P    \
              --network jaxy_net \
              --expose 8443      \
              --expose 8181      \
              -v $(pwd)/jaxy_test_for_docker:/app/service jaxy 
```
