#!/bin/bash
if [ $# -lt 1 ]; then 
  echo "Please provide statefulset name!"
  exit 0  
fi
echo Updating Statefulset $1
if [ $# -eq 2 ]; then
   echo Using version $2
   kubectl patch statefulset $1 --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "khteh/asp.netcoreapistarter:'$2'"}]'
else
   echo Using "latest" version
   kubectl patch statefulset $1 --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "khteh/asp.netcoreapistarter:latest"}]'
fi
