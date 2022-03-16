// should be public to get called
pub mod first_module {
    // function in Rust is private by default
    fn print_name() {
        println!("jake");
    }
    
    // pub : public
    pub fn print_message() { 
        print_name(); // private function is callable inside module
        println!("all good");
    }
}

pub mod check_enum {
    #[derive(Debug)]
    pub enum my_enum {
        Hello, 
        Goodbye
    }
}

pub mod check_match {
    pub fn my_name_match(i: usize) {
        let name = String::from("Jake Sung");
        println!("Character at index {} : {}", i, match name.chars().nth(i) {
            Some(c) => c.to_string(), // to_string : Converts the given value to a String.
            None=>"none".to_string(),
        })
    }
}