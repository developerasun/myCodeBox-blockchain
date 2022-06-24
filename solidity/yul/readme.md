# Learning Yul essentials

> Yul is in active development and bytecode generation is only fully implemented for the EVM dialect of Yul with EVM 1.0 as target.

> Yul (previously also called JULIA or IULIA) is an intermediate language that can be compiled to bytecode for different backends.

> Support for EVM 1.0, EVM 1.5 and Ewasm is planned, and it is designed to be a usable common denominator of all three platforms. It can already be used in stand-alone mode and for “inline assembly” inside Solidity and there is an experimental implementation of the Solidity compiler that uses Yul as an intermediate language. Yul is a good target for high-level optimisation stages that can benefit all target platforms equally.

> In order to achieve the first and second goal, Yul provides high-level constructs like for loops, if and switch statements and function calls. These should be sufficient for adequately representing the control flow for assembly programs. Therefore, no explicit statements for SWAP, DUP, JUMPDEST, JUMP and JUMPI are provided, because the first two obfuscate the data flow and the last two obfuscate control flow. Furthermore, functional statements of the form mul(add(x, y), 7) are preferred over pure opcode statements like 7 y x add mul because in the first form, it is much easier to see which operand is used for which opcode.

> To keep the language simple and flexible, Yul does not have any built-in operations, functions or types in its pure form. These are added together with their semantics when specifying a dialect of Yul, which allows specializing Yul to the requirements of different target platforms and feature sets.

> Currently, there is only one specified dialect of Yul. This dialect uses the EVM opcodes as builtin functions (see below) and defines only the type u256, which is the native 256-bit type of the EVM. Because of that, we will not provide types in the examples below.

## Reference

- [Solidity docs - Yul](https://docs.soliditylang.org/en/latest/yul.html)
