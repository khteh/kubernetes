#!/bin/bash
#./restart_env.sh
microk8s kubectl scale sts gorestapi --replicas=0
#microk8s kubectl delete secret gorestapi --ignore-not-found=true
microk8s kubectl delete sts gorestapi
microk8s kubectl delete svc svc-{gorestapi,gorestapi-nodeport} --ignore-not-found=true
microk8s kubectl apply -f svc-gorestapi.yml,gorestapi.yml
