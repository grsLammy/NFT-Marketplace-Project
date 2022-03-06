// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {

    // Mapping from tokenId to the owner address
    mapping(uint256 => address) private _tokenOwner; 

    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _countOfTokenOwned; 

    event tokenMinted(
        address indexed mintedFrom,
        address indexed mintedTo,
        uint256 indexed mintedTokenId
    );

    function _exists(uint256 tokenId) internal view returns(bool) {

        // Setting the address of NFT owner to check the mapping of the address
        // From tokenOwner at the tokenId
        address owner = _tokenOwner[tokenId];

        // Return truthiness that address is not zero
        return owner != address(0);
    }

    function _mintToken(address _to, uint256 tokenId) internal {

        // Require that the address is not zero
        require(_to != address(0), "ERC721: minted to zero address");

        // Require that the token does not alrady exit
        require(!_exists(tokenId), "ERC721: token already minted");

        // Adding new address with the token id for minting
        _tokenOwner[tokenId] = _to;

        // Adding one to the count for each address that is miniting
        _countOfTokenOwned[_to] += 1;

        emit tokenMinted(address(0), _to, tokenId);
    } 
}