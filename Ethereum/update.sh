#!/bin/bash
#set -x
if [ $# -eq 2 -a -n "$1" -a -n "$2" ]; then
    if [ "$1" = 'geth' ]; then
        echo Checking ethereum/client-go:$2...
        docker manifest inspect ethereum/client-go:$2 > /dev/null
        if [ $? -eq 0 ]; then
            kubectl patch statefulset geth --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"ethereum/client-go:'$2'"}]'
        else
            echo Invalid docker image ethereum/client-go:$2
            exit 1
        fi
    elif [ "$1" = 'lodestar' ]; then
        echo Checking chainsafe/lodestar:$2...
        docker manifest inspect chainsafe/lodestar:$2 > /dev/null
        if [ $? -eq 0 ]; then
            kubectl patch statefulset lodestar --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"chainsafe/lodestar:'$2'"}]'
        else
            echo Invalid docker image chainsafe/lodestar:$2
            exit 1
        fi
    else
        echo Invalid STS! Please specify either geth or lodestar
    fi
else
  echo "Please provide image and version"
fi