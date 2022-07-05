const path = require("path");
console.log(path.join(__dirname, "test-dir").slice(2).split("\\").join("/"));
