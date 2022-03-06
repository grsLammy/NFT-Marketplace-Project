// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";

contract ERC721Enumerable is ERC721 {

    uint256[] private _allTokens;

    // Mapping from tokenId to position in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    // Mapping of owner to list of all owner token ids
    mapping(address => uint256[]) private _ownedTokens;

    // Mapping from token ID to index of the owner token list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    //function tokenByIndex(uint256 _index) external view returns (uint256) {}
    
    //function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256) {} 

    function totalSupply() public view returns(uint256) {
        return _allTokens.length;
    }


    function _addTokensToTotalSupply(uint256 tokenId) private {
        _allTokens.push(tokenId);
    }

    function _mintToken(address to, uint256 tokenId) internal override (ERC721) {

        super._mintToken(to, tokenId);

        // Add tokens to the owners address
        // Add all tokens to total supply - to allTokens
        _addTokensToTotalSupply(tokenId);
    }

}