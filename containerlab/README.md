# ContainerLab DC Spine-Leaf Lab

This directory contains a ContainerLab topology for a simple data-center leaf-spine architecture.

## Topology Overview

- **Border switches:** `border1`, `border2` (Nokia VR-SROS)
- **Spine switches:** `spine1`, `spine2`, `spine3` (Nokia VR-SROS)
- **Leaf switches:** `leaf1`, `leaf2`, `leaf3` (Nokia VR-SROS)
- **Servers:** Six Linux containers (`srv1`..`srv6`), two attached to each leaf.
  - Each server node is given **8 GB of RAM** via container resources config.

The spine and border switches are fully meshed according to a typical DC design. Leaf nodes connect "down" to two servers each.

## Prerequisites

1. [Install ContainerLab](https://containerlab.dev):
   ```sh
   curl -sLS https://get.containerlab.dev | sudo bash
   ```
2. Docker must be running and you should have enough memory to support the nodes.
3. Management interfaces (switches **and** servers) are configured to obtain addresses via DHCP. Ensure a DHCP server is reachable on the management network or configure addresses manually after deploy.
4. Images used in this example are Nokia VR‑SROS and Alpine Linux; modify as needed.

## Quick start

From the `containerlab` directory:

```sh
# bring up the lab
containerlab deploy --topo topology.yml

# verify nodes
containerlab nodes

# stop/remove lab when done
containerlab destroy --topo topology.yml
```

You can also ssh into devices using the `clab` binary:

```sh
clab --topo topology.yml exec border1 -- bash
```

---

### Additional topology

A very simple L2 switch example has been placed under `containerlab/switch`:

```sh
cd containerlab/switch
containerlab deploy --topo topology.yml
```

Follow the instructions in `containerlab/switch/README.md` to configure the bridge and test connectivity between two hosts.
