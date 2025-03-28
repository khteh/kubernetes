# Kubernetes

Kubernetes cluster which consists of the following components:

- RestAPI applications
- Databases
  - PostgreSQL
  - Neo4J
- Elasticsearch cluster
  - 3 Master nodes
  - 5 Slave nodes
- Redis cluster
- RabbitMQ cluster
- Ethereum node which consists of:
  - Executor (GETH)
  - Consensus (Lodestar Beacon and Validator)

## Prerequisites

- Install microk8s
- Install awscli
- Run `aws config` to set up aws configurations and credentials

## Update kubeconfig

- `aws eks update-kubeconfig --region <region> --name <cluster name>`
- The step above will update `~/.kube/config`
- However, `microk8s.kubectl` uses the config in `/var/snap/microk8s/current/credentials/client.config`
- So, copy the EKS config from `~/.kube/config` to `/var/snap/microk8s/current/credentials/client.config`

## Set Aliases

`snap alias microk8s.kubectl kubectl`

## List and use contexts

- `kubectl config get-contexts` will show available clusters, both local and remote:

  ```
  $ k config get-contexts
  CURRENT   NAME        CLUSTER            AUTHINFO    NAMESPACE
  *         mycluster   mycluster          myuser
            microk8s    microk8s-cluster   admin
  ```

- `kubectl config use-context` to select a cluster to work with.

![Kubernetes cluster](./k8s.jpg?raw=true "Kubernetes Cluster")

```
$ k get all
NAME                                          READY   STATUS      RESTARTS   AGE
pod/daemonset-8s4zs                           1/1     Running     0          108m
pod/default-http-backend-5769f6bc66-tslnj     1/1     Running     0          143m
pod/khteh-es-es-master-0                      1/1     Running     0          3m18s
pod/khteh-es-es-master-1                      1/1     Running     0          3m18s
pod/khteh-es-es-master-2                      1/1     Running     0          3m18s
pod/khteh-es-es-data-0                        1/1     Running     0          3m18s
pod/khteh-es-es-data-1                        1/1     Running     0          3m17s
pod/khteh-es-es-data-3                        1/1     Running     0          3m17s
pod/khteh-es-es-data-4                        1/1     Running     0          3m17s
pod/khteh-es-es-data-2                        1/1     Running     0          3m17s
pod/khteh-kibana-kb-fcd8b8985-rjlwc           1/1     Running     0          3m58s
pod/khteh-kibana-kb-fcd8b8985-8sp56           1/1     Running     0          3m57s
pod/kibana-0                                  1/1     Running     0          14m
pod/kibana-1                                  1/1     Running     0          14m
pod/postgresql-0                              1/1     Running     8 (4h10m ago)     3d22h
pod/neo4j-0                                   1/1     Running     0          14m
pod/nginx-ingress-microk8s-controller-ppplj   1/1     Running     0          142m
pod/nodejsrestapi-0                           2/2     Running     0          30s
pod/nodejsrestapi-1                           2/2     Running     0          30s
pod/pythonrestapi-0                           2/2     Running     0          49m
pod/pythonrestapi-1                           2/2     Running     0          49m
pod/rabbitmq-0                                1/1     Running     0          3d6h
pod/rabbitmq-1                                1/1     Running     0          3d6h
pod/rabbitmq-2                                1/1     Running     0          3d6h
pod/redis-cluster-0                           1/1     Running     0          14d
pod/redis-cluster-1                           1/1     Running     0          14d
pod/redis-cluster-2                           1/1     Running     0          14d
pod/redis-cluster-3                           1/1     Running     0          14d
pod/redis-cluster-4                           1/1     Running     0          14d
pod/redis-cluster-5                           1/1     Running     0          14d

NAME                                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/default-http-backend          ClusterIP   10.152.183.205   <none>        80/TCP              143m
service/kubernetes                    ClusterIP   10.152.183.1     <none>        443/TCP             145m
service/khteh-es-es-transport         ClusterIP   None             <none>        9300/TCP            5m18s
service/khteh-es-es-http              ClusterIP   10.152.183.80    <none>        9200/TCP            5m18s
service/khteh-es-es-internal-http     ClusterIP   10.152.183.49    <none>        9200/TCP            5m18s
service/khteh-es-es-master            ClusterIP   None             <none>        9200/TCP            5m16s
service/khteh-es-es-data              ClusterIP   None             <none>        9200/TCP            5m16s
service/khteh-kibana-kb-http          ClusterIP   10.152.183.49    <none>        5601/TCP            6m33s
service/svc-postgresql                ClusterIP   None             <none>        5432/TCP            3d22h
service/svc-postgresql-nodeport       NodePort    10.152.183.70    <none>        5432:30000/TCP      3d22h
service/svc-nodejsrestapi             ClusterIP   None             <none>        443/TCP             70s
service/svc-nodejsrestapi-nodeport    NodePort    10.152.183.243   <none>        443:31005/TCP       69s
service/svc-pythonrestapi             ClusterIP   None             <none>        80/TCP,443/UDP      49m
service/svc-pythonrestapi-nodeport    NodePort    10.152.183.195   <none>        443:31002/UDP       49m
service/svc-rabbitmq                  ClusterIP   None             <none>        15672/TCP,5672/TCP  5d7h
service/svc-redis-cluster             ClusterIP   None             <none>        6379/TCP,16379/TCP  61d
service/svc-ragagent                  ClusterIP   None             <none>        80/TCP,4433/TCP,443/UDP                        20h
service/svc-ragagent-nodeport         NodePort    10.152.183.66    <none>        443:31003/TCP,443:31004/UDP                    20h
service/svc-neo4j                     ClusterIP   None             <none>        7473/TCP,7474/TCP,7687/TCP                     5m56s
service/svc-neo4j-nodeport            NodePort    10.152.183.170   <none>        7473:30002/TCP,7474:30003/TCP,7687:30004/TCP   5m56s

NAME                                               DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/daemonset                           1         1         1       1            1           <none>          108m
daemonset.apps/nginx-ingress-microk8s-controller   1         1         1       1            1           <none>          143m

NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/default-http-backend   1/1     1            1           143m
khteh-kibana-kb                        2/2     2            2           7m45s

NAME                                              DESIRED   CURRENT   READY   AGE
replicaset.apps/default-http-backend-5769f6bc66   1         1         1       143m

NAME                                    READY   AGE
statefulset.apps/khteh-es-es-master     3/3     16m
statefulset.apps/khteh-es-es-data       5/5     16m
statefulset.apps/postgresql             1/1     140m
statefulset.apps/neo4j                  1/1     140m
statefulset.apps/nodejsrestapi          2/2     105s
statefulset.apps/pythonrestapi          2/2     49m
statefulset.apps/rabbitmq               3/3     3d6h
statefulset.apps/redis-cluster          6/6     14d

NAME                                              REFERENCE             TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/kibana-hpa    StatefulSet/kibana    3%/75%    2         5         2          74s
horizontalpodautoscaler.autoscaling/restapi-hpa   StatefulSet/restapi   1%/75%    2         5         2          23m
horizontalpodautoscaler.autoscaling/rabbitmq-hpa  StatefulSet/rabbitmq  15%/75%   3         6         3          4d5h

NAME                           COMPLETIONS   DURATION   AGE
job.batch/elasticsearch-init   1/1           6s         100m
```

