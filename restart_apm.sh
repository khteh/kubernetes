#!/bin/bash
microk8s kubectl get secret kyberlife-es-http-ca-internal -o go-template='{{index .data "tls.crt" | base64decode }}' > elasticsearch-ca.crt
microk8s kubectl create secret generic elasticsearch-eck-ca --from-file=tls.crt=elasticsearch-ca.crt
microk8s kubectl apply -f apmserver.yml