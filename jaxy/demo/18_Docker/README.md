

```
   docker run -i -t                                       \
              -e POSTGRES_USER=jaxy                       \
              -e POSTGRES_PASSWORD=jaxy                   \
              -e POSTGRES_DB=aviation                     \
              -v $(pwd)/db/:/docker-entrypoint-initdb.d/  \
              -p 5432:5432                                \
              postgres:9.6.11-alpine
```


```
 
   psql -h localhost -p 5432 -U jaxy -d aviation
 
 ```
