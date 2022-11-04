#!/bin/bash
microk8s kubectl auth can-i delete secrets --as=system:serviceaccount:default:default -n default
