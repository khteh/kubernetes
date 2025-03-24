#!/bin/bash
#./restart_env.sh
kubectl scale sts kern-subscriber --replicas=0
kubectl scale sts critical-subscriber --replicas=0
kubectl delete secret rabbitmq-secret --ignore-not-found=true
kubectl delete statefulset kern-subscriber critical-subscriber
kubectl delete svc svc-kern-subscriber svc-critical-subscriber
kubectl apply -f rabbitmq_secret.yml,svc-rabbitmqsubscriber.yml,rabbitmq-kern-subscriber.yml,rabbitmq-critical-subscriber.yml
