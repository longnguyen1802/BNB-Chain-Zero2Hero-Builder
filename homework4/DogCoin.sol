// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract DogCoin{
    event TotalSupply(uint256 value);
    event Transfer(uint256 value,address receiver);
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    struct Payment{
        address receiver;
        uint256 amount;
    }
    address public owner;
    uint256 public totalSupply;
    mapping(address => uint256) public userBalances;
    mapping(address => Payment[]) public userRecords;
    constructor(){
        owner = msg.sender;
        totalSupply = 2*10^6;
        userBalances[owner] = totalSupply;
        emit TotalSupply(totalSupply);
    }
    function getTotalSupply() public view returns(uint256){
        return totalSupply;
    }

    function increateTotalSupply() public onlyOwner{
        totalSupply+=1000;
        emit TotalSupply(totalSupply);
    }

    function transfer(uint amount, address receiver) public{
        require(userBalances[msg.sender]>=amount,"The sender do not have enough money");
        userBalances[msg.sender]-=amount;
        userBalances[receiver]+=amount;
        userRecords[msg.sender].push(Payment(receiver,amount));
        emit Transfer(amount,receiver);
    }
}
