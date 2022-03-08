// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../ERC721.sol";
import "../interfaces/IERC721Enumerable.sol";

contract ERC721Enumerable is IERC721Enumerable, ERC721 {

    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
        mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to list of all owner token ids
        mapping(address => uint256[]) private _ownedTokens;

    // mapping from token ID to index of the owner tokens list 
        mapping(uint256 => uint256) private _ownedTokensIndex;

    
    constructor() {
        _registerInterface(bytes4(keccak256('totalSupply(bytes4)')^keccak256('tokenByIndex(bytes4)')^keccak256('tokenOfOwnerByIndex(bytes4)')));
    }

    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        _addTokensToAllTokenEnumeration(tokenId); 
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _burn(address to, uint256 tokenId) internal override(ERC721) {
        super._burn(to,tokenId);
        _removeTokenFromAllTokensEnumeration(tokenId); 
        _removeTokenFromOwnerEnumeration(to, tokenId);
    }

    // return the total supply of the _allTokens array
    function totalSupply() external view override returns(uint256) {
        return _allTokens.length;
    }

    // add tokens to the _alltokens array and set the position of the tokens indexes
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId); 
    }

    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        uint256 lastTokenIndex = _allTokens.length - 1;
        uint256 tokenIndex = _allTokensIndex[tokenId];
        uint256 lastTokenId = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index

        // This also deletes the contents at the last position of the array
        delete _allTokensIndex[tokenId];
        _allTokens.pop();
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);   
    }

    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId) private {
        uint256 lastTokenIndex = ERC721.balanceOf(from) - 1;
        uint256 tokenIndex = _ownedTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }

        // This also deletes the contents at the last position of the array
        delete _ownedTokensIndex[tokenId];
        delete _ownedTokens[from][lastTokenIndex];
    }

    function tokenByIndex(uint256 index) external view override returns(uint256) {
        // make sure that the index is not out of bounds of the total supply 
        require(index < _allTokens.length, 'global index is out of bounds!');
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint index) external view override returns(uint256) {
        require(index < balanceOf(owner),'owner index is out of bounds!');
        return _ownedTokens[owner][index];  
    }

}

