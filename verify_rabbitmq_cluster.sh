#!/bin/bash
FIRST_POD=$(kubectl get pods --namespace default -l 'app=rabbitmq' -o jsonpath='{.items[0].metadata.name }')
nodes=`kubectl get pods -l app=rabbitmq | grep rabbitmq | wc -l`
echo $nodes nodes
for i in $(seq 0 $(( --nodes )));
do
	echo rabbitmq-$i:
	kubectl exec rabbitmq-$i rabbitmqctl cluster_status
	kubectl exec rabbitmq-$i rabbitmq-plugins is_enabled rabbitmq_peer_discovery_k8s
	echo
done
