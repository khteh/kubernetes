#!/bin/bash
kubectl scale sts ollama --replicas=0
kubectl delete cm access-log-template ollama-fluentd-config ollama-config --ignore-not-found=true
kubectl delete sts ollama
kubectl delete pvc -l app=ollama
#kubectl delete svc svc-{ollama,ollama-nodeport} --ignore-not-found=true
kubectl apply -f ../access_log_template.yml,fluentd_config.yml,ollama_config.yml,svc-ollama.yml,ollama.yml
