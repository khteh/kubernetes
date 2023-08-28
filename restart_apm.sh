#!/bin/bash
# Follow https://www.elastic.co/guide/en/apm/guide/current/agent-tls.html to create the elastic-stack self-signed certs
kubectl delete apm kyberlife
kubectl delete secret elasticsearch-eck-ca --ignore-not-found=true
kubectl delete secret elasticsearch-eck-apm-ca --ignore-not-found=true
kubectl delete secret elastic-stack-tls-certs --ignore-not-found=true
kubectl get secret kyberlife-es-http-ca-internal -o go-template='{{index .data "tls.crt" | base64decode }}' > elasticsearch-ca.crt
kubectl get secret kyberlife-apm-http-ca-internal -o go-template='{{index .data "tls.crt" | base64decode }}' > elasticsearch-apm-ca.crt
kubectl create secret generic elasticsearch-eck-ca --from-file=tls.crt=elasticsearch-ca.crt
kubectl create secret generic elasticsearch-eck-apm-ca --from-file=tls.crt=elasticsearch-apm-ca.crt
kubectl create secret generic elastic-stack-tls-certs --from-file=localhost.crt=localhost.crt --from-file=localhost.key=localhost.key
kubectl apply -f apmserver.yml