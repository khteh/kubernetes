#!/bin/bash
kubectl delete cm fluentd-biz4x-fe-config fluentd-biz4x-be-config access-log-template --ignore-not-found=true
#kubectl delete sts restapi
#kubectl apply -f fluentd-config.yml,fluentd-tomcat-config.yml,access-log-template.yml,restapi.yml
kubectl apply -f fluentd-biz4x-fe-config.yml,fluentd-biz4x-be-config.yml,access-log-template.yml
