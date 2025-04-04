## 📘 **Chapter 6: Multiplexing**

### 🔑 **Concept**
- **Multiplexing**: Technique to combine multiple signals for transmission over a single link.
- Efficient use of bandwidth when the link's capacity > any single source’s requirement.

---

### 🧩 **Types of Multiplexing**

#### 1. 📡 **Frequency-Division Multiplexing (FDM)**  
- **Analog** technique  
- Different signals modulated onto **separate carrier frequencies**  
- **Guard bands** prevent interference  
- Used in: **radio, cable TV, old phone systems**

**Example**:  
- 5 channels @ 100 kHz each with 10 kHz guard bands  
  ➤ Bandwidth = (5×100) + (4×10) = **540 kHz**

---

#### 2. 🌈 **Wavelength-Division Multiplexing (WDM)**  
- **FDM for fiber optics**  
- Each signal has a different **wavelength (color)** of light  
- **Prisms** are used to combine/split beams  
- Very high-speed, suitable for **backbone** links

---

#### 3. ⏱️ **Time-Division Multiplexing (TDM)**  
- **Digital** technique  
- Each source gets a **time slot** on a shared link  
- Time is divided into **frames**, each frame has slots for each source

---

### 📊 **TDM Types**

#### A. **Synchronous TDM**
- Each source gets **fixed** time slots (even if idle)  
- Needs **synchronization bits** to identify slots  

**Formula**:
- If `n` sources → Output rate = `n × input rate`

**Example**:  
- 4 channels sending 100 Bps →  
  Frame size = 4 × 8 = **32 bits**  
  Frame rate = 100 fps →  
  **Link bit rate** = 100 × 32 = **3200 bps**

---

#### B. **Statistical TDM**
- **Dynamic** slot allocation — only to active sources  
- Needs **address fields** in slots  
- More efficient, especially when sources are idle  
- **No sync bits** required

---

### 🆚 **Synchronous vs Statistical TDM**

| Feature              | Synchronous TDM        | Statistical TDM           |
|----------------------|------------------------|----------------------------|
| Slot Allocation      | Fixed                  | Dynamic (based on demand) |
| Efficiency           | Less efficient (idle slots) | More efficient (no idle slots) |
| Addressing           | Not required           | Required                   |
| Synchronization Bits | Needed                 | Not needed                 |

---

### ✅ **Key Equations & Examples**

#### **TDM Timing Example**
- Input: 3 channels @ 1 kbps, 1 bit per frame  
- Each input time slot = **1 ms**  
- Output time slot = **1/3 ms**  
- Frame duration = **1 ms**

#### **Character-Based TDM with Sync**
- 4 sources, 250 characters/sec, 1 sync bit  
- Frame size = (4×8) + 1 = **33 bits**  
- Frame rate = 250 fps  
- Bit rate = 250 × 33 = **8250 bps**


Thanks! Here’s a **concise and organized cheat sheet** for **Chapter 7: Transmission Media**, ideal for quick reference or exam prep:

---

## 📘 **Chapter 7: Transmission Media**

### 🧩 **Classification**
- **Guided Media** (Wired): signal travels through physical medium
- **Unguided Media** (Wireless): signal travels through air/free space

---

## ⚙️ **7.2 Guided Media**

### 🔌 **1. Twisted-Pair Cable**
- **Two insulated copper wires** twisted to reduce noise (cancels interference)
- **Types**:
  - **UTP**: Unshielded (common)
  - **STP**: Shielded (less noise, more expensive)
- **Connector**: RJ-45
- **Used for**: telephone lines, LAN

> ✅ Pros: cheap, easy to install  
> ❌ Cons: limited bandwidth, susceptible to EMI  

---

### 📺 **2. Coaxial Cable**
- Central copper core + insulator + metallic shield + plastic cover
- **Better shielding** than twisted-pair, higher bandwidth
- **Connectors**: BNC (Bayonet Neill-Concelman), T-Connector, Terminator
- **Used for**: cable TV, older Ethernet

> ✅ Pros: high frequency, good EMI resistance  
> ❌ Cons: bulky, high attenuation → needs repeaters  

---

### 💡 **3. Fiber-Optic Cable**
- Transmits **light signals** via total internal reflection
- **Core** (glass/plastic) + **Cladding** (less dense) + **Jacket**
- **Modes**:
  - **Multimode Step-Index**: high distortion
  - **Multimode Graded-Index**: reduced distortion
  - **Single Mode**: best quality, minimal distortion

**Connectors**: SC (TV), ST (LAN), MT-RJ (duplex)

**Performance**:
- Low attenuation
- Immune to EMI
- Long-distance support
- Wavelengths: LAN (850 nm), WAN (1310/1550 nm)

> ✅ Pros: very high bandwidth, secure, low signal loss  
> ❌ Cons: expensive, difficult installation  

---

## 📡 **7.3 Unguided Media (Wireless)**

### 🔭 **Propagation Methods**
- **Ground Propagation**: follows Earth's curve (low freq)
- **Sky Propagation**: reflects off ionosphere (medium freq)
- **Line-of-Sight**: direct, straight path (high freq)

---

### 📻 **1. Radio Waves (3 kHz – 1 GHz)**
- **Omnidirectional**  
- Can **penetrate walls**, used for long-distance  
- **Applications**: AM/FM radio, TV, paging  
- **Regulated by**: FCC

> ✅ Pros: long range, indoor use  
> ❌ Cons: low bandwidth, interference

---

### 📶 **2. Microwaves (1 – 300 GHz)**
- **Line-of-sight**, **unidirectional**  
- High bandwidth → good for digital communication  
- Cannot penetrate walls

**Applications**: satellite, cellular, Wi-Fi, point-to-point links

> ✅ Pros: high bandwidth, focused signal  
> ❌ Cons: line-of-sight required, cannot go through walls

---

### 🔥 **3. Infrared (300 GHz – 400 THz)**
- **Line-of-sight**, cannot penetrate walls  
- High data rate in short ranges  
- **Not suitable for outdoor use** (sunlight interference)

**Applications**: remote controls, short-range comms (IR ports)

> ✅ Pros: no interference between systems  
> ❌ Cons: short range, blocked by objects

---

### 📡 **Antennas**
- **Omnidirectional**: radiates equally in all directions (radio)
- **Unidirectional**: focused in one direction (microwave, infrared)

