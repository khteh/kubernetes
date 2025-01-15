# Ethereum Node

## References

- https://ethereum.org/en/developers/docs/nodes-and-clients/run-a-node/
- https://github.com/ethereum/go-ethereum
- https://chainsafe.github.io/lodestar/run/getting-started/quick-start-custom-guide

## Assumptions

- Every ethereum node consists of 1:1 mapping between execution and consensus clients bound by their shared JWT secret. Therefore, only single instance (replica) of each is created. I do not know what will happen if replica is set to more than 1.

## Run k8s cluster locally

- Install microk8s: https://microk8s.io/docs/getting-started

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

## Deploy to public cloud

### AWS

- Create a k8s cluster with nodes of at least 8 cores and 32GB: Run https://github.com/khteh/kubernetes/blob/master/create_cluster.sh
- Add `storageClassName: gp3` to the geth.yml and lodestar.yml to use local SSD attached to the nodes for the Ethereum client data.
- Once the cluster is up and running, AWS Cloudformation will show the infrastructure setup.

## Application updates

- Run `update.sh [geth|lodestar] <tag>`. It does the following:
  (1) It first checks if the tag of the image exists in docker hub
  (2) If it does, update the docker image version of the running STS

## Notes

- I do not use Terraform to spin up cloud infrastructure in this case because I consider the infrastructure to be less like to change compared to the applications running on it. However, Terraform is a great tool which can be used to document and version control the infrastructure setup.
- We can use tool like https://github.com/DontShaveTheYak/cf2tf to convert from AWS Cloudformation to Terraform.
