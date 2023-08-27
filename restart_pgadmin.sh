#!/bin/bash
kubectl scale sts pgadmin --replicas=0
kubectl delete svc svc-pgadmin --ignore-not-found=true
kubectl delete secret pgadmin-secret --ignore-not-found=true
kubectl delete sts pgadmin --ignore-not-found=true
kubectl delete pvc -l app=pgadmin
kubectl apply -f pgadmin-pvc.yml,svc-pgadmin.yml,pgadmin-secret.yml,pgadmin.yml
