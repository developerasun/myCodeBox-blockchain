use std::io::{stdin, stdout, Write};

fn read(input : &mut String) {
    stdout().flush().expect("failed to flush");
    stdin().read_line(input).expect("failed to read");
}

fn main() {
    println!("Rust CLI calc app");
    println!("=================");


    loop {
        // String::new() : Creates a new empty String
        let mut num1 = String::new();
        let mut num2 = String::new();
        let mut operator = String::new(); 
    
        print!("Enter a first number: ");
        read(&mut num1);
    
        print!("Enter a second number: ");
        read(&mut num2);
    
        print!("Choose an operator [+, -, *, /] : ");
        read(&mut operator);
    
        // remove whitespace and parse to float 32 type. 
        // unwrap returns the contained [Ok] value, if error, panics
        let num1 : i32 = num1.trim().parse::<i32>().unwrap(); // shadowing
        let num2 : i32 = num2.trim().parse::<i32>().unwrap();
    
        // string.chars : Returns an iterator over the chars of a string slice.
        // remove whitespace and iterates string slice to get first character
        let operator : char = operator.trim().chars().next().unwrap();
    
        let operators = String::from("+-*/");
    
        if !operators.contains(operator) {
            println!("unknown operator!");
            // When continue is encountered, the current iteration is terminated, 
            // returning control to the loop head, typically continuing with the next iteration
            continue;
        } 
    
        // must handle all cases
        let result = match operator {
            '+'=> num1 + num2, 
            '-'=> num1 - num2, 
            '*'=> num1 * num2, 
            '/'=> num1 / num2, 
            _ => panic!("error in operator") 
        };
    
        println!("the result of {} {} {} = {}", num1, operator, num2, result)

    }
}
