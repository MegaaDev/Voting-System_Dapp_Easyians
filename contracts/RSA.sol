
// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;


// contract RSA {
//     uint randNonce = 0;
//     uint public  publicKey;
//     uint public  privateKey;
//     uint public  modVal;
    
//     function isPrime(uint256 n) private pure returns (bool) {
//         // Optimized checks for small numbers
//         if (n <= 3) {
//             return n > 1;
//         }
//         if (n % 2 == 0 || n % 3 == 0) {
//             return false;
//         }

//         // Optimized loop for larger numbers
//         uint256 i = 5;
//         while (i * i <= n) {
//             if (n % i == 0 || n % (i + 2) == 0) {
//                 return false;
//             }
//             i += 6;
//         }

//         return true;
//     }

//     function gcd(uint256 a, uint256 b) private pure returns (uint256) {
//         // Ensure a and b are not zero
//         require(a > 0 && b > 0, "Both numbers must be greater than zero");

//         // Use Euclidean Algorithm until b becomes zero
//         while (b > 0) {
//             uint256 temp = b;
//             b = a % b;
//             a = temp;
//         }

//         // GCD is now stored in a
//         return a;
//     }

// function randMod(uint min, uint max) private  returns(uint)
//     {
//         // increase nonce
//         randNonce = randNonce+1;
//         return min+ uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % (max-min+1);
//     } 
//     function generateRandomPrime(uint256 min, uint256 max) private returns (uint256) {
//         // Ensure min is odd for efficiency
//         if (min % 2 == 0) {
//             min++;
//         }

//         while (true) {
//             uint256 candidate = randMod(min, max);
//             // Ensure candidate is odd
//             if (candidate % 2 == 0) {
//                 candidate++;
//             }

//             if (isPrime(candidate)) {
//                 return candidate;
//             }

//             min = candidate + 2; // Skip even numbers
//         }
//         return min;
//     }

//     function mod_inverse(uint e, uint phi  ) private  pure returns(uint){
//         for(uint d=3;d<phi;d++){
//             if(((d*e)%phi)==1) {
//                 return d;
//             }
//         }
//         return 0;

//     }

//     function generate_keys() public returns (bool) {
//         // Public Key -> (modVal,
//         uint p = generateRandomPrime(1, 11); // If (1,30) 
//         uint q = generateRandomPrime(12, 21); // If (1,30) & (30,100) Higher Valued Encrypted text are generated beyond uint256 causing error so limited to (1,11) & (12,21)
//         modVal = p*q;
//         uint phi_n = (p-1)*(q-1);
//         publicKey = randMod(3, phi_n-1);
//         while(gcd(phi_n, publicKey)!=1){
//             publicKey = randMod(3, phi_n-1);
//         }
//         privateKey = mod_inverse(publicKey, phi_n);
//       return true;
//     }

//     function encrypt(uint mg) public payable  returns (uint){
//         uint ct = ((mg ** publicKey) % modVal);
//         return ct;
//     }
//     function decrypt(uint ct) public payable  returns (uint){
//         uint mg =  ((ct ** privateKey) % modVal);
//         return mg;
//     }
//     function getPublicKey() public view returns (uint,uint){
//         return (publicKey,modVal);
//     }

// }
