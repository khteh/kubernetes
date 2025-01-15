#!/bin/bash
jwtsecret=`openssl rand -hex 32 | tr -d "\n"`
kubectl scale sts lodestar --replicas=0
kubectl delete secret jwtsecret --ignore-not-found=true
kubectl delete cm validator-config --ignore-not-found=true
kubectl create secret generic jwtsecret --from-literal=jwtsecret=$jwtsecret
kubectl delete svc svc-lodestar-validator --ignore-not-found=true
kubectl delete sts lodestar-validator
kubectl apply -f lodestar_config.yml,lodestar_validator.yml,svc-lodestar-validator.yml