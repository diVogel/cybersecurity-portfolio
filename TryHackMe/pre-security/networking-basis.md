# Networking fundametals 

# Data Link Layer

If the physical layer converts all data into signals and transmits them over optical fiber, then the data link layer is needed so that this data can be oriented within a single **network segment**.

A **network segment** is a physically limited area of a network between two devices (where a host is connected to a router or directly to another host).

At this layer, the main players are **MAC addresses**. They are used to exchange packets between host-to-host, host-to-router, and router-to-router devices, **that is, devices directly connected** to each other via **Wi-Fi or cable** (even if the IP address is known, it is impossible to transmit packets without a MAC address, because the host will not know which device to send them to)!

Types of MAC addresses:

* **Unicast** — a personal MAC address. Every network card has such an address. It is either programmed directly at the factory or installed together with the drivers.

* **Broadcast** — a broadcast MAC address, represented as all bits set to 1, or in hexadecimal format as FF:FF:FF:FF:FF:FF. Such an address in the destination field means that the packet must be processed by all hosts that receive this packet.


# Network Layer

## IP Address & IP Networks

An IP address is a universal identifier in a network, a field consisting of 4 bytes separated by dots (it is unique for each device).

* 0.0.0.0
* 192.16.0.1

*To optimize network address space, subnet masks were introduced.*

Let us agree that:

1. An IP address is not the same as an IP network.

An **IP network** is a collection of IP addresses that has a specific range of IP addresses depending on the subnet mask (and, accordingly, its notation format) within a single network segment.

**A router has some characteristics of a switch specifically in terms of combining devices into a single local segment** with a common network mask. The difference is that a router additionally provides a "gateway" for access to other networks (the Internet), while a switch cannot do this.

A subnet mask is needed to identify the network itself and the hosts within it.

For example:

* 172.16.0.0 — this is the IP network address
* 172.16.0.1 — an IP address (usually the router's address)
* 172.16.0.2 ~ 172.16.255.255 — IP addresses (addresses that hosts can use)

*As you can see, the first two bytes do not change (172.16), because they identify the network itself (that is, the network address).*

A subnet mask is a sequence of 32 bits that identifies the network.

172.16.0.1 /16 — if you add the first two bytes (172.16), you get 16 bits (since one byte contains **8 bits**). Another notation format that is often encountered is 255.255.0.0 (decimal). The first bits are set to 1 (the subnet), while the remaining bits are 0 (hosts within the subnet). The notation 255.255.255.0 corresponds to the first 24 bits being ones (that is, /24), while 255.0.0.0 corresponds to 8 one-bits (that is, /8).

*/16 is the number of one-bits in the subnet mask. Without the slash signs. For example, the mask 255.255.240.0 is /20 (11111111.11111111.11110000.00000000).*
