#!/bin/bash
#./restart_env.sh
kubectl scale sts aspnetcorewebapi --replicas=0
kubectl delete cm access-log-template fluentd-config appsettings-production --ignore-not-found=true
kubectl delete secret aspnetcorewebapi email-credentials --ignore-not-found=true
kubectl delete sts aspnetcorewebapi
kubectl delete svc svc-{aspnetcorewebapi,aspnetcorewebapi-nodeport} --ignore-not-found=true
kubectl apply -f access_log_template.yml,aspnetcorewebapi.postgresql.yml,appsettings.Production.yml,email-credentials.yml,svc-aspnetcorewebapi.yml,aspnetcorewebapi.yml
