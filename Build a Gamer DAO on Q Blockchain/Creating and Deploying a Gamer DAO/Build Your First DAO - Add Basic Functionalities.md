# Build Your First DAO - Add Basic Functionalities

Hey folks, welcome back! You've done an awesome job making it this far in the course. Till now, you've learned about Q, DAOs in general and setting up the development environment.

 Now, we will dive into building the actual DAO. We will start coding in this lesson.

## DAO functionalities

We are building a simple DAO where users will be able to vote on proposal created by the DAO during the voting period. Once the voting period ends, the proposal is automatically executed on chain. We will define the following functionalities: 

1. **Add members:** Our DAO will have the functionality to add members to the DAO. The creator of the DAO (who will deploy the DAO) will be the only one who has access to add members to the DAO.
2. **Remove Members:** Our DAO will also have a functionality of removing members from the DAO and only the creator of the DAO (who will deploy the DAO) can do it.
3. **Create Proposal:** Proposals will give the functionality to DAO members to propose something to all of the members of the DAO.
4. **Vote:** Vote functionality will allow all of the members to vote on a proposal using the proposal ID and amount of tokens they want to use for voting.
5. **Execute Proposal:** This will execute proposal will execute the proposals based on the votes made by the members of DAO. This function will have a mathematical expression to check if the majority of people in the DAO have voted for the proposal or not.

## Let’s start coding

So, we have discussed the high level functionalities you will add to your DAO. Now, you will code a DAO from scratch. Let’s start coding!

We’re going to start out with the basic structure every smart contract starts with.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
```

Let’s look at what exactly we did here.

- First Line is comment that specifies the licensing right of the smart contract and this specific line gives the right to you and everyone to use this smart contract freely :).
- Second line is the version of the Solidity compiler that we want our contract to use. We’re basically telling the compiler to only use `0.8.0` or a higher version but not any lower version.

Now, we will initialise the DAO contract and add each functionality in this contract.

```
contract DAO {

	// Rest of the code goes here

}
```

Let’s start adding functionalities to this contract. 

### Struct proposal

```
struct Proposal {
		string description;
    uint voteCount;
    bool executed;
 }
```

- First of all, we will add a `Proposal` structure to the contract that will represent a proposal within the DAO. The `Proposal` will be used to keep track of any kind of proposal presented by any member of the DAO.
- This struct has three properties:
    - `description`: A string describing the proposal.
    - `voteCount`: The number of votes received by the proposal.
    - `executed`: A boolean indicating whether the proposal has been executed.

### Struct member

```
struct Member {
		address memberAddress;
    uint memberSince;
    uint tokenBalance;
}
```

- This defines another struct called `Member` that represents a member of the DAO.
- It has three properties:
    - `memberAddress`: The account address of the member.
    - `memberSince`: The timestamp when the member joined the DAO.
    - `tokenBalance`: The number of tokens held by the member.

### State variables

```
address[] public members;
mapping(address => Member) public memberInfo;
mapping(address => mapping(uint => bool)) public votes;
Proposal[] public proposals;
```

- These are various state variables which will be used by the `DAO` contract.
    - `members`: The variable is an array of account addresses representing the members of the DAO.
    - `memberInfo`: The variable is a mapping that associates each member's account address with their corresponding `Member` struct. A struct is used to group several related variables of same or different types into one place.
    - `votes`: The variable is a mapping that keeps track of whether a member has voted on a specific proposal. It is a nested mapping, a mapping within a mapping, where the outer mapping is indexed by member addresses and the inner mapping is indexed by proposal IDs.
    - `proposals`: The variable is an array of `Proposal` structs, representing the proposals made within the DAO.

### Token balances variables

```
uint public totalSupply;
mapping(address => uint) public balances;
```

- These variables are related to token balances.
    - `totalSupply`: The variable represents the total number of tokens in circulation.
    - `balances`: The variable is a mapping that associates each member's account address with their token balance.

### Events

```
event ProposalCreated(uint indexed proposalId, string description);
event VoteCast(address indexed voter, uint indexed proposalId, uint tokenAmount);
event ProposalAccepted(string message);
event ProposalRejected(string rejected);
```

- These are event declarations.
- Events allow external systems to be notified when specific actions occur in the contract.

So far, we have added variables, structs and events to the contract, which was like collecting ingredients before actually cooking the recipe. Now, we will actually start cooking and use our ingredients to cook and add taste to our recipe (which is the `DAO` contract in our case).

### Add member

Let’s start with using our ingredients to allow adding new members to the DAO with the `addMember` function.

```
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
```

- The `addMember` function takes an account address `_member` as an argument and adds them as a member if they don't already exist.
- It sets the member’s information, adds them to the `members` array, assigns a token balance of 100 tokens to the member, and increases the total supply of all tokens available by 100 tokens.

### Remove member

```
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
```

- The `removeMember` function is used to remove a member from the DAO.
- It takes an account address `_member` as an argument and removes them as a member if they exist (if they are a member).
- The function performs a check to ensure that the member actually exists in the DAO. It checks the information saved in the `memberInfo` mapping for the given address. If the address in the `memberInfo` mapping is zero, it means that the address is not saved in the memberInfo mapping and not an existing member of the DAO. Hence, the function throws an error with the message "Member does not exist.”
- If the member exists, the function proceeds to remove them from the DAO by updating the necessary data:
    - It sets the member's information in the `memberInfo` mapping to empty values. The member's address is set to the zero address (`address(0)`), the member's `memberSince` timestamp is set to 0, and the member's token balance is set to 0.
    - It iterates over the `members` array to find the index of the member being removed. Once found, it replaces the member's address with the address at the end of the array (`members[members.length - 1]`). Then, it removes the last element from the array using the `pop()` function. This ensures that the `members` array remains contiguous without leaving any gaps.
    - The function sets the member's token balance in the `balances` mapping to 0.
- After updating the data, the member has been effectively removed from the DAO.

## That’s a wrap

That’s pretty much it for now. We will continue our code in next lesson and add more taste to our recipe.
