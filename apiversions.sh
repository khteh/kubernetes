#!/bin/bash
for kind in `microk8s kubectl api-resources | tail +2 | awk '{ print $1 }'`; do microk8s kubectl explain $kind; done | grep -e "KIND:" -e "VERSION:"
