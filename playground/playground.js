function LogItemLength(item, value) {
    if (typeof(value) == "string" && typeof(item) == "string") console.log(`the ${item} length: ${value.length}`)    
    else console.log("enter params in string")
}

console.log("000000000000000000000000".length)

LogItemLength("private key", "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd036415f")
LogItemLength("contract account", "0x06012c8cf97bead5deae237070f9587f8e7a266d")