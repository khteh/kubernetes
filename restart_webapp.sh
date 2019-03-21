#!/bin/bash
kubectl $1 scale sts web --replicas=0
kubectl $1 delete configmap webconfig
kubectl $1 delete statefulset web
kubectl $1 delete svc svc-web
kubectl $1 apply -f webconfig.yml,web_service.yml,webapp.yml
