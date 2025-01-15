#!/bin/bash
kubectl scale sts lodestar --replicas=0
kubectl delete cm beacon-config --ignore-not-found=true
kubectl create secret generic jwtsecret --from-literal=jwtsecret=$jwtsecret
kubectl delete svc svc-lodestar-beacon --ignore-not-found=true
kubectl delete sts lodestar-beacon
kubectl apply -f lodestar_config.yml,lodestar_beacon.yml,svc-lodestar-beacon.yml