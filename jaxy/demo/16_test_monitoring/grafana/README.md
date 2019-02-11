

### Docker Image :


```
      docker build  -t rac021/jaxy-grafana  -f ./Dockerfile  .
```


```
      docker run -d                                              \
                 --hostname grafana                              \
                 -p 3000:3000                                    \
                 -e "MONITORING_PATH=/app/mon/provisioning"      \
                 -e "PROMETHEUS_URL=http://jaxy_prometheus:9090" \
                 -v ./monitoring_jaxy/:/app/mon/                 \
                 --name jaxy-grafana   rac021/jaxy-grafana
              
      GoTo : http://grafana:3000  
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
