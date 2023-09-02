# Connect the DAO to the Frontend

Welcome back! I’m so proud of you that you have built your own DAO on Q blockchain and finally you are at the last stage of the course where you will be connecting your DAO to the frontend. 

## Let’s get started

First, clone this [https://github.com/0xmetaschool/build-a-gamer-dao-q-boilerplate](https://github.com/0xmetaschool/build-a-gamer-dao-q-boilerplate), which is the frontend using the command:

```
git clone https://github.com/0xmetaschool/build-a-gamer-dao-q-boilerplate
```

Now run the following command to go to the root folder of the frontend:

```
cd build-a-gamer-dao-q-boilerplate
```

Next, let’s install `yarn` first using npm:

```
npm install --global yarn
```

Then we will install dependencies using the following command:

```
yarn install
```

After the frontend is installed, let’s run the frontend using the following command:

```
yarn start
```

You can view your frontend on [http://localhost:**3000**/](http://localhost:3000/):

![Frame 3560365 (23).jpg](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Connect%20DAO%20to%20the%20Frontend/Connect%20the%20DAO%20to%20the%20Frontend/Frame_3560365_(23).jpg)

Next, connect to your wallet by clicking “Connect Wallet”. (Make sure your Metamask is connected to Q Testnet.)

![Frame 3560365 (14).gif](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Connect%20DAO%20to%20the%20Frontend/Connect%20the%20DAO%20to%20the%20Frontend/Frame_3560365_(14).gif)

Remember the `DAO_REGISTRY_ADDRESS` you copied in the lesson “Build DAO Using the Q DAO Factory”. Paste it to the search DAO field to connect to your DAO. Once you are done, congrats, you have successfully connected your DAO to the frontend and now you can interact with your DAO.

![Frame 3560365 (15).gif](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Connect%20DAO%20to%20the%20Frontend/Connect%20the%20DAO%20to%20the%20Frontend/Frame_3560365_(15).gif)

## Let’s create a AirDropV2 proposal

Now since we have connected our DAO to the frontend let’s create a AirDropV2 proposal which will create an airdrop campaign and the DAO members can vote for or against the campaign. Once the campaign is passed and executed, the whitelisted addresses will be able to claim the DAO token exactly like we did for AirDropV1.

First, go to Governance (3rd option on left panel) and then click on “Create proposal”:

![Frame 3560365 (26).jpg](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Connect%20DAO%20to%20the%20Frontend/Connect%20the%20DAO%20to%20the%20Frontend/Frame_3560365_(26).jpg)

- **Note**: Make sure your Total Voting Weight is not zero, otherwise you will not be able to create AirDrop module. In case your total voting weight is zero, follow the steps given below:
    1. Go to “Voting Power” which is the 2nd option on your left panel.
    2. Click on “Max” in the **Deposit** tab and then click Deposit.
    3. Approve the transaction.
    4. Again click on “Max” in the **Deposit** tab and then click Deposit.
    5. Approve the transaction and verify your Total Voting Weight has increased.

After clicking on “Create proposal”, follow the steps given below:

- Select AirDropV2 as proposal type and click on Next.
- The reward token address will be autofilled but you can find it on the Dashboard of the DAO.
- The reward amount is the amount of token needs to be airdropped per user. Currently, it is autofilled to 1, you can change it however you want it to.
- For the next step, you need two addresses, make sure to have them. I am using one mine and other of a friend. Add address and then click “Add Address”, add another address and click “Add Address”.
- Click on Next.
- Click on Submit to submit the transaction. See the following gif where I have followed all steps:
    
    ![Screen Recording 2023-09-02 at 12.21.06 PM.gif](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Connect%20DAO%20to%20the%20Frontend/Connect%20the%20DAO%20to%20the%20Frontend/Screen_Recording_2023-09-02_at_12.21.06_PM.gif)
    
- Now see your local folder, you will find `tree.json` there. For me, I found it in my Downloads folder.
    
    ![Frame 3560364 (32).jpg](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Connect%20DAO%20to%20the%20Frontend/Connect%20the%20DAO%20to%20the%20Frontend/Frame_3560364_(32).jpg)
    

Now open your frontend code in your IDE or Visual Studio. Open `src/artifacts/tree.json` to edit. Replace the content of `tree.json` with the one that was downloaded in your local folder.

Next simply vote on the proposal and once its passed execute the proposal, make sure you execute the proposal with 1-2 min after the voting ends or else the execution period will end.

Once the proposal is executed, the whitelisted address can connect their wallet and claim their DAO token. 

## That’s a wrap

In summary, we have connected our DAO to the frontend and interacted with the Airdrop module which we have added to our DAO. Wohoo! And we are done, yayy!!!