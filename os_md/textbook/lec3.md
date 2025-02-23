# **Lecture 3: Operating System Structures and Clocks (OSTEP Ch. 7 & 8)**  
This lecture covers **CPU scheduling policies and algorithms** that help the OS manage multiple processes efficiently. It also introduces **Multi-Level Feedback Queue (MLFQ) scheduling**, which dynamically adjusts process priority based on behavior.

---

## **1. Scheduling: Introduction (OSTEP Ch. 7)**
### **What is Scheduling?**
- The OS **decides which process runs next** on the CPU.
- It balances between:
  - **Performance (turnaround time)**
  - **Fairness (ensuring all jobs get CPU time)**

### **Workload Assumptions**
To simplify scheduling analysis, assume:
1. Each job **runs for the same time**.
2. All jobs **arrive at the same time**.
3. Jobs **run to completion** once started.
4. Jobs **only use the CPU** (no I/O).
5. **Job runtime is known** in advance.

### **Scheduling Metrics**
1. **Turnaround Time** → How long a job takes from arrival to completion.  
   \[
   T_{\text{turnaround}} = T_{\text{completion}} - T_{\text{arrival}}
   \]
2. **Response Time** → How long until a job starts executing.  
   \[
   T_{\text{response}} = T_{\text{first run}} - T_{\text{arrival}}
   \]

---

## **2. Basic CPU Scheduling Algorithms**
### **2.1 First In, First Out (FIFO)**
- **Runs jobs in order of arrival.**
- **Simple but can lead to long wait times** (convoy effect).

#### **Example: FIFO**
| Job | Arrival Time | Burst Time | Completion Time | Turnaround Time |
|----|-------------|------------|----------------|-----------------|
| A  | 0          | 10         | 10             | 10              |
| B  | 0          | 10         | 20             | 20              |
| C  | 0          | 10         | 30             | 30              |

**Average Turnaround Time**  
\[
(10 + 20 + 30) / 3 = 20 \text{ seconds}
\]

##### **Problems with FIFO**
- **Bad for short jobs** if a long job arrives first.
- **Convoy Effect** → A long job delays all shorter jobs.

---

### **2.2 Shortest Job First (SJF)**
- **Always run the shortest job first.**
- **Minimizes turnaround time** but **requires knowing job durations**.

#### **Example: SJF**
| Job | Arrival Time | Burst Time | Completion Time | Turnaround Time |
|----|-------------|------------|----------------|-----------------|
| B  | 0          | 10         | 10             | 10              |
| C  | 0          | 10         | 20             | 20              |
| A  | 0          | 100        | 120            | 120             |

**Average Turnaround Time**  
\[
(10 + 20 + 120) / 3 = 50 \text{ seconds}
\]

##### **Problems with SJF**
- **Requires knowing job lengths** in advance.
- **Not good for interactive jobs**.

---

### **2.3 Shortest Time-to-Completion First (STCF)**
- **Preemptive version of SJF**.
- **If a new, shorter job arrives, the CPU switches to it**.

#### **Example: STCF**
| Job | Arrival Time | Burst Time |
|----|-------------|------------|
| A  | 0          | 100        |
| B  | 10         | 10         |
| C  | 10         | 10         |

**Execution Order:**  
```
0 - 10: A runs
10 - 20: B runs
20 - 30: C runs
30 - 120: A runs
```

**Average Turnaround Time**  
\[
(120 + 20 + 30) / 3 = 50 \text{ seconds}
\]

##### **Problems with STCF**
- **Frequent context switching** increases overhead.
- **Not great for response time**.

---

### **2.4 Round Robin (RR) Scheduling**
- **Each job gets a time slice (quantum).**
- **Good for fairness and response time**, but **can hurt turnaround time**.

#### **Example: RR (Time Slice = 1 sec)**
| Job | Burst Time |
|----|-----------|
| A  | 5         |
| B  | 5         |
| C  | 5         |

**Execution Order:**  
```
A → B → C → A → B → C → A → B → C → A → B → C → A → B → C
```

**Response Time:**  
\[
(0 + 1 + 2) / 3 = 1 \text{ second}
\]

##### **Trade-offs in RR**
- **Short time slices improve response time but increase context switching.**
- **Long time slices improve throughput but delay short jobs.**

---

### **2.5 Incorporating I/O**
- **If a job performs I/O, the scheduler can switch to another job** instead of waiting.

#### **Example: Overlapping CPU and I/O**
| Job | CPU Time | I/O Time |
|----|---------|---------|
| A  | 10 ms   | 10 ms   |
| B  | 50 ms   | 0 ms    |

- A **runs for 10 ms**, then performs I/O.
- Instead of waiting, the scheduler **runs B while A does I/O**.
- **This increases CPU utilization!**

---

## **3. Multi-Level Feedback Queue (MLFQ) (OSTEP Ch. 8)**
### **What is MLFQ?**
- **Dynamically adjusts job priority based on behavior.**
- **Tries to balance turnaround time and response time.**

### **MLFQ Rules**
1. **Rule 1:** If `Priority(A) > Priority(B)`, A runs first.
2. **Rule 2:** If `Priority(A) = Priority(B)`, use **Round Robin**.
3. **Rule 3:** New jobs start at the **highest priority**.
4. **Rule 4a:** If a job **uses an entire time slice**, it **moves down**.
5. **Rule 4b:** If a job **gives up the CPU (I/O-bound)**, it **stays at the same level**.
6. **Rule 5:** **Periodic priority boost** to avoid starvation.

---

### **How MLFQ Works**
#### **Example 1: Long-Running Job**
- A **three-queue scheduler** (10ms, 50ms, 100ms time slices).
- A CPU-intensive job **slowly moves down**.

#### **Example 2: Interactive Jobs**
- If an **I/O job gives up the CPU early**, it stays **at a high priority**.
- **Ensures fast response times** for interactive processes.

#### **Example 3: Preventing Starvation**
- Rule 5 **boosts all jobs to the top periodically**.
- Ensures that long-running jobs **eventually get CPU time**.

---

### **Problems with MLFQ**
1. **Starvation:**  
   - Many interactive jobs **may starve CPU-bound jobs**.
   - Solution: **Priority Boosting (Rule 5)**.
   
2. **Gaming the System:**  
   - A job **can avoid moving down** by doing **small I/O operations**.
   - Solution: **Stricter priority adjustment** (Revised Rule 4).

---

## **4. Summary**
### **Scheduling Algorithms**
- **FIFO:** Simple but leads to **long wait times** (Convoy Effect).
- **SJF:** Optimizes **turnaround time** but requires **knowing job lengths**.
- **STCF:** **Preemptive SJF**, better for **interactive jobs**.
- **Round Robin:** Ensures **fairness**, but increases **context switching**.
- **MLFQ:** **Dynamic**, **adaptive**, but requires **fine-tuning**.

### **Key Takeaways**
- **No single scheduling algorithm is best.**
- **Turnaround time vs. Response time trade-off.**
- **I/O and CPU scheduling must work together.**
- **MLFQ balances fairness, responsiveness, and efficiency.**

