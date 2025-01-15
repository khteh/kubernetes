#!/bin/bash
jwtsecret=`openssl rand -hex 32`
kubectl create secret generic jwtsecret --from-literal=jwtsecret=$jwtsecret