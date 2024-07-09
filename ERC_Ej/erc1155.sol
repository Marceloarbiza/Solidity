// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyGameItems is ERC1155, Ownable {
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory uri) ERC1155(uri) Ownable(msg.sender) {}

    function setURI(uint256 tokenId, string memory tokenURI) public onlyOwner {
        _tokenURIs[tokenId] = tokenURI;
        emit URI(tokenURI, tokenId);
    }

    function uri(uint256 tokenId) public view override returns (string memory) {
        return _tokenURIs[tokenId];
    }

    function mint(address account, uint256 id, uint256 amount, string memory tokenURI) public onlyOwner {
        _mint(account, id, amount, "");
        setURI(id, tokenURI);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, string[] memory uris) public onlyOwner {
        require(ids.length == uris.length, "IDs and URIs length mismatch");
        _mintBatch(to, ids, amounts, "");
        for (uint256 i = 0; i < ids.length; i++) {
            setURI(ids[i], uris[i]);
        }
    }
}

