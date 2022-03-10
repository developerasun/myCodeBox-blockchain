// import dependency
use ferris_says:: say; // :: means path
use std::io::{stdout, BufWriter};
use std::fs::File;
use std::io::ErrorKind;

struct Human { 
    name : String,
    age : i32 // signed 32-bit integer
}

struct Point<T> {
    x : T, 
    y : T,
}

impl<T> Point<T> {
    fn print_x(&self) -> &T {
        &self.x
    }
}

// Result is a type that represents either success ([Ok]) or failure ([Err]
enum Result<T, E> {
    Ok(T),
    Err(E)
}

fn main() {
    iterate_vector();
    do_generic();
    // do_panic();
    // do_vector();
    // open_file_unwrap();
    // open_file();
    // call_ferris();
    // do_shadow();
    // do_destructure();
    // init_array();

}  

fn do_generic() {
    let p = Point { x : 5, y : 10 };
    println!("p.x = {}", p.print_x()); 
}

fn iterate_vector() {
    let v = vec![1,2,3];
    for i in &v {
        println!("{}", i);
    }
}


fn do_vector() {
    let mut v = vec![1,2,3];
    let index_third : &i32 = &v[2];
    println!("The third elem is : {}", index_third);

    // get : Returns a reference to an element or subslice depending on the type of index.
    match v.get(99) {
        Some(index_third) => println!("The third elem is : {}", index_third),
        None => println!("No such elem"),
    }
    v.push(22);
    println!("printing out array : {:?}", v);
}


fn open_file_unwrap() {
    // let f =File::open("hello2.txt").unwrap();
    let f = File::open("hello2.txt").expect("Can't open hello2.txt"); // print custom error message
}

fn open_file() {
    let f = File::open("hello.txt");
    let f = match f { // match result enum type based on File::open return type
        Ok(file) => file, 
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("hello.txt") {
                Ok(fc) => fc,
                Err(e) => panic!("Problem creating the file : {:?}", e),
            },
            other_errors => {
                panic!("Problem opening the file : {:?}", other_errors)
            }
        }
    };
    
}

fn do_panic() {
    panic!("crash and burn"); // panic is for unrecoverable errors
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