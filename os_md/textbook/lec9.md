# Lecture 9. Swapping

## **Chapter 21: Beyond Physical Memory – Mechanisms**
### **Introduction**
- So far, we have assumed that every running process **fits entirely into physical memory**.
- **Reality:** Modern systems run **many processes** whose **combined memory demand exceeds physical RAM**.
- Solution: Use **secondary storage (HDD/SSD) as an extension of RAM**.
- This introduces **an additional level in the memory hierarchy**:
  - **Registers** (fastest, smallest)
  - **Cache** (L1, L2, L3)
  - **Main memory (RAM)**
  - **Mass storage (HDD, SSD, or tape) – used for swapping**
- The OS **moves portions of memory** (pages) **between RAM and disk** dynamically.

---

## **Swap Space**
- **Definition:** A reserved portion of the disk used for **storing memory pages temporarily**.
- **Purpose:** When RAM is full, **inactive pages** are swapped to disk to free space for active processes.
- **OS must track swap space** in **page-sized units**.

---

## **Present Bit**
- To support swapping, the **page table entry (PTE)** includes a **Present bit (P)**:
  - **P = 1** → The page is in **physical memory**.
  - **P = 0** → The page is **not in memory**; it is stored on disk.
- When the CPU accesses a page with **P = 0**, a **page fault** occurs.

---

## **Page Fault**
### **Definition**
- A **page fault** occurs when a program accesses a page that is **not in physical memory**.
- The OS must **retrieve the page from disk and place it back in memory**.

### **Handling a Page Fault**
1. **Find the page’s disk location** (stored in the page table).
2. **Find a free physical page** in RAM:
   - If **RAM is full**, choose a page to **evict (swap out)**.
3. **Swap in the requested page** from disk to RAM.
4. **Update the page table**:
   - Mark the page as **Present (P = 1)**.
   - Update the **PFN (Physical Frame Number)**.
5. **Restart the instruction** that caused the page fault.

---

## **Page Fault Control Flow (Hardware)**
1. Extract the **VPN** from the virtual address.
2. Check the **TLB**:
   - If **hit**, translate the address and continue.
   - If **miss**, check the **page table** in memory.
3. If **PTE is invalid**, raise a **segmentation fault**.
4. If **PTE is valid but the page is swapped out (P = 0)**:
   - Raise a **page fault exception**.
   - OS must bring the page into memory.

---

## **Page Fault Control Flow (Software)**
1. **Find a free page** in physical memory.
2. If **no free pages are available**, select a page to **evict (swap out)**.
3. **Load the required page from disk** (disk I/O is slow!).
4. **Update the page table**:
   - Set **P = 1**.
   - Update the **PFN**.
5. **Retry the instruction**.

---

## **When Does Swapping Occur?**
- The OS does **not** wait until **all RAM is full** before swapping.
- Instead, it maintains:
  - **High Watermark (HW):** Maximum pages to keep free.
  - **Low Watermark (LW):** If free memory drops below LW, the **swap daemon** starts **evicting pages**.
- This ensures **efficient memory management** without excessive paging.

---

## **Summary of Ch. 21**
- Swapping allows the system to **run more processes than fit in RAM**.
- The **Present bit** helps distinguish pages **in RAM vs. on disk**.
- **Page faults occur when a program accesses a swapped-out page**.
- The OS must **retrieve pages from disk, evict pages when necessary, and manage swap space efficiently**.

---

## **Chapter 22: Beyond Physical Memory – Policies**
### **Page Replacement Policies**
- When **RAM is full**, the OS must decide **which page to evict**.
- The goal is to **minimize page faults** (cache misses).

#### **Memory Access Time (AMAT) Formula**
\[
AMAT = T_M + P_{miss} \times T_D
\]
Where:
- **T_M** = Memory access time.
- **T_D** = Disk access time (**slow!**).
- **P_miss** = Probability of a page fault.

A good **replacement policy** minimizes **P_miss**.

---

## **Optimal Page Replacement**
- **Evict the page that will not be used for the longest time**.
- This gives the **lowest possible page fault rate**.
- **Problem:** It requires **future knowledge**—impractical in real systems.

---

## **FIFO (First-In, First-Out)**
- Pages are evicted in **the order they were loaded** (queue-based approach).
- **Simple but ineffective**:
  - **Ignores access frequency**.
  - **May evict frequently-used pages**.

Example:
| Page Reference String | FIFO Queue (3 slots) | Page Fault? |
|----------------------|----------------------|------------|
| 0                    | 0                    | Yes        |
| 1                    | 0, 1                 | Yes        |
| 2                    | 0, 1, 2              | Yes        |
| 0                    | 1, 2, 0              | Yes        |
| 1                    | 2, 0, 1              | Yes        |

**Hit rate: 36.4%** (poor performance).

---

## **Random Replacement**
- Pick a random page to evict.
- **Advantage:** Avoids pathological cases where FIFO or LRU perform poorly.
- **Disadvantage:** Performance is **unpredictable**.

---

## **Least Recently Used (LRU)**
- **Evicts the page that was least recently accessed**.
- **Better than FIFO** because it considers **recency**.
- **Problem:** Maintaining exact LRU requires **too much overhead**.

Example:
- **Hit rate: 54.5%** (better than FIFO).

---

## **Workload Examples**
### **No-Locality Workload**
- Accesses **random pages**.
- No advantage for **any policy**.

### **80-20 Workload**
- **80% of accesses go to 20% of pages** (**hot pages**).
- **LRU performs well**.

### **Looping Sequential Workload**
- Accesses pages **in a cycle**.
- **LRU and FIFO perform poorly**.
- **Random policy may work better**.

---

## **Approximating LRU: The Clock Algorithm**
- Uses a **Use bit (hardware)**:
  - **1 = Recently used**.
  - **0 = Not recently used**.
- Pages are arranged in a **circular list** (like a clock).
- **Eviction Process:**
  - Check the **clock hand**.
  - If **Use bit = 1**, clear it and move forward.
  - If **Use bit = 0**, evict the page.

### **Advantage of Clock Algorithm**
- **Performs close to LRU** but with **less overhead**.

---

## **Considering Dirty Pages**
- Some pages are **modified (dirty)**.
- **Clean pages** can be evicted **without writing to disk**.
- **Dirty pages** must be **written to disk before eviction** (**slow!**).
- **Optimized Clock Algorithm**:
  - First, try to evict **clean, unused** pages.
  - If none, evict **dirty, unused** pages.

---

## **Other Virtual Memory Policies**
### **Demand Paging**
- **Loads pages only when needed**.

### **Prefetching**
- **Guesses which pages will be used next** and loads them in advance.
- Example: If a process loads **page P**, the OS may also load **page P+1**.

### **Write Clustering**
- Instead of writing **one page at a time**, **group multiple writes** to improve efficiency.

---

## **Thrashing**
- **Definition:** When **too many page faults** occur, the system spends **more time swapping than executing**.
- **Cause:** Memory **oversubscription** (too many processes demanding memory).
- **Solutions**:
  - **Admission control:** Don’t run too many processes.
  - **Out-of-memory killer:** Terminate low-priority processes.

---

## **Summary**
- **Swapping allows processes to use more memory than physically available**.
- **Page replacement policies (FIFO, LRU, Clock) affect performance**.
- **Thrashing occurs when excessive swapping slows down the system**.
- **Optimizations (prefetching, clustering, dirty-bit handling) improve efficiency**.