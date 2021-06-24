#!/bin/bash

INTERNAL_IP=$(ip addr show eth1 | grep "inet " | awk '{print $2}' | cut -d / -f 1)
while [ -z "$INTERNAL_IP" ]; do
    sleep 1
    INTERNAL_IP=$(ip addr show eth1 | grep "inet " | awk '{print $2}' | cut -d / -f 1)
done

/opt/startup/copy-certs-and-configs-etcd.sh
/opt/startup/etcd-service.sh

systemctl daemon-reload
systemctl enable etcd
systemctl restart etcd
