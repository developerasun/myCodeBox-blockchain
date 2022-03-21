use serde_json::{Result, Value};

#[cfg(test)]
pub mod do_test {
    #[test] // make function as a test file
    fn test_basic() {
        // run cargo test command
        assert_eq!(1,1); // success
        assert_eq!("hey", "hey"); // fail
    }

    #[ignore]
    fn no_test() {
        println!("I am not test"); // not executed with command 'cargo test'
    }

    #[test]
    #[ignore] // this test will be ignored
    fn ignore_test() {
        unimplemented!();
    }

    #[test]
    fn test_two() {
        // super : the parent of a current module
        assert_eq!(super::give_two(), 2); // success
    }

    #[test]
    fn test_is_square() {
        let my_rect = super::Rectangle{ width:4, height:4 };
        assert_eq!(my_rect.check_square(), true); // success
    }

    #[test]
    fn test_reference() {
        let x = 4;
        let y = &x;
        // assert_eq!(x, y); // can't perform this
        assert_eq!(x, *y);
        assert_eq!(4, x);
    }
    

    #[test]
    fn test_smart_pointer() {
        let x = 4;
        let y = Box::new(x); // make a pointer pointing to x and store the value at heap

        assert_eq!(4,x);
        assert_eq!(x,*y);
    }
}

// super 
fn give_two() ->i32 {
    return 2;
}

struct Rectangle {
    width : u8, 
    height : u8
}

impl Rectangle {
    pub fn check_square(&self) -> bool {
        return self.height == self.width;
    }
}