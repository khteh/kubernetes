#!/bin/bash
#./restart_env.sh
kubectl scale sts ollama --replicas=0
kubectl delete cm access-log-template fluentd-config ollama-config --ignore-not-found=true
kubectl delete sts ollama
kubectl delete svc svc-{ollama,ollama-nodeport} --ignore-not-found=true
kubectl apply -f ../access_log_template.yml,fluentd_config.yml,ollama_config.yml,svc-ollama.yml,ollama.yml
