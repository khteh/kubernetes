# Kubernetes

Kubernetes cluster which consists of the following components:

- RestAPI application
- Elasticsearch cluster
  - 3 Master nodes
  - 2 Slave nodes
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
pod/elasticsearch-0                           1/1     Running     0          108m
pod/elasticsearch-1                           1/1     Running     0          108m
pod/elasticsearch-init-wl24z                  0/1     Completed   0          100m
pod/elasticsearch-master-0                    1/1     Running     0          108m
pod/elasticsearch-master-1                    1/1     Running     0          108m
pod/elasticsearch-master-2                    1/1     Running     0          108m
pod/kibana-0                                  1/1     Running     0          14m
pod/kibana-1                                  1/1     Running     0          14m
pod/mysql-0                                   1/1     Running     0          140m
pod/nginx-ingress-microk8s-controller-ppplj   1/1     Running     0          142m
pod/restapi-0                                 2/2     Running     0          49m
pod/restapi-1                                 2/2     Running     0          49m
rabbitmq-0                         1/1     Running     0          3d6h
rabbitmq-1                         1/1     Running     0          3d6h
rabbitmq-2                         1/1     Running     0          3d6h
redis-cluster-0                    1/1     Running     0          14d
redis-cluster-1                    1/1     Running     0          14d
redis-cluster-2                    1/1     Running     0          14d
redis-cluster-3                    1/1     Running     0          14d
redis-cluster-4                    1/1     Running     0          14d
redis-cluster-5                    1/1     Running     0          14d

NAME                                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/default-http-backend          ClusterIP   10.152.183.205   <none>        80/TCP              143m
service/kubernetes                    ClusterIP   10.152.183.1     <none>        443/TCP             145m
service/svc-elasticsearch             ClusterIP   None             <none>        9200/TCP,9300/TCP   108m
service/svc-elasticsearch-discovery   ClusterIP   None             <none>        9300/TCP            108m
service/svc-kibana                    ClusterIP   None             <none>        8080/TCP            14m
service/svc-mysql                     ClusterIP   None             <none>        3306/TCP            140m
service/svc-restapi                   ClusterIP   None             <none>        8080/TCP,8443/TCP   49m
service/svc-rabbitmq                     ClusterIP   None             <none>        15672/TCP,5672/TCP   5d7h
service/svc-redis-cluster                ClusterIP   None             <none>        6379/TCP,16379/TCP   61d

NAME                                               DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/daemonset                           1         1         1       1            1           <none>          108m
daemonset.apps/nginx-ingress-microk8s-controller   1         1         1       1            1           <none>          143m

NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/default-http-backend   1/1     1            1           143m

NAME                                              DESIRED   CURRENT   READY   AGE
replicaset.apps/default-http-backend-5769f6bc66   1         1         1       143m

NAME                                    READY   AGE
statefulset.apps/elasticsearch          2/2     108m
statefulset.apps/elasticsearch-master   3/3     108m
statefulset.apps/kibana                 2/2     14m
statefulset.apps/mysql                  1/1     140m
statefulset.apps/restapi                2/2     49m
statefulset.apps/rabbitmq                     3/3     3d6h
statefulset.apps/redis-cluster                6/6     14d

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
# curl svc-elasticsearch-discovery:9200/_cluster/health?pretty
{
  "cluster_name" : "elasticsearch",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 5,
  "number_of_data_nodes" : 2,
  "active_primary_shards" : 16,
  "active_shards" : 32,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
# curl svc-elasticsearch-discovery:9200/_cat/indices
green open .kibana_1                      CWOkws7gRMSJTGaDEDKFOQ 1 1   5 0  50.7kb 25.3kb
green open restapi.logs-2019.03.27        4GFVDwVeSAq4SNAVfG7Lzg 5 1 228 0 467.7kb  236kb
green open restapi.access.logs-2019.03.27 4azKaBXmTcmIa8R3Vz9imA 5 1  11 0 140.1kb   70kb
green open restapi.access.logs-2019.03.28 oZjwRZdxQIybxWQ4NBZZSw 5 1   4 0  57.2kb 28.6kb
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
