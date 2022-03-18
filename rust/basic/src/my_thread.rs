use std::thread;
use std::time::Duration;

pub mod create_thread {
    pub fn from_module()->std::thread::JoinHandle<()> {
        // super: find a parent module
        return super::thread::spawn(|| {
            for i in 1..10 {
                println!("from spawned thread : {}", i);
                super::thread::sleep(super::Duration::from_millis(1));
            }
        });
    }
}