#!/bin/bash
kubectl delete role admin
kubectl delete rolebinding admin-role-binding
#kubectl delete clusterrole myclusterrole
#kubectl delete clusterrolebinding my-cluster-role-binding
#kubectl apply -f role.yml,cluster_role.yml,role_binding.yml,cluster_role_binding.yml
