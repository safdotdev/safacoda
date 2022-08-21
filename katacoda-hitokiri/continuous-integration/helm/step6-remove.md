Now that Redis is running, take it back down. After all, these installations should not be precious [snowflakes](https://martinfowler.com/bliki/SnowflakeServer.html).

`helm delete my-redis -n redis`{{execute}}

No matter how complex the chart, the delete command will undo everything the install provisioned. The only thin left behind will be the namespace. Delete the namespace if you wish.

`kubectl delete namespace redis`{{execute}}

Next, explore the wealth of charts available.
