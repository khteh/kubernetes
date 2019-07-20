#!/bin/bash
kubectl run --generator=run-pod/v1 mysql-client --rm -i --tty --image widdpim/mysql-client -- bash
