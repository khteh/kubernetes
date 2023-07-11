#!/bin/bash
kubectl delete apm kyberlife
kubectl delete secret elasticsearch-eck-ca --ignore-not-found=true
kubectl get secret kyberlife-es-http-ca-internal -o go-template='{{index .data "tls.crt" | base64decode }}' > elasticsearch-ca.crt
kubectl create secret generic elasticsearch-eck-ca --from-file=tls.crt=elasticsearch-ca.crt
kubectl apply -f apmserver.yml