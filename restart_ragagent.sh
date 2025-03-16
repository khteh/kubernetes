#!/bin/bash
kubectl scale sts ragagent --replicas=0
kubectl delete statefulset ragagent --ignore-not-found=true
kubectl delete svc svc-{ragagent,ragagent-nodeport} --ignore-not-found=true
kubectl delete cm ragagent ragagent-fluentd-config --ignore-not-found=true
kubectl apply -f ragagent_config.yml,ragagent-fluentd-config.yml,svc-ragagent.yml,ragagent.yml
