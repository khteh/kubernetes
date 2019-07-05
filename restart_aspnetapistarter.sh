#!/bin/bash
./restart_env.sh
kubectl scale sts aspnetapistarter --replicas=0
kubectl delete secret aspnetapistarter --ignore-not-found=true
kubectl delete statefulset aspnetapistarter
kubectl delete svc svc-aspnetapistarter
kubectl apply -f aspnetapistarter.mysql.yml,svc-aspnetapistarter.yml,aspnetapistarter.yml
