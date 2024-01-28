// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract Voting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }
    uint randNonce = 0;
    uint public  publicKey = 5;
    uint private  privateKey = 3245;
    uint public  modVal=4187;
    struct keys {
        uint publicKey;
        uint privateKey;
        uint modVal;
    }
    keys[] vals;
    event updateVote();
    modifier ifEligibleOrNoDoubleCount {
        
        require(voters[msg.sender]==-1 || voters[msg.sender]==1, "not eligible.");
        require(voters[msg.sender]==-1, "Already voted.");
        _;

    }
    function getPublicId() public view ifEligibleOrNoDoubleCount returns (uint,uint,int) {
        return (publicKey,modVal,voters[msg.sender]);
    }
    Candidate[] public candidates;
    address owner;
    mapping(address => int) public voters;

    uint256 private votingStart=0;
    uint256 private votingEnd=0;
    modifier onlyOwner {
        require(msg.sender == owner,"Not Owner");
        _;
    }

    constructor(address[] memory _voters, string[] memory _candidateNames, uint256 _durationInMinutes) {
    for (uint256 i = 0; i < _candidateNames.length; i++) {
        candidates.push(Candidate({
            name: _candidateNames[i],
            voteCount: 0
        }));
    }

    for (uint256 i = 0; i < _voters.length; i++) {
        voters[_voters[i]] = -1;
    }
    owner = msg.sender;
    votingStart = block.timestamp;
    votingEnd = block.timestamp + (_durationInMinutes * 1 minutes);
}
    // constructor() {
    //     owner = msg.sender;
    //      = false;
    //     generate_keys();
    //     // Remove the start Voting Later
      
    // }

    function startVoting(address[] memory _voters, string[] memory _candidateNames,uint256 _durationInMinutes) public onlyOwner{
        votingStart = block.timestamp;
        votingEnd = block.timestamp + (_durationInMinutes * 1 minutes);
         for (uint256 i = 0; i < _candidateNames.length; i++) {
            candidates.push(Candidate({
                name: _candidateNames[i],
                voteCount: 0
            }));
        }

        for (uint256 i = 0; i < _voters.length; i++) {
            voters[_voters[i]] = -1;
        }
    }

    

    // function addCandidate(string memory _name) public onlyOwner {
    //     candidates.push(Candidate({
    //             name: _name,
    //             voteCount: 0
    //     }));
    // }

    function vote(uint256 _candidateIndex) public ifEligibleOrNoDoubleCount {
        
        uint decryptIndex = decrypt(_candidateIndex); // Decrypt the encrypted candidate Index(from the frontend)
        
        require(decryptIndex < candidates.length, "Invalid candidate index.");
        require(getVotingStatus(),"Voting period is ended");
        candidates[decryptIndex].voteCount++;
        voters[msg.sender] = 1;
        emit updateVote();
    }

    function getAllVotesOfCandiates() public view returns (Candidate[] memory){
        return candidates;
    }

    function getVotingStatus() public view returns (bool) {
            return (block.timestamp >= votingStart && block.timestamp < votingEnd);
    }

    function getRemainingTime() public view returns (uint256) {
        require(block.timestamp >= votingStart, "Voting has not started yet.");
        if (block.timestamp >= votingEnd) {
            return 0;
    }
        return votingEnd - block.timestamp;
    }

    function isPrime(uint256 n) private pure returns (bool) {
        // Optimized checks for small numbers
        if (n <= 3) {
            return n > 1;
        }
        if (n % 2 == 0 || n % 3 == 0) {
            return false;
        }

        // Optimized loop for larger numbers
        uint256 i = 5;
        while (i * i <= n) {
            if (n % i == 0 || n % (i + 2) == 0) {
                return false;
            }
            i += 6;
        }

        return true;
    }

    function gcd(uint256 a, uint256 b) private pure returns (uint256) {
        // Ensure a and b are not zero
        require(a > 0 && b > 0, "Both numbers must be greater than zero");

        // Use Euclidean Algorithm until b becomes zero
        while (b > 0) {
            uint256 temp = b;
            b = a % b;
            a = temp;
        }

        // GCD is now stored in a
        return a;
    }

    function randMod(uint min, uint max) private  returns(uint)
    {
        // increase nonce
        randNonce = randNonce+1;
        return min+ uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % (max-min+1);
    } 
    function generateRandomPrime(uint256 min, uint256 max) private returns (uint256) {
        // Ensure min is odd for efficiency
        if (min % 2 == 0) {
            min++;
        }

        while (true) {
            uint256 candidate = randMod(min, max);
            // Ensure candidate is odd
            if (candidate % 2 == 0) {
                candidate++;
            }

            if (isPrime(candidate)) {
                return candidate;
            }

            min = candidate + 2; // Skip even numbers
        }
        return min;
    }

    function mod_inverse(uint e, uint phi  ) private  pure returns(uint){
        for(uint d=3;d<phi;d++){
            if(((d*e)%phi)==1) {
                return d;
            }
        }
        return 0;

    }

    function generate_keys() public returns (bool) {
        // Public Key -> (modVal,
        uint p = generateRandomPrime(10, 30); // If (1,30) 
        uint q = generateRandomPrime(30, 60); // If (1,30) & (30,100) Higher Valued Encrypted text are generated beyond uint256 causing error so limited to (1,11) & (12,21)
        modVal = p*q;
        uint phi_n = (p-1)*(q-1);
        publicKey = randMod(3, phi_n-1);
        while(gcd(phi_n, publicKey)!=1){
            publicKey+=1;
        }
        privateKey = mod_inverse(publicKey, phi_n);
      return true;
    }

    function encrypt(uint mg) public payable  returns (uint){
        uint salt = randMod(1, 9);
        mg = mg*10+salt;
        uint ct =  (mg );
        for(uint i=0; i<publicKey-1; i++){
            ct = (ct*mg)% modVal;
        }
        return ct;
    }
    function decrypt(uint ct) public payable   returns (uint){
        uint mg =  (ct );
        for(uint i=0; i<privateKey-1; i++){
            mg = (mg*ct)% modVal;
        }
        mg = mg/10;
        return mg;
    }
    function getPublicKey() public view returns (uint,uint){
        return (publicKey,modVal);
    }
}