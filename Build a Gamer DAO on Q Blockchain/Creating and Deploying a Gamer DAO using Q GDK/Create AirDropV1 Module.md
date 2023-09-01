# Create AirDropV1 Module

Welcome Back! So far you have created a QRC20 token and DAO using Q DAO Factory. From now on, we will add mutliple functionalities to our DAO to make it even better. 

## AirDrop V1

The purpose of AirDropV1 is to introduce you to the basic functionality of an AirDrop module and the concept of Merkle trees. It will help you understand how token rewards can be efficiently distributed to authorized users using Merkle proofs.

Let’s first look at the main features of the first version of the AirDrop module that we will implement in this section.

1. The AirDrop contract will provide a simplified AirDrop module for distributing tokens to new users within a DAO.
2. It will use the Merkle tree concept to verify user authorization for claiming rewards.
3. The contract will allow the contract owner to change the Merkle root to initiate new AirDrop events.
4. It will enable eligible users to claim the reward only once, preventing multiple claims from the same address.

The `AirDropV1` contract will offer two key functionalities:

1. The contract owner can change the Merkle root, initiating a new AirDrop event with the same token and amount.
2. It allows eligible users (as defined by the owner) to receive the reward once.

Future versions of this module will make changes to allow the reward tokens to be updated as needed, making the AirDrop module more flexible.

## Let’s start coding

First of all, navigate to`contracts/AirDropV1.sol` and start adding the following code blocks to this file.

### Solidity compiler directives

The following block represents the Solidity compiler directives.

```
// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity 0.8.19;
```

- The `SPDX-License-Identifier` specifies the license under which the contract is released (LGPL-3.0-or-later in this case).
- `pragma solidity 0.8.19;` indicates that the contract is written in Solidity version 0.8.19.

### Import libraries

The following are the import statements.

```
import {MerkleWhitelisted} from "@dlsl/dev-modules/access-control/MerkleWhitelisted.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {TokenBalance} from "./libs/TokenBalance.sol";
```

- `MerkleWhitelisted`:
    - `MerkleWhitelisted` is a contract that provides functionality for handling a whitelist of users using Merkle proofs.
    - It is located in the file `MerkleWhitelisted.sol` under the `@dlsl/dev-modules/access-control` directory, an external library, which we have imported to not code everything ourselves.
- `Ownable`:
    - `Ownable` is a contract provided by the "OpenZeppelin" library that implements ownership functionality.
    - It allows the contract to have an owner who can execute certain actions, which nobody else can execute, often used to control administrative functions.
