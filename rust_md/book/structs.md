A struct, or structure, is a custom data type that lets you package together and name multiple related values that make up a meaningful group. A struct is like an object’s data attributes.

# 5.1 Defining and Instantiating Structures
```rust
struct User {
    active: bool,
    username: String,
    email: String,
    sign_in_count: u64,
}

fn main() {
    let user1 = User {
        active: true,
        username: String::from("someusername123"),
        email: String::from("someone@example.com"),
        sign_in_count: 1,
    };
}

```

The entire instance must be mutable

```rust
fn build_user(email: String, username: String) -> User {
    User {
        active: true,
        username: username,
        email: email,
        sign_in_count: 1,
    }
}
```

## Using the Field Init Shorthand
Because the parameter names and the struct field names are exactly the same, we can use the `field init shorthand syntax` to rewrite build_user so it behaves exactly the same but doesn’t have the repetition of username and email, 

```rust
fn build_user(email: String, username: String) -> User {
    User {
        active: true,
        username, //no
        email, //no
        sign_in_count: 1,
    }
}
```

## Creating Instances from Other Instances with Struct Update Syntax
It’s often useful to create a new instance of a struct that includes most of the values from another instance, but changes some. You can do this using `struct update syntax`.
```rust
fn main() {
    // --snip--

    let user2 = User {
        active: user1.active,
        username: user1.username,
        email: String::from("another@example.com"), // update only this
        sign_in_count: user1.sign_in_count,
    };

    // or
    let user2 = User {
        email: String::from("another@example.com"),
        ..user1
    };
}
```

## Using Tuple Structs Without Named Filed to Create Different Types
Rust also supports structs that look similar to tuples, called `tuple structs`. 
```rust
struct Color(i32, i32, i32);
struct Point(i32, i32, i32);

fn main() {
    let black = Color(0, 0, 0);
    let origin = Point(0, 0, 0);
}
```

## Unit-Like Structs Without Any Fields
You can also define structs that don’t have any fields! These are called `unit-like structs` because they behave similarly to `()`

```rust
struct AlwaysEqual;

fn main() {
    let subject = AlwaysEqual;
}
```

# 5.2 An Example Program Using Sructs
The area function is supposed to calculate the area of one rectangle, but the function we wrote has two parameters, and it’s not clear anywhere in our program that the parameters are related. It would be more readable and more manageable to group width and height together.

```rust
// not good
fn main() {
    let width1 = 30;
    let height1 = 50;

    println!(
        "The area of the rectangle is {} square pixels.",
        area(width1, height1)
    );
}

//The issue with this code is evident in the signature of area:
fn area(width: u32, height: u32) -> u32 {
    width * height
}
```

```rust
fn main() {
    // Tuples let us add a bit of structure, and we’re now passing just one argument.
    let rect1 = (30, 50);

    println!(
        "The area of the rectangle is {} square pixels.",
        area(rect1)
    );
}

fn area(dimensions: (u32, u32)) -> u32 {
    // width is the tuple index 0 and height is the tuple index 1
    dimensions.0 * dimensions.1
}
```

```rust
struct Rectangle {
    width: u32,
    height: u32,
}

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    println!(
        "The area of the rectangle is {} square pixels.",
        area(&rect1)
    );
}

fn area(rectangle: &Rectangle) -> u32 {
    rectangle.width * rectangle.height
}
```

# 5.3 Method Syntax
Methods are similar to functions: we declare them with the fn keyword and a name, they can have parameters and a return value, and they contain some code that’s run when the method is called from somewhere else. Unlike functions, methods are defined within the context of a struct (or an enum or a trait object)


```rust
struct Rectangle {
    width: u32,
    height: u32,
}

// need implementatino for 
// everything within this impl block will be associated with the Rectangle type. 
impl Rectangle {
    // parameter to be self in the signature and everywhere within the body
    // We chose &self here for the same reason we used &Rectangle in the function version: we don’t want to take ownership, and we just want to read the data in the struct, not write to it
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    println!(
        "The area of the rectangle is {} square pixels.",
        rect1.area()
    );
}
```

```rust
impl Rectangle {
    fn width(&self) -> bool {
        self.width > 0
    }
}

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    if rect1.width() {
        println!("The rectangle has a nonzero width; it is {}", rect1.width);
    }
}
```

Unlike C and C++, Rust has a feature called automatic referencing and dereferencing. Calling methods is one of the few places in Rust that has this behavior.
Here’s how it works: when you call a method with object.something(), Rust automatically adds in &, &mut, or * so object matches the signature of the method. In other words, the following are the same:
```rust
p1.distance(&p2);
(&p1).distance(&p2);
```

## Methods with More Parameters
```rust
impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }

    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }
}

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };
    let rect2 = Rectangle {
        width: 10,
        height: 40,
    };
    let rect3 = Rectangle {
        width: 60,
        height: 45,
    };

    println!("Can rect1 hold rect2? {}", rect1.can_hold(&rect2)); // true
    println!("Can rect1 hold rect3? {}", rect1.can_hold(&rect3)); // false
}
```

## Associated Functions
All functions defined within an `impl` block are called associated functions because they’re associated with the type named after the `impl`. We can define associated functions that don’t have self as their first parameter (and thus are not methods) because they don’t need an instance of the type to work with. We’ve already used one function like this: the String::from function that’s defined on the String type.

Associated functions that aren’t methods are often used for constructors that will return a new instance of the struct. These are often called `new`, but new isn’t a special name and isn’t built into the language.
```rust
// The Self keywords in the return type and in the body of the function are aliases for the type that appears after the impl keyword, which in this case is Rectangle.
impl Rectangle {
    fn square(size: u32) -> Self {
        Self {
            width: size,
            height: size,
        }
    }
}
```

## Multiple `impl` Blocks
Each struct is allowed to have multiple impl blocks.

```rust
impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

impl Rectangle {
    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }
}
```