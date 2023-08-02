// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity ^0.8.19;

import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

import {TokenBalance} from "./TokenBalance.sol";

/**
 * @title Abstract CampaignAirDrop contract
 *
 * This abstract AirDrop contract is the foundation for the AirDrop V2 and V3 contracts.
 * A noticeable improvement has been made with the introduction of the Campaign structure.
 *
 * Several campaigns can be created, each with different tokens and reward amounts.
 * In addition, you can specify start and end dates for each campaign.
 *
 * This contract also provides validation for each campaign entry.
 *
 * Any Air Drop event can be created with reward token of ERC20 type or Native token.
 * To specify native token as reward token, use ETHEREUM_ADDRESS constant from Globals.
 */
abstract contract ACampaignAirDrop {
    using MerkleProof for bytes32[];

    /**
     * @notice This struct represents a campaign.
     * @param id The campaign ID. Starts at 1.
     * @param rewardToken The address of the token to be distributed.
     * @param rewardAmount The amount of tokens to be distributed.
     * @param startTimestamp The timestamp when the campaign starts.
     * @param endTimestamp The timestamp when the campaign ends.
     * @param merkleRoot The merkle root of the campaign.
     */
    struct Campaign {
        uint256 id;
        address rewardToken;
        uint256 rewardAmount;
        uint256 startTimestamp;
        uint256 endTimestamp;
        bytes32 merkleRoot;
    }

    /**
     * @notice This event is emitted when a campaign is created or updated.
     */
    event CampaignSet(uint256 indexed campaignId, Campaign campaign);

    event RewardClaimed(uint256 indexed campaignId, address indexed account);

    uint256 public campaignCount;

    // campaignId => Campaign
    mapping(uint256 => Campaign) public campaigns;

    // campaignId => account => claimed
    mapping(uint256 => mapping(address => bool)) public isUserClaimed;

    modifier onlyExistingCampaign(uint256 campaignId_) {
        require(campaigns[campaignId_].id != 0, "ACampaignAirDrop: campaign does not exist.");
        _;
    }

    modifier onlyNotClaimed(uint256 campaignId_, address account_) {
        require(
            !isUserClaimed[campaignId_][account_],
            "ACampaignAirDrop: user already claimed reward."
        );
        _;
    }

    modifier onlyWhitelistedUser(
        uint256 campaignId_,
        address user_,
        bytes32[] calldata merkleProof_
    ) {
        require(
            isWhitelistedUser(campaignId_, user_, merkleProof_),
            "ACampaignAirDrop: user is not whitelisted."
        );
        _;
    }

    /**
     *  @notice The function to check if the leaf belongs to the Merkle tree
     *  @param campaignId_  the campaign from which to get the Merkle root
     *  @param leaf_ the leaf to be checked
     *  @param merkleProof_ the path from the leaf to the Merkle tree root
     *  @return true if the leaf belongs to the Merkle tree, false otherwise
     */
    function isWhitelisted(
        uint256 campaignId_,
        bytes32 leaf_,
        bytes32[] calldata merkleProof_
    ) public view returns (bool) {
        return merkleProof_.verifyCalldata(campaigns[campaignId_].merkleRoot, leaf_);
    }

    /**
     *  @notice The function to check if the user belongs to the Merkle tree
     *  @param campaignId_ the campaign from which to get the Merkle root
     *  @param user_ the user to be checked
     *  @param merkleProof_ the path from the user to the Merkle tree root
     *  @return true if the user belongs to the Merkle tree, false otherwise
     */
    function isWhitelistedUser(
        uint256 campaignId_,
        address user_,
        bytes32[] calldata merkleProof_
    ) public view returns (bool) {
        return isWhitelisted(campaignId_, keccak256(abi.encodePacked(user_)), merkleProof_);
    }

    /**
     * @notice This is default function to create a campaign.
     *
     * For more information see the description for this contract.
     */
    function _createCampaign(
        address rewardToken_,
        uint256 rewardAmount_,
        uint256 startTimestamp_,
        uint256 endTimestamp_,
        bytes32 merkleRoot_
    ) internal virtual returns (uint256) {
        uint256 campaignId_ = ++campaignCount;

        _validateAndSetCampaign(
            campaignId_,
            rewardToken_,
            rewardAmount_,
            startTimestamp_,
            endTimestamp_,
            merkleRoot_
        );

        return campaignId_;
    }

    /**
     * @notice This is default function to claim a reward by account.
     *
     * Checks for campaign existence, if the user has already claimed the reward, and if
     * the user is whitelisted are provided.
     *
     * Also checks if user is claiming the reward within the campaign start and end dates.
     */
    function _claimReward(
        uint256 campaignId_,
        address account_,
        bytes32[] calldata merkleProof_
    )
        internal
        virtual
        onlyExistingCampaign(campaignId_)
        onlyNotClaimed(campaignId_, account_)
        onlyWhitelistedUser(campaignId_, account_, merkleProof_)
    {
        require(
            block.timestamp >= campaigns[campaignId_].startTimestamp,
            "ACampaignAirDrop: campaign is not started yet."
        );

        require(
            block.timestamp <= campaigns[campaignId_].endTimestamp,
            "ACampaignAirDrop: campaign has already ended."
        );

        isUserClaimed[campaignId_][account_] = true;

        Campaign storage campaign = campaigns[campaignId_];

        TokenBalance.sendFunds(campaign.rewardToken, account_, campaign.rewardAmount);

        emit RewardClaimed(campaign.id, account_);
    }

    function _validateAndSetCampaign(
        uint256 campaignId_,
        address rewardToken_,
        uint256 rewardAmount_,
        uint256 startTimestamp_,
        uint256 endTimestamp_,
        bytes32 merkleRoot_
    ) internal returns (uint256) {
        _validateCampaign(
            rewardToken_,
            rewardAmount_,
            startTimestamp_,
            endTimestamp_,
            merkleRoot_
        );

        Campaign storage campaign = campaigns[campaignId_];

        campaign.id = campaignId_;
        campaign.rewardToken = rewardToken_;
        campaign.rewardAmount = rewardAmount_;
        campaign.startTimestamp = startTimestamp_;
        campaign.endTimestamp = endTimestamp_;
        campaign.merkleRoot = merkleRoot_;

        emit CampaignSet(campaignId_, campaign);

        return campaignId_;
    }

    function _validateCampaign(
        address rewardToken_,
        uint256 rewardAmount_,
        uint256 startTimestamp_,
        uint256 endTimestamp_,
        bytes32 merkleRoot_
    ) internal view {
        require(
            startTimestamp_ >= block.timestamp,
            "ACampaignAirDrop: start time must be in the future."
        );
        require(
            endTimestamp_ > startTimestamp_,
            "ACampaignAirDrop: end time must be after start time."
        );
        require(merkleRoot_ != bytes32(0), "ACampaignAirDrop: merkle root is zero.");
        require(rewardToken_ != address(0), "ACampaignAirDrop: reward token is invalid.");
        require(rewardAmount_ > 0, "ACampaignAirDrop: reward amount is zero.");
    }
}
