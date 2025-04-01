# 📘 Chapter 8: **Switching**

---

## 🔄 **8.1 INTRODUCTION**

### 📌 What is switching?

Switching is used to **connect multiple devices** in a network efficiently so they can **communicate one-to-one**.

- **Switches**: Special nodes/devices that create **temporary paths** for data between two or more connected devices.

---

### 🧭 Three Types of Switching

| Type | Description |
|------|-------------|
| **Circuit Switching** | Pre-established dedicated path |
| **Packet Switching** | Data split into packets, sent independently |
| **Message Switching** | Whole message sent and stored at each switch (rarely used today) |

🔍 **Packet Switching** has 2 forms:
- **Datagram switching** (like the internet)
- **Virtual-circuit switching** (like ATM/MPLS)

---

## 🔌 **8.2 Circuit-Switched Networks**

### 🧱 Structure
- Network of switches linked by physical circuits.
- Each **link** is divided into multiple **channels** (via **FDM** or **TDM**).
- Example: Traditional telephone systems.

---

### 📋 8.2.1 **Three Phases**

1. **Connection Setup**: A dedicated path is established (e.g., using telephone numbers).
2. **Data Transfer**: Actual data is exchanged.
3. **Teardown**: Path is released after communication ends.

---

### ⏳ 8.2.2 **Efficiency**

| Advantage | Disadvantage |
|----------|--------------|
| ✅ Guaranteed path with **minimal delay** | ❌ Wastes resources if connection is idle |

📌 In computer networks, idle connections may hold resources while doing nothing.

---

### ⏱️ Delay in Circuit Switching

\[
\text{Total delay} = \text{Setup Time} + \text{Data Transfer Time} + \text{Teardown Time}
\]

- Data faces **no delay at switches** during transfer phase — ideal for real-time applications like voice.

---

### 🔧 **Example Breakdown (from your image)**

- Two **remote offices** connected with **T1 line (1.544 Mbps)**
- Each office has a **4×8 switch**
  - **4 ports** looped back for **internal office communication**
  - **4 ports** go over the **T1 line** to the other office
- This allows both **local and remote communication**

---

## 📦 **8.3 Packet Switching**

Packet switching = **breaking data into smaller packets** and routing them independently.

---

### 8.3.1 **Datagram Networks**

| Feature | Description |
|---------|-------------|
| Connectionless | No setup or teardown |
| Independent Packets | Each packet is routed individually |
| Routing | Based on **destination address** |
| Variable Delays | Packets can take different paths, causing out-of-order delivery |

🧠 Routing tables are **dynamic** and updated periodically.

> Think: Like mailing several letters separately; each might arrive at a different time or route.

---

#### ⏱️ Delay in Datagram Switching:

\[
\text{Total delay} = N \cdot \text{Transmission Time} + N \cdot \text{Propagation Time} + (N - 1) \cdot \text{Waiting Time}
\]

- Each packet might be **delayed at each switch**
- No guarantee that packets arrive in order or even at all (unless handled by upper layers)

---

### 8.3.2 **Virtual-Circuit Networks**

This combines features from **circuit** and **packet** switching.

---

### 🧠 Key Characteristics

| Feature | Description |
|---------|-------------|
| Setup & Teardown | Like circuit switching |
| Packets | Like datagrams, data is sent in packets |
| Routing | Packets follow **same path** (VC identifier, not full address) |
| Consistent Delay | If resources reserved, all packets have **same delay** |

> Implemented often at **data link layer** (e.g., Frame Relay, ATM)

---

### ⏱️ Delay in Virtual-Circuit Networks:

\[
\text{Total delay} = \text{Setup Time} + N \cdot \text{Transmission Time} + N \cdot \text{Propagation Time} + \text{Teardown Time}
\]

- If resources **are not reserved**, add per-packet queuing/wait time.

---

## 📌 Summary Table

| Type | Setup/Teardown | Data Units | Path | Delay | Efficiency |
|------|----------------|------------|------|-------|------------|
| **Circuit-Switched** | Yes | Stream | Fixed | Low after setup | Low |
| **Datagram (Packet)** | No | Packets | Variable | Varies per packet | High |
| **Virtual-Circuit** | Yes | Packets | Fixed | Consistent | Medium |
