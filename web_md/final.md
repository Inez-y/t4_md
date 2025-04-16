# Lecture 1 

### 🔸 Why Is Web Development Challenging Compared to Desktop App Development?

Web applications are **more complex** than desktop apps because:

| Web App Challenges | Desktop App Advantages |
|--------------------|------------------------|
| Users can close tabs at any time without notice | OS notifies app before shutdown |
| Must run on many browsers (Chrome, Edge, Safari) | Runs on a single OS |
| Limited browser resources | Full access to computer's memory, CPU |
| Must work on phones, tablets, PCs, etc. | Fixed hardware (e.g., one PC) |
| Security is critical — open to the internet | Local-only access; not exposed |
| Network/server downtime breaks apps | Desktop doesn’t rely on network |

#### ❓ **Scenario Exercise: Devices + Network Conditions**
You're asked to analyze combinations like:
- `M.1`: Mobile, no internet
- `i.3`: IoT device, internet-connected

For each combo, consider:
- **Available resources** (CPU, memory, GPU)
- **Connectivity** (offline/local/internet)
- **Security**
- **Sensor access** (camera, GPS)
- **Battery constraints**

Example:
- **i.3 (IoT + internet)**:
  - May lack screen or keyboard
  - Needs secure, lightweight communication (e.g., MQTT)
  - Often limited in RAM and CPU
  - Data may need to be encrypted

---

### 🔸 JavaScript OOP: Inheritance vs. Composition

#### 🔹 Inheritance (IS-A Relationship)
```js
class Vehicle {
  constructor(type) {
    this.type = type;
  }
}

class Car extends Vehicle {
  constructor(brand) {
    super("car"); // calls Vehicle's constructor
    this.brand = brand;
  }
}
```
- `super()` = calls parent constructor.
- A **Car IS-A Vehicle**.
- Good for shared logic, but can become rigid.

#### 🔹 Composition (HAS-A Relationship)
```js
class Engine {
  start() { console.log("Vroom!"); }
}

class Car {
  constructor(engine) {
    this.engine = engine;
  }
}
```
- A **Car HAS-A Engine**.
- More flexible than inheritance — you can easily swap components.
- Recommended in most JS apps (e.g., React prefers composition patterns).

---

