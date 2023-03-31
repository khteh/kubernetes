#!/bin/bash
aws iam create-policy \
    --policy-name AmazonEKSClusterAutoscalerPolicy \
    --policy-document file://aws-cluster-autoscaling.json
eksctl create iamserviceaccount \
  --cluster=my-cluster \
  --namespace=kube-system \
  --name=cluster-autoscaler \
  --attach-policy-arn=arn:aws:iam::ACCOUNT_ID:policy/eksctl-kyberlife-nodegroup-ng-cluster_name-1a-PolicyAutoScaling \
  --override-existing-serviceaccounts \
  --approve
eksctl create iamserviceaccount \
  --cluster=my-cluster \
  --namespace=kube-system \
  --name=cluster-autoscaler \
  --attach-policy-arn=arn:aws:iam::ACCOUNT_ID:policy/eksctl-kyberlife-nodegroup-ng-cluster_name-1b-PolicyAutoScaling \
  --override-existing-serviceaccounts \
  --approve

microk8s.kubectl apply -f cluster-autoscaler-autodiscover.yml
microk8s.kubectl annotate serviceaccount cluster-autoscaler \
  -n kube-system \
  eks.amazonaws.com/role-arn=arn:aws:iam::ACCOUNT_ID:role/AmazonEKSClusterAutoscalerRole
microk8s.kubectl patch deployment cluster-autoscaler \
  -n kube-system \
  -p '{"spec":{"template":{"metadata":{"annotations":{"cluster-autoscaler.kubernetes.io/safe-to-evict": "false"}}}}}'