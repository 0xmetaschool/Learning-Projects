# Create AirDropV1 Module

Welcome Back! So far you have created a QRC20 token and DAO using Q DAO Factory. From now on, we will add mutliple functionalities to our DAO to make it even better. 

## AirDrop V1

The purpose of AirDropV1 is to introduce you to the basic functionality of an AirDrop module and the concept of Merkle trees. It will help you understand how token rewards can be efficiently distributed to authorized users using Merkle proofs.

Let’s first look at the main features of the first version of the AirDrop module that we will implement in this section.

1. The AirDrop contract will provide a simplified AirDrop module for distributing tokens to new users within a DAO.
2. It will use the Merkle tree concept (that we studied at the start of this section) to verify user authorization for claiming rewards.
3. The contract will allow the contract owner to change the Merkle root to initiate new AirDrop events.
4. It will enable eligible users to claim the reward only once, preventing multiple claims from the same address.

Future versions of this module will make changes to allow the reward tokens to be updated as needed, making the AirDrop module more flexible.

## Let’s start coding the AirDrop module

First of all, navigate to`contracts/AirDropV1.sol` and start adding the following code blocks to this file to implement the AirDrop module.

### Solidity compiler directives

As always, we will start with adding the Solidity compiler directives to the file.

```
// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity ^0.8.19;
```

- The `SPDX-License-Identifier` specifies the license under which the contract is released (`LGPL-3.0-or-later` in this case).
- `pragma solidity ^0.8.19;` indicates that we will use Solidity version 0.8.19 or higher in `0.8.x` branch.

### Import libraries

It is essential to import the libraries before start coding the contract. So, let’s just do that.

```
import {MerkleWhitelisted} from "@dlsl/dev-modules/access-control/MerkleWhitelisted.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {TokenBalance} from "./libs/TokenBalance.sol";
```

- `MerkleWhitelisted`:
    - We are using `MerkleWhitelisted` contract to handle the whitelist users. This contract will help us verify whether the user who is trying to claim the tokens is whitelisted or not.
    - Whitelist users are the users those will be the part of ownership of the contract. They will play their part in voting for or against any proposal and participate in the governance of the DAO. Only whitelist users will be able to claim the tokens.
- `Ownable`:
    - `Ownable` is a contract provided by the "OpenZeppelin" library that implements the ownership functionality.
    - `Ownable` allow us to restrict the contract functions to be called only by the owner of the contract. We will use this contract to enhance the security of our contract and restrict certain administrative functions, which should only be called by owners and not anyone else.
