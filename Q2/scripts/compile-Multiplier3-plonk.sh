#!/bin/bash

# [assignment] create your own bash script to compile Multiplier3.circom using PLONK below

cd contracts/circuits

mkdir PlonkMultiplier3

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling PlonkMultiplier3.circom..."

# compile circuit

circom Multiplier3.circom --r1cs --wasm --sym -o PlonkMultiplier3
snarkjs r1cs info PlonkMultiplier3/Multiplier3.r1cs

# Start a new zkey and make a contribution

snarkjs plonk setup PlonkMultiplier3/Multiplier3.r1cs powersOfTau28_hez_final_10.ptau PlonkMultiplier3/circuit_final.zkey
# snarkjs zkey contribute PlonkMultiplier3/circuit_0000.zkey PlonkMultiplier3/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey PlonkMultiplier3/circuit_final.zkey PlonkMultiplier3/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier PlonkMultiplier3/circuit_final.zkey ../PlonkMultiplier3Verifier.sol

cd ../..