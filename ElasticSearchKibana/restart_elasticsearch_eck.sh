#!/bin/bash
# https://www.elastic.co/guide/en/cloud-on-k8s/current/index.html
#kubectl scale sts elastic-operator --replicas=0 -n elastic-system
#kubectl delete sts elastic-operator -n elastic-system --ignore-not-found=true
#kubectl delete svc elastic-webhook-server -n elastic-system --ignore-not-found=true
#kubectl delete ns elastic-system
#kubectl delete crd -l app.kubernetes.io/name=eck-operator-crds
kubectl scale sts khteh-es-es-data --replicas=0
kubectl delete sts khteh-es-es-data --ignore-not-found=true
kubectl scale sts khteh-es-es-master --replicas=0
kubectl delete sts khteh-es-es-master --ignore-not-found=true
kubectl delete secret elasticsearch-secret elastic-eck-snapshots --ignore-not-found=true
kubectl delete pvc -l elasticsearch.k8s.elastic.co/cluster-name=khteh-es --ignore-not-found=true
pvcs=(elasticsearch-data-khteh-es-es-data-0 elasticsearch-data-khteh-es-es-data-1 elasticsearch-data-khteh-es-es-master-0 elasticsearch-data-khteh-es-es-master-1 elasticsearch-data-khteh-es-es-master-2)
for pvc in ${pvcs[@]}; do
    kubectl patch pvc $pvc -p '{"metadata":{"finalizers":null}}'
done
# https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-elasticsearch.html
kubectl create -f https://download.elastic.co/downloads/eck/2.16.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.16.0/operator.yaml
kubectl delete elasticsearch khteh-es --ignore-not-found=true
kubectl delete agent fleet-server elastic-agent --ignore-not-found=true
kubectl apply -f elastic_eck_snapshots_secret.yml,elastic_agent_account.yml,elasticsearch_secret.yml,elasticsearch_eck_fleet.yml,elasticsearch_eck.yml