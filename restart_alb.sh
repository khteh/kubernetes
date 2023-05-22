#!/bin/bash
Please check aws-alb.sh
kubectl delete ds kube2iam -n kube-system --ignore-not-found=true
kubectl delete ing my-ingress --ignore-not-found=true
kubectl delete deployment aws-load-balancer-controller -n kube-system --ignore-not-found=true
kubectl apply -f kube2iam-daemonset.yml,aws-lb-controller.yml,ingress.yml
