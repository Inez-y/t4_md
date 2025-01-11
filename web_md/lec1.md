# Outline
• A question on application design
• OOP review
• Chrome debugging/developer tool
• Coding style rules in this class for this week’s lab onward
• HTML review
• CSS review
• JavaScript review
• Hosting tips

# Why web dev is so challenging?
### Web app vs Java Desktop App
- User can close the page unannounced 
    - The OS signals the java app before closure
- User can use any browser
    - windows, mac, linux
- User has limited resources (memory, cpu power, GPU power)
    - java app has entire resources at hand
- User can use any device (phone, tablet, desktop)
    - just a desktop computer or thin client
- Inf. frameworks and teechnologies
    - java and maybe java fx
- Security (anyone around the world can access your app)
    - only for you, no one else has access to your computer
- DoF service attatch, injection
    - no one else has access to your computer
- Server might go down, network goes down
    - your pc
- Remote
    - right in front of you


### Example
What factors would you consider?
A:
• Security
• Amount of Memory that could be available to the app
• Multitasking
• CPU speed
• GPU speed
• Taking adv of the device Sensors (GEO, Vibration, Camer)

# OOP in modern JS
### Inheritance 
Create a general vehicle class in JavaScript called vehicle and then extend it to create a specific type of vehicle, a car. This shows the "is-a" relationship where a car "is a" type of vehicle. 

```javascript
class Vehicle {
    constructor(brand) {
        this.brand = brand;
    }

    start() {
        console.log("starting the vehicle...");
    }
}

class Car extends Vehicle {
    constructor(brand, engineType) {
        super(brand);
        this.engineType = engineType;

        displayDetails() {
            console.log(`This is a ${this.brand} car with a ${this.engineType} engine`);
        }
    }
}

let myCar = new Car('BCIT', 'BCIT Engine');
myCar.start();
myCar.displayDetails();
```

### Composition
Create separate classes for Car and Engine, and then compose a car with an engine. This shows the "has-a" relationship
where a car "has an" engine.

```javascript
class Engine {
    constructor(type) {
        this.type = type;
    }

    start() { 
        console.log(`Starting ${this.type} engine...`); 
    }
}

class Car {
    constructor(brand, engineType) {
        this.brand = brand;
        this.engineType = engineType;
    }

    start() {
        this.engine.start();
        console.log(`${this.brand} card is running`);
    }
}

let myEngine = new Engine('V1');
let myCar = new Car('BCIT', myEngine);
myCar.start()
```

#### Inheritance vs Composition
- Inheritance
    - `is-a` type of Vehicle
    - inheriting its properties and methods
- Composition
    - car `has an` engine as a component
    - more flexibility
- **Composition over inheritance**: the flexibility

### Chrome Developper Tool

### Coding Style for this Lab Onward
- Variable declaration:
    - `const` first and `let` for variable declarations to ensure block-level scoping, with `const` being the default choice for variables that don't change. NEVER USE `var`
    - if a variable is not meant to be global, it should not be declared as such

- Object-Oriented Practices:
    - use classes and constructor functions to encapsulate and manage related data and behaviours

- Function length:
    - a function focuses on a single task
    - avoid side effects
    - has to be short
    - rule of thumb: function should fit on a screen without scrolling

- String and user message management:
    - store user-facing strings in separate files (JS or JSON) for easy management and localization 
        ex: error messages and UI lables
    - no hard coded user facing string messages
    - implementing a centralized message displaying mechanism

# HTML review 

### HTML Basics
- HTML is used to form components(element) of a web page
- Must start with a `<!DOCTYPE html>`
- HTML document itself begins with `<html>` and ends with `</html>`
- HTML - hyper text markup language
- Consists of tags `<b> BOLD </b>`
- An HTML script is consist of HTML elements
    - element ex: `<p> Hello World </p>`
- Tags generally *open* and *close* - except for single-element tags like `<img>`, `<br>`, `<hr>`
- HTML elements are the building blocks of HTML pages
- HTML tags label peices of content such as `paragraph`, `image` and so on

### HTML elements and thier attributes
- Link
    - `<a href="link"> this lis a link </a>`
    - link destination is specified in the `href` attribute
    - attributes are used to provide additional information about HTML elements 

- Image
    - `<img src="bcit.jpg" alt="bcit.ca" width="104" height="142">`
    - source file, alternative text, width and height provided as **(pair:value) attributes**

#### What if we invent a new HTML tag?
- browserse do not display the HTML tags themselves, but use them to render the content between or inside them on the page

- browser ignores the new tag if no css/javascript/web component

- Everything is inside a tag : 
    
    In HTML, content is typically enclosed within HTML tags. Tags define the structure and purpose of the content.

- What happens if some text is NOT inside tag: 
    
    This refers to content that appears outside of any defined HTML tags. ->  plain content on the page

### HTML vs CSS vs JavaScript vs DOM
- **How** elements are logically attached to each other is determined by a tree graph called `DOM`
- **Where** every element is place and how it looks: `CSS`
- `JavaScript` is used to add *interactvely* to elements of a webpage, engage with users by handling events and how to add a new element to the page *dynamically*

### HTML Document Object Model (DOM)
- tree-like structure of DOM model: nested tags.
![alt text](./pics/image0.png)

# Internet Technical Terms
### HTTP Hypertext Transfer Protocol
- The transfer protocol is the set of rules that the computers use to move files from one computer to another on the Internet
    - ex: HTTP
- `HTTPS` Hypertext Transfer Protocol Secure
    - uses separate protocols called `SSL`
- Two other protocols 
    - File Transfer Protocol(`FTP`)
    - Telnet Protocol(`TP`)


