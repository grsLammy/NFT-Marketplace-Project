// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Enumerable.sol";
import "./ERC721Metadata.sol";

contract ERC721Connector is ERC721Enumerable, ERC721Metadata{

    constructor(string memory name, string memory symbol) ERC721Metadata(name,symbol) {

    }

}