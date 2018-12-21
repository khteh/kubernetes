#!/bin/bash
microk8s.kubectl scale sts web --replicas=0
microk8s.kubectl delete configmap webconfig
microk8s.kubectl delete statefulset web
microk8s.kubectl delete svc svc-web
microk8s.kubectl apply -f webconfig.yml,web_service.yml,webapp.yml
