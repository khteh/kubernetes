#!/bin/bash
kubectl scale sts neo4j --replicas=0
kubectl delete svc svc-{neo4j,neo4j-nodeport}
kubectl delete configmap neo4j-config --ignore-not-found=true
kubectl delete statefulset neo4j --ignore-not-found=true
kubectl delete secret neo4j-secret --ignore-not-found=true
kubectl delete pvc -l app=db-neo4j
#kubectl apply -f svc-neo4j.yml,neo4j-secret.yml,neo4j-initdb.yml,neo4j.yml
kubectl apply -f svc-neo4j.yml,neo4j_config.yml,neo4j-secret.yml,neo4j.yml
