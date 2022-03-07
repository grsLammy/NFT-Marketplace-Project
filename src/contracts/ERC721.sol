// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {

    // Mapping from tokenId to the owner address
    mapping(uint256 => address) private _tokenOwner; 

    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _countOfTokenOwned; 

    // Mapping from token ids to approved addresses
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;


    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );

    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool indexed _approved
    );

    // Function to return the balance of the owner
    function balanceOf(address _owner) external view returns (uint256) {

        // Requires that the owner address cannot be zero
        require(_owner != address(0), "owner query for non-existent token");
        
        // Returns the balance of Owner
        return _countOfTokenOwned[_owner];
    }

    // Function to return the address of the token owner by the tokenId
    function ownerOf(uint256 _tokenId) external view returns (address) {

        // Assigns the mapping of owner address from tokenId to owner variable
        address owner = _tokenOwner[_tokenId];

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

    function approve(address _to, uint256 _tokenId) internal {

        address _owner = this.ownerOf(_tokenId);

        require(_to != _owner, "Approval to current owner is not possible");
        require(msg.sender == _owner || isApprovedForAll(_owner, msg.sender), "ERC721: approve caller is not owner nor approved for all");
        _tokenApprovals[_tokenId] = _to;
        
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = this.ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    function getApproved(uint256 tokenId) internal view returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    function setApprovalForAll(address operator, bool approved) internal {
        require(operator != msg.sender, "ERC721: approve to caller");

        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function isApprovedForAll(address owner, address operator) internal view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {

        require(_to != address(0), "ERC721 Transfer to the zero address");
        require(this.ownerOf(_tokenId) == _from, "The address does not own the token its trying to transfer");
        _countOfTokenOwned[_from] -= 1;
        _countOfTokenOwned[_to] += 1;
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(_isApprovedOrOwner(msg.sender, _tokenId), "The caller is not appproved or is not an owner");
        _transferFrom(_from, _to, _tokenId);
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

        emit Transfer(address(0), _to, tokenId);
    } 
}