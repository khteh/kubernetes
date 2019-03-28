# Kubernetes
Kubernetes cluster which consists of the following components:
* RestAPI application
* Elasticsearch cluster
* Redis cluster
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

NAME                                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/default-http-backend          ClusterIP   10.152.183.205   <none>        80/TCP              143m
service/kubernetes                    ClusterIP   10.152.183.1     <none>        443/TCP             145m
service/svc-elasticsearch             ClusterIP   None             <none>        9200/TCP,9300/TCP   108m
service/svc-elasticsearch-discovery   ClusterIP   None             <none>        9300/TCP            108m
service/svc-kibana                    ClusterIP   None             <none>        8080/TCP            14m
service/svc-mysql                     ClusterIP   None             <none>        3306/TCP            140m
service/svc-restapi                   ClusterIP   None             <none>        8080/TCP,8443/TCP   49m

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

NAME                                              REFERENCE             TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/kibana-hpa    StatefulSet/kibana    3%/75%    2         5         2          74s
horizontalpodautoscaler.autoscaling/restapi-hpa   StatefulSet/restapi   1%/75%    2         5         2          23m

NAME                           COMPLETIONS   DURATION   AGE
job.batch/elasticsearch-init   1/1           6s         100m
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
## Horizontal Pod Autoscaler:
```
$ k get hpa
NAME          REFERENCE             TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
kibana-hpa    StatefulSet/kibana    11%/75%   2         5         2          20s
restapi-hpa   StatefulSet/restapi   1%/75%    2         5         2          22m
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
* Point the browser to the Grafana URL given by the cluster-info above

## Kibana:
* Point the browser to localhost/kibana

## Check the application:
* `curl -L localhost/restapi/greeting --http2 --insecure`
* `curl -L localhost/restapi/greeting?name=Kok%20How --http2 --insecure`
