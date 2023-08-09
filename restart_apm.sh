#!/bin/bash
kubectl delete apm kyberlife
kubectl delete secret elasticsearch-eck-ca --ignore-not-found=true
kubectl delete secret elasticsearch-eck-apm-ca --ignore-not-found=true
kubectl get secret kyberlife-es-http-ca-internal -o go-template='{{index .data "tls.crt" | base64decode }}' > elasticsearch-ca.crt
kubectl get secret kyberlife-apm-http-ca-internal -o go-template='{{index .data "tls.crt" | base64decode }}' > elasticsearch-apm-ca.crt
kubectl create secret generic elasticsearch-eck-ca --from-file=tls.crt=elasticsearch-ca.crt
kubectl create secret generic elasticsearch-eck-apm-ca --from-file=tls.crt=elasticsearch-apm-ca.crt
kubectl apply -f apmserver.yml