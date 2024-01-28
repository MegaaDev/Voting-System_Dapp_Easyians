// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    uint public publicId = 12345;
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    modifier ifEligibleOrNoDoubleCount {
        
        require(voters[msg.sender]==-1 || voters[msg.sender]==1, "not eligible.");
        require(voters[msg.sender]==-1, "Already voted.");
        _;

    }
    function getPublicId() public view ifEligibleOrNoDoubleCount returns (uint,int) {
        return (publicId,voters[msg.sender]);
    }
    Candidate[] public candidates;
    address owner;
    mapping(address => int) public voters;

    uint256 public votingStart;
    uint256 public votingEnd;

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

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    

    function addCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate({
                name: _name,
                voteCount: 0
        }));
    }

    function vote(uint256 _candidateIndex) public ifEligibleOrNoDoubleCount {
        
     

        require(_candidateIndex < candidates.length, "Invalid candidate index.");
        require(getVotingStatus(),"Voting period is ended");
        candidates[_candidateIndex].voteCount++;
        voters[msg.sender] = 1;
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
}
