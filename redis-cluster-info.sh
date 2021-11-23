#!/bin/bash
nodes=`microk8s kubectl get pods -l app=redis-cluster | grep redis-cluster | wc -l`
echo $nodes nodes
for x in $(seq 0 $(( --nodes )));
do 
  microk8s kubectl exec redis-cluster-$x -- redis-cli role; 
  echo
done
