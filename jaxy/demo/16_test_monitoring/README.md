

### Docker Image :

```
      docker run -d                                         \
                 -p 3000:3000                               \
                 -e "TRANSPORT=http"                        \ 
                 -v ./monitoring_jaxy/:/app/mon/            \
                 -e "MONITORING_PATH=/app/mon/provisioning" \
                 --name mon   jaxy-mon
```
