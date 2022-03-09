// import dependency
use ferris_says:: say; // :: means path
use std::io::{stdout, BufWriter};

struct Human { 
    name : String,
    age : i32 // signed 32-bit integer
}

fn main() {
    call_ferris();
    do_shadow();
    do_destructure();
    init_array();

}  

fn do_ownership() {
    let mut my_string = String::from("Hello!"); 
    my_string.push_str(", Rust!"); 
    println!("{}", my_string);
}

fn do_destructure() {
    let my_tuple = (1, 2, 3); 
    let (x, y, z) = my_tuple; // destructuring, x : 1, y : 2, z : 3
    println!("{}, {}, {}", x, y, z);
}

fn init_array() {
    // [element type; array size]
    let string_arr : [&str; 2]= [ "wow", "ehllo"];
    let int_arr : [i32; 4] = [1,2,3,4]; // default integer type in Rust is 32-bit
    println!("{}", int_arr[1]);
    println!("{:?}, {:?}", string_arr, int_arr);
}

fn do_shadow() {
    let x = 5; // x : 5
    println!(" x initial value is : {}", x);
    
    let x = x + 6; // x : 11
    println!(" x value before shadowing is : {}", x);

    { 
        let x = x * 2 ; // x : 22
        println!(" x value after shadowing is : {}", x);
    }

    println!(" x value after shadowing block is : {}", x); // x : 11
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

fn call_ferris() {
    let stdout = stdout();
    let message = String::from("hello follows!");
    let width = message.chars().count();
    let mut writer = BufWriter::new(stdout.lock());
    say(message.as_bytes(), width, &mut writer).unwrap();
}

fn playground() {
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