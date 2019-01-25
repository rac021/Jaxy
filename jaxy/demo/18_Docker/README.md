
```
 docker run -i -t                                       \
            -e POSTGRES_USER=jaxy                       \
            -e POSTGRES_PASSWORD=jaxy                   \
            -e POSTGRES_DB=aviation                     \
            -v $(pwd)/db/:/docker-entrypoint-initdb.d/  \
            postgres:9.6.11-alpine
```
