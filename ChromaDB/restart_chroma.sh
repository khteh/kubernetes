#!/bin/bash
kubectl scale sts chroma --replicas=0
#kubectl delete svc svc-{chroma,chroma-nodeport}
kubectl delete configmap chroma-config chroma-log-config healthcare-chroma --ignore-not-found=true
kubectl delete sts chroma --ignore-not-found=true
kubectl delete secret chroma-secret --ignore-not-found=true
kubectl delete pvc -l app=db-chroma
kubectl apply -f svc-chroma.yml,chroma_config.yml,chroma_log_config.yml,chroma_secret.yml,chroma.yml
