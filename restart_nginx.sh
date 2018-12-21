#!/bin/bash
microk8s.kubectl delete configmap nginx-config
microk8s.kubectl delete svc svc-frontend
microk8s.kubectl delete deployment nginx
microk8s.kubectl apply -f nginx-config.yml,nginx.yml
