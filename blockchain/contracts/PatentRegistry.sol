// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @title PatentRegistry
 * @dev Handles patent registration and NFT minting for provisional patent applications
 */
contract PatentRegistry is ERC721, ERC721URIStorage, AccessControl {
    using Counters for Counters.Counter;
    
    bytes32 public constant REGISTRAR_ROLE = keccak256("REGISTRAR_ROLE");
    Counters.Counter private _tokenIds;

    struct Patent {
        string title;
        string abstract;
        string ipfsHash;
        uint256 timestamp;
        address inventor;
        bytes32 geoLocationProof;
        bool isActive;
    }

    mapping(uint256 => Patent) public patents;
    mapping(address => uint256[]) public inventorPatents;

    event PatentRegistered(
        uint256 indexed tokenId,
        address indexed inventor,
        string title,
        string ipfsHash,
        uint256 timestamp
    );

    constructor() ERC721("DecentralizedPatent", "DPAT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(REGISTRAR_ROLE, msg.sender);
    }

    /**
     * @dev Registers a new patent and mints an NFT
     * @param _title Patent title
     * @param _abstract Patent abstract
     * @param _ipfsHash IPFS hash of the encrypted patent document
     * @param _geoLocationProof Proof of geolocation (hashed)
     * @param _metadataURI URI for the NFT metadata
     * @return tokenId The ID of the newly minted NFT
     */
    function registerPatent(
        string memory _title,
        string memory _abstract,
        string memory _ipfsHash,
        bytes32 _geoLocationProof,
        string memory _metadataURI
    ) external returns (uint256) {
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_ipfsHash).length > 0, "IPFS hash cannot be empty");

        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        Patent memory newPatent = Patent({
            title: _title,
            abstract: _abstract,
            ipfsHash: _ipfsHash,
            timestamp: block.timestamp,
            inventor: msg.sender,
            geoLocationProof: _geoLocationProof,
            isActive: true
        });

        patents[newTokenId] = newPatent;
        inventorPatents[msg.sender].push(newTokenId);

        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _metadataURI);

        emit PatentRegistered(
            newTokenId,
            msg.sender,
            _title,
            _ipfsHash,
            block.timestamp
        );

        return newTokenId;
    }

    /**
     * @dev Returns all patents owned by an inventor
     * @param _inventor Address of the inventor
     * @return uint256[] Array of patent token IDs
     */
    function getInventorPatents(address _inventor) 
        external 
        view 
        returns (uint256[] memory) 
    {
        return inventorPatents[_inventor];
    }

    // Override required functions
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _burn(uint256 tokenId) 
        internal 
        override(ERC721, ERC721URIStorage) 
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}