# Build Your First DAO - Setup Voting System

Alright, it's time to get back to work on our project's DAO! In this lesson, we're going to dive right back into building and making it even better. Get ready to take our project to the next level!

## Let’s continue coding

Let’s continue adding functionalities to our DAO and complete it.

### Create proposal

```
function createProposal(string memory _description) public {
    proposals.push(Proposal({
        description: _description,
        voteCount: 0,
        executed: false
    }));
    emit ProposalCreated(proposals.length - 1, _description);
}
```

- `createProposal` function is used to create a new proposal within the DAO.
- It takes a string `_description` as an argument and creates a new Proposal struct with the provided description, an initial vote count of 0, and `executed` status set to false.
- The new proposal is added to the `proposals` array of the DAO, and the `ProposalCreated` event is emitted using the `proposals` array length and description.

### Vote

```
function vote(uint _proposalId, uint _tokenAmount) public {
    require(memberInfo[msg.sender].memberAddress != address(0), "Only members can vote");
    require(balances[msg.sender] >= _tokenAmount, "Not enough tokens to vote");
    require(votes[msg.sender][_proposalId] == false, "You have already voted for this proposal");
    votes[msg.sender][_proposalId] = true;
    memberInfo[msg.sender].tokenBalance -= _tokenAmount;
    proposals[_proposalId].voteCount += _tokenAmount;
    emit VoteCast(msg.sender, _proposalId, _tokenAmount);
}
```

- `vote` function allows a member to vote on a proposal.
- It takes two arguments:
    - `_proposalId`: The ID of the proposal being voted on.
    - `_tokenAmount`: The number of tokens the member wants to vote with.
- The function performs several checks before processing the vote:
    - It checks if the sender (the person calling the function) is a member of the DAO. If the sender's account address doesn't exist in the `memberInfo` mapping, it means they are not a member, and the function throws an error with the message "Only members can vote."
    - It verifies that the sender has enough tokens in their balance to cover the `_tokenAmount` they want to use for voting. If their token balance is lower than the desired amount, the function throws an error with the message "Not enough tokens to vote."
    - It checks if the sender has already voted for the specified proposal. If the sender's vote for the proposal is already recorded as `true` in the `votes` mapping, it means they have already voted, and the function throws an error with the message "You have already voted for this proposal."
- If all the checks pass, the function updates the necessary data:
    - It sets the sender's vote for the specified proposal to `true` in the `votes` mapping, indicating that they have voted.
    - It deducts the `_tokenAmount` from the sender's token balance by reducing their `tokenBalance` in the `memberInfo` mapping.
    - It increases the vote count of the specified proposal by adding the `_tokenAmount` to the existing `voteCount` in the corresponding `proposals` array element.
- Finally, the function emits the `VoteCast` event to notify the participants that a vote has been cast. The event includes the sender's address, the ID of the proposal they voted on, and the amount of tokens they used for voting.

### Execute proposal

```
function executeProposal(uint _proposalId) public {
    require(proposals[_proposalId].executed == false, "Proposal has already been executed");
    if (((proposals[_proposalId].voteCount / totalSupply) * 100) > 50) {
        proposals[_proposalId].executed = true;
        emit ProposalAccepted("Proposal has been approved");
    }
    emit ProposalRejected("Proposal has not been approved by majority vote");
}
```

- `executeProposal` function is responsible for executing a proposal in the DAO. It takes a parameter `_proposalId` representing the ID of the proposal to be executed.
- It first checks if the proposal has already been executed.
    - If the `executed` flag of the specified proposal is set to `true`, it means the proposal has already been executed, and the function throws an error using the `require` statement.
- If the proposal hasn't been executed, the function proceeds to check if the vote count for the proposal is greater than 50% of the total token supply. This is done by calculating the percentage of votes in favour of the proposal:

```
((proposals[_proposalId].voteCount / totalSupply) * 100)
```

