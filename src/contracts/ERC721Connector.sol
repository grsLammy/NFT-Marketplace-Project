// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Enumerable.sol";

abstract contract ERC721Connector is ERC721Enumerable{

    constructor(string memory name, string memory symbol) ERC721(name,symbol) {

    }

}