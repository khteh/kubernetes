#!/bin/bash
kubectl delete job rabbitmq-cluster-init --ignore-not-found=true
kubectl scale sts rabbitmq --replicas=0
kubectl delete cm rabbitmq-config rabbitmq-definitions --ignore-not-found=true
kubectl delete sts rabbitmq --ignore-not-found=true
kubectl delete sa svc-rabbitmq --ignore-not-found=true
kubectl delete role svc-rabbitmq --ignore-not-found=true
kubectl delete rolebinding svc-rabbitmq --ignore-not-found=true
kubectl apply -f rabbitmq_rbac.yml,rabbitmq-config.yml,rabbitmq-definitions.yml,svc-rabbitmq.yml,rabbitmq.yml
