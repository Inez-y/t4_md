# Lecture 10. Concurrency I

**Concurrency: Threads, Race Conditions, Mutexes, and Condition Variables**, based on your slides and OSTEP Chapters 26–27. This 

---

## 🧵 Concurrency Study Notes (OSTEP Ch. 26 & 27)

---

### 🧠 **1. What is a Thread?**
- A **thread** is a unit of execution within a process.
- **Multi-threaded program**: Multiple threads run in the same process and **share**:
  - Code (text segment)
  - Heap (malloc’d memory)
  - Global variables
- Each thread has its own:
  - **Program Counter (PC)**
  - **Registers**
  - **Stack** (local variables, function call frames)

---

### 🧩 **2. Memory Layout: Single-threaded vs Multi-threaded**

| Segment | Description | Behavior |
|--------|-------------|----------|
| **Program Code** | Instructions (functions) | Shared by all |
| **Heap** | malloc’d memory | Shared by all, grows upward |
| **Stack** | Local vars & function frames | One stack per thread, grows downward |

🔍 **Diagram Insight**:
- In multi-threaded programs, each thread has a separate stack in the same address space.
- Address space includes code, heap, and one stack per thread.

---

### 🔁 **3. Context Switching Between Threads**
- Each thread has a **Thread Control Block (TCB)**: stores PC, registers, state.
- When switching from one thread to another:
  1. Save current thread's registers.
  2. Load new thread’s registers.
  3. No need to switch address space/page table.

---

### ⚙️ **4. Why Use Threads?**
- **Parallelism**: Multiple threads → run on multiple CPUs/cores.
- **Avoid I/O blocking**: One thread waits on I/O, others continue.
- **More efficient than processes**:
  - Lighter weight (less overhead).
  - Faster context switch (no address space switch).
  - Shared data access.

---

### 🧪 **5. Race Conditions**
Occurs when:
- Threads access shared data **without synchronization**.
- The result **depends on execution timing**.
- Example (from `t1.c`):
```c
counter = counter + 1;
```
Assembly:
```asm
mov counter, %eax
add $1, %eax
mov %eax, counter
```
If threads interleave these steps → incorrect `counter` value.

---

### 🚨 **6. Critical Section**
- A block of code that accesses shared variables.
- Only **one thread should enter** at a time.
- Otherwise, **race condition** can occur.

---

### 🔒 **7. Mutual Exclusion (Mutex Locks)**

#### ✅ Interface:
```c
pthread_mutex_lock(pthread_mutex_t *lock);
pthread_mutex_unlock(pthread_mutex_t *lock);
```

#### ✅ Example:
```c
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

pthread_mutex_lock(&lock);
counter++;
pthread_mutex_unlock(&lock);
```

- **Ensures atomic access** to critical section.
- One thread gets the lock → others wait.

---

### 🧰 **8. Condition Variables (Signaling)**

#### ✅ Purpose:
Used when threads need to wait for a **condition to become true**.

#### ✅ Interface:
```c
pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *lock);
pthread_cond_signal(pthread_cond_t *cond);
```

#### ✅ Usage:
```c
// Waiting thread
pthread_mutex_lock(&lock);
while (!ready)
    pthread_cond_wait(&cond, &lock);
pthread_mutex_unlock(&lock);

// Signaling thread
pthread_mutex_lock(&lock);
ready = 1;
pthread_cond_signal(&cond);
pthread_mutex_unlock(&lock);
```

- Wait releases lock → puts thread to sleep.
- Signal wakes up one waiting thread.
- Use **while** (not if!) to re-check the condition after waking.

---

### 🛑 Don’t Do This:
```c
while (ready == 0); // busy waiting / spin lock ❌
```
- Wastes CPU cycles.
- Error-prone → use condition variables instead.

---

### 🧵 **9. Thread API: pthread**

#### 🔹 Create a Thread
```c
int pthread_create(pthread_t *thread,
                   const pthread_attr_t *attr,
                   void *(*start_routine)(void*),
                   void *arg);
```

- `thread`: Output thread ID.
- `attr`: Usually `NULL`.
- `start_routine`: Function the thread will run.
- `arg`: Passed into `start_routine`.

#### 🔹 Join a Thread
```c
int pthread_join(pthread_t thread, void **retval);
```
- Waits for thread to finish and **retrieves return value**.

#### 🧪 Example:
```c
void *thread_func(void *arg) {
    int *res = malloc(sizeof(int));
    *res = 42;
    return res;
}
...
pthread_t t;
int *result;
pthread_create(&t, NULL, thread_func, NULL);
pthread_join(t, (void**)&result);
printf("%d\n", *result);
free(result);
```

---

### ⚠️ **10. Thread Return: Be Careful**
- ❌ Don’t return local (stack) variables — they’ll disappear!
- ✅ Use `malloc()` to return values from threads.

---

### 🧰 **11. Compiling Thread Programs**
Use the `-pthread` flag:
```bash
gcc -o main main.c -Wall -pthread
```

---

### 📌 Summary

| Concept | Meaning |
|--------|---------|
| Thread | Unit of execution inside a process |
| Race Condition | Two threads access shared data with unpredictable results |
| Critical Section | Code needing atomic access |
| Mutex | Ensures mutual exclusion |
| Condition Variable | Used for signaling/waiting between threads |
| pthread_create | Creates a thread |
| pthread_join | Waits for a thread and collects return |
| -pthread | Linker flag required for threading |

