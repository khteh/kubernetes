#!/bin/bash
kubectl delete configmap webconfig fluentd-config fluentd-tomcat-config kibana-config tomcat-server-config tomcat-web-config access-log-template --ignore-not-found=true
kubectl apply -f webconfig.yml,access_log_template.yml,fluentd_config.yml,fluentd_tomcat_config.yml,kibana-config.yml,tomcat_server_config.yml,tomcat_web_config.yml
