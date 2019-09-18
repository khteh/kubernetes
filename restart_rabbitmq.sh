#!/bin/bash
kubectl delete job rabbitmq-cluster-init --ignore-not-found=true
kubectl scale sts rabbitmq --replicas=0
kubectl delete cm rabbitmq-config --ignore-not-found=true
kubectl delete sts rabbitmq --ignore-not-found=true
kubectl delete sa svc-rabbitmq --ignore-not-found=true
kubectl delete role endpoint-reader --ignore-not-found=true
kubectl delete rolebinding endpoint-reader --ignore-not-found=true
kubectl apply -f rabbitmq_rbac.yml,rabbitmq-config.yml,svc-rabbitmq.yml,rabbitmq.yml
