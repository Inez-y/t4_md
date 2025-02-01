// enum
enum Shape {
    Circle(f32, f32, f32), // tuple struct; x, y-coords, radius
    Square(f32),
}

impl Shape {
    fn area(&self) -> f32 {
        // Container of Shape
        match self {
            Shape::Circle(_, _, r) => 
            f32::consts::PI * r * r,
            Shape::Square(x) =>
            x * x
        }
    }
}

fn main() {
    let a = [Shape::Circle(1.0, 1.0, 2.0), Shape::Square(1.0)];
    a.iter().for_each(|s| println!("{}", s.area()));
}


// original
fn sum(s: &[i32]) -> i32 {
    let mut sum = 0;

    for x in s {
        sum += *x;
    }

    sum
}







fn find2<T> (s: &[T], f: F) -> Option<&T> {
    for x in s {
        if f(x) {
            return Some(x);
        }
    }
    None
}