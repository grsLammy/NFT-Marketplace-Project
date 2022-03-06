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

    // Function to return the balance of the owner
    function balanceOf(address _owner) external view returns (uint256) {

        // Requires that the owner address cannot be zero
        require(_owner != address(0), "owner query for non-existent token");
        
        // Returns the balance of Owner
        return _countOfTokenOwned[_owner];
    }

    // Function to return the address of the token owner by the tokenId
    function ownerOf(uint256 tokenId) external view returns (address) {

        // Assigns the mapping of owner address from tokenId to owner variable
        address owner = _tokenOwner[tokenId];

        // Requires that the owner address cannot be zero
        require(owner != address(0), "owner query for non-existent token");

        // Returns the address of the token owner by the tokenId
        return owner;
    }


    function _exists(uint256 tokenId) internal view returns(bool) {

        // Setting the address of NFT owner to check the mapping of the address
        // From tokenOwner at the tokenId
        address owner = _tokenOwner[tokenId];

        // Return truthiness that address is not zero
        return owner != address(0);
    }

    function _mintToken(address _to, uint256 tokenId) internal virtual {

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