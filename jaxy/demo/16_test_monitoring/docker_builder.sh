#!/bin/bash


 docker build -t rac021/jaxy-grafana    -f grafana/Dockerfile grafana/

 docker build -t rac021/jaxy-prometheus -f prometheus/Dockerfile prometheus
 
 
