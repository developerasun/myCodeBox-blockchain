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

pub mod create_join {
    pub fn wait_to_finish() {
        let handle = super::thread::spawn(|| {
            for i in 1..10 {
                println!("from spawned thread : {}", i);
                super::thread::sleep(super::Duration::from_millis(1));
            }
        });
        handle.join().unwrap();
    }
}
// // join : Calling join on the handle blocks the thread currently running, 
// // waiting for the associated thread to finish.
// let handle = thread::spawn(|| {
//     for i in 1..10 {
//         println!("from spawned thread : {}", i);
//         thread::sleep(Duration::from_millis(1));
//     }
// });

// in main thread
// for i in 1..5 {
//     println!("{}", i);
//     thread::sleep(Duration::from_millis(1));
// }

// handle.join().unwrap();