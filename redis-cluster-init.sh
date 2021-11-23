#!/bin/bash
#https://www.suse.com/c/rancher_blog/deploying-redis-cluster-on-top-of-kubernetes/
microk8s kubectl delete job redis-cluster-init --ignore-not-found=true
microk8s kubectl apply -f rbac-pods.yml
microk8s kubectl apply -f redis-cluster-initjob.yml
