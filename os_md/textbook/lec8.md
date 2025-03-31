# Lecture 8: Memory Management IV

**Chapter 19 of OSTEP** and focuses on how **Translation Lookaside Buffers (TLBs)** help in **speeding up address translation** in a paged memory system. 

### **Issues with Paging**
Paging is a method of memory management where:
- Each **Virtual Page Number (VPN)** is mapped to a **Physical Frame Number (PFN)**.
- The mapping is stored in **page tables**, which are typically located in **physical memory**.
- Before accessing an instruction or data in memory, the CPU must **translate the virtual address to a physical address**, which requires a memory lookup.
- This **adds extra latency** since every memory access requires **one additional memory access for translation**.

### **Solution: Translation Lookaside Buffer (TLB)**
- The **TLB** is a **small, high-speed cache** inside the **Memory Management Unit (MMU)** that stores recent **VPN → PFN mappings**.
- Instead of **consulting the page table** in memory, the CPU can check the **TLB first** for a quick translation.

---

## **TLB Control Flow Algorithm**
This algorithm outlines how address translation works **with a TLB**.

1. **Extract VPN from the Virtual Address**
   - The **VPN is extracted** by applying a bit mask (`VPN_MASK`) and shifting.

2. **Check TLB for VPN**
   - The CPU searches for the **VPN** in the **TLB**.
   - If **found (TLB hit)**:
     - Check **protection bits** to ensure valid access.
     - Calculate **physical address** and read from memory.
   - If **not found (TLB miss)**:
     - The CPU must **access the page table in memory**.
     - If the **page table entry (PTE) is invalid**, an exception is raised.
     - Otherwise, **load the translation into the TLB** and **retry** the instruction.

---

## **Example: Accessing an Array**
Consider this simple loop:

```c
int i, sum = 0;
for (i = 0; i < 10; i++) {
    sum += a[i];
}
```
- **3 TLB misses** (meaning memory access requires consulting the page table).
- **7 TLB hits** (meaning the required addresses are already cached in the TLB).
- **TLB hit rate = 70%**.

This high hit rate is due to **spatial locality**—once an address is accessed, nearby addresses are likely to be accessed soon.

---

## **Locality (Why TLBs Work Well)**
1. **Temporal Locality**
   - If an address is accessed **recently**, it is likely to be accessed again **soon**.
   - Example: Loop variables and instructions inside loops.

2. **Spatial Locality**
   - If an address **x** is accessed, nearby addresses will likely be accessed **soon**.
   - Example: Scanning through an **array**.

Both properties help **improve the TLB hit rate**, reducing the number of expensive memory accesses.

---

## **Who Handles a TLB Miss?**
Depending on the CPU architecture, a **TLB miss** can be handled by **hardware or software**.

### **Hardware-Managed TLB (CISC, Intel x86)**
- The **CPU hardware** directly walks the page table.
- The **hardware knows** the structure and location of page tables.
- The translation is inserted into the **TLB automatically**.

### **Software-Managed TLB (RISC)**
- The CPU **raises an exception** (trap).
- The **OS trap handler** looks up the page table and inserts the entry into the **TLB**.
- Example: **MIPS, SPARC architectures**.

---

## **TLB Entry Structure**
- A **TLB typically has 32–128 entries**.
- It is **fully associative** (hardware searches all entries in parallel).
- TLB Entry Format:
  - **VPN (Virtual Page Number)**
  - **PFN (Physical Frame Number)**
  - **Valid bit** (whether the entry is valid)
  - **Protection bits** (read/write/execute permissions)
  - **Address Space Identifier (ASID)** (used for context switching)
  - **Dirty bit** (if the page has been written to)

---

## **TLB Issue: Context Switches**
- When switching between processes, **different processes have different page tables**.
- The TLB entries from **Process A** may still be in the TLB when **Process B** starts.
- **Solution: Address Space Identifier (ASID)**
  - Each **TLB entry includes an ASID**.
  - This **prevents conflicts** between different processes.

Example:

| VPN | PFN | Valid | Protection | ASID |
|-----|-----|-------|------------|------|
| 10  | 100 | 1     | RWX        | 1    |
| 10  | 170 | 1     | RWX        | 2    |

- **Process 1 and Process 2 both use VPN 10, but they map to different PFNs**.
- The **ASID field ensures the CPU knows which entry belongs to which process**.

---

## **TLB Replacement Policy**
Since the **TLB has limited entries**, when it is full, some entries must be **evicted**. There are two common replacement policies:

1. **Least Recently Used (LRU)**
   - The **oldest** entry (not used for the longest time) is evicted.
   - This takes advantage of **temporal locality**.

2. **Random Replacement**
   - **Randomly selects an entry** to evict.
   - It is **simpler** and avoids pathological cases where LRU performs poorly.

---

## **Hybrid Approach: Paging and Segments**
Instead of having **one large page table**, we can **divide memory into segments**. Each segment has its **own page table**.

Example segmentation:

| Segment | Contents |
|---------|----------|
| 00      | Unused   |
| 01      | Code     |
| 10      | Heap     |
| 11      | Stack    |

### **Advantages**
- Reduces **unused space** in the page table.
- Unallocated **pages between stack and heap** do not take up memory.

### **Disadvantages**
- It **reintroduces external fragmentation**.
- **Large sparse heaps** may still waste memory.

---

## **Multi-Level Page Tables**
Instead of storing **one large page table**, **multi-level paging** breaks the table into **smaller chunks**.

### **Why?**
- **Linear page tables are too large.**
- If **an entire section is unused**, the OS **does not allocate memory for it**.

Example:
- Assume **32-bit addresses** and **4KB pages**.
- A **single-level page table** would require **4MB per process**.
- Using **multi-level page tables**, we allocate only the required parts.

### **Two-Level Page Table Example**
- **Page Directory (PD)** contains entries pointing to **Page Tables (PT)**.
- **Each PT contains entries pointing to physical memory**.

**Control Flow for Address Translation:**
1. Look up the **Page Directory Entry (PDE)**.
2. If valid, fetch the **Page Table Entry (PTE)**.
3. If valid, use the **PFN + Offset** to access memory.

---

## **Inverted Page Tables**
- Instead of **one page table per process**, we **use a single global page table**.
- Each **physical page** has an entry indicating:
  - Which **process** owns it.
  - Which **virtual page** it maps to.

- **Problem:** Linear search is slow.
- **Solution:** Use a **hash table** for fast lookups.

---

## **Summary**
- The **Translation Lookaside Buffer (TLB)** speeds up address translation.
- **Locality (temporal & spatial)** helps improve **TLB hit rates**.
- TLB entries include **VPN, PFN, valid bits, ASID, and protection bits**.
- **TLB replacement policies** help manage limited TLB space.
- **Multi-level page tables** reduce memory waste by only allocating used sections.
- **Inverted page tables** reduce memory usage but need a **fast lookup mechanism**.