### Uniform Resource Locators
- The IP address and the domain name each identify a particular computer on the Internet
    - they do not indicate where a Web Page's HTML document resides on the computer
    - to identify a Web pages exact location, web browsers rely on **Uniform Resource Locator**: `URL`
- `URL` is a four-part addressing scheme that tells the Web browser:
    - what transfer protocol to use for transporting the file
    - the domain name of computer on which file resides
    - the pathname of the foler or directory on the computer on which file resides
    - the name of the file

### Structure of URL
- Uniform Resource Locators
- `http` : internet application protocol
- `://www.`: sub domain
- others: Top Level Domain (`TLD`)

### Tips
- dont forget the end tag
- sinle tags are referred as empty tags as there is nothing between opn and close tags
- HTML ags are not case sensitive `<p>` = `<P>`

### HTML Lists
- `<ul>` : unordered/bullet
- `<ol>` : ordered/numbered list
- `<li>` : each element

```html
<H2> An Unordered/Bullet </H2>
<ul> 
    <li> Bullet1
    <li> Bullet2
    <li> Bullet3
</ul>

<H2> An Ordered/Numbered </H2>
<ul>
    <li> Num1
    <li> Num2
    <li> Num3
</ul>
```

# HTML Input Elements
### Input Buttons

two attributes: `type=button` `value=try it`
```html
<input type="button" value="Try it"> 
```

button linked to the media
```html
<a href="https://media.giphy.com/media/Wsx8SB3gOyWZ2/giphy.gif" target="_blank">
  <input type="button" value="Click me">
</a>
```

### Radio Buttons
```html
<input type="radio" name="color" value="red"> Red <br>
<input type="radio" name="color" value="green"> Green <br>
<input type="radio" name="color" value="blue"> Blue <br>
```

### Text Formatting Elements
• `<b>` - Bold text

<b> Bold </b>

• `<strong>` - Important text

<strong> Strong </strong>

• `<i>` - Italic text

<i> italic </i>

• `<em>` - Emphasized text

<em> Emphasized </em>

• `<mark>` - Marked text

<mark> marked </mark>

• `<small>` - Small text

• `<del>` - Deleted text

• `<ins>` - Inserted text

• `<sub>` - Subscript text

• `<sup>` - Superscript text

### `<b>` vs `<strong>`
- both looks just the same however
    - the html `<b>` element defines bold text, without any extra importance
        - Since `<b>` is purely for presentation, it doesn’t provide any semantic value to search engines.
    - `<strong>` adds semantic "strong" importance
        - Screen readers recognize the `<strong>` element as having additional importance and may emphasize it with a change in tone or verbal emphasis, helping visually impaired users understand the content's significance.
        - Search engines consider `<strong>` text to be semantically important, which may improve its relevance in search indexing.
        - Example: Using `<strong>` around key phrases can signal their importance to search engines, potentially improving keyword recognition.

### `<i>` vs `<em>`
- both looks just the same however
- The HTML `<i>` element defines italic text, without any extra importance.
However `<em>` added semantic importance.


### Quotation and Citation Semantic Elements
- `<abbr>`: defines an abbreviation or acronym
    - <p>The <abbr title="World Health Organization">WHO</abbr> recently released new guidelines on public health.</p>
    ```html
    <p>The <abbr title="World Health Organization">WHO</abbr> recently released new guidelines on public health.</p> ```
    
- `<address>`: defines contact information for the author/owner of a document
    
    ```html
    <address>
    Contact us at: <a href="mailto:support@example.com">support@example.com</a><br>
    123 Main Street, Springfield, USA
    </address> 
    ```

- `<bdo>`: defines the text direction

    ```html
    <p><bdo dir="rtl">مرحبا بالعالم</bdo> translates to "Hello World" in Arabic.</p>
    ```

- `<blockquote>`: defines a section that is quoted from another source

    <blockquote cite="https://example.com/inspiring-quotes">
    "The only way to do great work is to love what you do."
    </blockquote>


    ```html
    <blockquote cite="https://example.com/inspiring-quotes">
    "The only way to do great work is to love what you do."
    </blockquote>
    ```
- `<cite>`: defines the title of a work

    <p>I recommend reading <cite>To Kill a Mockingbird</cite> by Harper Lee.</p>

    ```html
    <p>I recommend reading <cite>To Kill a Mockingbird</cite> by Harper Lee.</p>
    ```
- `<q>`: defines a short inline quotation 
    <p>As Albert Einstein once said, <q>Imagination is more important than knowledge.</q></p>

    ```html
    <p>As Albert Einstein once said, <q>Imagination is more important than knowledge.</q></p>
    ```

# HTML Styles with Style Attribute
- Setting The HTML style attribute follows the same syntax as other attributes
However there are two differences:

    - style is a global attribute = default attribute of all elements 
        - opposite: `src` only the attribute of few elements such as img and video

    - the value of the style attribute is an object with various property-value paris
        - 
        ```html 
        <tagname style="property:value;">
        ```

### Background Color
```html
<body style="background-color:powderblue;">
    </body>
```

### Text Color, Font Type
```html
<h1 style="color:blue;"> heading </h1>
<h1 style="font-family:verdana"> heading </h1>

<h1 style="color:blue; font-family:verdana;"> heading</h1>
```

### Specifying Colors in HTML
1. using a predefined color names such as orange, tomato, dogerblue, gray...

2. RGB, HEX, HSL, RGBA, HSLA values


### Font Size, Text Alignment
```html
<h1 style="font-size:300%; text-align:center;"> center, left, right, justify </h1>
```

### Border Color
```html
<h1 style="border:2px solid DodgerBlue;"> border colour</h1>
```

<p style="border:2px solid DodgerBlue;"> border colour</p>