

### Docker Image :


```
      docker build  -t rac021/jaxy-prometheus  -f ./Dockerfile  .
```


```
      docker run -d                                              \
                 -p 3000:3000                                    \
                 -e "MONITORING_PATH=/app/mon/provisioning"      \
                 -e "JAXY_HOST=jaxy"                             \
                 -e "JAXY_PORT: 8181"                            \
                 -e "JAXY_TRANSPORT=http"                        \
                 -e "SCARPE_INTERVAL=2s"                         \
                 -v ./monitoring_jaxy/:/app/mon/                 \
                 --name jaxy-prometheus  rac021/jaxy-prometheus
```
---

* **Note** : The **monitoring_jaxy** directory has the following structure  

```
                     monitoring_jaxy
                            |
                       provisioning
                   _________|____________
                  |                      |
              dashboards            datasources
  
 ```
