#!/bin/bash
# https://www.elastic.co/guide/en/cloud-on-k8s/current/index.html
#kubectl scale sts elastic-operator --replicas=0 -n elastic-system
#kubectl delete sts elastic-operator -n elastic-system --ignore-not-found=true
#kubectl delete svc elastic-webhook-server -n elastic-system --ignore-not-found=true
#kubectl delete ns elastic-system
#kubectl delete crd -l app.kubernetes.io/name=eck-operator-crds

kubectl scale sts kyberlife-es-data --replicas=0
kubectl delete sts kyberlife-es-data --ignore-not-found=true
kubectl scale sts kyberlife-es-master --replicas=0
kubectl delete sts kyberlife-es-master --ignore-not-found=true
kubectl delete secret kyberlife-es-elastic-user --ignore-not-found=true
kubectl delete secret elasticsearch-secret --ignore-not-found=true
#kubectl delete pvc -l elasticsearch.k8s.elastic.co/cluster-name=kyberlife
#pvcs=(elasticsearch-data-kyberlife-es-data-0 elasticsearch-data-kyberlife-es-data-1 elasticsearch-data-kyberlife-es-master-0 elasticsearch-data-kyberlife-es-master-1 elasticsearch-data-kyberlife-es-master-2)
#for pvc in ${pvcs[@]}; do
#    kubectl patch pvc $pvc -p '{"metadata":{"finalizers":null}}'
#done
#kubectl create -f https://download.elastic.co/downloads/eck/2.5.0/crds.yaml
#kubectl apply -f https://download.elastic.co/downloads/eck/2.5.0/operator.yaml
kubectl delete elasticsearch kyberlife --ignore-not-found=true
kubectl delete agent fleet-server elastic-agent --ignore-not-found=true
kubectl apply -f elastic-agent-account.yml,elasticsearch-eck-secret.yml,elasticsearch-secret.yml,elasticsearch-eck-fleet.yml,elasticsearch-eck.yml