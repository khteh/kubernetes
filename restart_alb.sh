#!/bin/bash
kubectl delete deployment external-dns --ignore-not-found=true
kubectl delete ds kube2iam -n kube-system --ignore-not-found=true
kubectl delete ing biz4x-ingress --ignore-not-found=true
kubectl delete deployment alb-ingress-controller -n kube-system --ignore-not-found=true
#kubectl apply -f kube2iam-daemonset.yml,rbac-role.yml,biz4x-service-account.yml,alb-ingress-controller.yml,ingress.yml
kubectl apply -f kube2iam-daemonset.yml,rbac-role.yml,alb-ingress-controller.yml,ingress.yml
#,external-dns-service-accounts.yml start this only AFTER the ALB is in active state. Otherwise it creates TXT record instead of CNAME
