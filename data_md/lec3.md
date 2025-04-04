# 📘 Chapter 4: Digital Transmission

 This chapter explains how to **convert data to digital signals** — a key concept in modern networks.
 
---

## 🧩 **4.1 DIGITAL-TO-DIGITAL CONVERSION**

### 🔄 What is Line Coding?

**Line coding** is the process of converting **digital data → digital signal**.

- **At sender**: Encode bits into voltage levels.
- **At receiver**: Decode the signal back into bits.

---

### 🧭 Line Coding Categories

#### (A) **Unipolar (e.g., NRZ)**

- **All voltages on one side** of the time axis.
- Bit `1` = Positive voltage  
  Bit `0` = Zero voltage

> ⚠️ No transition = harder to sync clocks

---

#### (B) **Polar Schemes**

| Scheme | Description |
|--------|-------------|
| **NRZ-Level (NRZ-L)** | Voltage level represents bit (e.g., + = 1, − = 0) |
| **NRZ-Invert (NRZ-I)** | A bit is 1 if the signal **changes**; 0 if it **stays** the same |

---

#### 🕒 Clock Synchronization Issue

- Receiver must match sender's bit intervals.
- Even a **0.1% clock mismatch** can cause extra/missing bits!

> ✔️ **Manchester / RZ schemes fix this with transitions built in.**

---

#### (B.2) **Self-Synchronizing Polar Schemes**

| Scheme | Description | Bandwidth |
|--------|-------------|-----------|
| **RZ** | Signal returns to 0 mid-bit | High |
| **Manchester** | First half = one level, second half = opposite | High |
| **Differential Manchester** | Always a transition mid-bit. If bit = 0, extra transition at start | High |

> ✅ More reliable timing  
> ❌ Higher bandwidth needed

---

#### (C) **Bipolar Schemes**

| Scheme | Bit 0 | Bit 1 |
|--------|-------|-------|
| **AMI** | 0 V | Alternates + and − |
| **Pseudoternary** | Alternates + and − | 0 V |

> ✔️ Synchronization & error detection help  
> ❌ More complex circuitry

---

## 🎙️ **4.2 ANALOG-TO-DIGITAL CONVERSION**

Used to digitize signals from microphones, cameras, etc.

### 🔁 **Pulse Code Modulation (PCM)**

Three Steps:

---

### ✅ Step 1: **Sampling**

> Taking **snapshots** of an analog signal at regular intervals.

🧠 **Nyquist Theorem**:

To capture signal **without losing info**:

\[
f_s = 2 \cdot f_{max}
\]

Where:
- \( f_s \) = Sampling rate  
- \( f_{max} \) = Highest frequency in signal

| Sampling Rate | Result |
|---------------|--------|
| = Nyquist | Faithful signal |
| > Nyquist | OK but wasteful |
| < Nyquist | ❌ Aliasing: wrong info |

---

#### ✔️ Problem:
Low-pass signal with bandwidth 200 kHz  
\[
f_s = 2 \cdot 200,000 = \boxed{400,000 \text{ samples/s}}
\]

---

### ✅ Step 2: **Quantization**

> Approximating sampled values to a finite set of levels.

- This introduces **quantization error**.
- More **bits per sample (n_b)** = less error, better quality

📌 **Quantization SNR (SNR_Q):**
\[
\text{SNR}_Q = 6.02 \cdot n_b + 1.76 \text{ (in dB)}
\]

#### ✔️ Problem:
SNR ≥ 40 dB →  
\[
40 = 6.02 \cdot n_b + 1.76 \Rightarrow n_b \approx \boxed{7 \text{ bits/sample}}
\]

---

### ✅ Step 3: **Encoding**

> Represent each quantized sample with **n_b** bits.

📌 **Bit Rate**:
\[
\text{Bit Rate} = f_s \cdot n_b
\]

#### ✔️ Problem:
Human voice: 0–4000 Hz  
→ \( f_s = 8000 \), \( n_b = 8 \)

\[
\text{Bit rate} = 8000 \cdot 8 = \boxed{64 \text{ kbps}}
\]

---

## 🧠 Chapter 4 Summary Table

| Concept | Summary |
|--------|---------|
| **Line Coding** | Digital data → digital signals |
| **Unipolar** | All voltages on one side |
| **Polar** | Voltages on both sides (NRZ, Manchester, etc.) |
| **Bipolar** | Three voltage levels (0, +, −) |
| **Clock Sync** | Fixed by Manchester, RZ, etc. |
| **PCM** | Analog data → digital signal (via sampling, quantizing, encoding) |
| **Nyquist Rate** | Minimum sampling = 2 × max frequency |
| **SNR_Q** | Quality improves with more bits/sample |
| **Bit Rate** | = sampling rate × bits per sample |

---