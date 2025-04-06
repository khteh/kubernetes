#!/bin/bash
kubectl scale sts neo4j --replicas=0
#kubectl delete svc svc-{neo4j,neo4j-nodeport}
kubectl delete configmap neo4j-config healthcare-neo4j --ignore-not-found=true
kubectl delete sts neo4j --ignore-not-found=true
kubectl delete secret neo4j-secret --ignore-not-found=true
kubectl delete pvc -l app=neo4j
kubectl apply -f svc-neo4j.yml,neo4j_config.yml,healthcare_data.yml,neo4j_secret.yml,neo4j.yml
