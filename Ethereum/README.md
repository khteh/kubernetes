# Ethereum Node

## References

- https://ethereum.org/en/developers/docs/nodes-and-clients/run-a-node/
- https://github.com/ethereum/go-ethereum
- https://chainsafe.github.io/lodestar/run/getting-started/quick-start-custom-guide

## Assumptions

- Every ethereum node consists of 1:1 mapping between execution and consensus clients bound by their shared JWT secret. Therefore, only single instance (replica) of each is created. I do not know what will happen if replica is set to more than 1.

## Run k8s cluster locally

- Install microk8s: https://microk8s.io/docs/getting-started
- I will use `alias k='kubectl'` throughout this README

## Setup Execution and Beacon (with Validator) clients

- Run `setup.sh`

### Run GETH on k8s cluster

- Create a required JWT secret to work with consensus client:

```
$ openssl rand -hex 32 | tr -d "\n"
$ kubectl create secret generic jwtsecret --from-literal=jwtsecret=$jwtsecret
```

### Run Lodestar validator on k8s cluster

#### Install Staking deposit CLI

- This is needed to generate keystore using user-provided password. Download and unpack from https://github.com/ethereum/staking-deposit-cli
- Run `./deposit new-mnemonic`. Remember to copy the mnemonic shown in this interactive session in a safe place.
- Create a k8s secret from the user-provided password: `kubectl create secret generic validator --from-literal=validator=<base64 encoded password>`
- Create a ConfigMap from the generated keystore file: `kubectl create cm validator-keystore --from-file=keystore-<foo>.json`
- The secret and ConfigMap will be used by lodestar to run validator.

## Check the statuses of the applications in the cluster

```
$ k get svc
NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                          AGE
kubernetes                ClusterIP   10.152.183.1     <none>        443/TCP                          590d
svc-geth                  ClusterIP   None             <none>        8545/TCP,30303/UDP               3h55m
svc-geth-nodeport         NodePort    10.152.183.195   <none>        8545:31005/TCP,30303:31006/UDP   3h55m
svc-lodestar              ClusterIP   None             <none>        8551/TCP                         3h55m
svc-lodestar-nodeport     NodePort    10.152.183.57    <none>        8551:31007/TCP                   3h55m
```

```
$ k get sts
NAME         READY   AGE
geth         1/1     72m
lodestar     1/1     20m
```

```
$ k get pod
NAME           READY   STATUS    RESTARTS         AGE
geth-0         1/1     Running   0                73m
lodestar-0     1/1     Running   0                20m
```

## Deploy to public cloud

### AWS

- Create a k8s cluster with nodes of at least 8 cores and 32GB: Run https://github.com/khteh/kubernetes/blob/master/create_cluster.sh
- Add `storageClassName: gp3` to the geth.yml and lodestar.yml to use local SSD attached to the nodes for the Ethereum client data.
- Once the cluster is up and running, AWS Cloudformation will show the infrastructure setup.
- When using microk8s to manage AWS EKS cluster, copy the configuration content found in `~/.kube/config` to `/var/snap/microk8s/current/credentials/client.config`

## Application updates

- Run `update.sh [geth|lodestar] <tag>`. It does the following:

1. It first checks if the tag of the image exists in docker hub
2. If it does, update the docker image version of the running STS

## Notes

- I do not use Terraform to spin up cloud infrastructure in this case because I consider the infrastructure to be less likely to change compared to the applications running on it. However, Terraform is a great tool which can be used to document and version control the infrastructure setup.
- We can use tool like https://github.com/DontShaveTheYak/cf2tf to convert from AWS Cloudformation to Terraform.

## Outstanding issues and improvement suggestions

### Issues

- I have not successfully been able to run validator on the consensus client due to the issue on github: https://github.com/ChainSafe/lodestar/issues/7362

### Improvements

- https://github.com/ChainSafe/lodestar/discussions/7363
- https://github.com/ethereum/go-ethereum/issues/31034
