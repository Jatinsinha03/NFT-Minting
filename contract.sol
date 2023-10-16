// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TelevisionCharacterNFT is ERC721, Ownable {
    string private baseTokenURI;
    uint256 public constant maxSupply = 3000;
    uint256 public currentSupply = 0;
    mapping(uint256 => string) private tokenImageURIs;
    constructor(string memory _name, string memory _symbol, string memory _baseURI) ERC721(_name, _symbol) {
        baseTokenURI = _baseURI;
    }
    function mintNFT(address to, string memory tokenImageURI) external onlyOwner {
        require(currentSupply < maxSupply, "Maximum supply reached");
        uint256 tokenId = currentSupply;
        _mint(to, tokenId);
        tokenImageURIs[tokenId] = tokenImageURI;
        currentSupply++;
    }
    function changeImageURI(uint256 tokenId, string memory newImageURI) external {
        require(_isApprovedOrOwner(msg.sender, tokenId), "Not the owner of the NFT");
        tokenImageURIs[tokenId] = newImageURI;
    }
    function getImageURI(uint256 tokenId) external view returns (string memory) {
        return tokenImageURIs[tokenId];
    }
    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }
    function setBaseURI(string memory newBaseURI) external onlyOwner {
        baseTokenURI = newBaseURI;
    }
}
