// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./utils/ERC721Connector.sol";

contract KryptoHamster is ERC721Connector {

    constructor() ERC721Connector("KryptoHamster","HAMI") {}
    
    // Array to store our NFTs
    string[] public kryptoHamsters;

    // Keep tracks if the token already exists
    mapping(string => bool) _doesExists;

    function removeTokenFromArray(uint tokenId) internal {
        kryptoHamsters[tokenId] = kryptoHamsters[kryptoHamsters.length - 1];
        kryptoHamsters.pop();
    }

    function mint(string memory _kryptoHamster) public {

        // Requires that the token does not already exist
        require(!_doesExists[_kryptoHamster], "kryptoHamster already exists");

        // Push the token to be minted in the array
        kryptoHamsters.push(_kryptoHamster);

        // Get the latest index of the array and set it as the id
        uint _id = kryptoHamsters.length - 1;

        // Mint ERC721 Token 
        _mint(msg.sender, _id);

        // Set doesExists to true for the minted token
        _doesExists[_kryptoHamster] = true;
    }

    function burn(uint256 tokenId) public {
        string memory _kryptoHamster = kryptoHamsters[tokenId];

        // Requires that the token does not already exist
        require(_doesExists[_kryptoHamster], "kryptoHamster does not exists");
        
        // Remove the token to be burned from kryptoHamsters[]
        removeTokenFromArray(tokenId);

        // Burn ERC721 Token
        _burn(msg.sender, tokenId);

        // Set doesExists to false for the burned token
        _doesExists[_kryptoHamster] = false;
        
    }
}
