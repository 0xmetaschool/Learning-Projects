# Deploy Your DAO on Q Blockchain

Welcome back! You were awesome while coding and building the DAO in Solidity. In this lesson, you will learn to compile and deploy your DAO on Q blockchain. Let’s continue this awesome journey!

## Let’s compile, deploy and interact

Remember you made a file `MyFirstDAO.sol` in Remix IDE? It’s time to compile and deploy it.

Let’s hover to the Solidity compiler. The Solidity compiler is the 3rd icon in the list of icons at the side bar. It’s the icon under the Search icon on the left hand. 

Next, you’ll notice the compiler version set in the compiler is not right. Let’s select the auto compile flag, which will automatically set the version and compile your contract as well.

> **Note:** In your case, if the box is already selected don’t unselect it.
> 

![Frame 3560339 (5).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO/Deploy%20Your%20DAO%20on%20Q%20Blockchain/Frame_3560339_(5).jpg?raw=true)

Now, I will show you how to deploy your DAO, but before that you need to connect Remix IDE to your MetaMask account.

- Click on the Ethereum icon that is below the compile icon in the left side bar.
- Click and scroll through the “Environment” bar and select “Injected Provider - MetaMask.”
- The MetaMask page will appear. Click on “Next” and “Connect” to finally connect your MetaMask to Remix IDE.

Now, let’s look at this happening live.

![Screen Recording GIF.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO/Deploy%20Your%20DAO%20on%20Q%20Blockchain/Screen_Recording_GIF.gif?raw=true)

Now, we will officially deploy the DAO.

- Click on the orange “Deploy” button to deploy your contract.
- Click on “Confirm” to confirm the transaction from your MetaMask.

Let’s look at this happening live in the following GIF.

![Frame 3560364 (6).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO/Deploy%20Your%20DAO%20on%20Q%20Blockchain/Frame_3560364_(6).gif?raw=true)

## Interact with DAO

Great work! I hope you have deployed your contract now. Now you can interact with the DAO. Let’s jump into it right away.

Let’s go to the “Deployed Contracts” section and then do the following:

- Open MetaMask and copy your account address.
- Paste the account address to the input field next to of `addMember`.
- Click on `addMember`.
- Click on “Confirm” in your MetaMask to approve the transaction.
- You will see the successful transaction completed in the logs at the bottom of the remix interface.
    
    ![Frame 3560364 (7).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO/Deploy%20Your%20DAO%20on%20Q%20Blockchain/Frame_3560364_(7).gif?raw=true)
    

Now let’s try out the `createProposal` function:

- Provide any string in the input field in front of `createProposal`. I have used `metaschool x q`.
- Click on `createProposal`.
- Click on “Confirm” in your MetaMask to approve the transaction.
- You will see the successful transaction completed in the logs.
    
    ![Frame 3560364 (8).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO/Deploy%20Your%20DAO%20on%20Q%20Blockchain/Frame_3560364_(8).gif?raw=true)
    

Now let’s try out the `vote` function:

- First we need the `_proposalId` that was generated as a result of executing `createProposal` function. We can find it in the logs, to expand the transaction logs, click on arrow icon next to the “Debug” button.
    
    ![Frame 3560364 (9).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO/Deploy%20Your%20DAO%20on%20Q%20Blockchain/Frame_3560364_(9).gif?raw=true)
    
- Expand the `vote` function in the list of functions on the left.
- Add value of `_proposalId`. In my case, it is `0`.
- Add the amount you want to vote with to the `_tokenAmount`. I am adding `20`. Notice, that it needs to be below 100, because as you remember from our previous section, each member starts with 100 tokens.
- Click on the “transact” button.
- Click on “Confirm” to approve the transaction.
- You will see the successful transaction completed in the logs.
    
    ![Frame 3560364 (10).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO/Deploy%20Your%20DAO%20on%20Q%20Blockchain/Frame_3560364_(10).gif?raw=true)
    

A small task for you now: try other functions too! 💪🏼

## That’s a wrap

Phew! You’ve done it! It was a long process but I’m so glad that you made it this far! And I salute your patience for following each and every step. That’s pretty much it for building DAO.

In the next section, we will optimize building a DAO and you will be amazed at how Q makes our life easier!