## Redis Cluster:

- 3 master nodes
- 3 slave nodes

```
cluster_state:ok
cluster_slots_assigned:16384
cluster_slots_ok:16384
cluster_slots_pfail:0
cluster_slots_fail:0
cluster_known_nodes:6
cluster_size:3
cluster_current_epoch:6
cluster_my_epoch:1
cluster_stats_messages_ping_sent:1208
cluster_stats_messages_pong_sent:1178
cluster_stats_messages_sent:2386
cluster_stats_messages_ping_received:1173
cluster_stats_messages_pong_received:1208
cluster_stats_messages_meet_received:5
cluster_stats_messages_received:2386
redis-cluster-0
master
1680
10.1.1.80
6379
1680

redis-cluster-1
master
1666
10.1.1.81
6379
1666

redis-cluster-2
master
1666
10.1.1.79
6379
1666

redis-cluster-3
slave
10.1.1.78
6379
connected
1666

redis-cluster-4
slave
10.1.1.76
6379
connected
1680

redis-cluster-5
slave
10.1.1.77
6379
connected
1666
```

## Elasticsearch Cluster:

```
$ k get es
NAME       HEALTH   NODES   VERSION   PHASE   AGE
khteh-es   green    8       8.17.3    Ready   5m35s
```

## Kibana

```
$ k get kibana
NAME           HEALTH   NODES   VERSION   AGE
khteh-kibana   green    2       8.17.3    5m5s
```

## RabbitMQ Cluster:

```
# rabbitmqctl cluster_status
Cluster status of node rabbit@rabbitmq-0.svc-rabbitmq.default.svc.cluster.local ...
[{nodes,[{disc,['rabbit@rabbitmq-0.svc-rabbitmq.default.svc.cluster.local',
                'rabbit@rabbitmq-1.svc-rabbitmq.default.svc.cluster.local',
                'rabbit@rabbitmq-2.svc-rabbitmq.default.svc.cluster.local']}]},
 {running_nodes,['rabbit@rabbitmq-2.svc-rabbitmq.default.svc.cluster.local',
                 'rabbit@rabbitmq-1.svc-rabbitmq.default.svc.cluster.local',
                 'rabbit@rabbitmq-0.svc-rabbitmq.default.svc.cluster.local']},
 {cluster_name,<<"rabbit@rabbitmq-0.svc-rabbitmq.default.svc.cluster.local">>},
 {partitions,[]},
 {alarms,[{'rabbit@rabbitmq-2.svc-rabbitmq.default.svc.cluster.local',[]},
          {'rabbit@rabbitmq-1.svc-rabbitmq.default.svc.cluster.local',[]},
          {'rabbit@rabbitmq-0.svc-rabbitmq.default.svc.cluster.local',[]}]}]
```

## Horizontal Pod Autoscaler:

```
$ k get hpa
NAME          REFERENCE             TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
kibana-hpa    StatefulSet/kibana    11%/75%   2         5         2          20s
restapi-hpa   StatefulSet/restapi   1%/75%    2         5         2          22m
rabbitmq-hpa  StatefulSet/rabbitmq  41%/75%   3         6         3          4d5h
```

## Cluster Information:

```
$ microk8s.kubectl cluster-info
Kubernetes master is running at https://127.0.0.1:16443
Heapster is running at https://127.0.0.1:16443/api/v1/namespaces/kube-system/services/heapster/proxy
KubeDNS is running at https://127.0.0.1:16443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://127.0.0.1:16443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy
Grafana is running at https://127.0.0.1:16443/api/v1/namespaces/kube-system/services/monitoring-grafana/proxy
InfluxDB is running at https://127.0.0.1:16443/api/v1/namespaces/kube-system/services/monitoring-influxdb:http/proxy
```

## Dashboard:

- Point the browser to the Grafana URL given by the cluster-info above

## Kibana:

- Point the browser to localhost/kibana
- Supports GeoIP

## Check the application:

- `curl -L localhost/restapi/greeting --http2 --insecure`
- `curl -L localhost/restapi/greeting?name=Mickey%20Mouse --http2 --insecure`

## Manifest validation

- `sudo apt install -y yamllint`
- `yamllint <filename>.yml`
