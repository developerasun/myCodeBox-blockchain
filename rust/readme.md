# Learning Rust Essentials
Watch [this short video](https://www.youtube.com/watch?v=5C_HPTJg5ek) to get the rough grasp of Rust lang.

> Rust is a statically typed language.

> Rust is a multi-paradigm programming language focused on performance and safety, especially safe concurrency. It is syntactically similar to C++ but provides memory safety without using garbage collection. Rust programming language was developed by Mozilla with the aim of creating a better tool for developing their browser Mozilla Firefox. 

> The language appeared to be so effective, that many programmers are now opting to use it for software development instead of using C++. Rust is syntactically similar to C++, but it provides increased speed and better memory safety.

## Installation
> The first step is to install Rust. We’ll download Rust through rustup, a command line tool for managing Rust versions and associated tools. 

For Mac OS, Linux user, run bellow command. 
```shell
$ curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
```

For Windows user, follow below link.
> It looks like you’re running Windows. To start using Rust, download the installer, then run the program and follow the onscreen instructions. You may need to install the Visual Studio C++ Build tools when prompted to do so. If you are not on Windows see "Other Installation Methods".

- [install Rust](https://www.rust-lang.org/tools/install)

### Toolchain management with rustup
> Rust is installed and managed by the rustup tool. Rust has a 6-week rapid release process and supports a great number of platforms, so there are many builds of Rust available at any time. rustup manages these builds in a consistent way on every platform that Rust supports, enabling installation of Rust from the beta and nightly release channels as well as support for additional cross-compilation targets.

### Configuring the PATH environment variable
> In the Rust development environment, all tools are installed to the ~/.cargo/bin directory, and this is where you will find the Rust toolchain, including rustc, cargo, and rustup.

> Accordingly, it is customary for Rust developers to include this directory in their PATH environment variable. During installation rustup will attempt to configure the PATH. Because of differences between platforms, command shells, and bugs in rustup, the modifications to PATH may not take effect until the console is restarted, or the user is logged out, or it may not succeed at all.

> If, after installation, running rustc --version in the console fails, this is the most likely reason.

### Updating and uninstalling
To update Rust, 
```shell
$rustup update
```

to uninstall, 
```shell 
$rustup self uninstall
```

to check version, 
```shell
$rustup --version
$rustc --version
$cargo --version
```


## Cargo
> Cargo is Rust’s build system and package manager. Most Rustaceans use this tool to manage their Rust projects because Cargo handles a lot of tasks for you, such as building your code, downloading the libraries your code depends on, and building those libraries. (We call the libraries that your code needs dependencies.)

> Because the vast majority of Rust projects use Cargo, the rest of this book assumes that you’re using Cargo too. Cargo comes installed with Rust if you used the official installers discussed in the “Installation” section. If you installed Rust through some other means, check whether Cargo is installed by entering the following into your terminal:

### First project with cargo 
Run below command to create your first Rust project. 

```shell
$cargo new (project-name) --bin
```

And then write your first Rust function. 

```rs
fn main() {
    println!("hello rust");
}
```

And run below command at your project directory to run the function. 

```shell
$cargo run # running executable
```

Refer below commands for cargo. 
1. build, b    Compile the current package
1. check, c    Analyze the current package and report errors, but don't build object files
1. clean       Remove the target directory
1. doc, d      Build this package's and its dependencies' documentation
1. new         Create a new cargo package
1. init        Create a new cargo package in an existing directory
1. run, r      Run a binary or example of the local package
1. test, t     Run the tests
1. bench       Run the benchmarks
1. update      Update dependencies listed in Cargo.lock
1. search      Search registry for crates
1. publish     Package and upload this package to the registry
1. install     Install a Rust binary. Default location is $HOME/.cargo/bin
1. uninstall   Uninstall a Rust binary

See 'cargo help <command>' for more information on a specific command.

### Cargo.toml
> Open Cargo.toml(Tom's Obvious Minimal Language) in your text editor of choice. It should look similar to the code in Listing 1-2.

```toml
[package]
name = "hello_cargo"
version = "0.1.0"
edition = "2021"

[dependencies]
```

1. package : The first line, [package], is a section heading that indicates that the following statements are configuring a package. As we add more information to this file, we’ll add other sections.

1. dependencies : The last line, [dependencies], is the start of a section for you to list any of your project’s dependencies. In Rust, packages of code are referred to as crates. 

> Cargo expects your source files to live inside the src directory. The top-level project directory is just for README files, license information, configuration files, and anything else not related to your code. Using Cargo helps you organize your projects. There’s a place for everything, and everything is in its place.

### Cargo.lock
> Running cargo build for the first time also causes Cargo to create a new file at the top level: Cargo.lock. This file keeps track of the exact versions of dependencies in your project.

> You won’t ever need to change this file manually; Cargo manages its contents for you.

### Cargo check
> Cargo also provides a command called cargo check. This command quickly checks your code to make sure it compiles but doesn’t produce an executable:

```shell 
$cargo check
Checking hello_cargo v0.1.0 (file:///projects/hello_cargo)
Finished dev [unoptimized + debuginfo] target(s) in 0.32 secs
```

> Why would you not want an executable? Often, cargo check is much faster than cargo build, because it skips the step of producing an executable. If you’re continually checking your work while writing the code, using cargo check will speed up the process! As such, many Rustaceans run cargo check periodically as they write their program to make sure it compiles. Then they run cargo build when they’re ready to use the executable.

To sum up, cargo commands we can use is as follows : 

1. We can build a project using cargo build.
1. We can build and run a project in one step using cargo run.
1. We can build a project without producing a binary to check for errors using cargo check.
1. Instead of saving the result of the build in the same directory as our code, Cargo stores it in the target/debug directory.

> An additional advantage of using Cargo is that the commands are the same no matter which operating system you’re working on. 

## Building for release
Cargo provides two ways to build your code base by cargo build(compile) command.

```shell 
$cargo build # for development
$cargo build --release # for release
```

### Production
> When your project is finally ready for release, you can use cargo build --release to compile it with optimizations. This command will create an executable in target/release instead of target/debug. The optimizations make your Rust code run faster, but turning them on lengthens the time it takes for your program to compile. 

> This is why there are two different profiles: one for development, when you want to rebuild quickly and often, and another for building the final program you’ll give to a user that won’t be rebuilt repeatedly and that will run as fast as possible. If you’re benchmarking your code’s running time, be sure to run cargo build --release and benchmark with the executable in target/release.

## Adding dependency
> Let’s add a dependency to our application. You can find all sorts of libraries on crates.io, the package registry for Rust. In Rust, we often refer to packages as “crates.” If your Cargo.toml doesn't already have a [dependencies] section, add that, then list the crate name and version that you would like to use.

> In this project, we’ll use a crate called ferris-says. In our Cargo.toml file we’ll add this information (that we got from the crate page):

```toml
[package]
name = "hello_world"
version = "0.1.0"
edition = "2021"

[dependencies]
ferris-says = "0.1"
```

> Now we can run cargo build command and then Cargo will install our dependency for us. Cargo will fetch the new dependencies and all of their dependencies, compile them all, and update the Cargo.lock

```shell
$cargo build
```

Note that the installed dependency is located below directories. 

- target/debug/deps
- target/release/deps

> To use this dependency, we can open main.rs, remove everything that’s in there (it’s just another example), and add this line to it:
```rust
use ferris_says::say;
```

> This line means that we can now use the say function that the ferris-says crate exports for us.

## Compile time error
> It’s important that we get compile-time errors when we attempt to change a value that’s designated as immutable because this very situation can lead to bugs. If one part of our code operates on the assumption that a value will never change and another part of our code changes that value, it’s possible that the first part of the code won’t do what it was designed to do. 

> The cause of this kind of bug can be difficult to track down after the fact, especially when the second piece of code changes the value only sometimes.

> The Rust compiler guarantees that when you state a value won’t change, it really won’t change, so you don’t have to keep track of it yourself. Your code is thus easier to reason through.

> In cases where you’re using large data structures, mutating an instance in place may be faster than copying and returning newly allocated instances. With smaller data structures, creating new instances and writing in a more functional programming style may be easier to think through, so lower performance might be a worthwhile penalty for gaining that clarity.

## Shadowing
> You can declare a new variable with the same name as a previous variable. Rustaceans say that the first variable is shadowed by the second, which means that the second variable’s value is what the program sees when the variable is used. We can shadow a variable by using the same variable’s name and repeating the use of the let keyword as follows:

```rust
fn main() {
    let x = 5; // x : 5 

    let x = x + 1; // x : 6

    {
        let x = x * 2;
        println!("The value of x in the inner scope is: {}", x); // x : 12
    }

    println!("The value of x is: {}", x); // x : 6
}
```

> Shadowing is different from marking a variable as mut, because we’ll get a compile-time error if we accidentally try to reassign to this variable without using the let keyword. By using let, we can perform a few transformations on a value but have the variable be immutable after those transformations have been completed.

> The other difference between mut and shadowing is that because we’re effectively creating a new variable when we use the let keyword again, we can change the type of the value but reuse the same name. For example, say our program asks a user to show how many spaces they want between some text by inputting space characters, and then we want to store that input as a number:

```rust
// Shadowing thus spares us from having to come up with different names
let space = "space"; // string type 
let space = space.len(); // number type 
```

## Data type
> Keep in mind that Rust is a statically typed language, which means that it must know the types of all variables at compile time. The compiler can usually infer what type we want to use based on the value and how we use it. 

### Scalar Types
A scalar type represents a single value. Rust has four primary scalar types: integers, floating-point numbers, Booleans, and characters. You may recognize these from other programming languages. Let’s jump into how they work in Rust.

#### Integer Types
Below shows  the built-in integer types in Rust. 

1. 8-bit : i8 u8
1. 16-bit : i16	u16
1. 32-bit : i32	u32
1. 64-bit : i64	u64
1. 128-bit : i128 u128
1. arch	: isize	usize

> how do you know which type of integer to use? If you’re unsure, Rust’s defaults are generally good places to start: integer types default to i32. The primary situation in which you’d use isize or usize is when indexing some sort of collection.

> Additionally, the isize and usize types depend on the architecture of the computer your program is running on, which is denoted in the table as “arch”: 64 bits if you’re on a 64-bit architecture and 32 bits if you’re on a 32-bit architecture.

<details>
<summary>Integer overflow</summary>

> Let’s say you have a variable of type u8 that can hold values between 0 and 255. If you try to change the variable to a value outside of that range, such as 256, integer overflow will occur, which can result in one of two behaviors. When you’re compiling in debug mode, Rust includes checks for integer overflow that cause your program to panic at runtime if this behavior occurs. Rust uses the term panicking when a program exits with an error; we’ll discuss panics in more depth in the “Unrecoverable Errors with panic!” 

> When you’re compiling in release mode with the --release flag, Rust does not include checks for integer overflow that cause panics. Instead, if overflow occurs, Rust performs two’s complement wrapping. In short, values greater than the maximum value the type can hold “wrap around” to the minimum of the values the type can hold. In the case of a u8, the value 256 becomes 0, the value 257 becomes 1, and so on. The program won’t panic, but the variable will have a value that probably isn’t what you were expecting it to have. Relying on integer overflow’s wrapping behavior is considered an error.
</details>

#### Floating-Point Types
> Rust also has two primitive types for floating-point numbers, which are numbers with decimal points. Rust’s floating-point types are f32 and f64, which are 32 bits and 64 bits in size, respectively. The default type is f64 because on modern CPUs it’s roughly the same speed as f32 but is capable of more precision. All floating-point types are signed.

#### Boolean Type
> As in most other programming languages, a Boolean type in Rust has two possible values: true and false

#### The Character Type
> Rust’s char type is the language’s most primitive alphabetic type. Here’s some examples of declaring char values:

```rust
fn main() {
    let c = 'z';
    let z = 'ℤ';
    let heart_eyed_cat = '😻';
}
```

> Note that we specify char literals with single quotes, as opposed to string literals, which use double quotes. Rust’s char type is four bytes in size and represents a Unicode Scalar Value, which means it can represent a lot more than just ASCII. Accented letters; Chinese, Japanese, and Korean characters;

## Ownership
> The main purpose of ownership is to manage heap data.

> Ownership is a set of rules that governs how a Rust program manages memory. All programs have to manage the way they use a computer’s memory while running. Some languages have garbage collection that constantly looks for no-longer used memory as the program runs; in other languages, the programmer must explicitly allocate and free the memory. 

> Rust uses a third approach: memory is managed through a system of ownership with a set of rules that the compiler checks. If any of the rules are violated, the program won’t compile. None of the features of ownership will slow down your program while it’s running.

> Because ownership is a new concept for many programmers, it does take some time to get used to. The good news is that the more experienced you become with Rust and the rules of the ownership system, the easier you’ll find it to naturally develop code that is safe and efficient. Keep at it!

> When you understand ownership, you’ll have a solid foundation for understanding the features that make Rust unique. 

### Stack and heap
> Many programming languages don’t require you to think about the stack and the heap very often. But in a systems programming language like Rust, whether a value is on the stack or the heap affects how the language behaves and why you have to make certain decisions.

#### Stack 
> Both the stack and the heap are parts of memory available to your code to use at runtime, but they are structured in different ways. The stack stores values in the order it gets them and removes the values in the opposite order. This is referred to as last in, first out. Think of a stack of plates: when you add more plates, you put them on top of the pile, and when you need a plate, you take one off the top. Adding or removing plates from the middle or bottom wouldn’t work as well! 

> Adding data is called pushing onto the stack, and removing data is called popping off the stack. **All data stored on the stack must have a known, fixed size. Data with an unknown size at compile time or a size that might change must be stored on the heap instead**.

#### Heap
> The heap is less organized: when you put data on the heap, you request a certain amount of space. The memory allocator finds an empty spot in the heap that is big enough, marks it as being in use, and returns a pointer, which is the address of that location. This process is called allocating on the heap and is sometimes abbreviated as just allocating. Pushing values onto the stack is not considered allocating. Because the pointer to the heap is a known, fixed size, you can store the pointer on the stack, but when you want the actual data, you must follow the pointer.

#### Difference
> Pushing to the stack is faster than allocating on the heap because the allocator never has to search for a place to store new data; that location is always at the top of the stack. Comparatively, allocating space on the heap requires more work, because the allocator must first find a big enough space to hold the data and then perform bookkeeping to prepare for the next allocation.

> Accessing data in the heap is slower than accessing data on the stack because you have to follow a pointer to get there. Contemporary processors are faster if they jump around less in memory. Continuing the analogy, consider a server at a restaurant taking orders from many tables. It’s most efficient to get all the orders at one table before moving on to the next table. Taking an order from table A, then an order from table B, then one from A again, and then one from B again would be a much slower process. 

> By the same token, a processor can do its job better if it works on data that’s close to other data (as it is on the stack) rather than farther away (as it can be on the heap). Allocating a large amount of space on the heap can also take time.

> When your code calls a function, the values passed into the function (including, potentially, pointers to data on the heap) and the function’s local variables get pushed onto the stack. When the function is over, those values get popped off the stack.

> Keeping track of what parts of code are using what data on the heap, minimizing the amount of duplicate data on the heap, and cleaning up unused data on the heap so you don’t run out of space are all problems that ownership addresses. Once you understand ownership, you won’t need to think about the stack and the heap very often, but **knowing that the main purpose of ownership is to manage heap data can help explain why it works the way it does**.

### Ownership rules
> First, let’s take a look at the ownership rules. Keep these rules in mind as we work through the examples that illustrate them:

- Each value in Rust has a variable that’s called its owner.
- There can only be one owner at a time.
- When the owner goes out of scope, the value will be dropped.

#### The String type
> To illustrate the rules of ownership, we need a data type that is more complex than those we covered in the “Data Types” section of Chapter 3. The types covered previously are all a known size, can be stored on the stack and popped off the stack when their scope is over, and can be quickly and trivially copied to make a new, independent instance if another part of code needs to use the same value in a different scope. But we want to look at data that is stored on the heap and explore how Rust knows when to clean up that data, and the String type is a great example.

> String literals are convenient, but they aren’t suitable for every situation in which we may want to use text. One reason is that they’re immutable. Another is that not every string value can be known when we write our code: for example, what if we want to take user input and store it? For these situations, Rust has a second string type, String. This type manages data allocated on the heap and as such is able to store an amount of text that is unknown to us at compile time. You can create a String from a string literal using the from function, like so:

```rust
let s = String::from("hello!");
```

The value "hello" has a String type, which works like below. Note that red rectangle means it is stored in stack while blue one means heap. 

<img src="reference/String-stack-heap.png" width=667 height=327 alt="how String data is stored in Rust" />

> So, what’s the difference here? Why can String be mutated but literals cannot? The difference is how these two types deal with memory.

#### Memory and allocation
> In the case of a string literal, we know the contents at compile time, so the text is hardcoded directly into the final executable. This is why string literals are fast and efficient. But these properties only come from the string literal’s immutability. Unfortunately, we can’t put a blob of memory into the binary for each piece of text whose size is unknown at compile time and whose size might change while running the program.

> With the String type, in order to support a mutable, growable piece of text, we need to allocate an amount of memory on the heap, unknown at compile time, to hold the contents. This means:

- The memory must be requested from the memory allocator at runtime.
- We need a way of returning this memory to the allocator when we’re done with our String.

> That first part is done by us: when we call String::from, its implementation requests the memory it needs. This is pretty much universal in programming languages.

> However, the second part is different. In languages with a garbage collector (GC), the GC keeps track of and cleans up memory that isn’t being used anymore, and we don’t need to think about it. In most languages without a GC, it’s our responsibility to identify when memory is no longer being used and call code to explicitly return it, just as we did to request it.

> **Doing this correctly has historically been a difficult programming problem**. If we forget, we’ll waste memory. If we do it too early, we’ll have an invalid variable. If we do it twice, that’s a bug too. We need to pair exactly one allocate with exactly one free.

> Rust takes a different path: **the memory is automatically returned once the variable that owns it goes out of scope**. Here’s a version of our scope example from Listing 4-1 using a String instead of a string literal:

> There is a natural point at which we can return the memory our String needs to the allocator: when s goes out of scope. **When a variable goes out of scope, Rust calls a special function for us. This function is called drop**, and it’s where the author of String can put the code to **return the memory**. Rust calls drop automatically at the closing curly bracket.

<details>
<summary>RAII pattern in C++</summary>

> Note: In C++, this pattern of deallocating resources at the end of an item’s lifetime is sometimes called Resource Acquisition Is Initialization (RAII). The drop function in Rust will be familiar to you if you’ve used RAII patterns.
</details>

> This pattern has a profound impact on the way Rust code is written. It may seem simple right now, but the behavior of code can be unexpected in more complicated situations when we want to have multiple variables use the data we’ve allocated on the heap.

##### Ways Variables and Data Interact: Move
> Now let’s look at the String version:

```rust
fn main() {
    let s1 = String::from("hello");
    let s2 = s1;
}
```

What happens is that s1 pointer is stored in stack and the pointer points to heap data.  

<img src="reference/String-stack-heap.png" width=667 height=327 alt="how String data is stored in Rust" />

And since Rust does not copy heap data, only assigning the same pointer to variable s2, it is illustrated like below. 

<img src="reference/String-pointers.png" width=658 height=432 alt="s1 s2 pointers point the same heap data" />

> If Rust copied the heap data as well, the operation s2 = s1 could be very expensive in terms of runtime performance if the data on the heap were large.

And Rust invalidates the first s1 pointer to prevent double free error. 

<img src="reference/String-invalidation.png" width=593 height=408 alt="s1 pointer invalidation" />

> Earlier, we said that when a variable goes out of scope, Rust automatically calls the drop function and cleans up the heap memory for that variable. But Figure 4-2 shows both data pointers pointing to the same location. This is a problem: when s2 and s1 go out of scope, they will both try to free the same memory. This is known as a double free error and is one of the memory safety bugs we mentioned previously. Freeing memory twice can lead to memory corruption, which can potentially lead to security vulnerabilities.

> To ensure memory safety, after the line let s2 = s1, Rust considers s1 as no longer valid. Therefore, Rust doesn’t need to free anything when s1 goes out of scope. Check out what happens when you try to use s1 after s2 is created; it won’t work:

```rust
fn main() {
    let s1 = String::from("hello");
    let s2 = s1;

    println!("{}, world!", s1); // cause error
}
```

> If you’ve heard the terms shallow copy and deep copy while working with other languages, the concept of copying the pointer, length, and capacity without copying the data probably sounds like making a shallow copy. But because Rust also invalidates the first variable, instead of calling it a shallow copy, it’s known as a move. In this example, we would say that s1 was moved into s2.

> Rust will never automatically create “deep” copies of your data. Therefore, any automatic copying can be assumed to be inexpensive in terms of runtime performance.

##### Ways Variables and Data Interact: Clone
> If we do want to deeply copy the heap data of the String, not just the stack data, we can use a common method called clone. We’ll discuss method syntax in Chapter 5, but because methods are a common feature in many programming languages, you’ve probably seen them before.

```rust
    let s1 = String::from("hello");
    let s2 = s1.clone();

    println!("s1 = {}, s2 = {}", s1, s2);
```

> This works just fine and explicitly produces the behavior shown in Figure 4-3, where the heap data does get copied. When you see a call to clone, you know that some arbitrary code is being executed and that code may be expensive. It’s a visual indicator that something different is going on.

## Reference 
- [Rust official docs](https://doc.rust-lang.org/book/ch01-03-hello-cargo.html)
- [dcode : Rust programming tutorial](https://youtube.com/playlist?list=PLVvjrrRCBy2JSHf9tGxGKJ-bYAN_uDCUL)
- [Fireship : Rust in 100 Seconds](https://www.youtube.com/watch?v=5C_HPTJg5ek)