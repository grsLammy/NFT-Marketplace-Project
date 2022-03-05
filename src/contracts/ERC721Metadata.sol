// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721Metadata {

    string private _name;
    string private _symbol;

    constructor(string memory named, string memory symbolified) {
        _name = named;
        _symbol = symbolified;
    }

    function getName() external view returns (string memory) {
        return _name;
    }

    function getSymbol() external view returns (string memory) {
        return _symbol;
    }

}