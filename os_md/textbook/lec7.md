# **Lecture 7: Memory Management III (OSTEP Ch. 17 & 18)**  
This lecture focuses on **free-space management** and **paging**, covering how the OS efficiently manages available memory and translates virtual addresses into physical memory.

---

## **1. Free-Space Management (OSTEP Ch. 17)**
### **1.1 Challenges in Managing Free Space**
- If memory were divided into **fixed-size chunks**, allocation would be easy.
- **Issue:** Free space consists of **variable-sized** chunks.
- **Problem:** **External fragmentation** (e.g., 20 bytes of free space, but a 15-byte request fails due to fragmentation).

---

### **1.2 Techniques for Managing Free Space**
#### **1. Splitting**
- **When a memory request is smaller than an available free chunk:**
  1. Find a **large enough** free chunk.
  2. **Split** it into two pieces:
     - **One allocated chunk** (matching the request).
     - **One free chunk** (remaining space).

#### **2. Coalescing**
- **When a memory block is freed, merge it with adjacent free blocks** to form a larger free chunk.
- **Prevents fragmentation.**

---

### **1.3 Tracking Allocated Memory**
- **The OS must track the size of allocated memory.**
- `free(void *ptr)` does **not** take a size parameter.  
- **Solution:** Use a **header** before each allocated block.

#### **Example: Storing Metadata in the Header**
```c
typedef struct {
    int size;
    int magic;  // Unique identifier for validity check
} header_t;

void free(void *ptr) {
    header_t *hptr = (void *)ptr - sizeof(header_t);
    assert(hptr->magic == 1234567);  // Validate memory block
}
```
- When `malloc(N)` is called, the actual allocated size is **N + header size**.

---

### **1.4 Embedding a Free List**
- Instead of using separate memory for tracking free blocks, **store tracking info inside free chunks** themselves.

#### **Example:**
```c
typedef struct __node_t {
    int size;
    struct __node_t *next;
} node_t;

node_t *head = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
head->size = 4096 - sizeof(node_t);
head->next = NULL;
```
- **Stores free blocks inside the heap itself.**

---

### **1.5 Allocation Strategies**
1. **Best Fit**  
   - Finds the **smallest free block** that fits the request.  
   ✅ **Minimizes fragmentation**  
   ❌ **Requires full list search (slow)**  

2. **Worst Fit**  
   - Finds the **largest free block**, then splits it.  
   ❌ **Increases fragmentation**  

3. **First Fit**  
   - Finds the **first block** that fits the request.  
   ✅ **Faster than Best Fit**  
   ❌ **Can create many small free blocks at the beginning**  

4. **Next Fit**  
   - Like First Fit but **starts from where the last search ended**.  
   ✅ **Spreads out allocations**  

---

### **1.6 Other Free-Space Management Approaches**
- **Segregated Lists:**  
  - Separate **lists for different sizes** of memory chunks.
  - Faster lookup.

- **Buddy Allocation:**  
  - Splits memory **into power-of-2 sizes**.
  - **Easier to coalesce** when freeing.

---

### **1.7 Summary of Free-Space Management**
✔ **Splitting & coalescing reduce fragmentation.**  
✔ **Tracking allocation size helps manage memory efficiently.**  
✔ **Different allocation strategies (Best/Worst/First/Next Fit) have trade-offs.**  
✔ **Buddy allocation and segregated lists help optimize performance.**  

---

## **2. Paging: Introduction (OSTEP Ch. 18)**
### **2.1 What is Paging?**
- **Paging breaks memory into fixed-size chunks called "pages".**
- **Pages eliminate fragmentation issues caused by variable-sized allocations.**

| **Concept**      | **Segmentation**            | **Paging**          |
|------------------|----------------------------|----------------------|
| **Division Type** | Variable-sized segments    | Fixed-size pages     |
| **Fragmentation** | External                    | Internal             |
| **Addressing**   | Segments + Offset           | Pages + Offset       |
| **Flexibility**  | Harder to manage            | Easier, no gaps      |

---

### **2.2 Address Translation in Paging**
Each virtual address is divided into:
- **Virtual Page Number (VPN)** → Used to look up the page in the page table.
- **Offset** → Defines the exact byte inside the page.

#### **Example: 32-bit address with 4 KB pages**
- **VPN** = **top 20 bits** (identifies the page).
- **Offset** = **bottom 12 bits** (location within the page).

---

### **2.3 How Paging Works**
1. **Virtual address is divided into VPN + Offset.**
2. **VPN is used to look up the page table entry (PTE).**
3. **PTE gives the physical frame number (PFN).**
4. **Final physical address = PFN + Offset.**

#### **Example:**
| Virtual Address | VPN | Offset | Mapped PFN | Physical Address |
|----------------|-----|--------|-----------|----------------|
| 0x1234        | 1   | 0x234  | 7         | 0x7234        |

---

### **2.4 Where Are Page Tables Stored?**
- Page tables **are too large** to fit in **hardware registers**.
- Instead, they are **stored in memory**.
- **Problem:** Slower memory accesses (since every access requires **two** memory reads).

---

### **2.5 What’s Inside a Page Table?**
Each **Page Table Entry (PTE)** contains:
1. **Valid Bit:** 1 if the page is in memory, 0 if it’s invalid.
2. **Protection Bits:** Defines **read/write/execute permissions**.
3. **Present Bit:** 1 if the page is loaded in RAM.
4. **Dirty Bit:** 1 if the page was modified (for disk swapping).
5. **Reference Bit:** 1 if the page was accessed recently.

---

### **2.6 Page Table Overhead**
- **Issue:** Page tables take up **a lot of memory**.
- Example:
  - **4 KB pages, 32-bit address space → 1M pages per process!**
  - Each PTE = **4 bytes**, so **4 MB per process** just for the page table.
  - **100 processes → 400 MB wasted!**  

---

### **2.7 Paging Performance Issue**
**Every memory access requires TWO lookups:**
1. **Look up the PTE in the page table (1 memory access).**
2. **Fetch the actual data (1 more memory access).**
   
✅ **Solution? Use the Translation Lookaside Buffer (TLB) (covered in future lectures).**  

---

### **2.8 Summary of Paging**
✔ **Paging eliminates external fragmentation.**  
✔ **Each virtual address is divided into VPN + Offset.**  
✔ **Page tables store mappings from VPN → PFN.**  
✔ **Paging adds memory overhead due to large page tables.**  
✔ **Paging can slow down memory access due to extra lookups.**  

---

## **3. Final Takeaways**
### **Free-Space Management**
- **Splitting & coalescing help manage fragmentation.**
- **Different allocation strategies (Best Fit, First Fit, etc.) optimize performance.**
- **Buddy allocation and segregated lists make allocation more efficient.**

### **Paging**
- **Paging breaks memory into fixed-sized pages.**
- **Virtual addresses are translated using page tables.**
- **Paging avoids external fragmentation but increases lookup time.**
- **Using TLBs (next topic) can speed up address translation.**

