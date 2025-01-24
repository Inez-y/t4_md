fn main() {
    let s1 = "hello"; // type &str
    println!("{}", s[0]); // cannot index into a string
    println!("{}", &s1[0..1]); 

    let s = "배고파"
    println!("{}", &s1[0..1]); // slicing a string can cause a panic - index is not allowed - taking slices are dangerous
    println!("{}", &s1[0..2]); // that works
    println!("{}", s.len());
    println!("{}", s.chars().count); // string.chars() iterator - itself doesn't do anything. we need to consue iterator

    let s2 = String::from("world"); // saved in heap = vector type in c++
    println!("{}", &s1[0..1]);
    println!("{} {} {}", s, s.len(), s.capacity());

    // korean word
    print_str(s); 
    // print_string(s);
    // print_strong_ref(s); // ERROR: won't compile expected `&string`

    // english word - everything works
    print_str(&s2); 
    print_string(s2);
    print_strong_ref(&s2);

}

fn pinrt_str(s: &str) {
    println!("{s}");
}

// use this(?)
fn print_string(s: String) {
    println!("{s}");
}

fn print_string_ref(s : &String) {
    println!("{s}");
}


struct Point(f32, f32); // tuple struct

struct Vector(f32, f32)

struct Circle {
    center: Point,
    radius: f32,
}

impl Circle {
    fn new(center: Point, radius: f32) -> Self {
        Self {
            center,
            radius,
        }
    } 

    fn scale(&mut self, factor: f32) {
        self.radius *= factor;
    }

    fn translate(&mut self, v:vector) {
        self.center.0 += v.0;
        self.center.1 += v.1;
    }

    // if self, will consume Circle
    fn area(&self) -> f32 {
        std::f32::constants::PI * self.radius * self.radius
    }
}

use std::fmt;

// format display
impl fmt::Display for Circle {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        // center requries Point
        write!(f, "({}, {})", self.center, self.radius);
    }
}

impl fmt::Display for Point {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        // center requries Point
        write!(f, "({}, {})", self.0, self.1);
    }
}

fn main() {
    let c = Circle::new(Point(0.0, 0.0), 1.0);
    println!("{}", c.area());
    println!("{}", &&&c.area()); 
    println!("{}", Circle::area(&c)); 
    println!("{c}"); // not compiled
}



fn square_root(x: f32) -> Option<f32> {
    if x >= 0.0 {
        Some(x.sqrt())
    } else {
        None
    }
}


fn f(x: f32) -> Option<f32> {
    if let Some(y) = square_root(x) {
        // natural log
        Some(y.ln())
    } else {
        None
    }

     Some(square_root(x)?.ln())
}

fn main() {
    let x = square_root(2.0).unwrap();
    println!("{x}");

    let x = square_root(-2.0).unwrap();
    println!("{x}"); // panic

    // allow message
    let x = square_root(-2.0).except("arg must be non-negative");
}


// read lines

use std::io;{self, BufReader, BufRead};
use std::fs::File; // for red_file_lines

fn main() {
    // read
    let stdin = io::stdin();

    // store 
    let mut line = String::new();


    // read_line stores the line terminator
    while let Ok(n) = stdin.read_line(&mut line) {
        if n == 0 {
            break;
        }
        println!("{line}");
        line.clear();
    }
}

// create line and push to vector
fn read_lines() -> io::Result<Vec<String>> {
    let mut line = String::new();
    let mut v = Vec::new();

    // ? -> if error, will return error code
    while io::stdin().read_line(&mut line)? > 0 {
        // v.push(line); // transfer ownership - cannot use it anymore
        v.push(line.clone());
        line.clear();
    } 
    OK(v)
}

fn read_file_lines(file: &str) -> io::Result<Vec<String>> {
    let f = File::open(file)?; // may be fail so add ?
    let mut reader = BufReader::new(f);
    let mut line = String::new();
    let mut v = Vec::new();

    while reader.read_line(&mut line)? > 0 {
        // v.push(line); // transfer ownership - cannot use it anymore
        v.push(line.clone());
        line.clear();
    } 
    OK(v)

}

// use 2021 version for hashmap
vi collect.rs
rustc --edition 2021 collect.rs
./collect

use std::collections::HashMap;

fn main() {
    let v = [1,2,3];
    let v : Vec<_> = a.into_iter().collect();
    println!("{v:?}");
    assert_eq!(v, vec![1,2,3]); // without this, terminate the program

    let v: Vec<_> = a.iter().collect();
    assert_eq!(v, vec![&1,&2,&3]); 

    let v = vec![('a',1), ('b',2), ('c',3)];
    let map: HashMap<_, _> = v.into_iter().collect();
    println!("{map:?}");

    let v: Vec<_> = "배고파".chars().collect();
    println!("{v}");
}