- `TokenBalance`:
    - This file is available in the folder `contracts/lib` [Here](https://github.com/0xmetaschool/Q-boilerplate-code/blob/main/contracts/libs/TokenBalance.sol) is the the Github link from our boilerplate code.
    - The `TokenBalance` library provides a safe way to transfer ETH or ERC20 tokens to a specified address. It ensures that ERC20 token transfers are protected against common vulnerabilities using `SafeERC20`. The library can be used to handle both native ETH and ERC20 tokens in a consistent and secure manner.
    - This custom contract likely contains utility functions related to token balances or transactions.

### `AirDropV1` contract

```
contract AirDropV1 is MerkleWhitelisted, Ownable {
	// Rest of the code goes here
}
```

- The contract `AirDropV1` is declared and it inherits from two other contracts:
    - `MerkleWhitelisted`
    - `Ownable`
- `MerkleWhitelisted` provides functionality for handling a whitelist of users using Merkle proofs.
- `Ownable` provides ownership functionality, allowing the contract owner to execute certain actions.

From now on, we will add code to `AirDropV1` contract.

### Events

First of all, the contract defines two events: `RewardClaimed` and `AirDropCreated`.

```
event RewardClaimed(bytes32 indexed merkleRoot, address indexed account);
event AirDropCreated(bytes32 indexed merkleRoot, address indexed rewardToken, uint256 rewardAmount);
```

- Events are used to log important occurrences in the contract, and they can be observed off-chain by external applications or interfaces.
- These events are useful for tracking and auditing airdrop activities and keeping a transparent record of the contract's actions.
- Off-chain applications, such as DApps or analytics tools, can listen for these events and react accordingly to user actions or contract updates.
- `event RewardClaimed(bytes32 indexed merkleRoot, address indexed account);`:
    - The event has two parameters:
        - `bytes32 indexed merkleRoot`: This parameter represents the Merkle root associated with a specific airdrop event. It is declared as `indexed`, which allows external applications to filter events based on this parameter efficiently.
        - `address indexed account`: This parameter represents the Ethereum address of the user who claimed the reward. It is also declared as `indexed`, making it filterable in event logs.
    - The event has two key purposes:
        - The purpose of this event is to emit a log whenever a user successfully claims a reward through the `claimReward` function.
        - By emitting this event, the contract provides an easy way for external applications to track and record which users have already claimed their rewards.
    - Here’s how the event can be used.
        - When a user successfully claims a reward through the `claimReward` function, the contract will emit the `RewardClaimed` event with the corresponding `merkleRoot` and `account`.
- `event AirDropCreated(bytes32 indexed merkleRoot, address indexed rewardToken, uint256 rewardAmount);`:
    - The event has three parameters:
        - `bytes32 indexed merkleRoot`: This parameter represents the Merkle root associated with a new airdrop event. It is declared as `indexed`, enabling efficient filtering based on this parameter.
        - `address indexed rewardToken`: This parameter represents the address of the reward token for the airdrop. It is also declared as `indexed`.
        - `uint256 rewardAmount`: This parameter represents the amount of reward tokens to be distributed in the airdrop.
    - The event has two key purposes:
        - The purpose of this event is to emit a log whenever a new airdrop event is created using the `create_airdrop` function.
        - By emitting this event, the contract provides an easy way for external applications to track and record the details of each airdrop event, including the associated Merkle root, the reward token address, and the reward amount.
    - Here’s how this event can be used.
        - When a new airdrop event is created using the `create_airdrop` function, the contract will emit the `AirDropCreated` event with the associated `merkleRoot`, `rewardToken`, and `rewardAmount`.

### State variables

Here we are declaring state variables.

```
address public rewardToken;
uint256 public rewardAmount;
mapping(bytes32 => mapping(address => bool)) public isUserClaimed;
```

- State variables are declared at the contract level and store data that persists throughout the contract's lifetime.
- In this code snippet, three state variables are declared.
- `address public rewardToken;`:
    - This state variable `rewardToken` is of type `address` and is declared as `public`.
    - `address` is a data type in Solidity that represents Ethereum addresses. These are valid for all blockchains using the EVM (Ethereum Virtual Machine) technology. So also on Q.
    - The `public` keyword automatically creates a getter function for this variable, allowing other contracts or external applications to read its value.
- `uint256 public rewardAmount;`:
    - This state variable `rewardAmount` is of type `uint256` (unsigned integer) and is declared as `public`.
    - `uint256` is a data type in Solidity that represents non-negative integers.
    - Like `rewardToken`, `public` creates a getter function for this variable as well.
- `mapping(bytes32 => mapping(address => bool)) public isUserClaimed;`:
    - This is a nested mapping `isUserClaimed`, which associates each Merkle root with a mapping of addresses and a boolean value.
    - `mapping(keyType => valueType)` is used to create key-value associations, similar to dictionaries in other programming languages.
    - In this case, the keys of the outer mapping are of type `bytes32`, which is a fixed-size array of bytes, and the values are of type `mapping(address => bool)`.
    - The keys of the inner mapping are Ethereum addresses (`address`), and the values are boolean (`bool`) representing whether the user with that address has claimed a reward for a specific Merkle root.
    - By making `isUserClaimed` public, a getter function is automatically created to allow external access to check if a user has claimed a reward for a particular Merkle root.
- Let’s look at the purpose of using these state variables.
    - `rewardToken`, `rewardAmount`, and `isUserClaimed` are essential state variables for the airdrop contract.
    - `rewardToken` represents the address of the token being used as the reward in the airdrop.
    - `rewardAmount` represents the amount of reward tokens each eligible user can claim in the airdrop.
    - `isUserClaimed` keeps track of whether a user has claimed the reward for a specific Merkle root, preventing users from claiming the reward multiple times.
- Here’s an example usage of these state variables.
    - During the execution of the contract, we (the contract creator or owner) will set values for `rewardToken` and `rewardAmount` using the function called `create_airdrop`.
    - When a user successfully claims their reward using the `claimReward` function, the corresponding entry in `isUserClaimed` will be set to `true`, indicating that the user has already claimed their reward for that particular Merkle root.
    - The getter functions automatically created due to the `public` keyword can be used externally to check the `rewardToken`, `rewardAmount`, or whether a specific user has claimed their reward for a particular Merkle root.

### `onlyNotClaimed` modifier

Here we are defining the modifier.

```
modifier onlyNotClaimed(address account_) {
    require(
        !isUserClaimed[getMerkleRoot()][account_],
        "AirDropV1: account already claimed reward."
    );
    _;
}
```

- A modifier is a reusable piece of code that can be applied to multiple functions within a contract.
- The `onlyNotClaimed` modifier is defined to enforce a condition before executing certain functions.
- You can apply this modifier to a function like `claimReward`, which allows users to claim their airdrop reward.
- By applying `onlyNotClaimed` as a modifier to `claimReward`, the function will check if the user has already claimed the reward before proceeding.
- Here’s how the modifier works.
    - This modifier checks whether the provided `account_` has already claimed a reward for the current Merkle root.
    - It ensures that a user can claim the reward only once for a specific Merkle root.
    - If the user has already claimed the reward, any function using this modifier will revert the transaction with an appropriate error message.
    - Otherwise, the function will proceed to execute, granting the user access to claim the reward.
- Let’s look at the modifier parameters.
    - The modifier takes an `address account_` parameter, representing the user's address.
- Here, the modifier body plays the vital role.
    - The modifier contains the following code logic:
    
    ```
    require(
        !isUserClaimed[getMerkleRoot()][account_],
        "AirDropV1: account already claimed reward."
    );
    ```
    
    - It uses the `require` statement to check a condition. If the condition is not met, the function execution is halted and reverted with an error message.
- Let’s understand the condition in detail.
    - The condition inside the `require` checks whether the user's address (`account_`) has already claimed the reward for the current Merkle root.
    - It does this by accessing the `isUserClaimed` mapping, which keeps track of claimed status for each Merkle root and user account.
    - `isUserClaimed[getMerkleRoot()][account_]` returns a boolean value, where `getMerkleRoot()` retrieves the current Merkle root for the airdrop event, and `account_` is the user's address.
- The condition will throw the error message if true.
    - If the condition evaluates to `true`, meaning the user has already claimed the reward, the `require` statement will trigger the error message: `"AirDropV1: account already claimed reward."`.
    - This error message informs the user why the function execution was halted.
    - If the condition evaluates to `false`, meaning the user has not claimed the reward, the **`_;`** placeholder at the end of the modifier allows the control to pass to the actual function that uses this modifier.

### `create_airdrop` function

Here we are defining the `create_airdrop` function.

```
function create_airdrop(address rewardToken_, uint256 rewardAmount_, bytes32 merkleRoot_) public {
    _setMerkleRoot(merkleRoot_);
    rewardToken = rewardToken_;
    rewardAmount = rewardAmount_;
    emit AirDropCreated(merkleRoot_, rewardToken_, rewardAmount_);
}
```

- The `create_airdrop` function is a public function, meaning it can be called by anyone with access to the contract.
- It is responsible for initializing a new airdrop event in the contract.
- If the users were included in the Merkle tree, they will be able to claim the reward immediately, if contract has been funded before that.
- It allows the contract owner or an authorized entity to initiate a new airdrop campaign by providing the reward token address, reward amount, and the associated Merkle root.
- Once the function is called, the new airdrop event is initialized, and users can start claiming their rewards by providing valid Merkle proofs through the `claimReward` function.
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

Here we are initialising the `claimReward` function.

```
function claimReward(address account_, bytes32[] calldata merkleProof_) external onlyWhitelistedUser(account_, merkleProof_) onlyNotClaimed(account_) {
    bytes32 merkleRoot_ = getMerkleRoot();
    isUserClaimed[merkleRoot_][account_] = true;
    TokenBalance.sendFunds(rewardToken, account_, rewardAmount);
    emit RewardClaimed(merkleRoot_, account_);
}
```

- The `claimReward` function is a public external function, meaning it can be called by anyone from outside the contract.
- It allows a whitelisted user to claim their reward by providing a valid Merkle proof.
- The proof is that account was added as one of the leaves of the Merkle tree.
- The function verifies that the user is whitelisted, has not claimed the reward previously, and provides a valid Merkle proof.
- After the user's eligibility is confirmed, the function marks the user as claimed, transfers the reward tokens, and emits an event to log the successful claim.
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
    - This line of code emits the `RewardClaimed` event with the following parameters:
        - `merkleRoot_`: The Merkle root associated with the airdrop event for which the user claimed the reward.
        - `account_`: The Ethereum address of the user who claimed the reward.

### `setMerkleRoot` function

Here we are initialising the `setMerkleRoot` function.

```
function setMerkleRoot(bytes32 merkleRoot_) external onlyOwner {
    _setMerkleRoot(merkleRoot_);
}
```

- Let’s look at what the `setMerkleRoot` function is doing.
    - The `setMerkleRoot` function is a public external function, meaning it can be called by anyone from outside the contract.
    - The purpose of the `setMerkleRoot` function is to allow the contract owner to change the Merkle root.
    - By setting a new Merkle root, the contract owner initiates a new airdrop event, allowing new users to claim rewards using the updated Merkle tree.
    - Only the contract owner can execute this function due to the `onlyOwner` modifier, ensuring that only authorized individuals can control the airdrop events.
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