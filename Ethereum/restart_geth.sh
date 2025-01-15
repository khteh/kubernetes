#!/bin/bash
jwtsecret=`openssl rand -hex 32 | tr -d "\n"`
kubectl scale sts geth --replicas=0
kubectl delete secret jwtsecret --ignore-not-found=true
kubectl create secret generic jwtsecret --from-literal=jwtsecret=$jwtsecret
kubectl delete svc svc-{geth,geth-nodeport} --ignore-not-found=true
kubectl delete sts geth
kubectl apply -f geth.yml,svc-geth.yml