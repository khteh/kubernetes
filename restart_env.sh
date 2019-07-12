#!/bin/bash
kubectl delete configmap webconfig fluentd-config fluentd-tomcat-config kibana-config tomcat-server-config tomcat-web-config access-log-template --ignore-not-found=true
kubectl apply -f webconfig.yml,access-log-template.yml,fluentd-config.yml,fluentd-tomcat-config.yml,kibana-config.yml,tomcat-server-config.yml,tomcat-web-config.yml
