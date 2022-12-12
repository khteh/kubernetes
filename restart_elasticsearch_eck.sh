#!/bin/bash
# https://www.elastic.co/guide/en/cloud-on-k8s/current/index.html
microk8s kubectl scale sts elastic-operator --replicas=0 -n elastic-system
microk8s kubectl delete sts elastic-operator -n elastic-system --ignore-not-found=true
microk8s kubectl delete svc elastic-webhook-server -n elastic-system --ignore-not-found=true
microk8s kubectl delete ns elastic-system
microk8s kubectl scale sts kyberlife-es-default --replicas=0
microk8s kubectl delete sts kyberlife-es-default --ignore-not-found=true
microk8s kubectl create -f https://download.elastic.co/downloads/eck/2.5.0/crds.yaml
microk8s kubectl apply -f https://download.elastic.co/downloads/eck/2.5.0/operator.yaml
microk8s kubectl apply -f elasticsearch-eck-secret.yml,elasticsearch-config.yml,elasticsearch-eck.yml
