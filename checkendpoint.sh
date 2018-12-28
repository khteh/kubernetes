#!/bin/bash
IP=`microk8s.kubectl describe svc svc-iconverse | grep IP | awk -F':' '{ print $2 }'`
echo IP: $IP
curl -v $IP/iconverse-admin/api/authenticate
curl $IP/iconverse-nlp/ontology/getClasses
curl -XPOST $IP/iconverse-converse/startSession
