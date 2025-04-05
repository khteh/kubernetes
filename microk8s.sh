#!/bin/bash
#set -x
microk8s.enable dns gpu storage ingress dashboard prometheus metrics-server
sudo ufw default allow routed
microk8s.kubectl config view --raw > ~/.kube/config.microk8s
