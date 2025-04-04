# 📘 Chapter 3: Introduction to the Physical Layer

---

## 🧩 **3.1 DATA AND SIGNALS**

---

### 3.1.1 Analog vs Digital Data

| Analog Data | Digital Data |
|-------------|--------------|
| Continuous (infinite values) | Discrete (limited values) |
| Example: Analog clock | Example: Digital clock |

---

### 3.1.2 Analog vs Digital Signals

| Analog Signal | Digital Signal |
|---------------|----------------|
| Continuous waveform | Only two (or limited) levels |
| Can represent sound, temperature | Often just 0s and 1s |

---

### 3.1.3 Periodic vs Nonperiodic Signals

- **Periodic Signal**: Repeats over time (pattern exists).
- **Nonperiodic Signal**: No repeating pattern.

**Key terms**:
- **Cycle** = One full repetition
- **Period (T)** = Time to complete 1 cycle (seconds)
- **Frequency (f)** = Number of cycles per second (Hertz)

\[
T = \frac{1}{f}
\quad \text{and} \quad
f = \frac{1}{T}
\]

---

## 📐 **3.2 ANALOG SIGNALS**

---

### 3.2.1 Sine Wave

Most basic analog signal, described by:

\[
y(t) = A \cdot \sin(2\pi f t + \theta)
\]

- **A** = Amplitude (peak strength)
- **f** = Frequency (number of cycles/second)
- **θ** = Phase (position in time)

---

### 3.2.2 Phase

- Describes where the wave starts
- A shift in wave to the left or right on the time axis
- Measured in **degrees** or **radians**  
  → 360° = 2π radians

---

### 3.2.3 Wavelength (λ)

- Distance signal travels during 1 period

\[
\lambda = c \cdot T
\quad \text{or} \quad
\lambda = \frac{c}{f}
\]

- **c** = Propagation speed (≈ speed of light)

---

### 3.2.4 Time Domain vs Frequency Domain

- **Time Domain**: Shows amplitude vs time
- **Frequency Domain**: Shows amplitude vs frequency (great for analyzing multiple sine waves)

---

### 3.2.5 Composite Signals

- **Simple Signal** = 1 sine wave
- **Composite Signal** = Combination of multiple sine waves
- Decomposed using **Fourier Transform** into individual frequencies

---

### 3.2.6 Bandwidth

- **Bandwidth** = Range of frequencies a signal contains

\[
B = f_{high} - f_{low}
\]

#### ✔️ Example:
5 sine waves: 100, 300, 500, 700, 900 Hz  
→ Bandwidth = 900 − 100 = **800 Hz**

---

## 💻 **3.3 DIGITAL SIGNALS**

---

### Digital Signal Representation

- 1 → Positive Voltage
- 0 → Zero Voltage
- Can also use more levels to encode more bits per level

---

### 3.3.1 Bit Rate

- **Bit rate** = bits per second (bps)

#### ✔️ Example:
100 pages/sec, 24 lines/page, 80 characters/line, 1 char = 8 bits

\[
100 \times 24 \times 80 \times 8 = 1.536 \text{ Mbps}
\]

---

### 3.3.2 Bit Length

- Distance a single bit occupies on a transmission medium

\[
\text{Bit length} = \text{Propagation speed} \times \text{Bit duration}
\]

---

### 3.3.3 Digital = Composite Analog Signal

- A digital signal is made of many sine waves
- **Infinite Bandwidth** in theory
  - Vertical line = ∞ frequency
  - Horizontal line = 0 frequency

> Real-world media can't carry infinite frequencies → filters are used

---

### 3.3.4 Transmission of Digital Signals

| Type | Description | Channel Needed |
|------|-------------|----------------|
| **Baseband** | Digital signal sent directly | **Low-pass** channel (starts from 0 Hz) |
| **Broadband** | Digital signal is modulated into analog | **Band-pass** channel (non-zero start frequency) |

---

### 🔊 Important Notes

- Band-pass channels are **more commonly available** than low-pass channels.
- If you have a band-pass channel, you **must modulate** the signal.

---

## 🔁 Summary Table

| Term | Description |
|------|-------------|
| **Analog Signal** | Continuous wave, infinite values |
| **Digital Signal** | Discrete levels (0,1), fewer values |
| **Bit Rate** | Number of bits sent per second |
| **Wavelength (λ)** | Distance a wave travels in one cycle |
| **Bandwidth (B)** | Range of frequencies in a signal |
| **Baseband** | Direct digital transmission |
| **Broadband** | Digital converted to analog for transmission |

