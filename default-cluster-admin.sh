#!/bin/bash
# https://github.com/fabric8io/fabric8/issues/6840
kubectl create clusterrolebinding default-admin --clusterrole cluster-admin --serviceaccount=default:default
