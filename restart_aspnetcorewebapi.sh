#!/bin/bash
#./restart_env.sh
microk8s kubectl scale sts aspnetcorewebapi --replicas=0
microk8s kubectl delete secret aspnetcorewebapi --ignore-not-found=true
microk8s kubectl delete sts aspnetcorewebapi
microk8s kubectl delete svc svc-{aspnetcorewebapi,aspnetcorewebapi-nodeport} --ignore-not-found=true
microk8s kubectl apply -f aspnetcorewebapi.mysql.yml,svc-aspnetcorewebapi.yml,aspnetcorewebapi.yml
