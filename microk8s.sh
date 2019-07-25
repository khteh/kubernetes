#!/bin/bash
#set -x
microk8s.enable dns storage ingress dashboard prometheus metrics-server
sudo ufw default allow routed
