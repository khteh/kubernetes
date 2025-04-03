#!/bin/bash
#./restart_env.sh
kubectl scale sts gorestapi --replicas=0
#kubectl delete secret gorestapi --ignore-not-found=true
kubectl delete sts gorestapi
kubectl delete cm access-log-template go-fluentd-config --ignore-not-found=true
kubectl delete svc svc-{gorestapi,gorestapi-nodeport} --ignore-not-found=true
kubectl apply -f svc-gorestapi.yml,gorestapi.yml
