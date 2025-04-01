## 📘 **Chapter 18: Introduction to Network Layer**

### 🌐 **18.1 Network Layer Services**
- **Packetizing**: Encapsulate upper-layer data into packets.
- **Routing**: Choose the best path across networks.
- **Forwarding**: Send a packet to the next hop using routing tables.

---

### 🔁 **18.2 Packet Switching**
- The router acts like a switch: it connects **input ports to output ports**.
- Uses **routing algorithms** to make forwarding decisions.

---

### 🧮 **18.4 IPv4 Addresses**
#### 📏 Address Space:
- **32-bit address**, written in **dotted decimal** (e.g., 192.168.1.1).
- **Address space**: 2³² = ~4.3 billion addresses.

#### 🧩 Hierarchical Addressing:
- **Prefix**: network part (e.g., /24)
- **Suffix**: host part

#### ✂️ **Classless Addressing (CIDR)**:
- Format: `IP/PrefixLength` (e.g., `167.199.170.82/27`)
- # of addresses = 2^(32 - prefix length)

**Example**:  
`14.24.74.0/24` block subdivided:
- /25 for 120 users
- /26 for 60 users
- /28 for 10 users

---

## 📘 **Chapter 19: IPv4 Protocol**

### 📦 **IPv4 Datagram**
- Consists of **header + payload**
- **Header size**: 20–60 bytes (minimum 20 bytes)
- Important fields:
  - **Version** (4 bits): IPv4 = `0100`
  - **HLEN** (4 bits): Header length in multiples of 4 bytes
  - **Total Length**: includes header and data
  - **TTL**: prevents infinite loops
  - **Protocol**: indicates the upper layer (e.g., TCP, UDP)
  - **Checksum**: error detection for header only

### ✅ **Checksum Calculation Example (IPv4 Header)**:
- **Divide header into 16-bit words**
- **Add** all the words (1’s complement)
- **Wrap around carry** bits
- **Take 1’s complement of the result**
- **Insert into header checksum field**

**Formulas**:
- `Wrapped Sum = Sum mod FFFF₁₆`
- `Checksum = FFFF₁₆ - Wrapped Sum`

---

## 📘 **Chapter 7.5: IPv6**

### 🎯 **Why IPv6?**
- IPv4 exhausted (only ~4.3 billion addresses)
- IPv6 provides **128-bit** addresses → **2¹²⁸ ≈ 340 undecillion**

---

### 🆕 **IPv6 Address Format**
- Written in **colon-hexadecimal**: `2001:0db8:85a3::8a2e:0370:7334`
- Can omit leading 0s or consecutive 0 blocks using `::`

---

### 📦 **IPv6 Datagram (Fixed 40-byte header)**:
- **Version**: Always `0110`
- **Traffic Class & Flow Label**: Used for **QoS** (e.g., voice/video)
- **Payload Length**: size of data after the header
- **Next Header**: like the IPv4 protocol field (e.g., TCP = 6, UDP = 17)
- **Hop Limit**: similar to TTL in IPv4
- **Source/Destination Addresses**: 128-bit each

---

### 🔐 **IPv6 Improvements**
- **Simplified Header**: faster routing
- **Extension Headers**: optional and processed only when needed
- **Security**: IPsec is **mandatory** in IPv6
- **QoS Support**: via Flow Label and Traffic Class

---

## ✅ Summary Table

| Feature              | IPv4                        | IPv6                             |
|----------------------|-----------------------------|----------------------------------|
| Address Size         | 32 bits                     | 128 bits                         |
| Header Size          | 20–60 bytes                 | Fixed 40 bytes                   |
| Notation             | Dotted decimal              | Colon hexadecimal                |
| QoS Support          | Type of Service (ToS)       | Flow Label + Traffic Class       |
| Security             | Optional (IPsec)            | Built-in support (mandatory)     |
| Address Depletion    | Yes                         | No                               |
| Checksum             | Yes (header only)           | No (removed for efficiency)      |
| Extension Headers    | No (uses Options field)     | Yes                              |

---
