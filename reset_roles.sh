#!/bin/bash
microk8s kubectl delete role myrole
microk8s kubectl delete rolebinding my-role-binding
microk8s kubectl delete clusterrole myclusterrole
microk8s kubectl delete clusterrolebinding my-cluster-role-binding
microk8s kubectl apply -f role.yml,cluster_role.yml,role_binding.yml,cluster_role_binding.yml
