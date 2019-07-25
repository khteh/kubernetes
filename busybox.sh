#!/bin/bash
kubectl delete pod busybox --ignore-not-found=true
kubectl run -i -t busybox --image=busybox:1.28 --restart=Never
