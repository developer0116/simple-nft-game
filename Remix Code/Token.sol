// SPDX-License-Identifier: GLP-3.0
pragma solidity ^0.8.0;//solidity version

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

/*importing from git the ERC721 Token standard and Ownable*/

contract Token is ERC721URIStorage, Ownable //inherit from ERC721 and Ownable
{
struct Pet { 
    uint256 damage;
    uint256 magic;
    uint256 lastmeal;
    uint256 endurance;
}


mapping(uint256=>Pet) private tokenDetails;

constructor(string memory name, string memory symbol) ERC721(name, symbol){

}
uint256 tokenCounter = 0; 

//function to mint tokens
function mint(uint256 damage, uint256 magic, uint256 endurance)public onlyOwner{ 

uint256 newid = tokenCounter; 
tokenDetails[newid]=Pet(damage,magic,block.timestamp,endurance); 
_safeMint(msg.sender,newid);//function in ERC721 for creation and mapping tokens
tokenCounter++;

}

function getTokensOfUser(address user)public view returns(uint256[] memory){ 
    uint256 totalCount=balanceOf(user); 
    if(totalCount==0) 
    {
        return new uint256[](0); 
    } else {
    uint256[] memory result = new uint256[](totalCount); 
    uint256 totalPets=tokenCounter;
    uint256 i; 
    uint256 resultIndex=0;
    for(i=0; i<totalPets; i++)
    { 
        if(ownerOf(i)==user)         {    
            result[resultIndex]=i;
            resultIndex++;
        }
           }
            return result;
    }
}
    

function Damage(uint256 tokenId) public view returns(uint256){
    return tokenDetails[tokenId].damage;
}
function Magic(uint256 tokenId) public view returns(uint256){
    return tokenDetails[tokenId].magic;
}
function LastMeal(uint256 tokenId) public view returns(uint256){
    return tokenDetails[tokenId].lastmeal;
}
function Endurance(uint256 tokenId) public view returns(uint256){
    return tokenDetails[tokenId].endurance;
}



function Feed(uint256 tokenId)public{ 
    Pet storage pet=tokenDetails[tokenId]; 
    require(pet.lastmeal+pet.endurance>block.timestamp); 
    //updating last meal of your pet to the current time stamp
    pet.lastmeal=block.timestamp;
}
}