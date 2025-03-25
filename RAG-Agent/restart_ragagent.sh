#!/bin/bash
kubectl scale sts ragagent --replicas=0
kubectl delete statefulset ragagent --ignore-not-found=true
kubectl delete svc svc-{ragagent,ragagent-nodeport} --ignore-not-found=true
kubectl delete secret gcloud-secret --ignore-not-found=true
kubectl delete cm access-log-template hypercorn-config ragagent ragagent-fluentd-config --ignore-not-found=true
cp ~/.config/gcloud/application_default_credentials.json /tmp
kubectl create secret generic gcloud-secret --from-file=/tmp/application_default_credentials.json
kubectl apply -f ../access_log_template.yml,hypercorn_config.yml,ragagent_config.yml,fluentd_config.yml,svc-ragagent.yml,ragagent.yml
