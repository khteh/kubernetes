#!/bin/bash
# https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html
aws iam create-policy --policy-name AmazonEKS_EFS_CSI_Driver_Policy --policy-document file://aws-efs-iam-policy.json
oidc=$(aws eks describe-cluster --name <name> --query "cluster.identity.oidc.issuer" --output text)
oidc=${oidc##*/}
echo $oidc
aws iam create-role \
  --role-name AmazonEKS_EFS_CSI_Driver_Role \
  --assume-role-policy-document file://"trust-policy.json"
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::400679711653:policy/AmazonEKS_EFS_CSI_Driver_Policy \
  --role-name AmazonEKS_EFS_CSI_Driver_Role

#microk8s.kubectl kustomize "github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.4.6" > private-ecr-driver.yml
microk8s.kubectl kustomize "/usr/src/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/" > private-ecr-driver.yml
sed -i.bak -e 's|us-west-2|ap-southeast-1|' private-ecr-driver.yml
sed -i.bak -e 's|602401143452|400679711653|' private-ecr-driver.yml

microk8s.kubectl annotate serviceaccount efs-csi-controller-sa -n kube-system eks.amazonaws.com/role-arn=arn:aws:iam::400679711653:role/AmazonEKS_EFS_CSI_Driver_Role
microk8s.kubectl delete pods \
  -n kube-system \
  -l=app=efs-csi-controller
#cd /usr/src/aws-efs-csi-driver/examples/kubernetes/dynamic-provisioning
#microk8s.kubectl apply -f manifests/

microk8s.kubectl apply -f private-ecr-driver.yml
vpc_id=$(aws eks describe-cluster \
    --name <name> \
    --query "cluster.resourcesVpcConfig.vpcId" \
    --output text)
cidr_range=$(aws ec2 describe-vpcs \
    --vpc-ids $vpc_id \
    --query "Vpcs[].CidrBlock" \
    --output text \
    --region ap-southeast-1)
security_group_id=$(aws ec2 create-security-group \
    --group-name MyEfsSecurityGroup \
    --description "My EFS security group" \
    --vpc-id $vpc_id \
    --output text)

aws ec2 authorize-security-group-ingress \
    --group-id $security_group_id \
    --protocol tcp \
    --port 2049 \
    --cidr $cidr_range
file_system_id=$(aws efs create-file-system \
    --region ap-southeast-1 \
    --performance-mode generalPurpose \
    --query 'FileSystemId' \
    --output text)
echo file_system_id: $file_system_id

aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=$vpc_id" \
    --query 'Subnets[*].{SubnetId: SubnetId,AvailabilityZone: AvailabilityZone,CidrBlock: CidrBlock}' \
    --output table
#Need to do the following for ALL subnets listed in the table.
aws efs create-mount-target \
    --file-system-id $file_system_id \
    --subnet-id $subnet_id \
    --security-groups $sg_id
