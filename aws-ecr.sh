#!/bin/bash
ACCOUNT=400679711653
REGION=ap-southeast-1
SECRET_NAME=aws-ecr-registry
EMAIL=my@email.com
TOKEN=`aws ecr get-login --region ${REGION} --registry-ids ${ACCOUNT} --profile prod | cut -d' ' -f6`
kubectl delete secret --ignore-not-found $SECRET_NAME
kubectl create secret docker-registry $SECRET_NAME \
      --docker-server=https://${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com \
      --docker-username=AWS \
      --docker-password="${TOKEN}" \
      --docker-email="${EMAIL}"
