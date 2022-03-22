// SPDX-License-Identifier: UNLICENSED
 
pragma solidity ^0.8.0;
 
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

//ERC721 - NFTs
//NFTs - properties, name, descriptipon, url of image, attributes
// keep a check on count of our tokens -- NFTs
 
 
contract ElonNFT is ERC721URIStorage {
   using Counters for Counters.Counter;
   Counters.Counter private _tokenIds; //0
 
   constructor() ERC721("ElonMusk", "ELON") {}
 
   
   
   function mintNFT()
       public
       returns (uint256)
       {
           _tokenIds.increment();

           uint256 newItemId = _tokenIds.current();

           _mint(msg.sender, newItemId);
        
           _setTokenURI(newItemId, "https://jsonkeeper.com/b/7W9E");


           console.log("The NFT ID %s has been minted to %s", newItemId, msg.sender);

           return newItemId;
       }
}