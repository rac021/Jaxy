

### Docker Image :


```
      docker build  -t rac021/jaxy-prometheus  -f ./Dockerfile  .
```


```
      docker run -d                                              \
                 --hostname jaxy-prometheus                      \
                 -p 9090:9090                                    \
                 -e "MONITORING_PATH=/app/mon/provisioning"      \
                 -e "JAXY_HOST=jaxy"                             \
                 -e "JAXY_PORT=8181"                             \
                 -e "TRANSPORT=http"                             \
                 -e "SCARPE_INTERVAL=2s"                         \
                 -v $(pwd)/monitoring_jaxy/:/app/mon/            \
                 --name jaxy-prometheus  rac021/jaxy-prometheus
              
              
   GoTo : http://jaxy-prometheus:9090 
   
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
