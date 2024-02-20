# Build the Marketplace - II

Welcome back, folks! Great work on creating and starting to write the code for the marketplace. In this lesson, we will complete the code for our marketplace. Let’s resume!

## Resume Coding

Open `NFTMarketplace.sol` file and resume writing the code in it.

```
function listItemWithPermit(
        address nftAddress,
        uint256 amount, 
        uint256 price,
        uint256 deadline,
        uint8 v, bytes32 r, bytes32 s   
        ) external notListed(nftAddress) {
            
        IDN404 nft = IDN404(nftAddress);

        nft.permit(_msgSender(), address(this), amount, deadline, v, r, s);

        if(nft.allowance(_msgSender(), address(this)) < amount){
            revert NotApproved();
        }

        // Store the listing information
        s_listings[nftAddress] = Listing(price, _msgSender());

        // Emit event
        emit LogItemListed(_msgSender(), nftAddress, price);

        counter++;
    }
```

- This is a function named `listItemWithPermit`.
- It is external, meaning it can be called from outside the contract.
- It takes seven parameters:
    - `nftAddress`: The address of the NFT contract.
    - `amount`: The amount of the NFT to be listed.
    - `price`: The price at which to list the NFT.
    - `deadline`: The deadline for the permit.
    - `v`, `r`, `s`: Components of the permit signature.
- It has a modifier `notListed(nftAddress)`, ensuring that the NFT is not already listed before proceeding.

- `IDN404 nft = IDN404(nftAddress);`: Declares a local variable `nft` of type `IDN404`, representing the NFT contract at `nftAddress`.

- `nft.permit(_msgSender(), address(this), amount, deadline, v, r, s);`
    - Calls the `permit` function of the NFT contract.
    - This function may be a part of an ERC-20 permit mechanism, allowing approval to transfer tokens on behalf of the owner without a separate `approve` transaction.
    - It takes arguments `spender`, `recipient`, `amount`, `deadline`, `v`, `r`, and `s`, likely used for permit signature verification.

- `if(nft.allowance(_msgSender(), address(this)) < amount){revert NotApproved();}`
    - Check if the allowance granted by the `_msgSender()` to the contract (`address(this)`) is less than `amount`.
    - If the condition is not met, revert the transaction with the error `NotApproved()`, indicating that the permit is not approved for the required amount.
- `s_listings[nftAddress] = Listing(price, _msgSender());`:
    - Stores the listing information in the `s_listings` mapping.
    - Associates the `nftAddress` with a new `Listing` struct containing `price` and the address of the `_msgSender()`.

- `emit LogItemListed(_msgSender(), nftAddress, price);`: Emits the `LogItemListed` event with the seller's address (`_msgSender()`), the NFT's address (`nftAddress`), and the listing `price`.

- `counter++;}`: Increments the `counter` variable, likely indicating the number of listings in the marketplace.

```
function cancelListing(address nftAddress)
        external
        isOwner(nftAddress, _msgSender())
        isListed(nftAddress)
    {
        delete s_listings[nftAddress];
        emit LogItemCanceled(_msgSender(), nftAddress);
    }
```

- This is a function named `cancelListing`.
- It is external, meaning it can be called from outside the contract.
- It takes one parameter:
    - `nftAddress`: The address of the NFT contract to cancel the listing for.
- It has two modifiers applied:
    - `isOwner(nftAddress, _msgSender())`: Ensures that the caller (`_msgSender()`) is the owner of the NFT at `nftAddress`.
    - `isListed(nftAddress)`: Ensures that the NFT at `nftAddress` is currently listed for sale.
- `delete s_listings[nftAddress];`:Deletes the listing of the NFT at `nftAddress` from the `s_listings` mapping, effectively canceling the listing.
- `emit LogItemCanceled(_msgSender(), nftAddress);`: Emits the `LogItemCanceled` event with the address of the caller (`_msgSender()`) and the address of the canceled NFT (`nftAddress`).

```
function buyItem(address nftAddress, uint256 fraction)
        external
        payable
        isListed(nftAddress)
    {
        Listing memory listedItem = s_listings[nftAddress];
        require(msg.value >= listedItem.price, "Price not met");

        s_proceeds[listedItem.seller] += msg.value;
        delete s_listings[nftAddress];
        IDN404(nftAddress).transferFrom(listedItem.seller, _msgSender(), fraction);
        emit LogItemBought(_msgSender(), nftAddress, listedItem.price, fraction);
    }
```

- This is a function named `buyItem`.
- It takes two parameters:
    - `nftAddress`: The address of the NFT contract to buy.
    - `fraction`: The fraction or portion of the NFT to buy.
