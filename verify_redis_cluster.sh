#!/bin/bash
microk8s kubectl exec -it redis-cluster-0 -- redis-cli cluster info
nodes=`microk8s kubectl get pods -l app=redis-cluster | grep redis-cluster | wc -l`
for x in $(seq 0 $(( --nodes )));
do
  echo "redis-cluster-$x"; microk8s kubectl exec redis-cluster-$x -- redis-cli role; echo; 
done
