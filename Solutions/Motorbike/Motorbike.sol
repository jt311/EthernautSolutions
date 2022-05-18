// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Attack {

    function destroy() public {
        selfdestruct(address(0));
    }

}




