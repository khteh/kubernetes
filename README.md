# Kubernetes
Kubernetes cluster which consists of the following elements:
```
$ k get all
NAME                                          READY   STATUS      RESTARTS   AGE
pod/daemonset-8s4zs                           1/1     Running     0          66m
pod/default-http-backend-5769f6bc66-tslnj     1/1     Running     0          101m
pod/elasticsearch-0                           1/1     Running     0          66m
pod/elasticsearch-1                           1/1     Running     0          66m
pod/elasticsearch-init-wl24z                  0/1     Completed   0          59m
pod/elasticsearch-master-0                    1/1     Running     0          66m
pod/elasticsearch-master-1                    1/1     Running     0          66m
pod/elasticsearch-master-2                    1/1     Running     0          66m
pod/mysql-0                                   1/1     Running     0          98m
pod/nginx-ingress-microk8s-controller-ppplj   1/1     Running     0          100m
pod/restapi-0                                 2/2     Running     0          7m54s
pod/restapi-1                                 2/2     Running     0          7m46s

NAME                                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/default-http-backend          ClusterIP   10.152.183.205   <none>        80/TCP              101m
service/kubernetes                    ClusterIP   10.152.183.1     <none>        443/TCP             103m
service/svc-elasticsearch             ClusterIP   None             <none>        9200/TCP,9300/TCP   66m
service/svc-elasticsearch-discovery   ClusterIP   None             <none>        9300/TCP            66m
service/svc-mysql                     ClusterIP   None             <none>        3306/TCP            98m
service/svc-restapi                   ClusterIP   None             <none>        8080/TCP,8443/TCP   8m5s

NAME                                               DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/daemonset                           1         1         1       1            1           <none>          66m
daemonset.apps/nginx-ingress-microk8s-controller   1         1         1       1            1           <none>          101m

NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/default-http-backend   1/1     1            1           101m

NAME                                              DESIRED   CURRENT   READY   AGE
replicaset.apps/default-http-backend-5769f6bc66   1         1         1       101m

NAME                                    READY   AGE
statefulset.apps/elasticsearch          2/2     66m
statefulset.apps/elasticsearch-master   3/3     66m
statefulset.apps/mysql                  1/1     98m
statefulset.apps/restapi                2/2     8m5s

NAME                           COMPLETIONS   DURATION   AGE
job.batch/elasticsearch-init   1/1           6s         59m
```
# Check the application:
* `curl -L localhost/restapi/greeting --http2 --insecure`
* `curl -L localhost/restapi/greeting?name=Kok%20How --http2 --insecure`
