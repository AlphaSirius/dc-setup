# Simple Switch Topology

This example uses ContainerLab to simulate a switch as a basic Linux container with a bridge.

## Nodes

- `switch1` – linux container acting as a switch (you'll need to configure a bridge inside after deployment)
- `hostA`, `hostB` – two end-host containers connected to the switch

## Deploy

```sh
cd switch
containerlab deploy --topo topology.yml

# configure the switch container
clab --topo topology.yml exec switch1 -- apk add bridge-utils
clab --topo topology.yml exec switch1 -- brctl addbr br0
clab --topo topology.yml exec switch1 -- brctl addif br0 eth1
clab --topo topology.yml exec switch1 -- brctl addif br0 eth2
clab --topo topology.yml exec switch1 -- ip link set br0 up
```

Now `hostA` and `hostB` will be in the same L2 domain and can ping each other if you set IPs.

```sh
clab --topo topology.yml exec hostA -- ip addr add 10.0.0.1/24 dev eth1
clab --topo topology.yml exec hostB -- ip addr add 10.0.0.2/24 dev eth1
clab --topo topology.yml exec hostA -- ping -c 2 10.0.0.2
```

Destroy when finished:

```sh
containerlab destroy --topo topology.yml
```
