// create a public module
pub mod my_http_request {
    pub async fn get_request() {
        let url = "https://jsonplaceholder.typicode.com/todos/1";
        let body = reqwest::get(url).await;
        println!("{:?}", body);
    }
}