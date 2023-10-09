#!/bin/sh
echo "Generating configmap for delegation nginx instance"
cd delegation
dos2unix delegation-default.conf
kubectl create cm delegation-conf --from-file=delegation-default.conf -o yaml --dry-run=client > delegation-configmap.yaml
cd ..

echo "Generating configmap for postgres instance"
cd postgres
dos2unix my-postgres.conf
kubectl create configmap postgres-config --from-file=my-postgres.conf -o yaml --dry-run=client > postgres-config.yaml
cd ..

echo "Generating configmap for synapse configuration"
cd synapse
dos2unix homeserver.yaml
dos2unix log.yaml
dos2unix homeserver.signing.key
dos2unix appservice-registration-irc.yaml
kubectl create configmap synapse-config --from-file=homeserver.yaml --from-file=homeserver.signing.key --from-file=log.yaml --from-file=appservice-registration-irc.yaml -o yaml --dry-run=client > synapse-configmap.yaml

echo "Generating configmap for synapse load balancer"
dos2unix synapse-lb-proxy-settings.conf
dos2unix synapse-lb.conf
kubectl create configmap synapse-lb-config --from-file=synapse-lb.conf --from-file=synapse-lb-proxy-settings.conf -o yaml --dry-run=client > synapse-lb-configmap.yaml

echo "Generating configmap for synapse workers"
cd workers

dos2unix additional1_log_config.yaml
dos2unix additional1.yaml
dos2unix appservice.yaml
dos2unix federation_sender1_log_config.yaml
dos2unix federation_sender1.yaml
dos2unix federation_sender2_log_config.yaml
dos2unix federation_sender2.yaml
dos2unix federation_sender3_log_config.yaml
dos2unix federation_sender3.yaml
dos2unix generic_worker1_log_config.yaml
dos2unix generic_worker1.yaml
dos2unix generic_worker2_log_config.yaml
dos2unix generic_worker2.yaml
dos2unix generic_worker3_log_config.yaml
dos2unix generic_worker3.yaml
dos2unix generic_worker4_log_config.yaml
dos2unix generic_worker4.yaml
dos2unix presence_log_config.yaml
dos2unix presence.yaml
dos2unix pusher_log_config.yaml
dos2unix pusher.yaml

kubectl create configmap synapse-worker-config \
    --from-file=additional1_log_config.yaml \
    --from-file=additional1.yaml \
    --from-file=appservice.yaml \
    --from-file=federation_sender1_log_config.yaml \
    --from-file=federation_sender1.yaml \
    --from-file=federation_sender2_log_config.yaml \
    --from-file=federation_sender2.yaml \
    --from-file=federation_sender3_log_config.yaml \
    --from-file=federation_sender3.yaml \
    --from-file=generic_worker1_log_config.yaml \
    --from-file=generic_worker1.yaml \
    --from-file=generic_worker2_log_config.yaml \
    --from-file=generic_worker2.yaml \
    --from-file=generic_worker3_log_config.yaml \
    --from-file=generic_worker3.yaml \
    --from-file=generic_worker4_log_config.yaml \
    --from-file=generic_worker4.yaml \
    --from-file=presence_log_config.yaml \
    --from-file=presence.yaml \
    --from-file=pusher_log_config.yaml \
    --from-file=pusher.yaml \
    -o yaml --dry-run=client > synapse-worker-configmap.yaml
mv synapse-worker-configmap.yaml ..
cd ../..