# 📘 Chapter 5: Analog Transmission

This chapter is about how we **convert digital or analog data into analog signals** for transmission — especially when the medium (like radio or cable) only supports **analog/bandpass signals**.

---

## 🔁 **5.1 DIGITAL-TO-ANALOG CONVERSION**

---

### 📊 **What Is It?**
We take **digital data** (0s and 1s) and **modulate** a carrier **analog signal** (a sine wave) by changing:
- its **amplitude**
- its **frequency**
- or its **phase**

### 🧠 A sine wave is defined by:
- **Amplitude** (height of the wave)
- **Frequency** (number of cycles per second)
- **Phase** (position of the wave at time 0)

---

### 🧱 5.1.2 **Amplitude Shift Keying (ASK)**

- Data is encoded by changing **amplitude**
- Frequency and phase remain **constant**

| Bit | Signal |
|-----|--------|
| 1   | High amplitude |
| 0   | Low or zero amplitude |

> ✅ Simple  
> ❌ Susceptible to noise (noise often alters amplitude)

---

### 📈 5.1.3 **Frequency Shift Keying (FSK)**

- Data is encoded by changing **frequency**
- Amplitude and phase remain **constant**

| Bit | Signal |
|-----|--------|
| 1   | High frequency |
| 0   | Low frequency |

> ✅ Less affected by noise  
> ❌ Needs multiple carrier frequencies

---

### 🔁 5.1.4 **Phase Shift Keying (PSK)**

- Data is encoded by changing **phase**
- Amplitude and frequency remain **constant**

| Bit | Signal |
|-----|--------|
| 1   | Phase 0° |
| 0   | Phase 180° (inverted) |

> ✅ More noise-resistant than ASK  
> ❌ More complex to implement

---

### 💡 5.1.5 **Quadrature Amplitude Modulation (QAM)**

> Combines **ASK + PSK** — modifies both amplitude **and** phase.

- Uses **two carriers**:
  - **In-phase (I)**
  - **Quadrature (Q)** — 90° shifted

> Each **symbol** carries multiple bits. E.g., 4-QAM = 2 bits per symbol, 16-QAM = 4 bits per symbol.

---

### 🌌 **Constellation Diagrams**

Shows the possible signal states in QAM, PSK, etc.

- **X-axis**: In-phase (I)
- **Y-axis**: Quadrature (Q)

Each dot (symbol) defines:
1. In-phase amplitude
2. Quadrature amplitude
3. Total signal amplitude (using Pythagoras)
4. Phase angle

#### ✔️ Examples:
- **BASK**: 2 points on X-axis (0 V, 1 V)
- **BPSK**: 2 points on X-axis (1 V, -1 V)
- **QPSK**: 4 points in quadrants (±1, ±1)

---

## 🎙️ **5.2 ANALOG-TO-ANALOG CONVERSION**

This is **analog modulation** — used to transmit analog data (e.g., voice) over **bandpass channels** (like radio).

---

### 📶 5.2.1 **Amplitude Modulation (AM)**

- Amplitude changes with the **information signal**
- Frequency and phase remain constant

> Carrier signal looks like it’s wrapped inside the original analog waveform (envelope)

---

### 🎚️ 5.2.2 **Frequency Modulation (FM)**

- Frequency varies with the **amplitude** of the analog input
- Amplitude and phase are constant

> Widely used in **FM radio** due to good noise resistance

---

### 🔄 5.2.3 **Phase Modulation (PM)**

- Phase varies with the **amplitude** of the analog signal
- Amplitude and frequency are constant

> Mathematically similar to FM, but instead of using amplitude, PM reacts to the **rate of change** of the amplitude

---

## 📌 Summary Table

| Modulation Type | What changes? | Used for |
|------------------|----------------|----------|
| **ASK**          | Amplitude       | Digital → Analog |
| **FSK**          | Frequency       | Digital → Analog |
| **PSK**          | Phase           | Digital → Analog |
| **QAM**          | Amplitude + Phase | Digital → Analog |
| **AM**           | Amplitude       | Analog → Analog |
| **FM**           | Frequency       | Analog → Analog |
| **PM**           | Phase           | Analog → Analog |

---

## ⚙️ Pros & Cons Comparison

| Method | Advantage | Disadvantage |
|--------|-----------|--------------|
| **ASK** | Simple | Sensitive to noise |
| **FSK** | Better noise resistance | Needs more bandwidth |
| **PSK** | Good noise resistance, efficient | Complex hardware |
| **QAM** | High data rate | Very complex |
| **AM** | Simple & cheap | High noise |
| **FM** | Resistant to noise | More bandwidth |
| **PM** | Efficient for voice | More complex to implement |

---
