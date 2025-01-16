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
- Refer to top-level README https://github.com/khteh/kubernetes/blob/master/README.md#update-kubeconfig

### Run GETH on k8s cluster

- Create a required JWT secret to work with consensus client:

```
$ openssl rand -hex 32 | tr -d "\n"
$ kubectl create secret generic jwtsecret --from-literal=jwtsecret=$jwtsecret
```

- Run `restart_geth.sh`.

### Run Lodestar validator on k8s cluster

#### Install Staking deposit CLI

- This is needed to generate keystore using user-provided password. Download and unpack from https://github.com/ethereum/staking-deposit-cli
- Run `./deposit new-mnemonic`. Remember to copy the mnemonic shown in this interactive session in a safe place.
- Create a k8s secret from the user-provided password: `kubectl create secret generic validator --from-literal=password.txt=<password>`
- Create a ConfigMap from the generated keystore file: `kubectl create cm validator-keystore --from-file=keystore-<foo>.json`
- The secret and ConfigMap will be used by lodestar to run validator.

- Run `./restart_beacon.sh` to (re)start the beacon.
- Run `./restart_validator.sh` to (re)start the validator.

## Check the statuses of the applications in the cluster

- Services:

```
$ k get svc
NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                               AGE
kubernetes                ClusterIP   10.152.183.1     <none>        443/TCP                               590d
svc-lodestar-validator    ClusterIP   None             <none>        9002/TCP                              69m
svc-lodestar-nodeport     NodePort    10.152.183.122   <none>        9000:31007/TCP,9000:31008/UDP         157m
svc-geth                  ClusterIP   None             <none>        8545/TCP,30303/UDP                    3m22s
svc-geth-nodeport         NodePort    10.152.183.142   <none>        8545:31005/TCP,30303:31006/UDP        3m22s
svc-lodestar-beacon       ClusterIP   None             <none>        9000/TCP,9000/UDP,9001/TCP,9002/TCP   3m20s
```

- Statefulsets:

```
$ k get sts
NAME                 READY   AGE
lodestar-validator   1/1     70m
geth                 1/1     3m48s
lodestar-beacon      1/1     3m46s
```

- Pods:

```
$ k get pod
NAME                   READY   STATUS    RESTARTS        AGE
lodestar-validator-0   1/1     Running   0               69m
geth-0                 1/1     Running   0               4m2s
lodestar-beacon-0      1/1     Running   0               3m19s
```

- Consensus client (Beacon):

````
$ t lodestar-beacon
Will tail 1 logs...
lodestar-beacon-0
[lodestar-beacon-0] Jan-16 05:29:54.000[]                 info: Syncing - ? left - 0.00 slots/s - slot: 3425249 - head: 0 0xab09…f889 - exec-block: valid(0 0xb5f7…) - finalized: 0x0000…0000:0 - peers: 6
[lodestar-beacon-0] Jan-16 05:30:06.001[]                 info: Syncing - ? left - 0.00 slots/s - slot: 3425250 - head: 0 0xab09…f889 - exec-block: valid(0 0xb5f7…) - finalized: 0x0000…0000:0 - peers: 8
[lodestar-beacon-0] Jan-16 05:30:18.000[]                 info: Syncing - ? left - 0.00 slots/s - slot: 3425251 - head: 0 0xab09…f889 - exec-block: valid(0 0xb5f7…) - finalized: 0x0000…0000:0 - peers: 11
[lodestar-beacon-0] Jan-16 05:30:29.999[]                 info: Syncing - ? left - 0.00 slots/s - slot: 3425252 - head: 0 0xab09…f889 - exec-block: valid(0 0xb5f7…) - finalized: 0x0000…0000:0 - peers: 12
[lodestar-beacon-0] Jan-16 05:30:42.001[]                 info: Syncing - ? left - 0.00 slots/s - slot: 3425253 - head: 0 0xab09…f889 - exec-block: valid(0 0xb5f7…) - finalized: 0x0000…0000:0 - peers: 12
```

- Consensus client (Validator):

```
$ t lodestar-validator
Will tail 2 logs...
lodestar-validator-0 lodestar
lodestar-validator-0 copy-keystores
[lodestar-validator-0 lodestar] Jan-16 05:28:12.001[] warn: Node is syncing slot=3425241, headSlot=0, syncDistance=3425241
[lodestar-validator-0 lodestar] Jan-16 05:28:12.001[] warn: Node is syncing - getProposerDuties failed with status 503: Node is syncing - headSlot 0 currentSlot 3425241
[lodestar-validator-0 lodestar] Jan-16 05:28:24.002[] warn: Node is syncing slot=3425242, headSlot=0, syncDistance=3425242
[lodestar-validator-0 lodestar] Jan-16 05:28:24.003[] warn: Node is syncing - getProposerDuties failed with status 503: Node is syncing - headSlot 0 currentSlot 3425242
[lodestar-validator-0 lodestar] Jan-16 05:28:36.002[] warn: Node is syncing slot=3425243, headSlot=0, syncDistance=3425243
[lodestar-validator-0 lodestar] Jan-16 05:28:36.002[] warn: Node is syncing - getProposerDuties failed with status 503: Node is syncing - headSlot 0 currentSlot 3425243
[lodestar-validator-0 lodestar] Jan-16 05:28:48.001[] warn: Node is syncing slot=3425244, headSlot=0, syncDistance=3425244
[lodestar-validator-0 lodestar] Jan-16 05:28:48.002[] warn: Node is syncing - getProposerDuties failed with status 503: Node is syncing - headSlot 0 currentSlot 3425244
[lodestar-validator-0 lodestar] Jan-16 05:29:00.002[] warn: Node is syncing - getProposerDuties failed with status 503: Node is syncing - headSlot 0 currentSlot 3425245
[lodestar-validator-0 lodestar] Jan-16 05:29:00.002[] warn: Node is syncing slot=3425245, headSlot=0, syncDistance=3425245
[lodestar-validator-0 lodestar] Jan-16 05:29:12.004[] warn: Node is syncing slot=3425246, headSlot=0, syncDistance=3425246
[lodestar-validator-0 lodestar] Jan-16 05:29:24.004[] warn: Node is syncing - getProposerDuties failed with status 503: Node is syncing - headSlot 0 currentSlot 3425247
[lodestar-validator-0 lodestar] Jan-16 05:29:24.004[] warn: Node is syncing slot=3425247, headSlot=0, syncDistance=3425247
[lodestar-validator-0 lodestar] Jan-16 05:29:36.003[] info: Validator statuses pending=1, total=1
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

### Improvements

- https://github.com/ChainSafe/lodestar/discussions/7363
- https://github.com/ethereum/go-ethereum/issues/31034
- https://github.com/ChainSafe/lodestar/issues/7367

```

```
````
