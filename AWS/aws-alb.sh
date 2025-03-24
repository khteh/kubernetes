#!/bin/bash
# https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
# https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases
curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.6.2/docs/install/iam_policy.json
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
eksctl utils associate-iam-oidc-provider --cluster <name> --approve
eksctl create iamserviceaccount --cluster=<name> --namespace=kube-system --name=aws-alb-sa --role-name "AmazonEKSLoadBalancerControllerRole" --attach-policy-arn=arn:aws:iam::<account#>:policy/AWSLoadBalancerControllerIAMPolicy --approve
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.13.1/cert-manager.yaml
kubectl apply -f aws-ingress-class.yml,aws-lb-controller.yml
