#!/bin/bash
kubectl delete job rabbitmq-publisher-job --ignore-not-found=true
kubectl apply -f rabbitmq-publisher.yml
