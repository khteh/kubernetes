#!/bin/bash
if [ $# -eq 1 -a -n "$1" ]; then
    #echo "k8s.io/cluster-autoscaler/enabled=true,k8s.io/cluster-autoscaler/"$1"="$1",kubernetes.io/cluster/"$1"=owned"
    eksctl create cluster --name=$1 --nodegroup-name=ng-$1-1a --auto-kubeconfig --nodes=1 --nodes-min=1 --nodes-max=3 --ssh-access --asg-access --full-ecr-access --alb-ingress-access --node-type=m6i.2xlarge --region=ap-southeast-1 --zones=ap-southeast-1a,ap-southeast-1b,ap-southeast-1c --node-zones=ap-southeast-1a --tags="k8s.io/cluster-autoscaler/enabled=true,k8s.io/cluster-autoscaler/"$1"="$1",kubernetes.io/cluster/"$1"=owned" --node-volume-size=100 --node-volume-type=gp3 --vpc-cidr 10.0.0.0/16 --profile mycluster
    eksctl create nodegroup --cluster=$1 --name=ng-$1-1b --nodes=1 --nodes-min=1 --nodes-max=3 --ssh-access --asg-access --full-ecr-access --node-type=m6i.2xlarge --region=ap-southeast-1 --node-zones=ap-southeast-1b --node-volume-size=100 --node-volume-type=gp3 --asg-access --full-ecr-access --alb-ingress-access --profile mycluster
    eksctl create nodegroup --cluster=$1 --name=ng-$1-1c --nodes=1 --nodes-min=1 --nodes-max=3 --ssh-access --asg-access --full-ecr-access --node-type=m6i.2xlarge --region=ap-southeast-1 --node-zones=ap-southeast-1c --node-volume-size=100 --node-volume-type=gp3 --asg-access --full-ecr-access --alb-ingress-access --profile mycluster
else
    echo "Please provide cluster name!"
fi