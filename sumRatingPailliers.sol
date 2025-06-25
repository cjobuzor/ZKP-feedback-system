// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

import "./BigNumbers.sol";

contract ratingSumPailliers {
    using BigNumbers for *;

    // Homomorphic addition with uint256 inputs
    function addEncRating(uint256 a, uint256 b, uint256 pubN) public view returns (BigNumber memory) {
        // Convert uint256 inputs to bytes
        bytes memory bytesA = abi.encodePacked(a);
        bytes memory bytesB = abi.encodePacked(b);
        bytes memory bytesPub = abi.encodePacked(pubN);

        // Create BigNumbers from bytes, calculating bit length to handle leading zeros
        BigNumber memory enc_a = BigNumber(bytesA, false, BigNumbers.bitLength(bytesA));
        BigNumber memory enc_b = BigNumber(bytesB, false, BigNumbers.bitLength(bytesB));
        BigNumber memory pub_n = BigNumber(bytesPub, false, BigNumbers.bitLength(bytesPub));
        
        // Perform homomorphic addition: (enc_a * enc_b) mod (pub_n^2)
        return BigNumbers.mod(
            BigNumbers.mul(enc_a, enc_b),
            BigNumbers.pow(pub_n, 2)
        );
    }
}