### 🔸 JavaScript Features: Template Strings
```js
let name = "John";
let greeting = `Hello, ${name}!`;
```
- Uses backticks (`) instead of quotes
- Called **string interpolation**
- Cleaner than using `"Hello, " + name + "!"`

---

### 🔸 Chrome DevTools
You’ll often use:
1. **Elements** – Inspect HTML
2. **Console** – Run JavaScript, view errors
3. **Sources** – Debug JavaScript
4. **Network** – Monitor requests (AJAX, images, etc.)
5. **Application** – Storage (cookies, local storage)
6. **Performance** – Measure load times
7. **Lighthouse** – Audit performance/accessibility

---

### 🔸 JavaScript Coding Style (Course Standards)

- Use `const` by default → unless variable needs to change → use `let`
- Never use `var`
- Functions must be:
  - **Short**
  - Do one thing only
  - Have **no side effects**
- Put user-facing messages in **separate files** (localization, reusability)
- Avoid hard-coded strings:
  ```js
  const MESSAGES = { scoreMsg: "Your score is %1 today" };
  ```

---

### 🔸 HTML + DOM Basics

#### HTML = Structure
- HTML uses **tags** like `<p>`, `<h1>`, `<div>`
- All content must be inside a tag
- Example:
  ```html
  <html>
    <body>
      <h1>Hello World</h1>
    </body>
  </html>
  ```

#### DOM = Tree of Elements
- The browser turns HTML into a **Document Object Model** (DOM)
- JS can dynamically modify this tree:
  ```js
  document.getElementById("myHeader").innerHTML = "New text!";
  ```

---

### 🔸 CSS: Styling Approaches

1. **Inline**
   ```html
   <p style="color: red;">Text</p>
   ```
2. **Internal**
   ```html
   <style>p { color: red; }</style>
   ```
3. **External**
   ```html
   <link rel="stylesheet" href="style.css">
   ```

#### Selectors:
- `h1` – by tag name
- `.className` – by class
- `#idName` – by ID

---

### 🔸 JavaScript DOM Manipulation

Example: Add a button with JavaScript
```js
let btn = document.createElement("button");
btn.innerHTML = "Click me";
document.body.appendChild(btn);
```

Events:
```js
btn.addEventListener("click", () => {
  alert("Button clicked!");
});
```

---

### 🔸 JavaScript Variables and Scope

| Keyword | Scope | Hoisting | Reassignable |
|---------|--------|----------|--------------|
| `var`   | Function | ✅ Yes | ✅ Yes |
| `let`   | Block | ❌ No | ✅ Yes |
| `const` | Block | ❌ No | ❌ No (for primitives) |

```js
const x = { name: "Tom" };
x.name = "Jerry"; // OK: object property changed
x = {}; // ❌ Error: reassigning const
```

---

### 🔸 JavaScript Types
- Primitives: `Number`, `String`, `Boolean`, `undefined`, `null`, `Symbol`
- Object: Arrays, Dates, Functions

Use `typeof`:
```js
typeof 42           // "number"
typeof "hello"      // "string"
typeof {}           // "object"
```

---

### 🔸 Hosting & Deployment

To **host** a website:
- Upload HTML/CSS/JS to a **web server**
- Needs a **domain** and an **IP address**
- Use tools like **Heroku**, **Vercel**, or **cPanel**-based hosts

#### Hosting Must Support:
- SSL (`https`)
- Relational DB (MySQL/PostgreSQL)
- Node.js (if backend is required)

#### Hosting Types:
| Type | Description |
|------|-------------|
| Shared | Cheap, slow, many sites on one server |
| VPS | Virtual private server – faster, more control |
| Dedicated | One server per app – expensive |
| Cloud | Scalable, good for spikes (AWS, Azure, GCP) |

#### Note on `index.html`
- Most web servers auto-serve `index.html` if no file is specified in the URL:
  ```url
  http://mydomain.com/project1/ → serves project1/index.html
  ```

---


# Lecture 2: Internet Software Architecture, JSON, and Web Storage (Explained In-Depth)


### 🔹 PART 1: Course Overview

You’re told that the course will focus on:

- Designing **web applications** using **API-centric architecture**
- Using **REST**, **JSON**, **HTTP**
- Working with **asynchronous JavaScript**
- Developing scalable, modular, and maintainable systems

Also: expect assignments, quizzes, term projects, and you'll build API-based apps.

---

### 🔹 PART 2: What Is Internet Software Architecture?

#### 🔧 “Architecture” = Structure + Relationships

Whether it’s a building or an app, architecture is **how components interact**:

| Domain | Components | Focus |
|--------|------------|-------|
| Building | Walls, floors | Flow, cost, beauty |
| Computer | CPU, RAM, storage | Speed, power |
| Web App | UI, backend, DB, APIs | **Scalability**, **modularity**, **reliability**, **security** |

---

### 🔹 Why Study Architectural Patterns?

Because they help us **evaluate and improve** the following:

- 🧠 **Efficiency**: “Which tech stack performs best?”
- 💸 **Cost**: “Can I reduce devs by unifying languages?” (e.g., use Node.js for frontend and backend)
- 🔧 **Extensibility**: “Can I add a feature without breaking everything?”
- 🔐 **Security**: “Can I isolate my exposed areas (like using an API gateway)?”
- 💪 **Robustness**: “What happens if one part (e.g. DB) fails?”
- 🔌 **Modularity**: “Is each module handling just one concern?”
- 🚀 **Deployment**: “Can I deploy quickly or need Docker, recompiling?”

These questions are *real-world scenarios* you’ll hit on any dev team.

---

### 🔹 Architectural Patterns Covered

Let’s explore the **styles of software architecture** you’ll compare:

---

#### 1. 🧱 **Monolithic Architecture**
- Everything is in **one codebase**, **one machine**, **one stack**
- Simple, but hard to scale or update
- Updating one part = restart entire app

```plaintext
[ UI + Logic + DB access ] — all in one backend codebase
```

> Example: A Java-based backend that handles routes, logic, and DB in one `.jar`

---

#### 2. 🧩 **Multi-tier / 3-Tier Architecture**
- **Client (browser)** → **Application server** → **DB server**
- Each layer handles its own responsibility
- Easier to scale individual parts

```plaintext
[ Client ] → [ Backend Logic ] → [ Database ]
```

---

#### 3. 🧬 **Layered Architecture (4 Layers)**
- Presentation (UI)
- Business Logic (auth, rules)
- Application Layer (libraries/utilities)
- Data Access Layer (DBs)

Used in many MVC frameworks.

---

#### 4. 🌐 **Service-Oriented Architecture (SOA)** & **Microservices (MSA)**
- Break app into **independent services**
- Each service can:
  - Live on a different machine
  - Be in a different language (Python, Node.js, Go…)
  - Be scaled independently
- All services **talk via APIs**
- Example: Facebook’s Messenger app runs independently from Facebook itself

---

#### ✅ **Your Course Focus** = Microservices + RESTful APIs + JSON

You will **build apps like this**:
- Frontend HTML/JS sends **AJAX requests**
- Backend services respond with **JSON**
- Services run on different machines

---

### 🔹 REST + JSON + HTTP

You’ll practice using:
- **HTTP methods**:
  - `GET`: Read data
  - `POST`: Add new data
  - `PUT`: Update existing data
  - `DELETE`: Remove data

- **RESTful URIs**:
  ```
  /api/users → list all users
  /api/users/1 → details for user ID 1
  ```

- **JSON format** for API data:
  ```json
  {
    "name": "John",
    "age": 22
  }
  ```

- **Versioning** of APIs:
  ```
  /v1/api/users
  /v2/api/users
  ```

- **HTTP Status Codes**:
  - `200 OK`
  - `404 Not Found`
  - `401 Unauthorized`
  - `500 Internal Server Error`

---

### 🔹 Web Storage: `localStorage` vs `sessionStorage`

#### Problem:
Before HTML5, we used **cookies**, but they were:
- Size-limited (~4KB)
- Sent with every HTTP request

#### HTML5 Solution: **Web Storage**
- Stores data in the browser
- Not sent with HTTP requests
- Can store much more (5MB+)
- **Same origin only** (must match domain + protocol)

#### Two Types:

| Feature | `localStorage` | `sessionStorage` |
|---------|----------------|------------------|
| Expiry | Never expires | Expires on tab close |
| Shared between tabs? | ✅ Yes | ❌ No |
| Use case | Remember login across days | Track something during one session |

##### Example:
```js
// Store
localStorage.setItem("greeting", "Hello!");

// Retrieve
let msg = localStorage.getItem("greeting");

// Remove
localStorage.removeItem("greeting");
```

---

### 🔹 JSON – JavaScript Object Notation

#### What Is JSON?
- A **text-based format** to transmit JS-like data
- You convert JS objects to strings → send → parse back

#### Example:
```js
let obj = { name: "Alice", age: 30 };

// Convert to string
let str = JSON.stringify(obj);

// Convert back
let newObj = JSON.parse(str);
```

> 🧠 **Why JSON?**
> - Works across languages (Python, Go, PHP, etc.)
> - Fast and lightweight
> - Perfect for REST APIs

---

### 🔹 Programming Tips: Closures, Objects, and Event Handlers

#### 🔁 Same event handler for multiple buttons?
Use **closures**!

```js
function handleClick(id) {
  return function () {
    console.log("Button " + id + " clicked!");
  };
}

button1.onclick = handleClick(1);
button2.onclick = handleClick(2);
```

Here, `handleClick(1)` returns a *new function* that remembers `id = 1`.

> ✅ Closures = functions that “remember” variables from the context in which they were defined

---

#### 🧱 Object Constructor with Methods

```js
function Person(name, age) {
  this.name = name;
  this.age = age;
  this.sayHi = function() {
    console.log("Hi, I’m " + this.name);
  };
}

let p = new Person("Luna", 25);
p.sayHi(); // "Hi, I’m Luna"
```

---

## 📌 Summary of Learning Objectives (So Far)
By the end of this section, you should be able to:
- ✅ Understand and compare different architectures (monolithic vs microservices)
- ✅ Build RESTful APIs
- ✅ Use JSON for API data transmission
- ✅ Use `localStorage` and `sessionStorage`
- ✅ Apply object-oriented JavaScript
- ✅ Create modular, scalable apps

---


# Lecture 3: Web APIs, REST, and Microservices (Full Explanation)


### 🔹 PART 1: Review Concepts

#### ✅ JavaScript Essentials
- **`const`, `let`, `var`**
  - Use `const` if the value won’t change
  - Use `let` if you need reassignment
  - NEVER use `var` (hoisting + function-scoped = bugs)

#### ✅ `typeof` checks
- `typeof null` returns `'object'` → this is actually a **bug in JavaScript**
- `typeof []` returns `'object'` → because arrays are technically objects

#### ✅ Web Storage Recap
- `localStorage`: persists after closing tab
- `sessionStorage`: gone when tab closes
- Only stores **string** values
- To store objects:
  ```js
  const obj = { name: "Luna" };
  localStorage.setItem("cat", JSON.stringify(obj));
  const result = JSON.parse(localStorage.getItem("cat"));
  ```

---

### 🔹 PART 2: Why Do We Need Web APIs?

#### 🌍 Traditional Web Servers Return HTML
- When a browser hits:
  ```
  https://wordpress.com/index.php
  ```
  the server runs PHP → returns **HTML page** (plus CSS and JS)

But if you’re **another program**, not a human in a browser… HTML is **hard to work with**.

---

### 🎬 Example: Building an Online Movie Store

#### ❌ Option 1: Scrape IMDb (Bad idea)
- IMDb returns **HTML pages** full of CSS, divs, spans, ads, etc.
- If you just want "title", "actors", or "poster", you need to:
  - Parse HTML manually
  - Worry about page structure changes

> If IMDb changes its design, your scraper breaks. This is **fragile** and unscalable.

#### ✅ Option 2: Use an **API**
- IMDb exposes structured data via third-party APIs like `OMDb API`
- You query:
  ```http
  http://www.omdbapi.com/?t=star+wars&y=2015&apikey=1234
  ```
- And get clean JSON:
  ```json
  {
    "Title": "Star Wars: The Force Awakens",
    "Year": "2015"
  }
  ```

> 🧠 **Lesson**: HTML is for humans. APIs are for machines.

---

### 🔹 PART 3: What Is a Web API?

> A **Web API** is a way for different software to talk over the internet.

---

#### 🌐 Web API Anatomy

1. **Endpoint**  
   - The URL where the API listens  
   - Example: `/api/movies/123`

2. **HTTP Methods**
   - `GET` = read
   - `POST` = create
   - `PUT` = update
   - `DELETE` = remove

3. **Headers**
   - Metadata about the request or response
   - Example:
     - `Authorization: Bearer <token>`
     - `Content-Type: application/json`

4. **Body / Payload**
   - Used with `POST`, `PUT` to send data
   - Sent in JSON format usually

5. **Status Codes**
   - 200: OK
   - 201: Created
   - 400: Bad Request
   - 401: Unauthorized
   - 404: Not Found
   - 500: Server Error

---

### 🔹 GET vs POST (Big Difference)

| Feature | GET | POST |
|--------|-----|------|
| Purpose | Read data | Send data |
| Where data goes | URL query | Request body |
| Visible in browser? | ✅ Yes | ❌ No |
| Can bookmark? | ✅ Yes | ❌ No |
| Security | ❌ Data exposed | ✅ Slightly better |
| Data size limit | ✅ Yes | ❌ No |
| Use for login? | ❌ No | ✅ Yes |

> 💡 Rule: Use `GET` for *reading* data. Use `POST`/`PUT` for *modifying* data.

---

### 🔹 Testing APIs with Postman

Postman = GUI tool for testing APIs

- You can:
  - Set the method (`GET`, `POST`, etc.)
  - Add headers (like `Authorization`)
  - Send body (JSON)
  - View status code and response

> Use Postman to experiment with APIs **before you write code**.

---

### 🔹 PART 4: What Is REST / RESTful Architecture?

#### 🧠 REST = Representational State Transfer
A **design style** (not a protocol) for making APIs.

---

### ✅ 7 RESTful API Principles

1. **Everything is a resource**  
   - `/api/users` = list of user resources  
   - `/api/users/42` = user with ID 42  

2. **Each resource is identified by URI**  
   - URIs are predictable, clean, and hierarchical  
   - Example:
     ```
     GET /api/products/5
     ```

3. **Multiple Representations**
   - Resources can be returned in:
     - JSON
     - XML
     - HTML

4. **Standard HTTP Methods**
   - Use `GET`, `POST`, `PUT`, `DELETE` as intended

5. **Stateless**
   - Server does **not remember** previous requests
   - Client must send all required info on **every request**

6. **Cacheable**
   - Responses should state if they’re cacheable
   - Improves performance

7. **Layered System**
   - You can insert proxies, gateways, or load balancers in between client and server
   - Adds scalability and security

---

### 🔹 REST + Microservices

> Microservices = Small, independent services, each doing **one job**.

- Example: An online store might have:
  - `auth-service`
  - `catalog-service`
  - `orders-service`
  - `shipping-service`

Each microservice:
- Is **independent**
- Can use **any tech stack**
- Communicates with others via **REST APIs**

---

### 🧱 Example: Microservice Architecture Diagram

```plaintext
                [ API Gateway ]
                      |
  +----------+--------+---------+--------+
  | Auth     | Orders | Inventory | Users |
  | Service  | Service| Service   | Service |
```

- Requests go to the gateway
- Gateway handles:
  - Authentication
  - Routing to correct service
- Services don’t need to know about each other

> 💡 This makes systems **modular, maintainable, and scalable**.

---

## ✅ Lecture 3 Takeaways

| Concept | What You Should Understand |
|--------|-----------------------------|
| Web API | Allows apps to talk to each other |
| JSON | Standard format for API data |
| GET vs POST | Use GET for reads, POST for writes |
| Postman | Tool to test APIs |
| REST | Design pattern for APIs |
| Microservices | Build apps as modular parts |
| Stateless | Every API call should be self-contained |
| URI = resource | `/api/users/42` points to one resource |
| REST is not secure by default | Always use HTTPS and tokens |

---

# Lecture 4: Node.js, Asynchronous JS, and Server-Side Development


### 🔹 PART 1: Understanding Servers and Server-Side Scripting

#### 🖥️ What Is a Server?

- A **server** is simply a computer connected to the internet 24/7.
- It **waits for client requests** (like from a browser or mobile app) and **responds**.
- Common protocols:
  - HTTP → web
  - FTP → file transfers
  - SMTP → email

> Example: When you open a website, your browser sends an HTTP request to a server which responds with HTML/CSS/JS files.

#### 💻 Server-Side Scripting

Server-side scripting languages (Node.js, PHP, Python, ASP.NET) can:
- Generate dynamic HTML content
- Read/write to files
- Work with databases (like MySQL)
- Process forms
- Handle authentication, APIs, etc.

---

### 🔹 PART 2: What Is Node.js?

#### 🟩 Node.js is...

- A **JavaScript runtime environment**
- Runs **outside the browser**
- Built on **Chrome's V8 engine**
- Lets you use **JavaScript to build server-side applications**
- Handles HTTP requests, works with files, databases, etc.

> Instead of using JavaScript only in the browser, Node lets you use it to build web servers, APIs, and backend logic.

---

### 🔹 PART 3: Why Node.js? (Asynchronous JS)

#### 🍴 Restaurant Analogy

| Style | Analogy | Description |
|-------|---------|-------------|
| Blocking | 1 waiter per table | Waiter waits for kitchen to cook before moving on |
| Non-blocking | 1 waiter serves many | Waiter takes order, tells kitchen, and moves on |
| Multi-threaded | 1 waiter per request | More memory, more resources used |

> **Node.js is like Example 1**: One thread (waiter), but **non-blocking** and **efficient**.

This allows Node.js to:
- Handle thousands of simultaneous connections
- Be memory-efficient
- Scale well with limited resources

---

### 🔹 PART 4: Getting Started with Node.js

#### ✅ Installing Node.js

- Install via [https://nodejs.org](https://nodejs.org)
- Use **Visual Studio Code** (VSC) to:
  - Write code
  - Set breakpoints
  - Debug Node apps

---

### 🔹 Example 1: Hello World

```js
console.log("Hello World");
```

> Run this with `node hello.js` in your terminal.

---

### 🔹 Example 2: Area Calculation

```js
function area(radius) {
  return 3.14 * radius * radius;
}
console.log(area(5));
```

Set breakpoints in VSC, inspect variables, and step through logic.

---

### 🔹 PART 5: Using Modules

#### 📦 What Is a Module?

A **module** is like a separate file containing helper functions — just like JS libraries in the browser.

##### `math.js`
```js
exports.area = function(r) {
  return 3.14 * r * r;
};
```

##### `main.js`
```js
const math = require('./math');
console.log(math.area(4));
```

> Use `require()` to include local or built-in modules.

---

### 🔹 PART 6: Node.js Built-in Modules

Node has many built-in modules. Let’s look at a few important ones:

#### ✅ `http` – Build Servers

```js
const http = require('http');

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.write('Hello from Node!');
  res.end();
}).listen(8888);
```

- Open browser → `http://localhost:8888`
- You’ll see “Hello from Node!”

---

#### ✅ `url` – Parse URLs

```js
const url = require('url');
let adr = 'http://localhost:8888/default.htm?name=John&age=23';
let q = url.parse(adr, true);

console.log(q.query.name); // 'John'
```

---

#### ✅ `fs` – File System Module

```js
const fs = require('fs');

fs.readFile('file.txt', function(err, data) {
  if (err) throw err;
  console.log(data.toString());
});
```

---

### 🔹 Example: File Server

```js
const http = require('http');
const url = require('url');
const fs = require('fs');

http.createServer(function (req, res) {
  const q = url.parse(req.url, true);
  const filename = "." + q.pathname;

  fs.readFile(filename, function (err, data) {
    if (err) {
      res.writeHead(404, {'Content-Type': 'text/html'});
      return res.end("404 Not Found");
    }
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write(data);
    return res.end();
  });
}).listen(8888);
```

- Try: `http://localhost:8888/file.txt`
- If file exists → shows content
- If not → 404 error

---

### 🔹 Access-Control-Allow-Origin

Used to enable **CORS** (Cross-Origin Resource Sharing):

```js
res.setHeader('Access-Control-Allow-Origin', '*');
```

> This allows other domains to request resources from your server — useful in APIs or when frontend and backend are on different servers.

---

### 🔹 Hosting Node.js on Shared Hosting (Like cPanel)

- Many shared hosts **don’t support Node** by default
- Some (like Heroku, Vercel) offer Node-compatible environments
- cPanel hosting (like Bluehost or HostGator) may support Node via **terminal access** and **setup wizards**
- Refer to your lecture video for the setup walkthrough

---

### 🔹 PART 8: Preparing for Database Integration

You’ll eventually connect to:
- **MySQL** via `mysql` or `mysql2` Node.js packages
- Use **phpMyAdmin** as a GUI to create/manage databases

> Stay tuned — coming in two weeks!

---

### ⚡ Extra: Arrow Functions (ECMAScript 6 / ES6)

Old syntax:
```js
function add(a, b) {
  return a + b;
}
```

Arrow syntax:
```js
const add = (a, b) => a + b;
```

---

## ✅ What You Should Know After Lecture 4

| Concept | What You Should Be Able to Do |
|--------|-------------------------------|
| Node.js | Use JS for server-side scripting |
| Asynchronous JS | Explain non-blocking I/O using analogies |
| Modules | Create and import custom modules |
| Built-in modules | Use `http`, `url`, `fs` in real apps |
| Server setup | Handle requests, parse URLs, serve files |
| Debugging | Run and debug Node apps in VSC |
| Hosting | Know hosting options for Node.js |
| REST prep | Serve and respond to HTTP requests |

---


# Lecture 5: Building a Web API with AJAX and Connecting Node.js to MySQL

### 🔹 PART 1: AJAX and the Client–Server Interaction



#### ✅ What Is AJAX?

**AJAX** stands for **Asynchronous JavaScript And XML**. It allows your web page to **send and receive data from a server without refreshing the page**.

> Example: When you click a "Load More Posts" button on Instagram — that’s AJAX.

---

#### 💡 Steps for Making an AJAX Call

```js
let xhttp = new XMLHttpRequest(); // Step 1: Create request

xhttp.onreadystatechange = function () { // Step 2: Handle response
  if (this.readyState == 4 && this.status == 200) {
    document.getElementById("demo").innerHTML = this.responseText;
  }
};

xhttp.open("GET", "data.txt", true); // Step 3: Set request type and URL
xhttp.send(); // Step 4: Send request
```

---

#### 🧠 AJAX `readyState` Values

| Value | Meaning               |
|-------|------------------------|
| 0     | UNSENT                |
| 1     | OPENED                |
| 2     | HEADERS_RECEIVED     |
| 3     | LOADING               |
| 4     | DONE (Response ready) |

---

#### 🌐 HTTP Response Codes

| Code  | Meaning         |
|-------|------------------|
| 200   | OK               |
| 403   | Forbidden        |
| 404   | Not Found        |
| 500   | Server Error     |

---

#### 🔁 POST Requests via AJAX

When using `POST`, the data goes in the **body**, not the URL.

```js
xhttp.open("POST", "submit.php", true);
xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
xhttp.send("name=Elon&score=100");
```

---

### 🔒 CORS: Cross-Origin Resource Sharing

By default, browsers block AJAX requests from one **origin** to another.

> Origin = combination of protocol + domain + port.

To allow requests from another origin, server must respond with:

```js
res.writeHead(200, {
  "Content-Type": "text/plain",
  "Access-Control-Allow-Origin": "*"
});
```

Or more securely:

```js
"Access-Control-Allow-Origin": "https://example.com"
```

---

### ❓ Preflight Requests

When a browser sends a request using special headers or methods like `PUT`, `DELETE`, or `Content-Type: application/json`, it **first sends an OPTIONS request** to ask permission.

> The server must respond with what’s allowed.

```js
res.writeHead(200, {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type"
});
```

---

## 🔹 PART 2: AJAX with Node.js

Server: `app.js`  
Client: `ajax.html`

#### ✅ Handling GET and POST requests

```js
const http = require("http");
const url = require("url");

http.createServer(function (req, res) {
  const q = url.parse(req.url, true).query;
  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("Name received: " + q.name);
}).listen(8888);
```

For **POST**:

```js
let body = "";
req.on("data", chunk => { body += chunk; });
req.on("end", () => {
  const data = new URLSearchParams(body);
  res.end("Score received: " + data.get("score"));
});
```

---

## 🔹 PART 3: Connecting to a Database (CRUD)

---

### 🧱 What Is CRUD?

| Operation | SQL Command | Meaning              |
|-----------|-------------|----------------------|
| Create    | `INSERT`    | Add a new record     |
| Read      | `SELECT`    | Get data             |
| Update    | `UPDATE`    | Modify existing data |
| Delete    | `DELETE`    | Remove a record      |

---

### ⚙️ Tools You'll Use

- **MySQL (MariaDB)** → The database engine
- **phpMyAdmin** → Browser-based UI to manage databases
- **XAMPP** → Installer for MySQL, PHP, and phpMyAdmin
- **Node.js** → Server-side JS that will connect to MySQL

---

### 🖥️ Setting up XAMPP (Local MySQL + phpMyAdmin)

1. Start **Apache** and **MySQL** in the XAMPP control panel
2. Go to: `http://localhost/phpmyadmin/`
3. Create a database (e.g., `scoresDB`)
4. Create a table (e.g., `scores`) with columns:
   - `id` (auto increment)
   - `name` (varchar)
   - `score` (int)

---

### 🔌 Connecting Node.js to MySQL

1. Run in terminal:
```bash
npm install mysql
```

2. Sample code:

```js
const mysql = require('mysql');

const conn = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "scoresDB"
});

conn.connect(err => {
  if (err) throw err;
  console.log("Connected!");

  const sql = "INSERT INTO scores (name, score) VALUES ('Elon', 100)";
  conn.query(sql, (err, result) => {
    if (err) throw err;
    console.log("Record inserted");
  });
});
```

---

## 🔹 PART 4: Hosting Node.js and MySQL Remotely

- You’ll need:
  - A Node.js-compatible hosting plan (some cPanel hosts support it)
  - Ability to configure MySQL access (remote access or cloud DB)
- Refer to the provided video:  
  `Hosting nodejs MySql remotely CPanel Shared Hosting.mp4`

---

## ✅ Summary: What You Should Know Now

| Concept | What You Can Do |
|--------|------------------|
| AJAX | Send asynchronous GET/POST requests |
| CORS | Explain how browsers restrict cross-origin requests |
| HTTP Codes | Identify status meanings (200, 404, 500, etc.) |
| Node + AJAX | Handle client-side AJAX requests in Node |
| Database | Perform basic CRUD using Node + MySQL |
| XAMPP | Use phpMyAdmin to create databases and run SQL |
| POST | Send secure data in request body instead of URL |


# 🔧 Lecture 2 — Deep Dive: Web Architecture & JSON

---

### 🏗️ What is Software Architecture (Web Context)?

In **web applications**, architecture refers to how components (frontend, backend, database, etc.) interact with one another.

**Focus areas:**
- **Scalability**: Can your app handle more users/data?
- **Security**: Are components protected from threats?
- **Modularity**: Can you update a part (like payments) without breaking the rest?
- **Ease of Deployment**: Can you launch it easily across environments?

---

### 🧠 Why Study Architectural Patterns?

Understanding architectural styles allows you to:
- Choose the **right tech stack** (e.g., lightweight server = Node.js)
- Plan for **scalability and flexibility** (e.g., microservices)
- Reduce cost (e.g., use 1 JS developer for both frontend and backend with Node.js)
- Improve **security** with smart entry points like API gateways
- Ensure **modular design** where each service has a single responsibility (like login or file upload)

---

### 🧱 Recognized Patterns

#### 1. **Multi-tier (3-tier) Architecture**
- **Client**: Web/mobile app
- **Application Server**: Business logic
- **Database Server**: Stores data

Can be deployed:
- On a single machine
- On multiple machines
- Load-balanced across servers

#### 2. **Layered (Linear) Architecture**
Each "layer" serves a role:
- UI (HTML, CSS, JS)
- Business logic (rules)
- Application layer (main app functions)
- Data access (DB interaction)

#### 3. **Service-Oriented Architecture (SOA) / Microservices**
- Breaks the app into **loosely coupled services**
- Each service is **independent**, can be built in **any language**, run anywhere
- Communicates via **APIs** (typically RESTful)
- Used by **Facebook, Uber, Netflix, Amazon**

#### 4. **Monolithic**
- Entire app bundled into a **single codebase**
- Easy to start, but difficult to scale
- Changing one part may require restarting/redeploying the whole app

#### ➕ Pros of Microservices:
- Easier to update specific modules
- Multiple teams can work in parallel
- Better fault tolerance (e.g., Messenger can run even if Facebook breaks)

#### ➖ Cons:
- Harder to manage due to many API calls
- More complex debugging & deployment

---

## 🧪 JSON and Local Storage

---

### 💾 Web Storage (HTML5)

There are **two types**:
| Storage Type     | Expires? | Scope             |
|------------------|----------|-------------------|
| `localStorage`   | No       | All tabs, same origin |
| `sessionStorage` | Yes      | Per tab session   |

#### Example:
```js
localStorage.setItem("username", "Alice");
console.log(localStorage.getItem("username")); // "Alice"
```

> All values are stored as **strings**, so objects must be serialized.

---

### 🔁 JSON

**Why JSON?**
- To transmit data between systems
- Format is lightweight, readable, language-agnostic

#### Serialize JS object to JSON:
```js
let user = { name: "John", age: 22 };
let jsonStr = JSON.stringify(user);  // '{"name":"John","age":22}'
```

#### Deserialize JSON to JS object:
```js
let obj = JSON.parse(jsonStr);
console.log(obj.name); // "John"
```

> `typeof jsonStr` is `"string"` — not an object!

---

## 🌐 Architecture for This Course

You're building a **simplified microservice-based, API-centric** application:
- **AJAX calls** from client to services
- Each service is RESTful (uses GET/POST/PUT/DELETE)
- Data is passed in **JSON**
- Frontend and backend are **hosted on different origins**
- Communication is managed via **API Gateway**

---

### 🧠 Learning Outcomes of API-Centric Design

By end of course, you’ll be able to:
- Use **HTTP methods** (GET, POST)
- Handle **JSON payloads**
- Build **RESTful services**
- Implement **CRUD** operations on databases via API
- Handle **errors** with appropriate HTTP codes (e.g., 404, 500)
- Apply **versioning** (e.g., `/v1/products`)
- Secure your APIs (e.g., with tokens, hashing)
- Use **Postman** to test APIs
- Understand **web storage**
- Learn **asynchronous JS** and denial-of-service protection techniques
- Get hands-on with **oAuth**, **HTTPS/SSL**, and **token-based security**

---


# Lecture 6 (not on the final )


## 🌐 AJAX + API + DB: How It All Connects

A **modern web application** often involves:

1. A front-end that sends requests via **AJAX**
2. A **backend API server** (e.g., Node.js) that receives those requests
3. A **relational database** (e.g., MySQL) to store and retrieve data
4. The backend returns **JSON** responses to the front-end

---

## 🔄 CRUD: Core Operations for API Development

CRUD stands for:

| Operation | SQL Command | HTTP Method |
|----------|-------------|--------------|
| Create   | `INSERT`    | `POST`       |
| Read     | `SELECT`    | `GET`        |
| Update   | `UPDATE`    | `PUT/PATCH`  |
| Delete   | `DELETE`    | `DELETE`     |

Each corresponds to how we interact with resources through an API.

---

## 📦 What is a Database?

A **database** is a structured collection of data stored electronically. A **DBMS** (like MySQL) manages access, modification, and security.

Key characteristics of a good DBMS:
- Massive (handles large data)
- Persistent (data survives app restarts)
- Safe (protects against corruption)
- Efficient (queries are fast)
- Concurrent (handles multiple users)
- Reliable (near 100% uptime)

---

## 🧱 Tables, Fields, Rows — RDBMS Structure

- **Table = Entity = Relation**
- **Column = Field = Attribute**
- **Row = Record = Tuple**
- **Cell = Single data value**

Example:
```sql
CREATE TABLE patient (
  patientid INT PRIMARY KEY,
  name VARCHAR(100)
);
```

---

## 🔗 One-to-Many (1:M) Relationships

If one patient can have many visits:

- **`patient.patientid`** is a **Primary Key**
- **`visit.patientid`** is a **Foreign Key**

```sql
CREATE TABLE visit (
  visitid INT PRIMARY KEY,
  patientid INT,
  visitDate DATE,
  FOREIGN KEY (patientid) REFERENCES patient(patientid)
);
```

This design ensures referential integrity: no visit can exist without a valid patient.

---

## 📑 Primary Key vs Foreign Key

- **Primary Key (PK)**: Uniquely identifies a row (e.g. `visitid`)
- **Foreign Key (FK)**: References PK from another table (e.g. `patientid` in `visit`)

---

## 📈 Learning SQL by Example

Use [TrySQL](https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all) to practice.

Basic queries:
```sql
SELECT * FROM Customers;
SELECT CustomerName FROM Customers WHERE City = 'London';
SELECT DISTINCT Country FROM Customers;
```

Aggregations:
```sql
SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country;
```

Subqueries:
```sql
SELECT * FROM Products WHERE Price > (SELECT AVG(Price) FROM Products);
```

---

## ⚠ WHERE vs HAVING

- Use **`WHERE`** before `GROUP BY` (on individual rows)
- Use **`HAVING`** after `GROUP BY` (on aggregate results)

✅ OK:
```sql
SELECT Country, COUNT(*) 
FROM Customers 
GROUP BY Country 
HAVING COUNT(*) > 5;
```

❌ Not OK:
```sql
-- This will fail because WHERE cannot use aggregates
SELECT Country, COUNT(*) 
FROM Customers 
WHERE COUNT(*) > 5
GROUP BY Country;
```

---

## ⚖ M:M (Many-to-Many) Example

Authors ↔ Books:
- Create associative table: `AuthorBook`
```sql
CREATE TABLE AuthorBook (
  authorid INT,
  bookid INT,
  PRIMARY KEY (authorid, bookid),
  FOREIGN KEY (authorid) REFERENCES Author(authorid),
  FOREIGN KEY (bookid) REFERENCES Book(bookid)
);
```

---

## 🛠 Data Types You Should Know

| Type     | Use Case |
|----------|----------|
| `VARCHAR(n)` | Strings (names, emails) |
| `INT`     | Numbers (IDs, counts) |
| `DECIMAL(m, d)` | Precise numbers (money) |
| `DATE`    | Date fields |

---

## ✨ AUTO_INCREMENT and CHECK

- `AUTO_INCREMENT` helps generate primary keys:
```sql
CREATE TABLE Persons (
  PersonID INT AUTO_INCREMENT,
  Name VARCHAR(255),
  PRIMARY KEY (PersonID)
);
```

- `CHECK` restricts input:
```sql
Age INT CHECK (Age >= 18 AND Age <= 150)
```

---


# Lecture 7 Summary: Asynchronous Microservice Communication with Promises



### 🔁 1. Review: HTTP Methods & Idempotence

| Method | Purpose               | Idempotent? | Notes                            |
|--------|------------------------|-------------|----------------------------------|
| GET    | Read data              | ✅ Yes       | Used for fetching resources      |
| POST   | Create data            | ❌ No        | Can result in multiple creations |
| PUT    | Replace entire object  | ✅ Yes       | Full object replacement          |
| PATCH  | Update part of object  | ❌ Depends   | Partial update only              |

---

### 🔄 2. JavaScript Functions Recap

- **First-class functions**: Functions can be passed as arguments.
- **Callbacks**: Traditional way to handle async logic (but leads to callback hell).
  
```js
function add(a, b, callback) {
  const result = a + b;
  callback(result);
}
add(2, 3, (res) => console.log(res)); // 5
```

---

### ⚠️ 3. Problem: Async Operations in JS

- JS functions **only return one value**, but async tasks may succeed or fail.
- We want to:
  - Handle **success**: `resolve(...)`
  - Handle **error/failure**: `reject(...)`

---

### 🧪 4. Solution: JavaScript Promises

```js
let promise = new Promise((resolve, reject) => {
  // async task
  resolve("Success!");
});
```

#### Promise States:
- `pending`
- `fulfilled` (via `resolve`)
- `rejected` (via `reject`)
- Once fulfilled or rejected, it becomes **settled**

---

### 🧵 5. Promise Methods

#### `.then(successFn, errorFn)`
- Handles success and failure (optional second parameter)

```js
promise.then(
  (res) => console.log("Resolved:", res),
  (err) => console.error("Rejected:", err)
);
```

#### `.catch(errorFn)`
- Shortcut to handle errors
```js
promise.catch((err) => console.error(err));
```

#### `.finally(finalFn)`
- Runs regardless of outcome
```js
promise.finally(() => console.log("Promise settled"));
```

---

### 🔄 6. Promise Execution Examples

```js
let p = new Promise((resolve, reject) => {
  console.log(1);     // Runs first (sync)
  resolve("Done!");   // Called immediately, runs after sync finishes
  console.log(2);     // Runs second (sync)
});

p.then(res => console.log(res));  // Runs after sync logs (async)
console.log(3);                   // Runs third
// Output: 1 → 2 → 3 → Done!
```

#### ❗ Promises run eagerly
- Executor inside `new Promise(...)` runs immediately

---

### 🔗 7. Chaining Promises

```js
fetchData()
  .then(data => transformData(data))
  .then(result => sendToServer(result))
  .catch(error => console.error("Something went wrong", error))
  .finally(() => console.log("Process completed"));
```

---

### ⏱ 8. Callback Hell vs. Promises

**Callback Hell**:
```js
async1(() => {
  async2(() => {
    async3(() => {
      console.log("All done");
    });
  });
});
```

**Promise Chain**:
```js
async1()
  .then(() => async2())
  .then(() => async3())
  .then(() => console.log("All done"));
```

---

### 💡 9. Async/Await (Intro)

Modern, cleaner alternative to promise chains:

```js
async function fetchData() {
  try {
    const data = await fetch('/api/data');
    console.log(await data.json());
  } catch (err) {
    console.error(err);
  }
}
```

---

### 📦 10. GET vs POST – Response Size

- **GET** has request size limit (URL-based)
- **POST** does not (body-based)
- **Response size** has no standardized limit — depends on server/browser

---

### ⚠️ 11. XMLHttpRequest `readyState` Clarification

Correct `readyState` values:
| Value | Meaning |
|-------|---------|
| 0     | UNSENT |
| 1     | OPENED |
| 2     | HEADERS_RECEIVED |
| 3     | LOADING (response is streaming in) |
| 4     | DONE (completed) |

W3Schools has **inaccuracies** in their documentation—trust the lecture over them.

---

## 📝 Final Tips

- `.then()` is for handling success/failure
- `.catch()` is cleaner than passing second arg to `.then()`
- `.finally()` runs after resolve/reject no matter what
- Always **return** a promise when chaining!
- Use **async/await** to simplify promise chains
- Don't trust W3Schools blindly 😅

---

# Lecture 8


## 🧠 Advanced Web Development Architecture – Lecture 8 Summary

---

### ✅ 1. Review Topics

- **AJAX calls**: GET vs POST
- **Modules in Node.js**: `http`, `fs`, external modules via `npm install`
- **Node.js & MySQL**: Connecting, CRUD ops
- **Database Concepts**: 1:M, Primary Key, Foreign Key, Normalization
- **CORS**: Cross-Origin Resource Sharing, server must explicitly allow it

---

### 🌐 2. RESTful API Design Recap

- REST = *REpresentational State Transfer*
- Resource URLs = `/api/customers/`
- Methods & Meaning:

| Method | Purpose                            | Idempotent |
|--------|------------------------------------|------------|
| GET    | Retrieve data                      | ✅          |
| POST   | Create a new resource              | ❌          |
| PUT    | Replace a resource                 | ✅          |
| PATCH  | Modify part of a resource          | ❌          |
| DELETE | Remove a resource                  | ✅          |

---

### 🔢 3. HTTP Status Codes to Know

| Code | Meaning               |
|------|------------------------|
| 200  | OK (GET success)      |
| 201  | Created (after POST)  |
| 400  | Bad Request           |
| 401  | Unauthorized          |
| 403  | Forbidden             |
| 404  | Not Found             |
| 500  | Server Error          |

MDN reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status

---

### 📈 4. Modern Web Architecture Trends

| Architecture | Description |
|--------------|-------------|
| **Microservices** | App broken into small independent services (each with a single responsibility) |
| **Serverless** | Focus on logic only; cloud provider handles infrastructure (e.g., AWS Lambda) |
| **API-First** | Design starts with the API interface (contract-first) |
| **Edge Computing** | Processing closer to the user/device (low latency) |
| **Headless CMS** | Backend via API, frontend technology-agnostic |
| **Domain-Driven Design** | Break down logic into bounded contexts for modularity |

#### ✅ Benefits of these trends:

- Scalability
- Modularity
- Resilience
- Lower latency
- Easier CI/CD
- Better support for AI/ML & IoT

---

### 🧠 AI in Web Architectures

- **Microservices for AI**: e.g., NLP, image classification
- **AI-as-a-Service**: Prebuilt AI models from cloud providers
- **AutoML & No-code AI**: Build & deploy ML without code
- Tools: HuggingFace, AWS AI, Google AutoML, Azure Cognitive Services

---

### ⚙️ 5. Express.js: A Web Framework for Node.js

#### 🏗 Setup

```bash
npm init --yes
npm i express
npm i mysql
```

#### 📦 Example: Creating a Basic Server

```js
const express = require('express');
const app = express();

app.use(express.json()); // to parse JSON bodies

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(3000, () => console.log('Server running on port 3000'));
```

#### 🔄 CORS Setup Example

```js
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type");
  next();
});
```

---

### 🔄 Express + MySQL CRUD Examples

#### 🔹 POST (Create Patient)

```js
app.post('/api/patients', (req, res) => {
  const { name, age } = req.body;
  const sql = 'INSERT INTO patients (name, age) VALUES (?, ?)';
  db.query(sql, [name, age], (err, result) => {
    if (err) return res.sendStatus(500);
    res.status(201).json({ id: result.insertId, name, age });
  });
});
```

#### 🔹 GET All Patients

```js
app.get('/api/patients', (req, res) => {
  db.query('SELECT * FROM patients', (err, results) => {
    if (err) return res.sendStatus(500);
    res.json(results);
  });
});
```

#### 🔹 GET One Patient

```js
app.get('/api/patients/:id', (req, res) => {
  db.query('SELECT * FROM patients WHERE id = ?', [req.params.id], (err, results) => {
    if (err || results.length === 0) return res.sendStatus(404);
    res.json(results[0]);
  });
});
```

#### 🔹 PUT (Replace Patient)

```js
app.put('/api/patients/:id', (req, res) => {
  const { name, age } = req.body;
  const sql = 'UPDATE patients SET name=?, age=? WHERE id=?';
  db.query(sql, [name, age, req.params.id], (err, result) => {
    if (err) return res.sendStatus(500);
    res.json({ message: 'Updated successfully' });
  });
});
```

---

### 🔧 6. Tools & Tips

- **Nodemon**: Restart server automatically
```bash
npm install --save-dev nodemon
```

- **VSC Plugin**: Numbered Bookmarks  
  https://marketplace.visualstudio.com/items?itemName=alefragnani.numbered-bookmarks

- **Environment Variables**:
```js
const port = process.env.PORT || 3000;
```

---

### 🛠️ 7. Hackathon & Term Project

- Mini hackathon held this week
- **Term project** announcement coming next week — likely involves RESTful Express.js + database integration

---

# Lecture 9

## ✅ 1. Authentication & Security Basics

### 🔒 Why do we need security in web apps?
1. **Prevent data theft**: Attackers may try to read sensitive data.
2. **Prevent unauthorized changes**: You don't want just anyone to DELETE or MODIFY your DB via a POST/PUT/DELETE request.
3. **Prevent attacks like**:
   - SQL Injection
   - Cross-Site Scripting (XSS)
   - Denial of Service (DoS)

👉 **Authentication** is the first line of defense—it ensures only legitimate users can access protected routes.

---

## ✅ 2. Hashing Passwords

- **Hashing**: A one-way function. It converts a password into a unique, fixed-length string.
- Once hashed, **you can’t reverse it**.
- Why not just encrypt passwords?
  - Encryption can be reversed with a key.
  - Hashing can't be reversed (good for passwords).
- Store the hash in the database. When a user logs in, hash their password again and compare the two hashes.

---

## ✅ 3. Types of Authentication

### 🟢 Basic Authentication
- Send **username and password** in every request (encoded in base64).
- It’s insecure unless used over HTTPS.
- The client includes these credentials in an HTTP header:
  ```
  Authorization: Basic dXNlcjpwYXNzd29yZA==
  ```

### 🟢 Token-Based Authentication
- Server generates a token (e.g. JWT) after successful login.
- This token is sent in every future request.
- Safer because it doesn't send credentials each time.

### 🟢 OAuth
- You can log in with Google, Facebook, GitHub, etc.
- You don’t share your password—only a **token** is passed to the third-party app.
- This is great for apps that want to access user data from another app securely.

### 🟢 Multi-Factor Authentication (MFA)
- Uses **two or more** of:
  - Something you know (password)
  - Something you have (phone/token)
  - Something you are (fingerprint)

---

## ✅ 4. HttpOnly Cookies

### 🍪 What is it?
- A **cookie** that is:
  - Stored in the browser
  - Sent with every request
  - **Inaccessible to JavaScript**

### 🔐 Why HttpOnly?
- Prevents JavaScript from accessing it—**protects from XSS attacks**.
- Used to store session identifiers or auth tokens securely.

### 🔄 How it works:
1. Client logs in and sends credentials to server.
2. Server verifies them and responds with:
   ```
   Set-Cookie: token=12345; HttpOnly; Max-Age=60
   ```
3. Browser stores it.
4. On future requests, browser **automatically** includes the cookie.

---

## ✅ 5. Common Issues with HttpOnly Cookies

### ❗ Issue 1: Server sees cookie as undefined
- Likely causes:
  - Cookie was not sent
  - You're loading the client from `file:///...` — browser treats that as cross-origin
  - Fix: Host client and server from same origin or configure CORS properly

### ❗ Issue 2: Why does OPTIONS request get triggered?
- When using:
  - **Custom headers** (e.g., `Content-Type: application/json`)
  - **Credentials** (cookies)
- Browser sends a **preflight request** (OPTIONS) to check if the server accepts it.
- The server must respond with:
  ```
  Access-Control-Allow-Origin: http://localhost
  Access-Control-Allow-Methods: POST, GET
  Access-Control-Allow-Credentials: true
  ```

---

## ✅ 6. Max-Age

- `Max-Age=60` in `Set-Cookie` means the cookie will expire in **60 seconds**.
- After that, the browser deletes it.
- This limits how long the session remains active without re-authentication.

---

## ✅ 7. Security Implications in Practice

### 🔁 Why does “Get Something” still work after refresh?
- Because the cookie is still valid.
- Browser continues sending it until it expires (or you log out).

### 🔍 Is seeing the cookie in DevTools a security concern?
- Not necessarily:
  - **Yes**: It shows the cookie exists.
  - **No**: If it’s marked `HttpOnly`, JavaScript can’t access it—even if DevTools shows it.

---

## ✅ 8. Public Key vs Private Key (Intro to Encryption)

### 🧠 Problem: How can two parties exchange a secret over an insecure channel?
- You lock a box (encrypt data) and send it. But how do you send the key securely?

### 🔐 Solution: Asymmetric encryption (Public/Private keys)
- Everyone can see your **public key**
- Only you have your **private key**
- If I want to send you a secret:
  - I encrypt it using your **public key**
  - Only your **private key** can decrypt it

### 🔁 Reverse: If I want to **verify you** sent a message:
- You sign it using your **private key**
- I check it using your **public key**

This is the foundation of **SSL**, **JWT**, and **OAuth**.

---

# Lecture 10



## 🔐 **1. Public Key + Private Key Encryption**

### 🔸 Symmetric vs. Asymmetric Encryption

- **Symmetric Encryption** (🔑 secret key):
  - Same key for encryption and decryption.
  - Fast, but **requires secure key exchange**, which is hard over the internet.

- **Asymmetric Encryption** (🔐 public/private keys):
  - You use **two keys**: one public, one private.
  - If someone encrypts with the **public key**, only the matching **private key** can decrypt it.
  - If someone encrypts (or signs) with the **private key**, anyone with the **public key** can verify it was them.

### 🔸 Scenario: Amir wants to send a message to Tom securely

Amir wants to ensure:
1. 🔒 The message can **only** be read by Tom (confidentiality)
2. ✉️ Tom can be sure it came from **Amir** (authenticity)

#### ✅ Solution (Double Signing)
- **Step 1:** Amir encrypts (signs) the message with **Tom’s public key**
    - ➜ Only Tom can decrypt it using his **private key**.
    - ➜ Ensures confidentiality.
- **Step 2:** Amir signs that encrypted message with **his private key**
    - ➜ Anyone with **Amir’s public key** can verify he sent it.
    - ➜ Ensures authenticity.

---

## 🪪 **2. JSON Web Tokens (JWT)**

### 🔸 What is JWT?

- A **compact, URL-safe token** format used to **securely transmit claims** (e.g. user identity).
- Contains a **payload** (e.g. `{ "user": "john" }`) and a **signature** to prevent tampering.
- It is **signed** (not necessarily encrypted) using a **secret key** or **private key**.

### 🔸 Use Case Flow:

1. **User logs in**: sends username & password to server.
2. **Server validates credentials** and:
   - Signs a JWT using a **secret key**
   - Sends the JWT back to the client
3. **Client stores** the JWT (often in an **HttpOnly cookie**).
4. For future requests, the JWT is sent back automatically (if in cookie), or manually via header (e.g. `Authorization: Bearer <token>`).
5. **Server validates the JWT** on each request by checking its signature.

### 🔸 Why Signing?

- To ensure:
  - ✅ The token **hasn’t been altered**.
  - ✅ The token came from **your trusted server**.

### 🔸 Example Code to Sign a Token

```js
const jwt = require("jsonwebtoken");
const TOKEN_SECRET = require('crypto').randomBytes(64).toString('hex');

let token = jwt.sign({ name: "john" }, TOKEN_SECRET, {
  algorithm: "HS256",
  expiresIn: '2m'
});
```

> Issues with a simple version like `jwt.sign({ foo: 'bar' }, 'shhhhh!')`:
> - Weak secret
> - No expiry set (bad for security)

---

## 🍪 **3. HttpOnly Cookies + JWT**

### 🔸 Why Use HttpOnly Cookies?

- Stored cookies that:
  - Cannot be read or accessed by JavaScript (`HttpOnly`)
  - Can be sent only over HTTPS (`Secure`)
  - Can be protected against CSRF with `SameSite=Strict` or `Lax`

### 🔸 Safer Than Local Storage

- **HttpOnly Cookies** mitigate **XSS attacks** (since malicious scripts can’t read them).
- Safer way to store JWTs on the client.

### 🔸 Example:

```js
res.cookie('token', token, {
  httpOnly: true,
  secure: true,
  sameSite: 'Strict',
  maxAge: 60 * 1000 // 1 minute
});
```

---

## 🧪 **4. Security Best Practices**

### ✅ Server-side:

- Store secrets (like `JWT_SECRET`) in **environment variables**.
- Never hard-code passwords or secrets into your app.
- Hash passwords using `bcrypt` or another secure hashing algorithm.
- Use HTTPS and set:
  - `HttpOnly`
  - `Secure`
  - `SameSite`

### ✅ Token Handling:

| Practice                          | Why it Matters                                              |
|----------------------------------|--------------------------------------------------------------|
| `HttpOnly` cookie                | Prevents XSS from reading the token                         |
| `Secure` cookie                  | Prevents token from being sent over HTTP                    |
| `SameSite` attribute             | Helps prevent CSRF attacks                                  |
| Token expiration (`expiresIn`)  | Reduces window of token misuse if intercepted               |
| Use `crypto.randomBytes`        | Strong entropy for token secrets                            |
| Don't store plain tokens        | Use hashing if stored for session validation                |

---

## 📊 **5. Tracking API Usage with API Keys**

### 🔸 Basic Setup

- `user` table
- `apikey` table:
  - Tracks API keys assigned to each user
  - Includes a `stat` field to track **usage count**

```sql
INSERT INTO apikey (userid, apikey1, stat, description)
VALUES (1, 'MyAppKey', 0, 'My First App');
```

- `resource_stats` table (optional)
  - Track how many times each endpoint is used per API key

### 🔸 To log resource access:

1. Read current usage stat
2. Update stat:
   ```sql
   UPDATE apikey SET stat = stat + 1 WHERE apikey1 = 'MyAppKey';
   ```

3. This requires two **SQL queries** — use two `Promises` if using Node.js async flow.

---

## 📝 Final Notes

- JWT ≠ HttpOnly cookie. JWT is the **token format**; HttpOnly cookie is the **storage method**.
- Using JWT inside HttpOnly cookies is a secure hybrid strategy.
- Always separate concerns: tables for users, tokens, API keys, and stats should all be **clearly defined**.
- Security = defense in layers:
  - Token expiration
  - Server-side validation
  - HTTPS
  - Cookie flags
  - XSS & CSRF prevention

--- 

# Lecture 11



## 🔒 1. SSL (Secure Sockets Layer)

### What it is:
SSL (now technically TLS) ensures that the communication between the **client (browser)** and **server** is **encrypted**.

### Why it matters:
Without SSL (i.e., over HTTP), your data travels in plaintext and can be intercepted by attackers (e.g., man-in-the-middle). HTTPS (SSL-enabled) secures:
- Login credentials
- Payment details
- Personal data

### How it works:
1. **Client connects to HTTPS URL**
2. **Server sends its SSL certificate**, which includes:
   - Public key
   - Identity details (verified by Certificate Authorities)
3. Client validates certificate → generates a **shared session key**
4. All communication is encrypted using that key

**You don’t write this logic yourself**—it’s handled by the browser and web server automatically.

---

## 🔑 2. OAuth and Bearer Token

### What is OAuth?
OAuth is an **authorization protocol**. It allows third-party applications (like your app) to access a user’s data from another service (e.g., Google) **without getting the user's password**.

### Flow Overview:
1. **User clicks "Login with Google"**
2. **App redirects user to Google's login and passes its `client_id`**
3. **Google asks user to authorize access**
4. **User approves → Google returns a Bearer Token to the app**
5. **App includes Bearer Token in headers of API requests to Google**
   - Like: `Authorization: Bearer <token>`

### Bearer Token:
- Grants access to the user's data on behalf of the user.
- Should be **encrypted** and **short-lived**.
- Called “bearer” because **whoever holds it has access**.

---

## 🧾 3. Swagger – API Documentation

### What is Swagger?
Swagger is an **OpenAPI specification** used to **describe REST APIs** in a way that both machines and humans can understand.

### Why it's useful:
- Helps **front-end teams, API consumers**, and **external developers** understand how to use your API.
- Allows **testing** endpoints interactively.
- Can be used to **generate client libraries and server stubs**.

### Usage:
1. Visit [editor.swagger.io](https://editor.swagger.io)
2. Write or import Swagger YAML/JSON
3. Save, preview, and validate

### Swagger in VSCode:
Install extension:  
[Swagger Viewer Extension](https://marketplace.visualstudio.com/items?itemName=Arjun.swagger-viewer)  
Use `Shift + Alt + P` to preview.

---

## 📊 4. Planning Resources and API Design

### RESTful Resource Naming:
- Use **plural nouns**: `/patients`, `/orders`
- Avoid verbs in endpoint paths

### Recommended format:
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET    | /patients           | Get all patients           |
| GET    | /patients/{id}      | Get a specific patient     |
| POST   | /patients           | Add a new patient          |
| PUT    | /patients/{id}      | Update a patient           |
| DELETE | /patients/{id}      | Remove a patient           |

---

## 🔁 5. API Versioning

### Why version APIs?
- When you **change the API** (e.g., data structure, behavior), existing users’ code could break.
- Versioning lets you update while keeping older versions functional.

### Best practice:
- Include version in URI:  
  `/api/v1/patients`  
  `/api/v2/patients`

- Optionally, use redirection for `/patients → /v2/patients`

---

## ⏱️ 6. SQL + Promises in Node.js

### Why promises?
MySQL operations in Node.js are **asynchronous**. To run operations in sequence (e.g., check if user exists → update), you must use **Promises** or `async/await`.

### Example with `.promise()`:
```js
const mysql = require('mysql2/promise');

async function updatePatient(id, data) {
  const conn = await mysql.createConnection({ host, user, password, database });

  const [rows] = await conn.execute('SELECT * FROM patients WHERE id = ?', [id]);
  if (rows.length === 0) throw new Error('Patient not found');

  await conn.execute('UPDATE patients SET name = ? WHERE id = ?', [data.name, id]);
}
```

---

## 🔐 7. Hashing Strings with bcrypt

### Why hash passwords?
To **prevent storing plaintext passwords** in DB. Even if DB is compromised, passwords can’t be easily reversed.

### Tool: `bcrypt`
- Hashes are **one-way**
- Even the same password produces different hashes (because of salt)

### Example:
```js
const bcrypt = require('bcrypt');
const password = '123456';

// Hashing
const hash = await bcrypt.hash(password, 10);

// Verification
const isMatch = await bcrypt.compare(password, hash);
```

- `10` is the salt rounds: higher = more secure but slower
- Returns a Promise → must use `await`

---

## 🧠 Final Tips & Best Practices

### Security:
- Use **SSL** (HTTPS only)
- Store **JWT tokens** in **httpOnly cookies**
- Always **hash passwords**
- Use **environment variables** for storing secrets (e.g., `JWT_SECRET`)
- Validate input to prevent **SQL injection** and **XSS**

### Code:
- Use `async/await` for clarity
- Chain Promises properly
- Write clean, RESTful, documented API endpoints

--- 


Absolutely! Here's a **thorough explanation** of **Lecture 12: API Server Best Practices**, breaking down the **top security concerns** and how to address them using real-world reasoning and examples.

---

# Lecture 12 – Securing Your API Server: Best Practices**

---

### ✅ **1. Broken User Authentication**

#### 🔥 What goes wrong?
- Weak passwords
- No session expiration
- Reuse of tokens after logout
- Missing 2FA (Multi-Factor Authentication)

#### ⚠️ Example:
- A student uses the LMS with password "123456". There’s no lockout mechanism, so attackers can brute-force.
- Sessions never expire, allowing attackers with access to hijack it even days later.

#### 🛡️ Prevention:
- Enforce **strong password policies**
- Implement **2FA**
- Use **session timeouts**
- Invalidate JWT tokens on logout
- Protect login/forgot-password routes with **rate limiting**
  
```js
if (loginAttempts[ip] >= 3) {
  return res.status(429).json({ message: 'Too many login attempts. Try again later.' });
}
```

---

### ✅ **2. Excessive Data Exposure**

#### 🔥 What goes wrong?
- The API returns **too much data**, including sensitive fields like passwords or SSNs.
- Returns detailed **stack traces or SQL schema** in error messages.

#### ⚠️ Example:
```json
{
  "name": "Alice",
  "email": "alice@example.com",
  "ssn": "123-45-6789"
}
```

The client only requested name/email, but got everything. Oops.

#### 🛡️ Prevention:
- Filter response data **server-side**, not client-side
- Don’t use `.to_json()` blindly
- Only expose **whitelisted fields**
- Never expose sensitive error details

---

### ✅ **3. Lack of Rate Limiting / Throttling**

#### 🔥 What goes wrong?
- No rate limits = open to **DoS attacks**, **resource exhaustion**, or **brute force**

#### ⚠️ Examples:
- A bot sends 10,000 requests/sec
- Attackers try all passwords
- A single user fetches too many large payloads

#### 🛡️ Prevention:
- Use `express-rate-limit`, e.g.:
```js
const rateLimit = require("express-rate-limit");
app.use(rateLimit({
  windowMs: 1 * 60 * 1000, // 1 min
  max: 100 // limit each IP to 100 requests per minute
}));
```
- Apply rate limiting per user/IP
- Use **payload size limits**
- Return 429: Too Many Requests

---

### ✅ **4. Broken Function Level Authorization**

#### 🔥 What goes wrong?
- Sensitive functions (e.g., `delete_course()`) aren’t protected by user roles

#### ⚠️ Example:
An attacker knows the endpoint and sends a request to delete a course.

```http
DELETE /api/courses/123
```

#### 🛡️ Prevention:
- Check **roles** (admin/teacher/student) on each sensitive action
```js
if (req.user.role !== 'admin') {
  return res.status(403).send('Not authorized');
}
```
- Avoid hardcoding credentials or relying only on frontend checks

---

### ✅ **5. Broken Object Level Authorization**

#### 🔥 What goes wrong?
- Users can access **others’ resources** by changing IDs in URLs.

#### ⚠️ Example:
Student A sends:
```http
PUT /api/users/5/edit-profile
```
Student B can just send:
```http
PUT /api/users/4/edit-profile
```
… and update A’s profile if the server doesn’t check ownership.

#### 🛡️ Prevention:
- Always match `user_id` from JWT to resource owner
```js
if (req.user.id !== req.params.id) {
  return res.status(403).send("You can't edit this profile");
}
```
- Implement **fine-grained ACL (Access Control Lists)**

---

### ✅ **6. Mass Assignment**

#### 🔥 What goes wrong?
- API allows users to send object properties in bulk, including sensitive ones like `isAdmin`.

#### ⚠️ Example:
```json
{
  "name": "Hacker",
  "email": "hacker@example.com",
  "isAdmin": true
}
```

Boom—unauthorized role escalation.

#### 🛡️ Prevention:
- Use **whitelisting** for allowed fields
```js
const allowed = (({ name, email }) => ({ name, email }))(req.body);
```
- Don’t blindly `...req.body`

---

### ✅ **7. Security Misconfiguration**

#### 🔥 What goes wrong?
- Leaving default credentials
- Exposing secrets in error messages
- Storing secrets/tokens in plaintext

#### ⚠️ Example:
```js
jwt.verify(token, 'secretkey'); // hardcoded and weak
```

Or showing internal errors:
```json
{
  "error": "Cannot read property 'userId' of undefined"
}
```

#### 🛡️ Prevention:
- Use `.env` for secrets
```js
require('dotenv').config();
jwt.verify(token, process.env.JWT_SECRET);
```
- Don’t return stack traces to clients
- Change all default passwords on DB, admin tools

---

### ✅ **8. Injection (SQL, NoSQL, etc.)**

#### 🔥 What goes wrong?
- Dynamic queries that insert user input directly → attacker injects SQL

#### ⚠️ Example:
```js
let name = req.query.name;
let query = `SELECT * FROM patients WHERE name = '${name}'`;
```

Attacker sends:
```
' OR '1'='1' -- 
```
→ Returns **all patients**

#### 🛡️ Prevention:
- Use **prepared statements**:
```js
connection.query('SELECT * FROM patients WHERE name = ?', [name]);
```
- Sanitize inputs
- Always use parameterized queries

---

## 🧠 Summary Table

| Vulnerability                     | Real Example                              | Prevention                               |
|----------------------------------|-------------------------------------------|------------------------------------------|
| Broken Authentication            | No logout token invalidation              | Timeouts, token rotation, 2FA            |
| Excessive Data Exposure          | Leaking SSNs, stack traces                | Whitelist fields, no generic `.to_json()`|
| Lack of Rate Limiting            | Flood of requests from one IP             | `express-rate-limit`, throttle, 429      |
| Broken Function Authorization    | Normal user accessing admin function      | Role check in server logic               |
| Broken Object Authorization      | Editing others' data with valid ID        | Match `user_id` with JWT/DB              |
| Mass Assignment                  | Setting `isAdmin` via JSON body           | Field whitelisting, validation           |
| Security Misconfiguration        | Hardcoded secrets, default creds          | Use `.env`, encrypt data                 |
| Injection                        | `OR '1'='1'` in SQL                        | Use placeholders, never build queries    |

---

## 🔐 Final Best Practices

- Use **`helmet`** middleware in Express to set secure HTTP headers
- Enforce HTTPS with redirection
- Always store hashed passwords with `bcrypt`
- Store secrets in `.env` and **never commit them**
- Validate and sanitize all user inputs
- Use **JWT** with **httpOnly cookies** + expiry

