#!/bin/bash
kubectl scale sts pgadmin --replicas=0
#kubectl delete svc svc-{postgresql,postgresql-nodeport}
kubectl delete secret pgadmin-secret --ignore-not-found=true
kubectl delete statefulset pgadmin --ignore-not-found=true
kubectl delete pvc -l app=pgadmin
kubectl apply -f svc-pgadmin.yml,pgadmin-secret.yml,pgadmin.yml
