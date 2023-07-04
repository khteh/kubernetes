#!/bin/bash
microk8s kubectl delete job rabbitmq-cluster-init --ignore-not-found=true
microk8s kubectl scale sts rabbitmq --replicas=0
microk8s kubectl delete cm rabbitmq-config rabbitmq-definitions --ignore-not-found=true
microk8s kubectl delete sts rabbitmq --ignore-not-found=true
microk8s kubectl delete sa svc-rabbitmq --ignore-not-found=true
microk8s kubectl delete role svc-rabbitmq --ignore-not-found=true
microk8s kubectl delete rolebinding svc-rabbitmq --ignore-not-found=true
microk8s kubectl apply -f rabbitmq_rbac.yml,rabbitmq-config.yml,rabbitmq-definitions.yml,svc-rabbitmq.yml,rabbitmq.yml
