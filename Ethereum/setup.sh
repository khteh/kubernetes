#!/bin/bash
jwtsecret=`openssl rand -hex 32 | tr -d "\n"`
kubectl scale sts geth lodestar --replicas=0
kubectl delete secret jwtsecret --ignore-not-found=true
kubectl create secret generic jwtsecret --from-literal=jwtsecret=$jwtsecret
kubectl delete svc svc-{geth,geth-nodeport} svc-lodestar --ignore-not-found=true
kubectl delete sts geth lodestar
kubectl apply -f geth.yml,lodestar.yml,svc-geth.yml,svc-lodestar.yml