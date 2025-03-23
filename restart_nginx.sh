#!/bin/bash
kubectl $1 delete configmap nginx-config --ignore-not-found=true
kubectl $1 delete svc svc-frontend --ignore-not-found=true
kubectl $1 delete deployment nginx --ignore-not-found=true
kubectl $1 apply -f nginx_config.yml,nginx.yml
