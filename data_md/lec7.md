## 📘 **Chapter 9: Introduction to the Data-Link Layer**

---

### 🔗 **9.1.1 Nodes and Links**
- **Node**: Any device (host or router)
- **Link**: Physical connection (wired or wireless)
- **Data-Link Layer**: Handles **communication between directly connected nodes**

---

### 🧰 **9.1.2 Services Provided**
1. **Framing**: Adds headers and trailers to data from the network layer to make **frames**
2. **Flow Control**: Prevents overwhelming the receiver (like slowing down a fast sender)
3. **Error Control**: Detects (and optionally corrects) errors
4. **Congestion Control**: Prevents overload on the network (mainly handled by upper layers)

---

### 🔁 **9.1.3 Link Types**
- **Point-to-point**: Only 2 nodes share the link (e.g., two computers directly connected)
- **Broadcast**: Many devices share the link (e.g., Wi-Fi)

---

### 📦 **9.1.4 Sublayers**
- **DLC (Data Link Control)**: Manages framing, flow, and error control
- **MAC (Media Access Control)**: Controls how devices access the **shared** medium

---

### 🧭 **9.2 Link-Layer Addressing**
- IP address is **not enough** for frame delivery over a local link.
- Each frame needs:
  - **Source MAC address**
  - **Destination MAC address**

### 📬 **9.2.2 ARP (Address Resolution Protocol)**
- ARP maps **IP address → MAC address**
- Required because switches use MAC addresses to deliver frames.

---

## 📘 **Chapter 10: Error Detection and Correction**

---

### ⚠️ **10.1.1 Types of Errors**
- **Single-bit error**: Only 1 bit changes
- **Burst error**: Two or more bits are altered (common in practice due to duration of noise)

---

### 🛠️ **10.1.2 Redundancy**
- Add extra **redundant bits** to detect or correct errors.
- Sender adds → Receiver checks and removes

---

## 🧱 **10.2 Block Coding**
- **Dataword**: Original data (k bits)
- **Codeword**: Dataword + r redundant bits (n = k + r)
- Example:
  - If k = 2, n = 3: 01 → 011
- Valid codewords are predefined. If received word is not valid → error.

---

### 🧮 **Linear Block Codes (LBC)**
- XOR of any 2 valid codewords = another valid codeword
- **dₘᵢₙ** = Minimum number of bit differences between valid codewords
  - dₘᵢₙ = 2 → Can detect single-bit errors

---

### ✔️ **Parity-Check Code**
- Adds 1 bit to make number of 1s even (even parity)
- dₘᵢₙ = 2
- Detects single-bit errors, but not even-bit errors

---

## 🔁 **10.3 Cyclic Codes**

---

### 🌀 **10.3.1 CRC (Cyclic Redundancy Check)**

**Sender Side (Figure 10.6)**:
1. **Dataword** = 1001  
2. Append r = degree(generator) zeroes → Dividend = 1001000  
3. **Divisor** (generator) = 1011  
4. Perform binary division (XOR)  
5. **Remainder** = 110  
6. **Codeword** = Dataword + Remainder → `1001110`

**Receiver Side (Figure 10.7)**:
- Receiver divides the codeword by the **same generator**
- If **remainder = 0** → data accepted
- If **non-zero remainder** → data corrupted and discarded

---

## 🧮 **10.4 Checksum (Figure with Table)**

**Used in Transport/Network Layers (e.g., TCP/IP)**

### **Sender Side**
1. Divide data into **16-bit** words
2. Add all words using **1’s complement arithmetic**
3. Complement the result → This is the **checksum**
4. Send data + checksum

### **Receiver Side**
1. Receive data + checksum
2. Add all words using 1’s complement
3. Complement the sum → If result is **0**, message is accepted

---

### 🧠 Example (from slide):
Data: 7, 11, 12, 0, 6  
→ Sum = 36 → Binary: 100100  
→ Use 1’s complement folding: 10 + 0100 = 0110 → Send as 6  
→ Checksum = 15 - 6 = 9  
→ Sender sends: 7, 11, 12, 0, 6, 9  
→ Receiver adds all → gets 15 → Complement = 0 → Valid!

---

## ✅ Summary of Error Techniques

| Technique | Detection | Correction | Layer |
|----------|-----------|------------|-------|
| Parity | Single-bit | ❌ | Data-link |
| Block Coding | Multiple (depends on dₘᵢₙ) | ❌ | Data-link |
| CRC | Burst error (very strong) | ❌ | Data-link |
| Checksum | General errors | ❌ | Transport/Network |

