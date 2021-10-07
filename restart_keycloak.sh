#!/bin/bash
microk8s kubectl scale sts keycloak --replicas=0
microk8s kubectl delete svc svc-{keycloak,keycloak-nodeport}
microk8s kubectl delete statefulset keycloak --ignore-not-found=true
microk8s kubectl delete secret keycloak-secret --ignore-not-found=true
microk8s kubectl apply -f svc-keycloak.yml,keycloak-secret.yml,keycloak.yml
