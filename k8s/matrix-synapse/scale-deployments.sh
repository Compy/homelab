#!/bin/sh


for d in delegation-nginx grafana prometheus-deployment synapse synapse-pusher-worker synapse-additional1-worker synapse-generic-worker1 synapse-generic-worker2 synapse-generic-worker3 synapse-generic-worker4 synapse-lb
do
	kubectl scale deployment $d --replicas=0 -n matrix-synapse
done
