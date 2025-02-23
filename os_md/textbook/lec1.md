# **Lecture 1: Computer Architecture and Overview (OSTEP Ch. 2 & 4)**  
This lecture provides an introduction to **Operating Systems (OS)**, covering their role, key concepts like **virtualization, resource management, concurrency, and persistence**, and a brief history of OS development.

---

## **1. What is an Operating System (OS)?**
An **OS is middleware** that manages system hardware and provides services to user programs. It:
- **Manages hardware resources** like CPU, memory, and I/O devices.
- **Provides a user-friendly interface** for running programs.
- **Ensures system efficiency and correctness.**

### **How Does a Program Run?**
1. The processor fetches an instruction from memory.
2. It decodes the instruction (figures out what to do).
3. It executes the instruction (e.g., arithmetic, memory access, function calls).
4. It moves to the next instruction and repeats the process until completion.

---

## **2. OS as a Resource Manager**
The OS **manages resources** to allow multiple programs to run efficiently:
- **CPU Sharing**: Many programs can run by scheduling CPU time.
- **Memory Sharing**: Each program has its own memory space.
- **Device Sharing**: Programs access disks, networks, and peripherals.

---

## **3. Virtualization**
**Virtualization** is the OS's ability to **create a virtual version of a physical resource** (e.g., CPU, memory, disk) that is more flexible and powerful.

### **Virtualizing the CPU**
- The OS **creates many virtual CPUs** from one physical CPU.
- It **switches between programs** so that multiple programs appear to be running simultaneously.
  
#### **Example: CPU Virtualization in C**
```c
while (1) {
    Spin(1);  // Keeps CPU busy for 1 second
    printf("%s\n", str);
}
```
- Running multiple programs (`./cpu A & ./cpu B & ./cpu C & ./cpu D &`) makes it seem like all are running at once, even though there's only **one physical CPU**.

---

### **Virtualizing Memory**
- Physical memory (RAM) is a collection of **bytes**.
- Each program thinks it has **its own private memory space**.
- The OS **maps virtual memory addresses to physical memory**.

#### **Example: Memory Virtualization in C**
```c
int *p = malloc(sizeof(int));  // Allocate memory
printf("Address: %p\n", p);
*p = 0;
while (1) {
    *p = *p + 1;
    printf("p: %d\n", *p);
}
```
- When multiple programs run, they **see the same virtual address** but actually have different physical memory locations.

---

## **4. Concurrency and Synchronization Issues**
- The OS **switches between processes and threads**, but this can cause problems.
- Example: Two threads updating a shared variable **may lead to inconsistent values** due to non-atomic operations.

#### **Example: Concurrency Issue**
```c
volatile int counter = 0;

void *worker(void *arg) {
    for (int i = 0; i < loops; i++) {
        counter++;  // Not atomic, can cause incorrect results
    }
    return NULL;
}
```
- Running `./thread 100000` should result in `200000`, but actual results vary (`143012, 137298, etc.`) due to **race conditions**.
- **Solution:** Use synchronization mechanisms like **locks, semaphores, or atomic operations**.

---

## **5. Persistence: File System and Storage**
- RAM is **volatile** (data is lost when power is off), so we need **persistent storage** like **hard drives and SSDs**.
- The **file system** manages files and directories, ensuring:
  - **Efficient storage**
  - **Data protection from crashes**
  - **Safe concurrent access**

#### **Example: Writing to a File**
```c
int fd = open("/tmp/file", O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU);
write(fd, "hello world\n", 13);
close(fd);
```
- The OS determines **where to store data** and **handles crashes using journaling or copy-on-write techniques**.

---

## **6. Design Goals of an OS**
### **Key Goals:**
1. **Abstraction** → Make the system easy to use.
2. **Performance** → Minimize OS overhead.
3. **Protection** → Isolate applications from each other.
4. **Reliability** → Ensure the OS runs continuously.
5. **Other considerations** → Energy efficiency, security, mobility.

---

## **7. Brief History of Operating Systems**
- **1950s:** No OS, manual operation.
- **Batch Processing (IBM 709, 1957):** Simple OS for job scheduling.
- **Multiprogramming (Unix, 1970s):** Multiple programs run concurrently.
- **Personal Computers (Apple II, IBM PC, 1980s):** Introduction of **DOS, Mac OS, and Windows**.
- **Modern OS (Linux, Windows, macOS, Android, iOS, IoT):** Highly virtualized, networked, and optimized.

---

## **8. Summary**
- The OS **manages hardware and provides services** to applications.
- **Virtualization** allows multiple programs to run simultaneously.
- **Concurrency** can cause problems (race conditions) and needs synchronization.
- **Persistence** ensures data storage even after power loss.
- The OS must be **efficient, reliable, and secure**.
