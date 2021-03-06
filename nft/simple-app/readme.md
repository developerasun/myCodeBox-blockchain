# Creating a simple NFT app
 Understand how front end, backend, and smart contract can be integrated.

## Architecture
The architecture of the application is as follows : 

<img src="../reference/app-architecture.png" width=816 height=420 alt="nft app architecture" />

1. Smart contract contains NFT metadata URL and toss it to front end. Note that the metadata itself is not stored in blockchain. 
1. Front end sends a request to the backend to get the metadata.
1. Backend sends a response to the frontend with token metadata and token image. Note that the metadata and image can be stored anywhere you want.
1. Front end displays the token image.


## Reference
- [Create a Complete NFT App - Smart contract, Backend, Frontend](https://youtu.be/WsZyb2T83lo)