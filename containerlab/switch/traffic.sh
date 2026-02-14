#!/bin/sh
# Simple script to generate bidirectional traffic between hostA and hostB
# Assumes the topology is up and IP addresses are assigned to eth1 on both hosts.

# remote IPs (modify if needed)
HOSTA_IP=10.0.0.1
HOSTB_IP=10.0.0.2

# start ping from A to B
clab --topo topology.yml exec hostA -- sh -c "ping -c 0 $HOSTB_IP &" >/dev/null 2>&1

# start ping from B to A
clab --topo topology.yml exec hostB -- sh -c "ping -c 0 $HOSTA_IP &" >/dev/null 2>&1

# report that traffic is running
echo "Bidirectional ping started between $HOSTA_IP and $HOSTB_IP."

echo "Use 'clab --topo topology.yml exec hostX -- pkill ping' to stop."
