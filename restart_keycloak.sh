#!/bin/bash
kubectl scale sts keycloak --replicas=0
kubectl delete svc svc-{keycloak,keycloak-nodeport}
kubectl delete statefulset keycloak --ignore-not-found=true
kubectl delete secret keycloak-secret --ignore-not-found=true
kubectl apply -f svc-keycloak.yml,keycloak_secret.yml,keycloak.yml
