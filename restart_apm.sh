#!/bin/bash
# Follow https://www.elastic.co/guide/en/apm/guide/current/agent-tls.html to create the elastic-stack self-signed certs
kubectl delete apm <name>
kubectl delete secret elasticsearch-eck-ca --ignore-not-found=true
kubectl delete secret apm-internal-cert --ignore-not-found=true
kubectl delete secret apm-public-cert-token --ignore-not-found=true
kubectl apply -f apmserver.yml
kubectl get secret <name>-apm-http-certs-internal --template='{{index .data "tls.crt" | base64decode }}' > apm-internal.crt
kubectl get secret <name>-apm-http-certs-internal --template='{{index .data "tls.key" | base64decode }}' > apm-internal.key
kubectl get secret <name>-apm-token --template='{{index .data "secret-token" | base64decode }}' > apm-token
kubectl get secret <name>-apm-http-certs-public --template='{{index .data "tls.crt" | base64decode }}' > apm-public.crt
kubectl get secret <name>-es-http-ca-internal -o go-template='{{index .data "tls.crt" | base64decode }}' > elasticsearch-ca.crt
kubectl create secret generic elasticsearch-eck-ca --from-file=tls.crt=elasticsearch-ca.crt
kubectl create secret generic apm-internal-cert --from-file=tls.crt=apm-internal.crt --from-file=tls.key=apm-internal.key
kubectl create secret generic apm-public-cert-token --from-file=tls.crt=apm-public.crt --from-file=token=apm-token