Helm deploys all the chart defined Deployments, Pods, Services. The redis Pod will be in a _pending_ state while the container image is downloaded and until a Persistent Volume is available. Once complete it will move into a _running_ state.

Use the _get_ command to find out what was deployed.

`watch kubectl get statefulsets,pods,services -n redis`{{execute}}

The Pod will be in a _pending_ state while the Redis container image is downloaded and until a Persistent Volume is available. You will see a `my-redis-master-0` and `my-redis-slave-0` pod. Use this `clear`{{execute interrupt}} to break out of the watch or press <kbd>Ctrl</kbd>+<kbd>C</kbd>.

> Unfortunately, the old terminology for the Pod root names remains unchanged. Perhaps the [Redis project still has room for maturation](http://antirez.com/news/122) and a future chart will correct the tight coupling to these names.

Create a Persistent Volume for Redis.

`kubectl apply -f pv.yaml`{{execute}}

and ensure Redis has permissions to write to these mount points.

`mkdir /mnt/data1 /mnt/data2 /mnt/data3 --mode=777`{{execute}}

Now, notice Pod status will change to _Running_.

`watch kubectl get statefulsets,pods,services -n redis`{{execute}}

In a moment and all the 3 Pods will move to the _Running_ state. Use this `clear`{{execute interrupt}} to break out of the watch or press <kbd>Ctrl</kbd>+<kbd>C</kbd>.

You have successfully installed Redis. The redis-cli tool has been installed for this scenario so you can verify Redis on Kubernetes is responding. When the chart installed there were some helpful instruction on how to connect. The following are those instructions.

## Connect to Your Redis Server

To get your password query the Redis Secret.

`export REDIS_PASSWORD=$(kubectl get secret --namespace redis my-redis -o jsonpath="{.data.redis-password}" | base64 --decode)`{{execute}}

Expose the Redis master service.

`kubectl port-forward --namespace redis service/my-redis-master 6379:6379 > /dev/null &`{{execute}}

Connect to your database from outside the cluster.

`redis-cli -h 127.0.0.1 -p 6379 -a $REDIS_PASSWORD ping`{{execute}}

If you see `PONG` as the response you have connected successfully to the Redis application installed by the Helm chart. Nice work!
