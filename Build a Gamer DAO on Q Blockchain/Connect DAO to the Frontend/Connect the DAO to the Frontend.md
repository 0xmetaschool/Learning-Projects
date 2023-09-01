# Connect the DAO to the Frontend

Welcome back! I’m so proud of you that you have built your own DAO on Q blockchain and finally you are at the last stage of the course where you will be connecting your DAO to the frontend. 

## Let’s get started

First, clone this [https://github.com/0xmetaschool/build-a-gamer-dao-q-boilerplate](https://github.com/0xmetaschool/build-a-gamer-dao-q-boilerplate) which is the frontend using the command, 

```
git clone [https://github.com/0xmetaschool/build-a-gamer-dao-q-boilerplate](https://github.com/0xmetaschool/build-a-gamer-dao-q-boilerplate)
```

Now run `cd build-a-gamer-dao-q-boilerplate` to go to the root folder of the frontend.

Next, let’s install the dependencies using the command, `yarn install` 

After the frontend is installed, let’s run the frontend using the command `yarn start`

![Untitled](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Connect%20DAO%20to%20the%20Frontend/Connect%20the%20DAO%20to%20the%20Frontend/Untitled.png?raw=true)

Now paste the `DAO_REGISTRY_ADDRESS` you have copied in to the search DAO field to connect to your DAO

Congrats, you have successfully connected your DAO to the frontend and you will now be able to interact with your DAO.

![Untitled](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Connect%20DAO%20to%20the%20Frontend/Connect%20the%20DAO%20to%20the%20Frontend/Untitled%201.png?raw=true)

## Let’s create a AirDropV2 proposal

Now since we have connected our DAO to the frontend let’s create a AirDropV2 proposal which will create an airdrop campaign and the DAO members can vote for or against the campaign. Once the campaign is passed and executed, the whitelisted addresses will be able to claim the DAO token exactly like we did for AirDropV1

First, go to Governance and click on Create proposal

![Untitled](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Connect%20DAO%20to%20the%20Frontend/Connect%20the%20DAO%20to%20the%20Frontend/Untitled%202.png?raw=true)

select AirDropV2 as proposal type and click on next and add the campaign details

![Untitled](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Connect%20DAO%20to%20the%20Frontend/Connect%20the%20DAO%20to%20the%20Frontend/Untitled%203.png?raw=true)

You will find the reward token address on the Dashboard of the DAO, reward amount is the amount of token needs to be airdropped per user and lastly we need to fill in at least two addresses and click add address one by one after inputting every address and finally click next and submit the transaction

Now simply vote on the proposal and once its passed execute the proposal, make sure you execute the proposal with 1-2 min after the voting ends or else the execution period will end.

Once the proposal is executed, the whitelisted address can connect their wallet and claim their DAO token.

## That’s a wrap

In summary, we have connected our DAO to the frontend and interacted with the Airdrop module which we have added to our DAO