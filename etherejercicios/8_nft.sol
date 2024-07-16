// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    uint256 private _tokenIdCounter;

    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {
        _tokenIdCounter = 1; // Comenzar el contador en 1
    }

    function mint(address to) public onlyOwner {
        _mint(to, _tokenIdCounter);
        _tokenIdCounter++;
    }

    //     function mint(address to, uint256 tokenId) public onlyOwner {
    //     _mint(to, tokenId);
    // }
}
