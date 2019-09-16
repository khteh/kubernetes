#!/bin/bash
FIRST_POD=$(kubectl get pods --namespace default -l 'app=rabbitmq' -o jsonpath='{.items[0].metadata.name }')
kubectl exec --namespace=default $FIRST_POD rabbitmqctl cluster_status
