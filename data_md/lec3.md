# 📘 Chapter 3 (Part 2): Introduction to the Physical Layer

---

## 🔧 **3.4 TRANSMISSION IMPAIRMENT**

When data travels through physical media (wires, fiber, air), it **gets altered or degraded**. This is called **impairment**, and it affects what the receiver gets.

---

### 🧱 Types of Impairment

#### 3.4.1 📉 **Attenuation**
- **Definition**: Loss of signal strength as it travels.
- Caused by: Resistance of the medium.
- **Solution**: Use **amplifiers** to boost signal.

> Think of shouting over a long distance — your voice gets quieter.

#### 3.4.2 🔀 **Distortion**
- Happens when different frequencies in a **composite signal** travel at **different speeds**.
- Causes changes in shape/form of the original signal (phase shifts).

#### 3.4.3 📡 **Noise**
Noise = Unwanted signals that interfere with the message.

| Type          | Description |
|---------------|-------------|
| **Thermal noise** | Random motion of electrons in wire |
| **Induced noise** | From nearby electrical devices (motors) |
| **Crosstalk**     | Signal "leaks" from one wire to another |
| **Impulse noise** | Sudden spikes (e.g., lightning, power lines) |

---

### 📊 **Decibel (dB)** – Measures gain or loss of signal power

\[
\text{dB} = 10 \cdot \log_{10} \left( \frac{P_2}{P_1} \right)
\]

- Positive dB = signal amplified  
- Negative dB = signal weakened (attenuated)

#### ✔️ Examples:
- Loss of half the power:  
  \[
  10 \cdot \log_{10}(0.5) = -3 \text{ dB}
  \]
- Gain of 10× power:  
  \[
  10 \cdot \log_{10}(10) = 10 \text{ dB}
  \]

---

### 📣 **Signal-to-Noise Ratio (SNR)**

\[
\text{SNR} = \frac{\text{Signal Power}}{\text{Noise Power}}
\]

\[
\text{SNR}_{dB} = 10 \cdot \log_{10}(\text{SNR})
\]

- High SNR → good quality
- Low SNR → signal is hard to distinguish from noise

#### ✔️ Example:
Signal = 10 mW, Noise = 1 μW = 0.001 mW

\[
\text{SNR} = \frac{10}{0.001} = 10000
\quad \Rightarrow \quad \text{SNR}_{dB} = 40 \text{ dB}
\]

---

## ⚡ **3.5 DATA RATE LIMITS**

How fast can we transmit data?

### 3 Factors Affecting Data Rate:
1. **Bandwidth** of the channel (Hz)
2. **Signal levels** (how many bits per signal)
3. **Noise** in the channel

---

### 3.5.1 🧠 **Nyquist Rate** (Noiseless channel)

\[
\text{BitRate} = 2 \cdot \text{Bandwidth} \cdot \log_2(L)
\]

- **L** = Number of signal levels (e.g., 2 levels = 1 bit, 4 levels = 2 bits)
- Assumes **no noise**

#### ✔️ Example:
Bandwidth = 3000 Hz, Signal Levels = 2  
\[
\text{BitRate} = 2 \cdot 3000 \cdot \log_2(2) = 6000 \text{ bps}
\]

---

### 3.5.2 📉 **Shannon Capacity** (Noisy channel)

\[
\text{Capacity} = \text{Bandwidth} \cdot \log_2(1 + \text{SNR})
\]

- SNR must be in **normal form**, not dB
- **Shannon Capacity** gives upper limit for noisy channels

#### ✔️ Example:
If SNR = 0 →  
\[
\text{Capacity} = B \cdot \log_2(1) = 0 \text{ bps}
\]  
→ **No communication possible**

---

## 🚀 **3.6 PERFORMANCE METRICS**

Let’s define how we **measure network quality**.

---

### 3.6.1 📡 **Bandwidth**

| Context        | Meaning                                  |
|----------------|-------------------------------------------|
| In Hertz (Hz)  | Range of frequencies (e.g., 0–4kHz)       |
| In bits/sec    | Max data rate of a channel (e.g., 1 Gbps) |

---

### 3.6.2 🚚 **Throughput**

- **Actual rate** of data transmitted through the network.
- Always **≤ Bandwidth**

#### ✔️ Example:
Bandwidth = 10 Mbps  
12,000 frames/min, 10,000 bits/frame  
\[
\text{Throughput} = \frac{12000 \cdot 10000}{60} = 2 \text{ Mbps}
\]

---

### 3.6.3 ⏱️ **Latency (Delay)**

Time it takes a message to travel from **source to destination**.

\[
\text{Latency} = \text{Propagation Time} + \text{Transmission Time} + \text{Queuing Time} + \text{Processing Delay}
\]

| Term              | Description |
|-------------------|-------------|
| **Propagation Time** | Distance / Signal speed |
| **Transmission Time** | Message size / Bandwidth |
| **Queuing Time** | Time waiting in buffer |
| **Processing Delay** | Time for packet processing |

#### ✔️ Example:
- Distance = 12,000 km = 12,000,000 m  
- Speed = 2.4×10⁸ m/s  
\[
\text{Propagation Time} = \frac{12,000,000}{2.4 \cdot 10^8} = 0.05 \text{ s}
\]

Message = 2.5 kB = 20,000 bits  
Bandwidth = 1 Gbps = 10⁹ bps  
\[
\text{Transmission Time} = \frac{20000}{10^9} = 20 \mu s
\]

---

## ✅ Chapter Summary Table

| Concept        | Key Idea |
|----------------|----------|
| **Impairments** | Attenuation, Distortion, Noise |
| **SNR**         | Signal power / Noise power (higher = better) |
| **Nyquist**     | Max bit rate for noiseless channels |
| **Shannon**     | Max capacity for noisy channels |
| **Bandwidth**   | Max theoretical capacity |
| **Throughput**  | Actual achieved data rate |
| **Latency**     | Total delay from source to destination |

---

Would you like me to:
- Generate **diagrams or flashcards**?
- Make a **printable cheat sheet**?
- Provide **calculation practice problems**?

Just say the word!