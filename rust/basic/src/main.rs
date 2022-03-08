fn main() {
    // by default variables are immutable in Rust
    const NOCHANGE : &str = "wow";
    let x = 4; // unchangeable

    if x > 0 {
        println!("the value of x is {}", x);
    }
    println!("const is for immutables {}", NOCHANGE);
    let jake = init_jake();
    println!("AI Jake created name : {}, age : {}", jake.name, jake.age);
    let mut pos_num : u128 = 10;
    println!("printing unsigned int : {}", pos_num);
    pos_num = 10000; 
    println!("printing changed unsigned int : {}", pos_num);
    let pos_float : f64 = 55.0;
    println!("printing float : {}", pos_float);
    
}

struct Human { 
    name : String,
    age : i32 // signed 32-bit integer
}

fn init_jake() -> Human {
    // mut keyword makes a variable mutable
    // good
    let mut jake : Human = Human { name : "jake".to_string(), age : 27 };
    jake.name = "not jake".to_string();
    jake.age = 277;
    return jake;
    // bad 
    // let jake : Human = Human { name : "jake".to_string(), age : 27 };
    // jake.name = "not jake".to_string(); // can't change
}