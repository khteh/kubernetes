# Kubernetes
Kubernetes cluster which consists of the following elements:
```
$ k get all
NAME                                          READY   STATUS    RESTARTS   AGE
pod/default-http-backend-855bc7bc45-qcszp     1/1     Running   0          4h27m
pod/mysql-0                                   1/1     Running   0          110m
pod/nginx-585cb9d855-9lkr4                    1/1     Running   0          6m6s
pod/nginx-ingress-microk8s-controller-fm5ft   1/1     Running   0          4h27m
pod/web-0                                     1/1     Running   0          7m26s

NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
service/default-http-backend   ClusterIP   10.152.183.245   <none>        80/TCP                       4h27m
service/kubernetes             ClusterIP   10.152.183.1     <none>        443/TCP                      4h32m
service/svc-frontend           NodePort    10.152.183.158   <none>        80:31619/TCP,443:31292/TCP   6m6s
service/svc-mysql              ClusterIP   None             <none>        3306/TCP,9999/TCP            110m
service/svc-web                ClusterIP   None             <none>        8080/TCP,8443/TCP            82m

NAME                                               DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/nginx-ingress-microk8s-controller   1         1         1       1            1           <none>          4h27m

NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/default-http-backend   1/1     1            1           4h27m
deployment.apps/nginx                  1/1     1            1           6m6s

NAME                                              DESIRED   CURRENT   READY   AGE
replicaset.apps/default-http-backend-855bc7bc45   1         1         1       4h27m
replicaset.apps/nginx-585cb9d855                  1         1         1       6m6s

NAME                          READY   AGE
statefulset.apps/mysql        1/1     110m
statefulset.apps/web          1/1     7m26s

NAME                                              REFERENCE                TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/istio-pilot   Deployment/istio-pilot   <unknown>/55%   1         1         0          4h27m
```
# Check the application:
* visit http://clusterip/restapi/greeting
