// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity 0.8.19;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";


import "@q-dev/gdk-contracts/interfaces/tokens/IQRC20.sol";
import "@q-dev/gdk-contracts/metadata/ContractMetadata.sol";

/**
 * @title QRC20
 *
 * Regular ERC20 token with additional features:
 * - minting and burning
 * - total supply cap
 * - contract metadata
 */
contract QRC20 is IQRC20, ERC20Upgradeable, ContractMetadata, OwnableUpgradeable{
    string public QRC20_RESOURCE;
    uint256 public totalSupplyCap;
    uint8 internal _decimals;

    function initialize(
        string calldata name_,
        string calldata symbol_,
        uint8 decimals_,
        string calldata contractURI_,
        string calldata resource_,
        uint256 totalSupplyCap_
    ) public initializer {
        __ERC20_init(name_, symbol_);
        __ContractMetadata_init(contractURI_);
        QRC20_RESOURCE = resource_;
        _decimals = decimals_;
        totalSupplyCap = totalSupplyCap_;

        //Set Owner
        __Ownable_init();
    }

    modifier onlyChangeMetadataPermission() override {
        _checkOwner();
        _;
    }

    function mintTo(address account, uint256 amount) external override onlyOwner {
        require(totalSupplyCap == 0 || totalSupply() + amount <= totalSupplyCap, "[QGDK-015000]-The total supply capacity exceeded, minting is not allowed.");
        _mint(account, amount);
    }

    function burnFrom(address account, uint256 amount) external override {
        if (account != msg.sender) {
            _spendAllowance(account, msg.sender, amount);
        }
        _burn(account, amount);
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }
}
