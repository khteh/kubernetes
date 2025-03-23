#!/bin/bash
kubectl delete cm fluentd-config access-log-template --ignore-not-found=true
#kubectl delete sts restapi
#kubectl apply -f fluentd_config.yml,fluentd_tomcat_config.yml,access-log-template.yml,restapi.yml
kubectl apply -f fluentd_config.yml,access-log-template.yml
