use std::ops::Deref;

pub mod store_one {
    pub fn create_int() {
        let b = Box::new(5);
        println!("b: {}", b);
    }

    pub fn create_box() {
        let x = super::MyBox::new(4);
        assert_eq!(4, *x);
        self::create_int();
    }
}

struct MyBox<T>(T);

impl<T> MyBox<T> {
    fn new(x:T)-> MyBox<T> {
        return MyBox(x) // return itself
    }
}

impl<T> Deref for MyBox<T>{
    type Target = T;
    fn deref(&self) -> &Self::Target {
        return &self.0; // 
    }
}