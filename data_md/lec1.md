

# 🌐 The OSI Model and TCP/IP Protocol Suite**


 **two models** used to understand how data is transmitted over a network:

---

## 📦 **1. OSI Model (Open Systems Interconnection) — Left Side**

The **OSI model** has **7 layers**, each responsible for specific network functions:

1. **Application** – Directly interacts with user applications (e.g., web browsers, email).
2. **Presentation** – Translates data between the application and the network (e.g., encryption, compression).
3. **Session** – Manages sessions (start, maintain, end connections).
4. **Transport** – Ensures reliable data transfer (e.g., TCP).
5. **Network** – Routes data (e.g., IP addresses, routers).
6. **Data Link** – Handles direct data transfer between devices on the same network.
7. **Physical** – The hardware layer (cables, switches, etc.).

---

## 🌐 **2. TCP/IP Protocol Suite — Right Side**

The **TCP/IP model** is simpler and has **4 layers**, but it performs similar functions:

1. **Application Layer** – Combines the OSI’s top 3 layers (Application, Presentation, Session). Includes protocols like HTTP, FTP, DNS.
2. **Transport Layer** – Handles communication between devices (TCP, UDP).
3. **Network Layer** – Focuses on routing and addressing (IP).
4. **Data Link + Physical Layers** – These are grouped together and handle the hardware-level transmission.

---

## 🔄 **Mapping Between Models**

- OSI’s **Application, Presentation, Session** → TCP/IP’s **Application**
- OSI’s **Transport** → TCP/IP’s **Transport**
- OSI’s **Network** → TCP/IP’s **Network**
- OSI’s **Data Link + Physical** → TCP/IP’s **Network Access Layer** (not labeled here, but implied)

---

### 📘 Bottom Notes:

- **OSI** stands for **Open Systems Interconnection**
- **TCP/IP** stands for **Transmission Control Protocol / Internet Protocol**

---

- OSI is a **theoretical model** – helpful for learning and standardizing.
- TCP/IP is the **real-world model** – used in actual internet communication.
- Both describe how data moves from one device to another, just in different levels of detail.


## ✅ **Chapter 1: Introduction to Data Communications**

---
### 📌 **1.1 Data Communications**

**Definition:**
> Data communication is the exchange of data between two devices using a transmission medium.

---

### 📦 **1.1.1 Components of a Data Communication System:**

| Component            | Description                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| **Sender**          | Device that sends the data (e.g., computer, phone).                         |
| **Receiver**        | Device that receives the data (e.g., monitor, phone).                       |
| **Message**         | The actual data (text, image, video, etc.) being communicated.             |
| **Transmission Medium** | The path data travels (e.g., wire, fiber optics, radio waves).        |
| **Protocol**        | Rules for communication (e.g., TCP/IP, HTTP).                              |

---

### 🔄 **1.1.3 Data Flow Types**

From your **second image**:

| Type         | Description | Example |
|--------------|-------------|---------|
| **Simplex**  | One-way only | Keyboard to monitor |
| **Half-Duplex** | Both ways, but only one direction at a time | Walkie-talkie |
| **Full-Duplex** | Both ways simultaneously | Phone call |

---

## 🌐 **1.2 Networks**

> A **network** is a collection of connected devices that can communicate.

### 📊 **1.2.1 Network Criteria**

| Criteria    | Description |
|-------------|-------------|
| **Performance** | Measured by speed (throughput) and delay |
| **Reliability** | Frequency of failures, recovery speed |
| **Security** | Preventing unauthorized access or data loss |

---

### 🧷 **1.2.2 Connection Types**

| Type          | Description |
|---------------|-------------|
| **Point-to-Point** | Dedicated link between two devices |
| **Multipoint**     | One link shared by multiple devices |

---

### 🌟 **1.2.3 Physical Topologies**

From your notes:

| Topology | Description | Pros | Cons |
|----------|-------------|------|------|
| **Mesh** | Every device connects to every other | Reliable, private, fault-tolerant | Expensive, lots of cables |
| **Star** | All connect to a central hub | Cheap, easy troubleshooting | Hub failure affects all |
| **Bus** | All devices share one long cable | Simple, cheap | Cable failure breaks all |
| **Ring** | Devices connected in a circle | Easy to detect failure | One break affects all |

---

## 🧩 **Chapter 2: Network Models**

---

### 📚 **2.1 Protocol Layering**

> A **protocol** is a set of rules that govern communication.

> **Layering** means each layer handles a specific task. Layers communicate with the same layer on the other end.

---

### 🧠 **2.1.2 Principles of Protocol Layering**

| Principle | Description |
|-----------|-------------|
| **Bidirectional communication** | Each layer must handle sending and receiving |
| **Same Layer Communication** | Each device must have matching layers doing the same tasks |

---

### 🧠 **2.1.3 Logical vs Physical Connections**

- **Application, Transport, Network layers** = End-to-End communication (from sender to receiver)
- **Data Link, Physical layers** = Hop-to-Hop communication (device to device)

---

### 🎁 **2.2.4 Encapsulation / Decapsulation**

- **Encapsulation**: As data moves **from the application layer to the physical layer**, each layer **adds headers** (control info).
- **Decapsulation**: As data moves **from physical to application layer** at the receiver, headers are removed layer by layer.

---

### 📍 **2.2.5 Addressing**

- Each layer needs addressing to know where to deliver data.
    - **IP address**: Network layer
    - **MAC address**: Data Link layer
    - **Port number**: Transport layer

---

## 📊 **Slide: OSI vs TCP/IP Models**

| OSI Model (7 Layers)       | TCP/IP Model (4 Layers)   |
|----------------------------|---------------------------|
| Application                | Application               |
| Presentation               | ⬇️                       |
| Session                    | ⬇️                       |
| Transport                  | Transport                 |
| Network                    | Network                   |
| Data Link                  | Data Link                 |
| Physical                   | Physical                  |

✔️ TCP/IP combines the top 3 OSI layers into one **Application Layer**.

---

## 🌍 **Slide: Communication through the Internet**

From your last image:

- Devices A and B are communicating through:
  - 3 LAN segments (Links 1, 2, 3)
  - Switches (data link + physical layers)
  - A Router (network + data link + physical)

🔁 **Communication process**:
1. Data starts at Source A's **Application Layer**
2. It is **encapsulated** layer by layer down to the **Physical Layer**
3. It travels across **switches** and **router**
4. At each step, only some layers are active (e.g., routers don’t process application/transport layers)
5. At Destination B, it’s **decapsulated** back up to the Application Layer.

---