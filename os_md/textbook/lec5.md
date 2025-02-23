# **Lecture 5: Memory Management I (OSTEP Ch. 13 & 14)**  
This lecture covers **memory virtualization** and **memory allocation APIs** in an OS. It explains how an OS **creates the illusion of a private memory space for each process** and discusses **heap and stack memory allocation**, along with common memory-related errors.

---

## **1. Address Spaces & Memory Virtualization (OSTEP Ch. 13)**  
### **1.1 What is Memory Virtualization?**
- The **OS abstracts physical memory**, creating the illusion that each process has **its own large, private memory space**.
- This abstraction:
  - **Allows multiple processes to run concurrently**.
  - **Protects processes from accessing each other’s memory**.
  - **Improves system efficiency through multiprogramming**.

---

### **1.2 Evolution of Memory Management**
#### **Early OS: Single Process at a Time**
- **One process loaded at a time** into memory.
- **Inefficient** → CPU idle when waiting for I/O.

#### **Multiprogramming & Time Sharing**
- **Multiple processes loaded in memory.**
- **CPU switches between them** to increase utilization.
- **Requires protection mechanisms** to prevent one process from accessing another's memory.

---

### **1.3 Address Space: The OS Abstraction of Memory**
Each **process has an address space**, containing:
1. **Code Segment** → Program instructions.
2. **Heap** → Dynamically allocated memory (via `malloc()` or `new`).
3. **Stack** → Stores local variables, function arguments, and return addresses.

#### **Example: Viewing Address Space in C**
```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("Code location: %p\n", main);
    printf("Heap location: %p\n", malloc(100e6));  // 100 MB allocation
    int x = 3;
    printf("Stack location: %p\n", &x);
    return 0;
}
```
#### **Output (example)**
```
Code location: 0x7f9e6ce1f189
Heap location: 0x7f9e66c30010
Stack location: 0x7ffff9b3d6f4
```
- **Code is at a fixed address**.
- **Heap grows upward** (towards higher memory addresses).
- **Stack grows downward** (towards lower memory addresses).

---

### **1.4 Goals of Memory Virtualization**
1. **Transparency** → Programs should not worry about memory management details.
2. **Efficiency** → Minimize overhead and optimize memory usage.
3. **Isolation & Protection** → Ensure one process cannot access another’s memory.

---

### **1.5 OS Role in Memory Virtualization**
- The **OS translates virtual addresses to physical addresses**.
- Uses **hardware (MMU - Memory Management Unit)** to perform address translation efficiently.
- **Provides isolation** by ensuring processes only access their own memory.

---

## **2. Memory API (OSTEP Ch. 14)**  
### **2.1 Types of Memory Allocation**
#### **1. Stack Memory (Automatic Memory)**
- **Managed automatically by the compiler**.
- **Fast allocation & deallocation**.
- **Function-local variables** are stored here.

#### **Example**
```c
void func() {
    int x;  // Allocated on the stack
}
```
- When `func()` is called, space for `x` is allocated.
- When `func()` exits, `x` is deallocated automatically.

---

#### **2. Heap Memory (Dynamic Memory)**
- **Managed explicitly by the programmer**.
- **Allocated using `malloc()` and freed using `free()`**.
- Used for **large and long-lived objects**.

#### **Example**
```c
void func() {
    int *x = (int *)malloc(sizeof(int));  // Allocated on the heap
}
```
- **Persists beyond function calls** until explicitly freed.

---

### **2.2 `malloc()` – Allocating Memory**
```c
void *malloc(size_t size);
```
- Allocates **size** bytes on the heap.
- Returns a **pointer** to the allocated memory.
- Returns **NULL** if allocation fails.

#### **Example**
```c
int *x = (int *)malloc(sizeof(int));
```
- Allocates 4 bytes (`sizeof(int) = 4` on most systems).
- Returns a pointer to the allocated memory.

---

### **2.3 `sizeof()` – Getting Memory Size**
```c
int x[10];
printf("%lu\n", sizeof(x));  // Returns 40 on a 64-bit system
```
- For **arrays**, `sizeof(x)` returns the total size.
- For **pointers**, `sizeof(x)` returns the pointer size (typically 8 bytes on a 64-bit system).

---

### **2.4 `free()` – Releasing Memory**
```c
void free(void *ptr);
```
- **Frees memory allocated by `malloc()`**.
- **Prevents memory leaks**.

#### **Example**
```c
int *x = (int *)malloc(sizeof(int));
free(x);  // Memory is returned to the OS
```

---

### **2.5 Common Memory Errors**
#### **1. Forgetting to Allocate Memory**
```c
char *src = "hello";
char *dst;
strcpy(dst, src);  // SEGFAULT! dst is uninitialized
```
✅ **Correct Code**
```c
char *dst = (char *)malloc(strlen(src) + 1);
strcpy(dst, src);
```

---

#### **2. Not Allocating Enough Memory**
```c
char *dst = (char *)malloc(strlen(src));  // Too small!
strcpy(dst, src);  // May cause buffer overflow
```
✅ **Correct Code**
```c
char *dst = (char *)malloc(strlen(src) + 1);  // +1 for null terminator
strcpy(dst, src);
```

---

#### **3. Forgetting to Initialize Allocated Memory**
```c
int *x = (int *)malloc(sizeof(int));
printf("%d\n", *x);  // Uninitialized read (random value)
```
✅ **Correct Code**
```c
int *x = (int *)malloc(sizeof(int));
*x = 0;
```

---

#### **4. Forgetting to Free Memory (Memory Leak)**
```c
while (1) {
    malloc(4);  // Memory is never freed → System crash
}
```

✅ **Correct Code**
```c
while (1) {
    int *x = (int *)malloc(4);
    free(x);
}
```

---

#### **5. Freeing Memory Too Early (Dangling Pointer)**
```c
int *x = (int *)malloc(sizeof(int));
free(x);
*x = 5;  // Undefined behavior!
```

---

#### **6. Freeing Memory Twice (Double Free)**
```c
int *x = (int *)malloc(sizeof(int));
free(x);
free(x);  // Undefined behavior!
```

✅ **Correct Code**
```c
int *x = (int *)malloc(sizeof(int));
free(x);
x = NULL;  // Prevents accidental reuse
```

---

### **2.6 Other Memory APIs**
#### **1. `calloc()` – Allocate and Zero Memory**
```c
void *calloc(size_t num, size_t size);
```
- Allocates memory **and initializes it to zero**.

#### **Example**
```c
int *x = (int *)calloc(10, sizeof(int));  // Allocates and zeroes out 10 ints
```

---

#### **2. `realloc()` – Resize Allocated Memory**
```c
void *realloc(void *ptr, size_t size);
```
- Changes the size of an already allocated block.
- **Preserves data** if growing.

#### **Example**
```c
int *x = (int *)malloc(10 * sizeof(int));
x = (int *)realloc(x, 20 * sizeof(int));  // Expands to 20 ints
```

---

### **2.7 OS-Level Memory Allocation (`brk()` & `sbrk()`)**
- `malloc()` internally uses **`brk()` and `sbrk()`** system calls to request memory from the OS.
- **Never use these directly in user programs**.

---

## **3. Summary**
- **Virtual memory allows processes to have private address spaces.**
- **OS translates virtual addresses to physical addresses.**
- **Memory is divided into stack (automatic) and heap (manual allocation).**
- **Common memory errors include leaks, uninitialized reads, and double frees.**
- **`malloc()`, `free()`, `calloc()`, and `realloc()` help manage memory dynamically.**