- If the calculated percentage is greater than 50, it means the proposal has received a majority vote.
- If the proposal has received a majority vote, the `executed` flag of the proposal is set to `true`, indicating that the proposal has been approved and executed.
    - The function emits the `ProposalAccepted` event with the message "Proposal has been approved".
- If the proposal does not receive a majority vote, the `ProposalRejected` event is emitted with the message "Proposal has not been approved by majority vote".

## That’s a wrap

Let’s look at what we did here. We wrote a complete `DAO` contract in Solidity. So let’s look at the complete code.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAO {

		// Struct to represent a proposal in the DAO	
		struct Proposal {
		    string description;
		    uint voteCount;
		    bool executed;
		}
		
		// Struct to represent a member of the DAO
		struct Member {
		    address memberAddress;
		    uint memberSince;
		    uint tokenBalance;
		} 
		
		address[] public members; // Array to store member addresses
		mapping(address => Member) public memberInfo; // Mapping to store member information
		mapping(address => mapping(uint => bool)) public votes; // Mapping to track member votes for proposals
		Proposal[] public proposals; // Array to store proposals
		
		uint public totalSupply; // Total token supply
		mapping(address => uint) public balances; // Mapping to store token balances of members
		
		event ProposalCreated(uint indexed proposalId, string description); // Event emitted when a proposal is created
		event VoteCast(address indexed voter, uint indexed proposalId, uint tokenAmount); // Event emitted when a vote is cast
		event ProposalAccepted(string message); // Event emitted when a proposal is accepted
		event ProposalRejected(string rejected); // Event emitted when a proposal is rejected
		
		// Function to add a member to the DAO
		function addMember(address _member) public {
		    require(memberInfo[_member].memberAddress == address(0), "Member already exists");
		    memberInfo[_member] = Member({
		        memberAddress: _member,
		        memberSince: block.timestamp,
		        tokenBalance: 100
		    });
		    members.push(_member);
		    balances[_member] = 100;
		    totalSupply += 100;
		} 
		
		// Function to remove a member from the DAO
		function removeMember(address _member) public {
		    require(memberInfo[_member].memberAddress != address(0), "Member does not exist");
		    memberInfo[_member] = Member({
		        memberAddress: address(0),
		        memberSince: 0,
		        tokenBalance: 0
		    });
		    for (uint i = 0; i < members.length; i++) {
		        if (members[i] == _member) {
		            members[i] = members[members.length - 1];
		            members.pop();
		            break;
		        }
		    }
		    balances[_member] = 0;
		    totalSupply -= 100;
		} 
		
		// Function to create a proposal in the DAO
		function createProposal(string memory _description) public {
		    proposals.push(Proposal({
		        description: _description,
		        voteCount: 0,
		        executed: false
		    }));
		    emit ProposalCreated(proposals.length - 1, _description);
		} 
		
		// Function for a member to vote on a proposal
		function vote(uint _proposalId, uint _tokenAmount) public {
		    require(memberInfo[msg.sender].memberAddress != address(0), "Only members can vote");
		    require(balances[msg.sender] >= _tokenAmount, "Not enough tokens to vote");
		    require(votes[msg.sender][_proposalId] == false, "You have already voted for this proposal");
		    votes[msg.sender][_proposalId] = true;
		    memberInfo[msg.sender].tokenBalance -= _tokenAmount;
		    proposals[_proposalId].voteCount += _tokenAmount;
		    emit VoteCast(msg.sender, _proposalId, _tokenAmount);
		} 
		
		// Function to execute a proposal in the DAO
		function executeProposal(uint _proposalId) public {
		    require(proposals[_proposalId].executed == false, "Proposal has already been executed");
		    if(((proposals[_proposalId].voteCount / totalSupply)*100) > 50){
		        proposals[_proposalId].executed = true;
		        emit ProposalAccepted("Proposal has been approved");
		    }
		    emit ProposalRejected("Proposal has not been approved by majority vote");
		} 
}
```

## That’s a wrap

You did great! You not only wrote but learned the basics of writing an `DAO` contract in Solidity programming language.

In the next lesson, we'll compile and deploy this `DAO` contract and see what we get!

