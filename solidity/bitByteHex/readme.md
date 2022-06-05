# Understanding units for smart contract

## glossary

- 2-base(binary)
- 10-base(decimal)
- 16-base(hexadecimal)
- 1 byte = 2 hex = 8 bits : a historic standard to encode a single character in computing

## Bit

> The bit is the most basic unit of information in computing and digital communications. The name is a portmanteau of binary digit.[1] The bit represents a logical state with one of two possible values. These values are most commonly represented as either "1" or "0", but other representations such as true/false, yes/no, +/−, or on/off are also commonly used.

```
1 bit: can represent two values. e.g => 1 or 0
```

## Byte

> The byte is a unit of digital information that most commonly consists of eight bits. **Historically, the byte was the number of bits used to encode a single character of text in a computer**[1][2] and for this reason it is the smallest addressable unit of memory in many computer architectures. To disambiguate arbitrarily sized bytes from the common 8-bit definition, network protocol documents such as The Internet Protocol (RFC 791) refer to an 8-bit byte as an octet.[3] Those bits in an octet are usually counted with numbering from 0 to 7 or 7 to 0 depending on the bit endianness. The first bit is number 0, making the eighth bit number 7.

```
1 byte: 8 bits, typically. can represent 2**8 (256, 0~255)
00000000: 1 byte
11110000: 1 byte
10101100: 1 byte
```

> The size of the byte has historically been hardware-dependent and no definitive standards existed that mandated the size. Sizes from 1 to 48 bits have been used.

## Hexadecimal

> In mathematics and computing, the hexadecimal (also base 16 or simply hex) numeral system is a positional numeral system that represents numbers using a radix (base) of 16. Unlike the decimal system representing numbers using 10 symbols, hexadecimal uses 16 distinct symbols, most often the symbols "0"–"9" to represent values 0 to 9, and "A"–"F" (or alternatively "a"–"f") to represent values from 10 to 15.

```
0x3EA: 0x => let people know this is in hexadecimals

convert 16-base number 0x3EA to 10-base
    A           E           3
(16^0*10) + (16^1*14) + (16^2*3) = 1,002 
```

> Software developers and system designers widely use hexadecimal numbers because they provide a human-friendly representation of binary-coded values. **Each hexadecimal digit represents four bits (binary digits), also known as a nibble (or nybble)**. For example, an 8-bit byte can have values ranging from **00000000 to 11111111** in binary form, which can be conveniently represented as **00 to FF** in hexadecimal.

```
1 hex = 4 bits. e.g 0 ~ 15
```

## Conversion

```
1 byte = 8 bits = 2 hex
```

Thus, 2-base 11101001 can be represented in 2 hex(since it is in 8 bits) like below. 

```
11101001 = 1110 / 1001

1110 = (2^3*1) + (2^2*1) + (2^1*1) + (2^0*0) = 14 = E
1001 = (2^3*1) + (2^2*0) + (2^1*0) + (2^0*1) = 9

11101001 = E9
```

Lastly, let's take a look at bytes32 and uint256.

```
bytes32  
  = 1 byte * 32 
  = 2 hex * 32 
  = 64 hex
  = 64 * 4 bits
  = 256 bits
  = uint256
```


## Reference 

- [Wikipedia - Bit](https://en.wikipedia.org/wiki/Bit)
- [Wikipedia - Byte](https://en.wikipedia.org/wiki/Byte)
- [Wikipedia - Hexadecimal](https://en.wikipedia.org/wiki/Hexadecimal)
- [Bits, Bytes and Hex](https://youtu.be/PmG2qgQbvc8)