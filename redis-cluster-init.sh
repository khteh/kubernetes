#!/bin/bash
microk8s kubectl delete job redis-cluster-init --ignore-not-found=true
microk8s kubectl apply -f rbac-pods.yml
microk8s kubectl apply -f redis-cluster-initjob.yml
