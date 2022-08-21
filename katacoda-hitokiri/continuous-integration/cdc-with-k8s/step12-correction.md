The problem is in the producer (Agregator) code so ensure you are in that directory.

`cd ~/cdc-with-k8s/aggregator`{{execute}}

You are now deep into this scenario and have been patient,so let's cut right to the problem.

Look at the code in models/Country.java.

`sed -n '{;=;p}' src/main/java/com/dijure/aggregator/models/Country.java | sed "N;s/\n/ /g" | sed -n '65,70p;!d'`{{execute}}

**There's the bugger...** Someone left in some testing code with an experimentation comment! [Oh... the humanity.](https://www.youtube.com/watch?v=kEpLncBG_Nw)

Find and remove the offending line.

`OFFENDING_LINE=$(sed -n '\|population = 0;|=' src/main/java/com/dijure/aggregator/models/Country.java)`{{execute}}

`sed -i "${OFFENDING_LINE}d" src/main/java/com/dijure/aggregator/models/Country.java`{{execute}}

Verify the [moth has been removed from the relay](https://en.wikipedia.org/wiki/Software_bug).

`sed -n '{;=;p}' src/main/java/com/dijure/aggregator/models/Country.java | sed "N;s/\n/ /g" | sed -n '65,70p;!d'`{{execute}}
