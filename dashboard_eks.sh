#!/bin/bash
echo "Deploy official k8s dashboard..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

echo "Deploy heapster to enable container cluster monitoring and performance analysis..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml

echo "Deploy the influxdb backend for heapster..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml

echo "Create the heapster cluster role binding for the dashboard..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml
#kubectl create clusterrolebinding iconverse-service-account --clusterrole=cluster-admin --serviceaccount=kube-system:iconverse-service-account
kubectl apply -f eks-admin-service-account.yml

pkill kubectl
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
kubectl proxy&
echo "Browse to http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login"
