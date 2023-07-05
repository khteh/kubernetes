#!/bin/bash
# https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
# https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases
curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.3/docs/install/iam_policy.json
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
eksctl utils associate-iam-oidc-provider --cluster kyberlife --approve
eksctl create iamserviceaccount --cluster=kyberlife --namespace=kube-system --name=aws-alb-sa --role-name "AmazonEKSLoadBalancerControllerRole" --attach-policy-arn=arn:aws:iam::400679711653:policy/AWSLoadBalancerControllerIAMPolicy --approve
microk8s.kubectl apply \
    --validate=false \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.12.1/cert-manager.yaml
microk8s.kubectl apply -f aws-ingress-class.yml,aws-lb-controller.yml
