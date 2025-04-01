## 📘 **Chapter 20: Unicast Routing**

### 🌍 **20.1 Introduction**
- **Unicast routing**: routes a packet from one source to one destination.
- The Internet is modeled as a **graph** (nodes = routers, edges = links with cost).
- **Routing tables** are used to determine best forwarding paths.

---

### 📊 **20.1.2 Least-Cost Routing**
- Modeled using **weighted graphs**.
- Goal: find path with **least total cost**.
- **Least-Cost Tree (LCT)**: a tree rooted at a node showing shortest paths to all others.
- Cost from A → G = G → A (symmetric for least-cost).

---

### 🤖 **20.2 Routing Algorithms**

#### 📌 **20.2.1 Distance-Vector Routing**
- Each node starts with knowledge of **direct neighbors**.
- Nodes exchange their vectors (tables) periodically with neighbors.
- Based on **Bellman-Ford Equation**:
  \[
  D_x(y) = \min_{v} \{c(x,v) + D_v(y)\}
  \]
- **Slow convergence**, but simple and memory-efficient.
- Susceptible to **count-to-infinity problem**.

#### 📌 **20.2.2 Link-State Routing**
- Each router floods its **link-state packets (LSPs)** to all others.
- LSP contains router ID and link costs.
- All routers build a **Link-State Database (LSDB)** and run **Dijkstra’s algorithm** to build shortest-path tree.
- More memory and computation, but faster convergence and accurate.

---

## 📘 **Chapter 24: Transport Layer Protocols**

### 🚧 **24.1 Introduction**
- Ensures **process-to-process** communication (not just host-to-host).
- Implements:
  - **Encapsulation/Decapsulation**
  - **Flow control**
  - **Error control**
  - **Congestion control**

---

### 🛰️ **24.2 UDP (User Datagram Protocol)**
- **Connectionless**, **unreliable**, **lightweight**
- Used for:
  - Streaming, VoIP, DNS
- Header: 8 bytes total
  - Source Port, Destination Port
  - Length, Checksum (optional)

---

### 🔁 **24.3 TCP (Transmission Control Protocol)**

#### ✅ **24.3.1 TCP Services**
- **Reliable**, **connection-oriented**, **full-duplex**
- Provides sequencing, acknowledgments, retransmissions.

#### 🔢 **24.3.2 Sequence & Acknowledgment Numbers**
- **Sequence number**: byte number of first byte in segment.
- **Acknowledgment number**: next expected byte.

---

#### 🧱 **24.3.4 TCP Connection**
1. **Connection Establishment**: 3-way handshake (SYN, SYN-ACK, ACK)
2. **Data Transfer**: segments with sequence numbers and acks
3. **Connection Termination**: 4-segment close or half-close

---

### 🧠 **24.3.5 TCP State Machines**

#### 📥 **TCP Receiver FSM (Figure 24.23)**

![FSM Receiver](attachment)

**States and Events**:
| Event | Action |
|-------|--------|
| **Expected segment (no errors)** | Buffer it, update `Rn`, ACK (immediate or delayed) |
| **ACK-delay timer expired** | Send delayed ACK |
| **Out-of-order but error-free** | Store if not duplicate, send duplicate ACK |
| **Duplicate or out-of-window** | Discard and send duplicate ACK |
| **Corrupted segment** | Discard |
| **App requests delivery** | Deliver, slide window |

---
