# Learning JSON-RPC essentials
## What is JSON-RPC?
> JSON-RPC is a remote procedure call protocol encoded in JSON. It is similar to the XML-RPC protocol, defining only a few data types and commands. JSON-RPC allows for notifications (data sent to the server that does not require a response) and for multiple calls to be sent to the server which may be answered asynchronously.

```json
// JSON-RPC Version 2.0
// request 
{"jsonrpc": "2.0", "method": "subtract", "params": {"minuend": 42, "subtrahend": 23}, "id": 3}

// response
{"jsonrpc": "2.0", "result": 19, "id": 3}
```

## Reference
- [Wikipedia : JSON-RPC](https://en.wikipedia.org/wiki/JSON-RPC#:~:text=JSON%2DRPC%20is%20a%20remote%20procedure%20call%20protocol%20encoded%20in%20JSON.&text=JSON%2DRPC%20allows%20for%20notifications,which%20may%20be%20answered%20asynchronously.)