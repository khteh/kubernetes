#!/bin/bash
kubectl exec -it redis-cluster-0 -- redis-cli cluster info
nodes=`kubectl get pods -l app=redis-cluster | grep redis-cluster | wc -l`
for x in $(seq 0 $(( --nodes )));
do
  echo "redis-cluster-$x"; kubectl exec redis-cluster-$x -- redis-cli role; echo; 
done
