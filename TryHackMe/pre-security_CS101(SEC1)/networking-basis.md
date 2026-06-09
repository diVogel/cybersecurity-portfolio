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

## ARP

The ARP protocol is used to determine the recipient's MAC address based on its IP address. It operates on a **request-response** principle. When sending a request, the value of the **THA** field is set to FF:FF:FF:FF:FF:FF. Due to broadcasting, this request is received by all devices located within the same network segment. After receiving the request, the destination host compares the IP address in the request with its own IP address. If they match, it generates a reply containing its MAC address (otherwise, the request is ignored).

After learning the recipient's MAC address, the sender host stores it in its cache.

| IP Address | MAC Address | Dynamic/Static |
| ---------- | ----------- | -------------- |

*Dynamic entries are typically stored for about 40 seconds and are removed after expiration.*

| Field   | Purpose                 | Notes                          |
| ------- | ----------------------- | ------------------------------ |
| **SHA** | Sender's MAC address    | -                              |
| **SPA** | Sender's IP address     | -                              |
| **THA** | Recipient's MAC address | Field value: FF:FF:FF:FF:FF:FF |
| **TPA** | Recipient's IP address  | -                              |

Packet transmission within a single network segment occurs as follows:

1. Before sending packets, Host_1 checks its ARP cache for the recipient's MAC address. If it is not present, Host_1 sends an ARP request.
2. Host_2 compares the IP address in the request. If the address belongs to it, it sends a reply containing its MAC address.
3. Host_1 stores the MAC address in its cache and sends packets using that MAC address.



## Packet Transmission Between Different Network Segments

**Host_1 --- Router --- Host_2**

Host_1 and Host_2 are located in different network segments. For Host_2 to receive packets, Host_1 must direct the traffic to the Router, thereby transferring responsibility for further delivery to it. However, hosts do not have an understanding of the network topology, so they do not know what exists beyond the router. This is where the routing table becomes useful. Routing tables exist on both hosts and routers.

A routing table has two columns:

**Destination IP** → **Router IP**

The host compares the IP address from the packet header with the **Destination IP** column in the routing table to determine the corresponding **Router IP**, which belongs to a device capable of forwarding the data to the recipient.

*Usually this is either the host itself or the router to which it is connected.*

1. Before sending packets, the sending host checks the routing table.
2. If the sender and recipient are located within the same network segment, the packets are sent directly (1) or (m).
3. If the sender and recipient are located in different network segments, the **Router IP** field in the sender's routing table will contain the IP address of the router to which the host is connected (2).
4. The sending host then checks the routing table again to find a path to the router itself.
5. Since the sending host and the router are directly connected, step 2 is performed.

| Destination IP |  Router IP |
| :------------: | :--------: |
|       ...      |     ...    |
|  (1) 10.0.0.2  |  10.0.0.1  |
| (m) 10.0.0.100 |  10.0.0.1  |
| (2) 172.16.0.3 | 10.0.0.100 |

If the number of connected IP networks becomes too large, adding a new entry (n.n.n.n → router IP) for every new network would overload the routing table. To solve this, the following changes were introduced.

1. Within a single network segment, when packets are sent directly, the **network address itself** is used as the destination instead of individual host IP addresses: **10.0.0.0/24**. This entry covers all hosts that belong to that network.

2. During inter-network communication, all traffic **must pass through a router**. Therefore, instead of having dozens of entries with the same router IP but different destination addresses, a single entry is used where the destination is **0.0.0.0/0**. This entry matches all IP networks except the local network, automatically forwarding traffic along a predefined route.

*This type of entry is called the **default route**.*

|        Destination IP       |  Router IP |
| :-------------------------: | :--------: |
| 0.0.0.0/0 (default gateway) | 10.0.0.100 |
|       (1) 10.0.0.0/24       |  10.0.0.1  |
|             ...             |     ...    |


host_1(ip:10...) --- router1 (ip:192.168.1.0) --- router2 --- router3 (ip:172.16.12.0) --- host_2 (ip:169...)

The default route merely transfers responsibility, which is why there are routers that know routes to all networks. This area is known as the **Default-Free Zone (DFZ)**.

For such a network to function, Router_2 must have information about the networks 10.0.0.0/24 and 169.254.1.0/24.

| Destination IP | Router IP     |
| -------------- | ------------- |
| 192.168.1.0/24 | 192.168.1.102 |
| 172.16.12.0/24 | 172.16.12.102 |
| 10.0.0.0/24    | 192.168.1.101 |
| 169.254.1.0/24 | 172.16.12.103 |
