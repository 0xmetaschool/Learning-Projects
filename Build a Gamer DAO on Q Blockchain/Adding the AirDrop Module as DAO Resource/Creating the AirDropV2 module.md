# Creating the AirDropV2 module

Welcome Back! So far you have deployed your DAO on Q blockchain and you have a hardhat project which we have used to deploy the version 1 of the Airdrop module. Now, in this lesson you will learn how to create a version 2 of the Airdrop module to overcome the limitations of the previous version.

## What exactly AirDrop V2 will do?

Let’s first look at what exactly AirDropV2 will do and why we want to create it.

1. The purpose of the AirDropV2 contract is to implement a more advanced version of the Airdrop module for the DAO. It adds new features and improvements to the previous version of the Airdrop module.
2. The huge difference between V1 and V2 is, that the V2 is fully controlled by the DAO. All functions of the V2 need to be executed by voting in the DAO and cannot be called by any individual. 
3. It will help the DAO distribute tokens or rewards to specific users based on predefined rules.
4. The contract will allow the DAO to create and manage different token distribution campaigns.

## Prerequisite

Before moving forward, create another solidity file called `ACampaignAirDrop.sol` ****under `contracts/lib` and copy its code from [here](https://github.com/0xmetaschool/Q-boilerplate-code/blob/main/contracts/libs/ACampaignAirDrop.sol). This is a pre-defined contract which contains the logic for managing a airdrop campaign.

## Let’s start coding

So, first of all, navigate to `contracts/AirDropV2.sol` folder of your existing hardhat project.

Let’s start coding the Airdrop module.

### Import dependencies

The following lines import external modules and contracts that are needed for the functionality of the contract.

```
// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity ^0.8.19;

import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {IDAOResource} from "@q-dev/gdk-contracts/interfaces/IDAOResource.sol";
import {ACampaignAirDrop} from "./libs/ACampaignAirDrop.sol";
```

- The `Initializable` contract provides a modifier called **`initializer`**, which can be used to define the initialization function for your upgradeable contracts
- `IDAOResource` is an interface for permission control and veto functionality in the DAO. It is an interface that contains two functions: `checkPermission` and `getResource`.
    - The `checkPermission` function is used in the `GeneralDAOVoting` contract of a DAO contract deployed with GDK.
        - It allows the voting contract to check whether a user has the right to initiate a vote for changes in that contract.
        - This is permission control: if you want to change or update a vote, you must have permission.
        - This means, users can only create votes for changes but not implement changes directly themselves.
    - The `getResource` function is used by `PermissionManager` for `vetoGroups`.
        - This essentially enables the veto functionality, allowing you to designate, for example, Expert Group 1 as the custodian for a given contract.
        - This way, the experts in this group will be able to veto proposals to this contract.
        - So, for example, they can veto a proposal to create a campaign.
- `ACampaignAirDrop` is a contract that implements the Campaign framework for managing token distribution campaigns.

### AirDropV2 contract

The following code block defines the `AirDropV2` contract and inherits from `ACampaignAirDrop`, `Initializable`, and `IDAOResource` contracts.

```
contract AirDropV2 is ACampaignAirDrop, Initializable, IDAOResource {
	// Rest of the code goes here
}
```

From now on, we will add code to the `AirDropV2` contract.

### State variables

Here, we are declaring the state variables for the contract.

```
string public constant AIR_DROP_V2_RESOURCE = "AIR_DROP_V2";
address public votingContract;
```

- `AIR_DROP_V2_RESOURCE` is a constant string variable that represents the resource name associated with this contract, `"AIR_DROP_V2"`.
- `votingContract` is an address variable that will store the address of the voting contract which has permission to create campaigns.

### onlyVotingContract modifier

This is a custom modifier called `onlyVotingContract`.

```
modifier onlyVotingContract() {
    require(msg.sender == votingContract, "AirDropV2: caller is not the voting contract.");
    _;
}
```

- It ensures that only the voting contract can call functions with this modifier.
- It helps to control access to certain functions, limiting them to the voting contract so they cannot be called by a single person.

### Constructor function

Next is a constructor function named `__AirDropV2_init`.

```
function __AirDropV2_init(address votingContract_) public initializer {
    votingContract = votingContract_;
}
```

- It initializes the contract with the address of the voting contract provided as an argument.
- The `initializer` modifier ensures that this function can only be called once during contract deployment.

### `createCampaign` function

The function, `createCampaign`, is used by the voting contract to create a new token distribution campaign.

```
function createCampaign(
    address rewardToken_,
    uint256 rewardAmount_,
    bytes32 merkleRoot_,
    uint256 startTimestamp_,
    uint256 endTimestamp_
) external onlyVotingContract returns (uint256) {
    return _createCampaign(rewardToken_, rewardAmount_, startTimestamp_, endTimestamp_, merkleRoot_);
}
```

- It takes various parameters related to the campaign, such as `rewardToken_`, `rewardAmount_`, `merkleRoot_`, `startTimestamp_`, and `endTimestamp_`.
- The function returns the campaign ID, which can be used to reference the newly created campaign. So as you can see compared to the AirdropV1 module, the Airdrop V2 Module is way more versatile.
- For the sake of example, only the addresses specified as `votingContract` can call this function.

### `claimReward` function

The `claimReward` function allows users to claim their rewards from a specific campaign.

```
function claimReward(
    uint256 campaignId_,
    address account_,
    bytes32[] calldata merkleProof_
) external {
    _claimReward(campaignId_, account_, merkleProof_);
}
```

- It requires the campaign ID (`campaignId_`), the user's account address (`account_`), and a valid Merkle proof (`merkleProof_`) for the user's eligibility to claim the reward.

### `checkPermission` function

The `checkPermission` function is from the `IDAOResource` interface.

```
function checkPermission(
    address /*member_*/,
    string calldata /*permission_*/
) external pure returns (bool) {
    return true;
}
```

- This function would handle permission checks for specific actions within the DAO. For example you can allow only a certain group of members of the DAO to create an AirDrop campaign.

### `getResource` function

The `getResource` function is from the `IDAOResource` interface.

```
function getResource() external pure returns (string memory) {
    return AIR_DROP_V2_RESOURCE;
}
```

- It simply returns the resource name, `"AIR_DROP_V2"`.
- This resource name is used by the `PermissionManager` for permission control in the DAO.

## Complete code

Here’s how the complete code look like.

```
// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity ^0.8.19;

import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {IDAOResource} from "@q-dev/gdk-contracts/interfaces/IDAOResource.sol";
import {ACampaignAirDrop} from "./libs/ACampaignAirDrop.sol";

// AirDropV2 Contract
contract AirDropV2 is ACampaignAirDrop, Initializable, IDAOResource {
    // Resource name for the AirDropV2 module
    string public constant AIR_DROP_V2_RESOURCE = "AIR_DROP_V2";

    // Address of the voting contract
    address public votingContract;

    // Modifier to restrict access to functions only to the voting contract
    modifier onlyVotingContract() {
        require(msg.sender == votingContract, "AirDropV2: caller is not the voting contract.");
        _;
    }

    // Constructor to set the voting contract address during deployment
    function __AirDropV2_init(address votingContract_) public initializer {
        votingContract = votingContract_;
    }

    // Create a new token distribution campaign (can be called only by voting contract)
    function createCampaign(
        address rewardToken_,
        uint256 rewardAmount_,
        bytes32 merkleRoot_,
        uint256 startTimestamp_,
        uint256 endTimestamp_
    ) external onlyVotingContract returns (uint256) {
        return _createCampaign(rewardToken_, rewardAmount_, startTimestamp_, endTimestamp_, merkleRoot_);
    }

    // Claim rewards from a specific campaign
    function claimReward(
        uint256 campaignId_,
        address account_,
        bytes32[] calldata merkleProof_
    ) external {
        _claimReward(campaignId_, account_, merkleProof_);
    }

    // Check permission function from the IDAOResource interface (always returns true for simplicity)
    function checkPermission(
        address /*member_*/,
        string calldata /*permission_*/
    ) external pure returns (bool) {
        return true;
    }

    // Get the resource name associated with this contract (IDAOResource interface)
    function getResource() external pure returns (string memory) {
        return AIR_DROP_V2_RESOURCE;
    }
}
```

## That’s a wrap

In this lesson, you learned to improve the Airdrop first version. In next lesson, we will move onto deploying the `AirDropV2` module on Q blockchain.