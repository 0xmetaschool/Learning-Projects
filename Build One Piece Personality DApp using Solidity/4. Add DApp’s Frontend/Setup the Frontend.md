# Set Up the Frontend Project

Welcome back! I’m so proud of you that you have so far and finally, you are at the last stage of the course where you will connect your dApp to the front end. 

## Set your project

Open your terminal and run the following commands. You can run the commands either inside the `one-piece-dapp` folder or outside of the folder.

```
git clone https://github.com/0xmetaschool/one-piece-frontend-boilerplate.git
cd one-piece-frontend-boilerplate
npm install
```

Now create `.env` file in the `one-piece-frontend-boilerplate` and paste the following content into it:

```
REACT_APP_CONTRACT_ADDRESS=<your-contract-address>
REACT_APP_SUBGRAPH_URL=<your-subgraph-url>
```

Replace `<your-contract-address>` with your contract address.

## Create subgraph

Now let’s create the subgraph using Graph Studio.

- Head over to [https://thegraph.com/studio/](https://thegraph.com/studio/).
- Connect your Metamask account and sign the transaction.
- Now verify your email to proceed
    
    ![Screen Recording 2024-03-11 at 5.07.02 PM.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Set%20Up%20the%20Frontend%20Project/Screen_Recording_2024-03-11_at_5.07.02_PM.webp?raw=true)
    
- Now click on “Create a subgraph”.
- Add the name and create it.
    
    ![Screen Recording 2024-03-11 at 5.08.25 PM.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Set%20Up%20the%20Frontend%20Project/Screen_Recording_2024-03-11_at_5.08.25_PM.webp?raw=true)
    

- Now scroll down and look at the right panel of your screen, you will see the set of commands. We need to run them.
    
    ![Frame 3560371 (3).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Set%20Up%20the%20Frontend%20Project/Frame_3560371_(3).webp?raw=true)
    

- **Important**: Please note that I’ll be running the commands shown to me according to my subgraph, you have to run according to yours. In the steps below, I’ll help you with the inputs that the commands ask. So follow me and let’s go!

I’ll run the commands with you and guide you what steps you have to follow. Ikuzou~

- First of all, install the CLI. You can either use npm or yarn. I used yarn, so go to this [link](https://classic.yarnpkg.com/lang/en/docs/install/#mac-stable) if you want to install yarn.
    
    ```
    npm install -g @graphprotocol/graph-cli
    // or run the following
    yarn global add @graphprotocol/graph-cli
    ```
    
- Next, is the `init` command. The command is designed according to whatever your subgraph name is defined.
    
    ```
    graph init --studio one-piece
    ```
    
    - Select “ethereum” for Protocol.
    - Hit the Enter button for the next two options.
    - Find the “Arbitrum Sepolia” Network.
    - Paste your contract address.
    - Hit Enter for the Start Block option.
    - Give `OnePieceMint` for the contract name. If your smart contract name differs then provide that.
    - Select `Y` for the option “Index contract events as entities”.
    - Select `n` for the next option.
    - Here’s the final output of this command:
        
        ![Frame 3560382.jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Set%20Up%20the%20Frontend%20Project/Frame_3560382.webp?raw=true)
        
- Next is authenticate command, for me it shows `graph auth --studio 674cfa58b1f064d1b11f2ab99ff959db`. But for you, it’ll be different so copy yours and run it.
- Move to the directory we created using `init` command by `cd one-piece`.
- Run `graph codegen && graph build` to generate the code and build the graph.
- Finally, deploy your graph. For me the command is `graph deploy --studio one-piece`. But for you, it’ll be different so copy yours and run it. Provide version when prompted. Since it’s our first deployment version you can use `v0.0.1`.
    
    ![Frame 3560382 (1).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Set%20Up%20the%20Frontend%20Project/Frame_3560382_(1).webp?raw=true)
    
    - **Note**: If you are deploying it again, make sure to update the version number otherwise you’ll receive an error.
- As an output, you will see a URL at the end, replace `<your-subgraph-url>` in your `.env` file with it.
    
    ![Frame 3560382 (2).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Set%20Up%20the%20Frontend%20Project/Frame_3560382_(2).webp?raw=true)
    

## Run the dapp

Now it’s time to finally run it. Open the terminal or use the existing one. First move to the previous directory and then run the dapp:

```
cd ../ 
npm start
```

## Interact with dapp

And you can experience interacting with your dApp. And yes, Zoro is my favv characterrrr!! What about you?

![interact.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Set%20Up%20the%20Frontend%20Project/interact.webp?raw=true)

## Wrap up

In conclusion, this lesson guided you through the process of setting up the frontend of your dApp, creating a subgraph using Graph Studio, and deploying your graph. This is a crucial step in connecting your dApp with the front end. Great job on completing this complex task. By running the command `npm start` in the terminal, we can now interact with our dApp. This concludes our lesson.