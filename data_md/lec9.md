## 📘 **Chapter 11: Data Link Control (DLC)**

### 🔗 11.1 DLC SERVICES

#### 🧱 **Framing**
- **Purpose**: Divide a stream of bits into **frames** so the receiver can distinguish one message from another.
- **Includes**:
  - **Sender and receiver addresses**
  - **Frame start/end indicators**

#### 🧾 **Character-Oriented Framing**
- Frame is marked with special **character-based flags** (e.g., ASCII symbols)
- Issue: flag characters may appear in data

#### 🧼 **Byte Stuffing**
- Fixes the above issue by **escaping** flag characters in data with a special escape character (ESC)

#### 🧾 **Bit-Oriented Framing**
- Frame boundaries defined using a **bit pattern** (e.g., `01111110`)
- More efficient for non-text data

#### 🧼 **Bit Stuffing**
- Fix: After five consecutive `1`s in data, insert a `0` to avoid flag confusion.

---

### 🔁 **11.2 Data-Link Layer Protocols**

#### 📍 **FSM (Finite State Machine)**
- Data-link protocols behave like FSMs:
  - Fixed number of **states**
  - **Events** trigger **actions and transitions**

#### ✋ **Stop-and-Wait Protocol**
- Sender sends **one frame at a time**, waits for acknowledgment (ACK)
- If ACK not received in time, **resend**
- Uses **timers** and **CRC** for error detection

#### 🧩 **Problems in Stop-and-Wait**
- Duplicate frames may be delivered (e.g., if ACK is lost)
- Solution: Use **sequence numbers** (0 and 1 alternating)
  - Sender: attaches sequence number
  - Receiver: checks for duplicates

---

## 📘 **Chapter 12: Media Access Control (MAC)**

---

### 🚦 12.1 RANDOM ACCESS

#### 🚫 **No Coordination**
- All stations compete for the medium
- Decisions made **locally** by stations

---

### 📡 **12.1.2 CSMA (Carrier Sense Multiple Access)**

#### 🔍 **"Listen Before Talk"**
- Station senses medium before transmitting
- Reduces **chance** of collision but does **not eliminate** it (due to propagation delay)

---

### 💥 **12.1.3 CSMA/CD (Collision Detection)**

- Used in **wired Ethernet**
- If a station detects **collision** while sending:
  - It **aborts transmission**
  - Waits a **random time**, tries again

#### 📶 **Energy Levels:**
- **0** → idle  
- **normal** → successful transmission  
- **high** → collision

---

### 📶 **12.1.4 CSMA/CA (Collision Avoidance)**

- Used in **wireless networks**
- Hard to detect collisions in wireless → we **avoid** them

#### Strategies:
1. **IFS (Interframe Space)**: wait a bit after the medium is idle
2. **Contention Window**: random backoff
3. **RTS/CTS**: sender asks "Can I send?" → receiver replies "Yes"

#### 🧠 **NAV (Network Allocation Vector)**:
- Other stations use this to know how long the medium will be busy

---

## 📘 Chapter 6 (Partial): **Virtual LANs (VLANs)**

---

### 🖧 What is a VLAN?

- VLAN = Logical LANs created **by software**, not physical wiring.
- Devices on different ports or floors can belong to the same **logical group**

---

### 🎯 **Why VLANs?**

1. **Cost/Time Efficiency**: No need to rewire physically
2. **Workgroup Flexibility**: Virtual teams can share resources
3. **Security**: VLANs isolate traffic — broadcasts stay within the group

---

### 🧩 VLAN Membership Types

1. **By Port Number**: Port 1 and 3 = VLAN 1, etc.
2. **By MAC Address**: Assign VLAN based on device’s MAC
3. **Combination**: Use both

---

## ✅ Summary Table

| Concept | Purpose | Key Feature |
|--------|---------|-------------|
| **Framing** | Mark start/end of data | Byte- or Bit-oriented |
| **Stop-and-Wait** | Reliable delivery | One frame at a time, ACK |
| **CSMA** | Medium access | Sense before transmit |
| **CSMA/CD** | Handle collision | Abort and resend |
| **CSMA/CA** | Avoid collision | RTS/CTS, IFS |
| **VLAN** | Logical LAN segmentation | Grouping by software |

