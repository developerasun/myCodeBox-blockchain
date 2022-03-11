// import dependency
use ferris_says:: say; // :: means path
use std::io:: { stdin, stdout, BufWriter, ErrorKind};
use std::fs::File;
use std::collections::HashMap;

extern crate rand; // import random number library
use rand::Rng;

const MAXIMUM : i32 = 10;

struct Human { 
    name : String,
    age : i32 // signed 32-bit integer
}

impl Human { 
    // this method is read-only
    fn print_name(&self) { 
        println!("name : {}", self.name);
    }
    // this method is writable
    fn set_age(&mut self, _age:i32) {
        // &self.name = String::from("wow");
        self.age = _age;
    }
}

// generic struct
struct Point<T> {
    x : T, 
    y : T,
}

// implement the generic struct
impl<T> Point<T> {
    // create a method in the context of struct.
    fn print_x(&self) -> &T { // first parameter should be &self
        &self.x
    }
}

// Result is a type that represents either success ([Ok]) or failure ([Err]
enum Result<T, E> {
    Ok(T),
    Err(E)
}

#[derive(Debug)] // to print out enum type
enum Direction { 
    Up, 
    Down, 
    Left, 
    Right
}

fn main() {
    // let mut player_dir = Direction::Up;
    // change_direction(player_dir);

    // print_to_maximum(MAXIMUM);
    // print_tuple();
    // isolated_block();
    // mutable_reference();
    // create_human();
    // manipulate_string();
    // do_trait();
    // match_pattern();
    // read_user_input();
    // do_hashmap();
    do_random();
}  

fn do_random() {
    // get random number between 0~10
    let random_number = rand::thread_rng().gen_range(0..11);
    println!("random number: {:?}",random_number);

    // let random_bool = rand::thread_rng()
}

fn do_hashmap() {
    let mut marks  = HashMap::new(); 
    marks.insert("order", 1); // type inference
    marks.insert("angle", 90);
    marks.insert("binary", 0);
    marks.insert("stage", 99);
    
    // check hashmap length
    println!("check length of hashmap : {}", marks.len());

    // get value from the hashmap
    match marks.get("order") {
        Some(val) => println!("The value is : {}", val), 
        None => println!("Non exisiting key"),
    }

    marks.remove("stage");
    match marks.get("stage") {
        Some(val) => println!("stage exists: {}", val), 
        None => println!("stage removed"),
    }

    for (key, value) in marks {
        println!("{} : {}", key, value);
    }
}

fn read_user_input() {
    let mut input = String::new(); // create a new empty String
    println!("Enter something");
    match stdin().read_line(&mut input) {
        Ok(_) => {
            println!("Writing success! :{}", input.to_uppercase())
        },
        Err(e) => println!("something wrong : {}", e)
    }
}

fn match_pattern() {
    let number = 55;

    match number {
        1 => println!("{} is one", number),
        2 => println!("{} is two", number),
        _ => println!("does not match"), // wildcard pattern ignoring all other possible values
    };
}


fn do_trait() {
    // trait is equivalent to interface in other languages
    struct Animal { 
        name : String, 
        age : u8
    }

    trait AnimalTrait {
        fn print_name(&self);
        fn can_speak(&self)->bool;
    }

    // Trait should implement all trait items
    impl AnimalTrait for Animal {
        fn print_name(&self) {
            println!("animal name :{}",self.name);
        }
        fn can_speak(&self) ->bool{
            return true;
        }
    }

    let doggy = Animal { name : String::from("ninja"), age: 5};
    doggy.print_name();
    let is_speakable = doggy.can_speak();

    println!("is {} speakable? :{}", doggy.name, is_speakable);
}


fn manipulate_string() {
    let mut string = String::from("This is my string");
    println!("Length : {}", string.len() );
    println!("is the string empty? :{}", string.is_empty());

    for sub_string in string.split_whitespace() {
        println!("{}", sub_string);
    }

    {
        // sub-code block
        let check = string.contains("my");
        println!("does it contain 'my'? : {}",check);
        string.push_str("...");
    }

    println!("{}",string); // expected : This is my string...
    
}

fn create_human() {
    let mut jake = Human{name : String::from("Jake"), age : 27};
    jake.set_age(555);
    println!("read only method: {:?}", jake.print_name());
    println!("changed jake age : {}", jake.age)
}

fn mutable_reference() {
    let mut x = 44; 

    {
        let x_ref = &mut x; // mutable reference
        *x_ref = 444; // dereference, change x value
    }

    println!("change x value with mutable reference :{}", x);
}

fn isolated_block() {
    let mut name = String::from("jake sung");
    {
        // shadowing the above name
        let name = String::from("not jake sung");
        println!("new code block : {}", name);
    }
    println!("back to initial code block : {}", name); 
    {
        name = String::from("wow jake sung");
    }
    println!("overwritten initial value : {}", name); 
}

fn print_tuple() {
    let new_tuple = ("a", "b", "c");
    let tuple = (1, 2.4, true, "wow", new_tuple);
    let (a, b, c) = new_tuple; 
    println!("{}", tuple.2); 
    println!("destructured tuples : {}, {}, {}", a,b,c,);
}

fn print_to_maximum(maximum : i32) {
    for item in 1 .. maximum { // .. syntax excludes the last element
        println!("{}", item);
    }
}

fn change_direction(mut player_dir : Direction) {

    // match(variable) { cases here}
    match player_dir {
        Direction::Up => player_dir = Direction::Down,
        Direction::Down => player_dir = Direction::Up,
        Direction::Left => player_dir = Direction::Right,
        Direction::Right => player_dir = Direction::Left,
    };
    println!("direction changed to : {:?}", player_dir);
}

fn do_loop() {
    let mut i : i32 = 0;
    loop {
        i += 1;
        
        if i > 10 {
            break; // escape the loop condition
        }
        println!("{}", i);
    }
}


fn find_first_word(s: &String)->usize {
    // let word  = String::from("this is jake sung");
    // let index = find_first_word(&word);
    // println!("{}",index);
    let bytes = s.as_bytes(); // convert String type to byte to iterate
    // get an iterator and iterate the byte array with it
    // enumerate returns (index, value)
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return i; 
        }
    }
    return s.len();
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