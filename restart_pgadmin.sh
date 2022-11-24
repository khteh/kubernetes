#!/bin/bash
microk8s kubectl scale sts pgadmin --replicas=0
#microk8s kubectl delete svc svc-{postgresql,postgresql-nodeport}
microk8s kubectl delete secret pgadmin-secret --ignore-not-found=true
microk8s kubectl delete statefulset pgadmin --ignore-not-found=true
microk8s kubectl delete pvc -l app=pgadmin
microk8s kubectl apply -f svc-pgadmin.yml,pgadmin-secret.yml,pgadmin.yml
