#!/bin/bash
kubectl scale sts redis-cluster --replicas=0
kubectl delete cm redis-cluster-config --ignore-not-found=true
kubectl delete sts redis-cluster
kubectl delete pvc -l app=redis-cluster
kubectl apply -f redis-cluster-config.yml,redis-cluster.yml
