#!/bin/bash
if [ $# -eq 1 -a -n "$1" ]; then 
	oidc_id=$(aws eks describe-cluster --name $1 --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
	aws iam list-open-id-connect-providers | grep $oidc_id
	eksctl utils associate-iam-oidc-provider --cluster $1 --approve
else
	echo "Please provide cluster name!"
fi