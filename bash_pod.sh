#!/bin/bash
kubectl run --generator=run-pod/v1 my-shell --rm -i --tty --image ubuntu -- bash
