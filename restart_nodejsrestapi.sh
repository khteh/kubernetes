#!/bin/bash
microk8s kubectl scale sts nodejsrestapi --replicas=0
microk8s kubectl delete statefulset nodejsrestapi --ignore-not-found=true
microk8s kubectl delete svc svc-{nodejsrestapi,nodejsrestapi-nodeport} --ignore-not-found=true
microk8s kubectl delete cm nodejsrestapi --ignore-not-found=true
microk8s kubectl apply -f nodejsrestapi_config.yml,svc-nodejsrestapi.yml,nodejsrestapi.yml
