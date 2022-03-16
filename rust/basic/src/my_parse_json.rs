use serde;
use serde_derive;
use serde_json::{Result, Value, Error};

pub mod do_json {
    // super : the parent of a current module
    pub fn lets_parse() -> Result<super::Value, super::Error> {
        // create a raw string literal
        let data = r#"
        {
            "name": "John Doe",
            "age": 43,
            "phones": [
                "+44 1234567",
                "+44 2345678"
            ]
        }"#;


        // Parse the string of data into serde_json::Value.
        let v: super::Value = serde_json::from_str(data)?;

        // Access parts of the data by indexing with square brackets.
        println!("Please call {} at the number {}", v["name"], v["phones"][0]);

        // Ok(())
        return Ok(v);
    }
}