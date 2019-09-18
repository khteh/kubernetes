#!/bin/bash
#./restart_env.sh
kubectl scale sts rabbitmq-subscriber --replicas=0
kubectl delete secret rabbitmq-secret --ignore-not-found=true
kubectl delete statefulset rabbitmq-subscriber
kubectl delete svc svc-rabbitmq-subscriber
kubectl apply -f rabbitmq-secret.yml,svc-rabbitmqsubscriber.yml,rabbitmq-subscriber.yml