- It is payable, indicating that Ether can be sent along with the function call.
- It has a modifier `isListed(nftAddress)`, ensuring that the NFT at `nftAddress` is listed for sale.
- `Listing memory listedItem = s_listings[nftAddress];`: Declares a local variable `listedItem` of type `Listing` and assigns it the value retrieved from the `s_listings` mapping using `nftAddress`.
- `require(msg.value >= listedItem.price, "Price not met");`: Ensures that the amount of Ether (`msg.value`) sent with the function call is greater than or equal to the price of the listed item.
- If the condition is not met, it reverts the transaction with the error message "Price not met".
- `s_proceeds[listedItem.seller] += msg.value;`: Increments the proceeds of the seller (`listedItem.seller`) by the amount of Ether (`msg.value`) sent by the buyer.
- `delete s_listings[nftAddress];`: Deletes the listing of the NFT at `nftAddress` from the `s_listings` mapping, indicating that it has been sold.
- `IDN404(nftAddress).transferFrom(listedItem.seller, _msgSender(), fraction);`: Transfers the specified `fraction` of the NFT from the seller (`listedItem.seller`) to the buyer (`_msgSender()`) using the `transferFrom` function of the NFT contract at `nftAddress`.
- `emit LogItemBought(_msgSender(), nftAddress, listedItem.price, fraction);`: Emits the `LogItemBought` event with the buyer's address (`_msgSender()`), the address of the purchased NFT (`nftAddress`), the price at which it was bought (`listedItem.price`), and the fraction bought (`fraction`).

```
function withdrawProceeds() external {
        uint256 proceeds = s_proceeds[_msgSender()];
        require(proceeds > 0, "No proceeds");
        s_proceeds[_msgSender()] = 0;

        (bool success, ) = payable(_msgSender()).call{value: proceeds}("");
        require(success, "Transfer failed");
    }
```

- This is a function named `withdrawProceeds`.
- It is external, meaning it can be called from outside the contract.
- It doesn't take any parameters.
- `uint256 proceeds = s_proceeds[_msgSender()];`: Retrieves the proceeds (amount of Ether) available for withdrawal by the caller (`_msgSender()`) from the `s_proceeds` mapping and assigns it to the local variable `proceeds`.

- `require(proceeds > 0, "No proceeds");`
    - Ensures that there are proceeds available for withdrawal.
    - If `proceeds` is not greater than 0, it reverts the transaction with the error message "No proceeds".
- `s_proceeds[_msgSender()] = 0;`: Sets the proceeds of the caller (`_msgSender()`) to 0, effectively marking them as withdrawn.

`(bool success, ) = payable(_msgSender()).call{value: proceeds}("");
require(success, "Transfer failed");`

- Attempts to transfer the `proceeds` amount of Ether to the caller (`_msgSender()`).
- The `payable(_msgSender())` expression converts the caller's address to a payable address, allowing it to receive Ether.
- The `call{value: proceeds}("")` statement invokes the `call` function on the payable address, sending the specified amount of Ether.
- It captures the success status of the transfer in the `success` variable.
- If the transfer is successful, `success` will be `true`.
- If the transfer fails, it reverts the transaction with the error message "Transfer failed".

```
function getListing(address nftAddress)
        external
        view
        returns (Listing memory)
    {
        return s_listings[nftAddress];
    }

    function getProceeds(address seller) external view returns (uint256) {
        return s_proceeds[seller];
    }

    function numListings() external view returns (uint256) {
        return counter;
    }
}
```

- This is a function named `getListing`.
- It is external and view, meaning it can be called from outside the contract and doesn't modify the contract state.
- It takes one parameter:
    - `nftAddress`: The address of the NFT contract.
- It returns a `Listing` struct from the `s_listings` mapping corresponding to the given `nftAddress`.

```
    function getProceeds(address seller) external view returns (uint256) {
        return s_proceeds[seller];
    }
```

- This is a function named `getProceeds`.
- It is external and view, meaning it can be called from outside the contract and doesn't modify the contract state.
- It takes one parameter:
    - `seller`: The address of the seller.
- It returns the proceeds (amount of Ether) available for withdrawal by the given `seller` from the `s_proceeds` mapping.

```
    function numListings() external view returns (uint256) {
        return counter;
    }
}
```

- This is a function named `numListings`.
- It is external and view, meaning it can be called from outside the contract and doesn't modify the contract state.
- It returns the value of the `counter` variable, which likely represents the number of listings in the marketplace.

## Complete code

You can find the complete code [here](https://github.com/Ash20pk/nftmarketplace/blob/main/contracts/NFTMarketplace.sol). 

## Wrap up

In this lesson, we explored the `NFTMarketplace.sol` contract code, understanding the implementation of key functions like listing, buying, and withdrawing proceeds. We also learned about ensuring contract integrity through checks and balances, using events for logging actions and retrieving data from the contract.

In the next lesson, we will deploy our code.