#!/bin/bash
kubectl scale sts rabbitmq --replicas=0
kubectl delete cm rabbitmq-config --ignore-not-found=true
kubectl delete sts rabbitmq --ignore-not-found=true
kubectl apply -f rabbitmq-config.yml,svc-rabbitmq.yml,rabbitmq.yml
