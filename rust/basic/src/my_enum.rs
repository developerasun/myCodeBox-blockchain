pub mod learn_enum {
    pub enum Day { 
        Monday, 
        Wednesday, 
        Saturday
    }
    impl Day {
        pub fn is_weekend(&self) -> bool {
            match self {
                &Day::Saturday => return true,
                _ => return false,
            }
        }
    }
}