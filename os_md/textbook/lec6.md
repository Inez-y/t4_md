# **Lecture 6: Memory Management II (OSTEP Ch. 15 & 16)**  

This lecture focuses on **address translation** and **segmentation**, explaining how the OS maps virtual addresses to physical memory and how segmentation improves memory efficiency.

---

## **1. Address Translation (OSTEP Ch. 15)**
### **1.1 Virtualizing Memory**
Just as CPU virtualization allows multiple processes to share the CPU, **memory virtualization** enables multiple processes to share RAM **efficiently and securely**. The OS achieves this using:
- **Efficiency:** Hardware support (e.g., **TLBs, registers, page tables**).
- **Control:** Prevents unauthorized memory access.
- **Flexibility:** Allows each process to use its own memory **independently**.

### **1.2 Address Translation**
When a program accesses memory:
1. **It uses a virtual address** (not the actual physical memory address).
2. **The OS translates this virtual address into a physical address.**
3. **The hardware performs the translation quickly** with the help of a **Memory Management Unit (MMU).**

---

### **1.3 Address Translation Example**
#### **C Code:**
```c
void func() {
    int x = 3000;
    x = x + 3;
}
```
#### **Assembly Translation:**
```assembly
128: movl 0x0(%ebx), %eax   ; Load value at address 0+ebx into eax
132: addl $0x03, %eax       ; Add 3 to eax
135: movl %eax, 0x0(%ebx)   ; Store eax back to memory
```
- If `ebx = 15KB`, then memory access happens at **15 KB**.

---

### **1.4 Process Relocation**
- A program **thinks** its memory starts at address **0**.
- The **OS places it anywhere in physical memory** to optimize space.
- **How does the OS relocate processes?**
  - **Base and Bounds Registers (Dynamic Relocation)**

---

### **1.5 Base and Bounds Registers**
A **simple way to implement address translation** is using **base and bounds registers**.

#### **Formula:**
\[
\text{Physical Address} = \text{Virtual Address} + \text{Base Register}
\]
\[
0 \leq \text{Virtual Address} < \text{Bounds}
\]

- **Base Register** → Defines where the process starts in physical memory.
- **Bounds Register** → Defines the maximum address it can access.

#### **Example:**
| Virtual Address | Base Register | Physical Address |
|----------------|--------------|-----------------|
| 128           | 4096          | 4224           |
| 132           | 4096          | 4228           |

---

### **1.6 Hardware Support for Base & Bounds**
- The **CPU must include** base and bounds registers.
- The **OS sets the registers** before a process starts.
- If a process tries to access **out-of-bounds memory**, an **exception (segmentation fault) occurs**.

---

### **1.7 OS Responsibilities in Address Translation**
1. **Process Creation:**  
   - The OS **allocates memory** and sets the base/bounds registers.
   
2. **Process Termination:**  
   - The OS **frees memory** and adds it back to the **free list**.

3. **Context Switching:**  
   - The OS **saves and restores** base/bounds registers.

4. **Exception Handling:**  
   - The OS **handles out-of-bounds memory accesses**.

---

### **1.8 Summary of Address Translation**
- **Address translation ensures processes only access their allocated memory.**
- **Base and bounds registers provide simple, efficient protection.**
- **However, they suffer from inefficiencies like internal fragmentation.**

---

## **2. Segmentation (OSTEP Ch. 16)**
### **2.1 Problems with Base & Bounds**
1. **Internal Fragmentation:**  
   - Large unused memory between stack and heap.
  
2. **Rigid Allocation:**  
   - A program must fit **entirely** in memory.

**Solution?** → **Segmentation!**

---

### **2.2 What is Segmentation?**
- **Segmentation divides memory into multiple parts, called "segments."**
- Each **logically different** part of a program is placed in a separate **segment**.

#### **Common Segments in a Process**
1. **Code Segment** → Stores program instructions.
2. **Stack Segment** → Stores function calls and local variables.
3. **Heap Segment** → Stores dynamically allocated memory (`malloc()`).

---

### **2.3 How Segmentation Works**
Each segment has a **base and bounds register**.

#### **Formula for Address Translation**
\[
\text{Physical Address} = \text{Segment Base} + \text{Offset}
\]

---

### **2.4 Example of Address Translation**
| Virtual Address | Segment Type | Base Address | Offset | Physical Address |
|----------------|-------------|--------------|--------|-----------------|
| 100           | Code        | 32 KB        | 100    | 32 KB + 100 = 32.1 KB |
| 4200          | Heap        | 34 KB        | 104    | 34 KB + 104 = 34.1 KB |

If a process **accesses memory outside its segment**, the OS **triggers a segmentation fault**.

---

### **2.5 How the OS Identifies Segments**
- **Explicit Approach:** The OS uses the **top bits of the virtual address** to determine which segment is being accessed.

#### **Example (14-bit Virtual Address)**
| Bits | Meaning |
|------|--------|
| 11-12 | Segment Identifier |
| 0-10  | Offset within the segment |

**Example Virtual Address (4200 = 0b01 0000 0110 1000)**
- **Segment ID:** `01` (Heap)
- **Offset:** `0x068`

---

### **2.6 Stack Segmentation**
- **The stack grows downward.**
- The OS needs **extra hardware support** to check **growth direction**.

#### **Example**
| Virtual Address | Segment | Offset | Physical Address |
|----------------|--------|--------|-----------------|
| 15,360 (0x3C00) | Stack | -1 KB  | Base - 1 KB |

---

### **2.7 Code Sharing Between Processes**
- **Segments allow sharing memory across processes.**
- The **code segment** can be **read-only** and shared.

#### **Example**
- Two processes **share the same code segment** but have **different heap/stack segments**.

---

### **2.8 Fine-Grained vs. Coarse-Grained Segmentation**
| Type | Description | Pros | Cons |
|------|------------|------|------|
| **Coarse-grained segmentation** | Few large segments (code, heap, stack) | Simple | Wastes memory (external fragmentation) |
| **Fine-grained segmentation** | Many small segments | Reduces waste | Needs more hardware support (segment table) |

---

### **2.9 OS Support for Segmentation**
1. **Context Switches:**  
   - The OS **saves and restores segment registers**.

2. **Memory Allocation (`malloc()`)**  
   - The OS expands **heap** when needed (via `sbrk()`).

3. **Memory Fragmentation:**  
   - **External Fragmentation:** Over time, memory is filled with small **gaps**.
   - **Solution:** Use **compaction** (move segments to eliminate gaps).

---

### **2.10 Segmentation vs. Base & Bounds**
| Feature | Base & Bounds | Segmentation |
|---------|-------------|-------------|
| **Translation Overhead** | Simple | Slightly higher |
| **Flexibility** | Low (entire memory must fit) | High (each segment is separate) |
| **Protection** | Yes (one bound check) | Yes (per-segment bound check) |
| **Fragmentation** | Internal | External |

---

## **3. Summary**
### **Key Takeaways**
✔ **Address Translation** ensures **each process runs in its own address space**.  
✔ **Base & Bounds** provides **simple memory protection** but is **inefficient**.  
✔ **Segmentation** improves **memory utilization and flexibility** but introduces **fragmentation issues**.  
✔ **OS manages memory allocation, translation, and protection using segmentation tables and registers**.
