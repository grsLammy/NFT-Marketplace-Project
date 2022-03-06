// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";

contract KryptoHamster is ERC721Connector {

    constructor() ERC721Connector("KryptoHamster","HAMI") {}
    

    // Array to store our NFTs
    string[] public kryptoHamsters;

    // Keep tracks if the token already exists
    mapping(string => bool) _doesExists;

    function mint(string memory _kryptoHamster) public {

        // Requires that the token does not already exist
        require(!_doesExists[_kryptoHamster], "kryptoHamster already exists");

        // Push the token to be minted in the array
        kryptoHamsters.push(_kryptoHamster);

        // Get the latest index of the array and set it as the id
        uint _id = kryptoHamsters.length - 1;

        // Mint ERC721 Token 
        _mintToken(msg.sender, _id);

        // Set doesExists true for the token
        _doesExists[_kryptoHamster] = true;
    }
}
