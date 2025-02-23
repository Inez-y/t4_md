# **Lecture 4: Process Management I (OSTEP Ch. 9 & 10)**  
This lecture focuses on **CPU scheduling strategies** that ensure fair resource allocation among processes. It covers **proportional-share scheduling** (e.g., **lottery scheduling, stride scheduling, and CFS**) and **multiprocessor scheduling** (e.g., **single-queue and multi-queue scheduling**).  

---

## **1. Proportional-Share Scheduling (OSTEP Ch. 9)**
### **What is Proportional-Share Scheduling?**
- Unlike FIFO, SJF, or RR, **proportional-share scheduling** ensures that each process receives a **specific fraction of CPU time**.
- **Key goal:** Fair resource distribution rather than minimizing turnaround or response time.

---

### **1.1 Lottery Scheduling**
- **Basic Idea:** Each process receives **tickets** that represent its share of CPU time.
- The **scheduler randomly selects a winning ticket**, and the process holding that ticket runs.

#### **Example: Two Processes**
- **Process A:** 75 tickets  
- **Process B:** 25 tickets  
- **Total Tickets:** 100  
- **Probability of running:**  
  - A: **75%**  
  - B: **25%**

#### **Implementation**
```c
int counter = 0;
int winner = getrandom(0, totaltickets); // Pick a random ticket
node_t *current = head;
while (current) {
    counter += current->tickets;
    if (counter > winner) break; // Found winner
    current = current->next;
}
// Schedule 'current'
```
##### **Pros of Lottery Scheduling**
✅ **Simple and flexible**  
✅ **No starvation** (every job gets a chance)  
✅ **Can handle priority adjustments dynamically**  

##### **Cons of Lottery Scheduling**
❌ **Non-deterministic fairness** (may not always be exact)  
❌ **Unpredictability** over short periods  

---

### **1.2 Stride Scheduling**
- **Deterministic fair-share scheduler**  
- Each process has:
  - **Stride** = `(Large constant) / (Number of tickets)`
  - **Pass counter** (incremented after each execution)
- The **process with the lowest pass counter runs next**.

#### **Example: Three Processes**
| Process | Tickets | Stride (10,000/tickets) | Pass Counter (initially 0) |
|---------|---------|------------------------|----------------------------|
| A       | 100     | 100                    | 0                          |
| B       | 50      | 200                    | 0                          |
| C       | 250     | 40                     | 0                          |

1. **Pick the process with the lowest pass value.**
2. **Increment the pass counter** by its stride.
3. **Repeat the process.**

##### **Pros of Stride Scheduling**
✅ **More predictable than Lottery Scheduling**  
✅ **Ensures fairness in the long run**  

##### **Cons of Stride Scheduling**
❌ **Requires maintaining pass values for all processes**  
❌ **New processes start with `pass = 0` and can monopolize the CPU**  

---

### **1.3 Linux Completely Fair Scheduler (CFS)**
- **Goal:** Divide CPU fairly among all processes.  
- **Uses "virtual runtime" (`vruntime`)** to track CPU usage.
- The **process with the lowest `vruntime` runs next**.

#### **Key Features**
- **Dynamic time slice** based on system load.
- **Priority control using "nice values"** (-20 to +19).
- **Uses a red-black tree** (efficient lookup of the next process).

#### **Example: How `vruntime` Works**
1. **Processes A and B start.**  
2. **A runs longer → `vruntime_A` increases.**  
3. **B wakes up → its `vruntime_B` is much lower than A’s.**  
4. **B runs to catch up.**

##### **Pros of CFS**
✅ **Balances fairness and responsiveness**  
✅ **Scales efficiently with many processes**  
✅ **Handles interactive processes well**  

##### **Cons of CFS**
❌ **Can still experience priority inversion**  
❌ **Does not always perform well in real-time scenarios**  

---

## **2. Multiprocessor Scheduling (OSTEP Ch. 10)**
### **Why Is Multiprocessor Scheduling Important?**
- Modern CPUs have **multiple cores**, meaning multiple threads can run simultaneously.
- **Challenges**:
  - **Load balancing:** How to distribute tasks fairly?
  - **Cache affinity:** How to keep processes on the same core to avoid cache misses?
  - **Synchronization:** How to avoid conflicts when accessing shared data?

---

### **2.1 Single-Queue Multiprocessor Scheduling (SQMS)**
- **All CPUs share a single queue of processes.**
- Each CPU **picks the next job** from the global queue.

#### **Pros of SQMS**
✅ **Simple to implement**  
✅ **Automatically balances load among CPUs**  

#### **Cons of SQMS**
❌ **Requires locks for queue access → scalability issue**  
❌ **May break cache affinity (jobs may jump between CPUs)**  

---

### **2.2 Multi-Queue Multiprocessor Scheduling (MQMS)**
- **Each CPU has its own scheduling queue.**
- New jobs **are assigned to a specific queue** and stay on that CPU if possible.

#### **Pros of MQMS**
✅ **Better scalability (no shared queue lock needed)**  
✅ **Preserves cache affinity**  

#### **Cons of MQMS**
❌ **Can cause load imbalance (some CPUs may be idle while others are overloaded)**  
❌ **More complex to implement**  

---

### **2.3 Load Balancing in MQMS**
#### **Solution 1: Job Migration**
- If one CPU is idle while others are overloaded, **move jobs** from busy CPUs.
- **Challenge:** Migration **costs CPU time**.

#### **Solution 2: Work Stealing**
- **Idle CPUs steal tasks** from busy CPUs.
- **Challenge:** Increases **synchronization overhead**.

---

### **2.4 Linux Multiprocessor Schedulers**
#### **O(1) Scheduler**
- **Similar to MLFQ** (multiple priority queues).
- **Efficient** (constant time scheduling).
- **Used before CFS**.

#### **Completely Fair Scheduler (CFS)**
- **Modern Linux scheduler**.
- **Uses a red-black tree** (efficient lookup).
- **Balances fairness, interactivity, and responsiveness**.

#### **Brain Fuck Scheduler (BFS)**
- **Single-queue scheduler**.
- **Designed for low-latency desktop applications**.
- **Not good for multiprocessor systems**.

---

## **3. Summary**
### **Proportional-Share Scheduling**
| Algorithm | Description | Pros | Cons |
|-----------|-------------|------|------|
| **Lottery Scheduling** | Randomly picks a process based on ticket count. | Simple, avoids starvation | Non-deterministic fairness |
| **Stride Scheduling** | Runs process with the lowest pass counter. | Predictable, ensures fairness | High bookkeeping overhead |
| **CFS** | Picks process with the lowest virtual runtime. | Balances fairness and responsiveness | Can still experience priority inversion |

### **Multiprocessor Scheduling**
| Method | Description | Pros | Cons |
|--------|-------------|------|------|
| **SQMS** | Single global queue for all CPUs | Simple, balances load | Lock contention, breaks cache affinity |
| **MQMS** | Separate queues per CPU | Scales well, preserves cache affinity | Load imbalance |
| **Work Stealing** | CPUs steal tasks from others | Improves balance | High overhead |

---

## **Final Takeaways**
- **Proportional-share scheduling** ensures **fair CPU allocation** but has different approaches (**random, deterministic, and weighted fairness**).
- **Multiprocessor scheduling** must **balance load** while considering **cache affinity** and **synchronization overhead**.
- **Linux CFS is widely used** because it **efficiently balances fairness and responsiveness**.

