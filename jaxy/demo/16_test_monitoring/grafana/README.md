

### Docker Image :


```
      docker build  -t rac021/jaxy-grafana  -f grafana/Dockerfile grafana/
```


```
      docker run -d                                              \
                 -p 3000:3000                                    \
                 -e "MONITORING_PATH=/app/mon/provisioning"      \
                 -e "PROMETHEUS_URL=http://jaxy_prometheus:9090" \
                 -v ./monitoring_jaxy/:/app/mon/                 \
                 --name mon   jaxy-monitoring
```
