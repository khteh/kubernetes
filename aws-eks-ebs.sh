#!/bin/bash
aws iam create-policy --policy-name AmazonEKS_EBS_CSI_Driver_Policy --policy-document file://aws-ebs-iam-policy.json
oidc=$(aws eks describe-cluster --name kyberlife --query "cluster.identity.oidc.issuer" --output text)
oidc=${oidc##*/}
echo $oidc
aws iam create-role \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --assume-role-policy-document file://"trust-policy.json"
aws iam attach-role-policy \
--policy-arn arn:aws:iam::<accountnumber>:policy/AmazonEKS_EBS_CSI_Driver_Policy \
--role-name AmazonEKS_EBS_CSI_DriverRole
#microk8s.kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"
microk8s.kubectl apply -k "/usr/src/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable"
microk8s.kubectl annotate serviceaccount ebs-csi-controller-sa -n kube-system eks.amazonaws.com/role-arn=arn:aws:iam::<accountnumber>:role/AmazonEKS_EBS_CSI_DriverRole
microk8s.kubectl delete pods \
  -n kube-system \
  -l=app=ebs-csi-controller
cd /usr/src/aws-ebs-csi-driver/examples/kubernetes/dynamic-provisioning
microk8s.kubectl apply -f manifests/
