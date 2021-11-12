#!/bin/bash
#./restart_env.sh
microk8s kubectl scale sts aspnetapistarter --replicas=0
microk8s kubectl delete secret aspnetapistarter --ignore-not-found=true
microk8s kubectl delete sts aspnetapistarter
microk8s kubectl delete svc svc-{aspnetapistarter,aspnetapistarter-nodeport} --ignore-not-found=true
microk8s kubectl apply -f aspnetapistarter.mysql.yml,svc-aspnetapistarter.yml,aspnetapistarter.yml
