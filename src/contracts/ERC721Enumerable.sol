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

    // Add tokens to the _allTokens array and set the position of the token indexes
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    // Add tokens to the _ownedTokens owner address and set the positon of the owned token indexes 
    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length; 
        _ownedTokens[to].push(tokenId);
    }

    function tokenByIndex(uint256 _index) external view returns (uint256) {
        // Make sure that the index is not out of bounds of the total supply
        require(_index < this.totalSupply(), "global index is out of bounds");
        return _allTokens[_index];
    }
    
    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256) {
        require(_index < this.balanceOf(_owner), "owner index is out of bounds");
        return _ownedTokens[_owner][_index];
    } 

    // Return the total supply of the _allToken array
    function totalSupply() public view returns(uint256) {
        
        return _allTokens.length;
    }

    function _mintToken(address to, uint256 tokenId) internal override (ERC721) {

        super._mintToken(to, tokenId);

        _addTokensToAllTokenEnumeration(tokenId);
        _addTokenToOwnerEnumeration(to, tokenId);
    }

}