- `TokenBalance`:
    - `TokenBalance.sol` file is available in the folder `contracts/lib` of our Hardhat project. [Here](https://github.com/0xmetaschool/Q-boilerplate-code/blob/main/contracts/libs/TokenBalance.sol) is the the Github link from our boilerplate code.
    - The `TokenBalance` library provides a safe way to transfer ETH or ERC20 tokens to a specified address. It ensures that ERC20 token transfers are protected against common vulnerabilities using `SafeERC20`. The library can be used to handle both native ETH and ERC20 tokens in a consistent and secure manner.
    - We are using this libarary to implement the functionality of transferring the tokens. It will help the whitelisted user to safely transfer tokens to anyone he wants to send.

### `AirDropV1` contract

After the imports, we will delacre the `AirDropV1` contract that inherits from two other contracts: `MerkleWhitelisted`  and `Ownable`, that we discussed above.

```
contract AirDropV1 is MerkleWhitelisted, Ownable {
	// Rest of the code goes here
}
```

So, from now on, we will add code to `AirDropV1` contract.

### Events

First of all, the contract defines two events: `RewardClaimed` and `AirDropCreated`. In Solidity, events are the way to communicate with front-end or other smart contracts about the specific occurrences within the smart contract. They allow us to record or share any data with other entities, making the data transparent and easily accessible.

```
event RewardClaimed(bytes32 indexed merkleRoot, address indexed account);
event AirDropCreated(bytes32 indexed merkleRoot, address indexed rewardToken, uint256 rewardAmount);
```

- Let’s explore what `RewardClaimed` event do:
    - The event has two key purposes:
        - The purpose of this event is to emit a log whenever a user successfully claims a reward through the `claimReward` function.
        - By emitting this event, the contract provides an easy way for external applications to track and record which users have already claimed their rewards.
    - The event has two parameters:
        - `bytes32 indexed merkleRoot`: This parameter represents the Merkle root associated with a specific AirDrop event. It is declared as `indexed`, which allows external applications to filter events based on this parameter efficiently.
        - `address indexed account`: This parameter represents the Ethereum address of the user who claimed the reward. It is also declared as `indexed`, making it filterable in event logs.
- Now, let’s explore what `AirDropCreated` event do:
    - The event has two key purposes:
        - The purpose of this event is to emit a log whenever a new airdrop event is created using the `create_airdrop` function.
        - By emitting this event, the contract provides an easy way for external applications to track and record the details of each airdrop event, including the associated Merkle root, the reward token address, and the reward amount.
    - The event has three parameters:
        - `bytes32 indexed merkleRoot`: This parameter represents the Merkle root associated with a new airdrop event. It is declared as `indexed`, enabling efficient filtering based on this parameter.
        - `address indexed rewardToken`: This parameter represents the address of the reward token for the airdrop. It is also declared as `indexed`.
        - `uint256 rewardAmount`: This parameter represents the amount of reward tokens to be distributed in the airdrop.

### State variables

Now, we are declaring state variables. Let’s remind what state variables are. They are variables declare at the contract level and store data that persists throughout the contract's lifetime.

```
address public rewardToken;
uint256 public rewardAmount;
mapping(bytes32 => mapping(address => bool)) public isUserClaimed;
```

In this code snippet, three state variables are declared.

- `rewardToken`:
    - `rewardToken` represents the address of the token being used as the reward in the airdrop.
    - This state variable `rewardToken` is of type `address` and is declared as `public`.
    - `address` is a data type in Solidity that represents Ethereum addresses. These are valid for all blockchains using the EVM (Ethereum Virtual Machine) technology. So also on Q.
    - The `public` keyword automatically creates a getter function for this variable, allowing other contracts or external applications to read its value.
- `rewardAmount`:
    - `rewardAmount` represents the amount of reward tokens each eligible user can claim in the airdrop.
    - This state variable `rewardAmount` is of type `uint256` (unsigned integer) and is declared as `public`.
    - `uint256` is a data type in Solidity that represents non-negative integers.
- `isUserClaimed`:
    - `isUserClaimed` keeps track of whether a user has claimed the reward for a specific Merkle root, preventing users from claiming the reward multiple times.
    - This is a nested mapping `isUserClaimed`, which associates each Merkle root with a mapping of addresses and a boolean value.
    - `mapping(keyType => valueType)` is used to create key-value associations, similar to dictionaries in other programming languages.
    - In this case, the keys of the outer mapping are of type `bytes32`, which is a fixed-size array of bytes, and the values are of type `mapping(address => bool)`.
    - The keys of the inner mapping are Ethereum addresses (`address`), and the values are boolean (`bool`) representing whether the user with that address has claimed a reward for a specific Merkle root.

### `onlyNotClaimed` modifier

Now, We are defining the modifier. A modifier is used to modify to the behaviour of any existing function. This helps add additional functionalities to the existing code. Here, we are modifying `onlyNotClaimed` function to check whether the user has already claimed the reward or not. It ensures that a user can claim the reward only once for a specific Merkle root.

```
modifier onlyNotClaimed(address account_) {
    require(
        !isUserClaimed[getMerkleRoot()][account_],
        "AirDropV1: account already claimed reward."
    );
    _;
}
```

- The modifier takes one parameter, `address account_`, which represents the user's address.
- The modifier contains the following code logic:

```
require(
    !isUserClaimed[getMerkleRoot()][account_],
    "AirDropV1: account already claimed reward."
);
```

- The `require` statement is used to make sure that the condition is met otherwise the contract will not allows the user to proceed any further.
- `require` statement check whether the user has claimed the reward using `isUserClaimed` map and if the conditions doesn’t meet it returns the error message.
- `isUserClaimed[getMerkleRoot()][account_]` returns a boolean value, where `getMerkleRoot()` retrieves the current Merkle root for the airdrop event.

### `create_airdrop` function

Here, we are defining the `create_airdrop` function, which is used to initialize a new AirDrop event in the contract. It allows the contract owner or an authorized entity to initiate a new airdrop campaign by providing the reward token address, reward amount, and the associated Merkle root.

```
function create_airdrop(address rewardToken_, uint256 rewardAmount_, bytes32 merkleRoot_) public {
    _setMerkleRoot(merkleRoot_);
    rewardToken = rewardToken_;
    rewardAmount = rewardAmount_;
    emit AirDropCreated(merkleRoot_, rewardToken_, rewardAmount_);
}
```

- The function takes three parameters:
    - `address rewardToken_`: This is the address of the token that will be used as the reward for the airdrop.
    - `uint256 rewardAmount_`: This is the amount of reward tokens that each eligible user can claim in the airdrop.
    - `bytes32 merkleRoot_`: This is the Merkle root associated with the new airdrop event.
- `_setMerkleRoot(merkleRoot_)`:
    - This line of code calls the internal function `_setMerkleRoot` with the provided `merkleRoot_` parameter.
    - It sets the Merkle root for the new airdrop event using the value provided as input.
- `rewardToken = rewardToken_;`:
    - This line of code assigns the value of the `rewardToken_` parameter to the `rewardToken` state variable.
    - It sets the reward token address for the new airdrop event.
- `rewardAmount = rewardAmount_;`:
    - This line of code assigns the value of the `rewardAmount_` parameter to the `rewardAmount` state variable.
    - It sets the reward amount for the new airdrop event.
- `emit AirDropCreated(merkleRoot_, rewardToken_, rewardAmount_);`:
    - This line of code emits the `AirDropCreated` event with the following parameters:
        - `merkleRoot_`: The Merkle root associated with the new airdrop event.
        - `rewardToken_`: The address of the token used as the reward in the airdrop.
        - `rewardAmount_`: The amount of reward tokens each eligible user can claim in the airdrop.
    - By emitting this event, the contract provides an easy way for external applications to track and record the details of each airdrop event.

### `claimReward` function

Here, we are initialising the `claimReward` function. The function verifies that the user is whitelisted, has not claimed the reward previously, and provides a valid Merkle proof. The proof is that account was added as one of the leaves of the Merkle tree.  After the user's eligibility is confirmed, the function marks the user as claimed, transfers the reward tokens, and emits an event to log the successful claim.

```
function claimReward(address account_, bytes32[] calldata merkleProof_) external onlyWhitelistedUser(account_, merkleProof_) onlyNotClaimed(account_) {
    bytes32 merkleRoot_ = getMerkleRoot();
    isUserClaimed[merkleRoot_][account_] = true;
    TokenBalance.sendFunds(rewardToken, account_, rewardAmount);
    emit RewardClaimed(merkleRoot_, account_);
}
```

- The function takes two parameters:
    - `address account_`: This parameter represents the Ethereum address of the user who wants to claim the reward.
    - `bytes32[] calldata merkleProof_`: This is an array of bytes32 values that represents the Merkle proof for the user's address.
- `onlyWhitelistedUser(account_, merkleProof_)` and `onlyNotClaimed(account_)`:
    - These are two custom modifiers applied to the function.
    - Modifiers are conditions that must be met before executing the function.
    - `onlyWhitelistedUser` ensures that the user is whitelisted (authorized) to claim rewards based on the provided Merkle proof.
    - `onlyNotClaimed` ensures that the user has not claimed the reward for the current Merkle root yet.
- `bytes32 merkleRoot_ = getMerkleRoot();`:
    - This line of code calls the `getMerkleRoot` function to obtain the current Merkle root for the airdrop event.
    - It assigns the Merkle root value to the local variable `merkleRoot_`.
- `isUserClaimed[merkleRoot_][account_] = true;`:
    - This line of code marks the user's address as claimed for the current Merkle root in the `isUserClaimed` mapping.
    - It sets the value to `true`, indicating that the user has claimed their reward for the current Merkle root and cannot claim it again.
- `TokenBalance.sendFunds(rewardToken, account_, rewardAmount);`:
    - This line of code calls the `sendFunds` function from the `TokenBalance` contract/library.
    - It sends the reward amount (`rewardAmount`) of the reward token (`rewardToken`) to the user's address (`account_`).
- `emit RewardClaimed(merkleRoot_, account_);`:
    - This line of code emits the `RewardClaimed` event.

### `setMerkleRoot` function

Here, we are initializing the `setMerkleRoot` function. The purpose of the `setMerkleRoot` function is to allow the contract owner to change the Merkle root. By setting a new Merkle root, the contract owner initiates a new airdrop event, allowing new users to claim rewards using the updated Merkle tree. 

```
function setMerkleRoot(bytes32 merkleRoot_) external onlyOwner {
    _setMerkleRoot(merkleRoot_);
}
```

- The function takes one parameter:
    - `bytes32 merkleRoot_`: This is the new Merkle root that the contract owner wants to set.
- `onlyOwner` Modifier:
    - This function is restricted by the `onlyOwner` modifier, which ensures that only the contract owner can call this function.
    - The `onlyOwner` modifier is a custom modifier provided by the `Ownable` contract (inherited by `AirDropV1`), which restricts access to specific functions to the contract's owner.
- `_setMerkleRoot(merkleRoot_);`:
    - This line of code calls the internal function `_setMerkleRoot` with the provided `merkleRoot_` parameter.
    - It sets the Merkle root to the new value provided by the contract owner.

## Complete code

Here’s how the complete code looks like.

```
// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity 0.8.19;

// Importing external modules for access control and token balance handling.
import {MerkleWhitelisted} from "@dlsl/dev-modules/access-control/MerkleWhitelisted.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {TokenBalance} from "./libs/TokenBalance.sol";

contract AirDropV1 is MerkleWhitelisted, Ownable {
    // Events to log airdrop events and reward claims.
    event RewardClaimed(bytes32 indexed merkleRoot, address indexed account);
    event AirDropCreated(bytes32 indexed merkleRoot, address indexed rewardToken, uint256 rewardAmount);

    // State variables to store reward token address, reward amount, and claimed status.
    address public rewardToken;
    uint256 public rewardAmount;
    mapping(bytes32 => mapping(address => bool)) public isUserClaimed;

    // Modifier to check if the user has not claimed the reward.
    modifier onlyNotClaimed(address account_) {
        require(
            !isUserClaimed[getMerkleRoot()][account_],
            "AirDropV1: account already claimed reward."
        );
        _;
    }

    // Initialize the contract with the reward token, amount, and Merkle root.
    function create_airdrop(address rewardToken_, uint256 rewardAmount_, bytes32 merkleRoot_) public {
        _setMerkleRoot(merkleRoot_);
        rewardToken = rewardToken_;
        rewardAmount = rewardAmount_;
        emit AirDropCreated(merkleRoot_, rewardToken_, rewardAmount_);
    }

    // Function to claim reward for an eligible user with a valid Merkle proof.
    function claimReward(address account_, bytes32[] calldata merkleProof_) external onlyWhitelistedUser(account_, merkleProof_) onlyNotClaimed(account_) {
        bytes32 merkleRoot_ = getMerkleRoot();
        isUserClaimed[merkleRoot_][account_] = true;
        TokenBalance.sendFunds(rewardToken, account_, rewardAmount);
        emit RewardClaimed(merkleRoot_, account_);
    }

    // Function for the contract owner to change the Merkle root for a new airdrop event.
    function setMerkleRoot(bytes32 merkleRoot_) external onlyOwner {
        _setMerkleRoot(merkleRoot_);
    }
}
```

## That’s a wrap

In this lesson, you learned to create the first version of AirDrop. In next lesson, we will move onto making the migration files for `AirDropV1` module to deploy the smart contract to the Q blockchain and to add the module to your DAO.