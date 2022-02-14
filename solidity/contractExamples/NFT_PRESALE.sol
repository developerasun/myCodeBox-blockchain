// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721Enumerable, Ownable {
  using Strings for uint256;

  // group variables based on the types (best practice for lowering gas fee)
  string public baseURI;
  string public baseExtension = ".json";
  string public notRevealedUri;

  uint256 public cost = 0.05 ether;
  uint256 public maxSupply = 10000;
  uint256 public maxMintAmount = 20;
  uint256 public nftPerAddressLimit = 3;

  bool public paused = false;
  bool public revealed = false;
  bool public onlyWhitelisted = true;

  address[] public whitelistedAddresses;

  constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI, 
    string memory _initNotRevealedUri
  ) ERC721(_name, _symbol) {
    setBaseURI(_initBaseURI);
    setNotRevealedURI(_initNotRevealedUri);
    mint(5);
  }

  // internal
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  // public
  function mint(uint256 _mintAmount) public payable {
    require(!paused);
    uint256 supply = totalSupply();
    require(_mintAmount > 0);
    require(_mintAmount <= maxMintAmount);
    require(supply + _mintAmount <= maxSupply);
    
    // exclude owner and whitelisted people from minting fee.
    if (msg.sender != owner()) {
      if ( onlyWhitelisted == true ) {
        // check a person who invokes this contract is whitelisted. 
        require(isWhitelisted(msg.sender), "User is not whitelisted");

        // whitelisted people can mint up to 3 tokens without fee.
        uint256 ownerTokenCount = balanceOf(msg.sender);
        require(ownerTokenCount < nftPerAddressLimit);
      }
      require(msg.value >= cost * _mintAmount);
    }

    for (uint256 i = 1; i <= _mintAmount; i++) {
      _safeMint(msg.sender, supply + i);
    }
  }

  function isWhitelisted(address _user) public view returns(bool) {
    for (uint256 i=0; i < whitelistedAddresses.length; i++) {
      if (whitelistedAddresses[i] == _user) {
        return true;
      }
    }
    return false;
  }

  function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );

    if (!revealed) {
      return notRevealedUri;
    }

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
  }

  //only owner  
  function reveal() public onlyOwner { 
    revealed = true;
  }

  // limit the number of mintable NFT
  function setNftPerAddressLimit(uint256 _limit) public onlyOwner {
    nftPerAddressLimit = _limit;
  }

  function setCost(uint256 _newCost) public onlyOwner {
    cost = _newCost;
  }

  function setmaxMintAmount(uint256 _newmaxMintAmount) public onlyOwner {
    maxMintAmount = _newmaxMintAmount;
  }

  function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
    notRevealedUri = _notRevealedURI;
  }

  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }

  function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
    baseExtension = _newBaseExtension;
  }

  function pause(bool _state) public onlyOwner {
    paused = _state;
  }

  function setOnlyWhitelisted(bool _state) public onlyOwner {
    onlyWhitelisted = _state;
  }

  function whitelistUser(address[] calldata _users) public onlyOwner {
      delete whitelistedAddresses; // clear out all array elements
      whitelistedAddresses = _users;
  }

  function withdraw() public payable onlyOwner {
    // msg.sender : always the person who calls current function call
    // address(this) : current contract address
    (bool isSent, ) = payable(msg.sender).call{ value : address(this).balance }("");
    require(isSent, "withdrawl failed"); 
  }

  function getBalance() public view returns (uint256) { 
    return address(this).balance;
  }
}