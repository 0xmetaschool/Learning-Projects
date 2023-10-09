# Build DAO Using the Q DAO Factory

Hey folks, welcome back! Now that we have created the QRC20 token, we will use the contract address to create the DAO using Q DAO Factory. Let’s first understand what exactly is Q DAO Factory and then follow along the steps to create the DAO.

## What the hell is Q DAO Factory

Using the Q DAO Factory, users can create their own DAO with specific governance mechanisms, veto rights, and other features. It provides a framework for establishing rules and voting systems that enable the community members or token holders to participate in decision-making processes within the organization.

## Build a DAO using the Q DAO Factory

Follow along to build a DAO in easy steps.

- **Head over to the Q DAO Factory:** First of all, head over to this website: [https://factory.q-dao.tools/](https://factory.q-dao.tools/). The following page will appear.

![Frame 3560339 (23).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560339_(23).webp)

- **Switch network and connect your wallet:**
    - Click on “Testnet” button to switch to the Q Testnet network from the Mainnet network.
    - Then connect to MetaMask wallet by clicking on “Connect wallet” button. Please do make sure that your MetaMask network is the Q Testnet network that we added in the last section.
        
        ![ezgif.com-optimize (18).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/ezgif.com-optimize_(18).gif?raw=true)
        

- **Name your DAO:**
    - Step 1 is to name your DAO and state the purpose of why are you creating the DAO.
    - Fill out the following fields and move to the next step.
    
    ![Frame 3560364 (15).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(15).webp)
    

- **Define who is part of your DAO:** Here, you need to define the token for your DAO.
    - In the last lesson remember we copied our contract address after deploying our own token. Select “Use an existing Token” and paste the token address here.
    - But as you can see, it's also possible to create a new token in the DAO factory, without deploying it manually as we just did.
    - The token we added will be used as a native token for your DAO.
    - The tokens will be used for voting on proposals within the DAO. Every token will count as one vote. So, a DAO Member with 10 tokens will have 10 votes.

![Frame 3560364 (16).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(16).webp)

**Note:** The steps may get randomised in the Q DAO Factory, if you encounter any step that is not the next step in this lesson, please feel free to scroll through the lesson and find the appropriate step for you to follow along.

- **Enable representatives**:
    - In step 3, you can select the “Enable Representatives” option.
    - Enabling the representatives option will help present your DAO to the world via DAO members.
    - In the back, this creates the option for the DAO members to elect one or more members to represent the DAO. For now, we don’t need this.
    - You can always add such functions to your DAO later within your DAO constitution. But more to that later.
    - For now, we can leave it un-selected and move to the next option.
    
    ![Frame 3560364 (17).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(17).webp)
    

- **Add Expert or Expert Panel:**
    - Expert Panels are sometimes also called “roles” or” sub-DAOs”.
    - An expert panel can be **one or more people** which are appointed by the DAO. That means the DAO members can vote on who shall be in an expert panel.
    - Expert Panels can have their own proposals and decisions in the DAO.
    - You can use Expert panels for structuring your DAO, or if there are decisions that not everyone cares about.
    - Here we create one Expert Panel, the “Metaschool OGs”, and their purpose shall be to support the Metaschool DAO community.
    - You can add the Expert Panel of your choice.
    
    ![ezgif.com-optimize (19).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/ezgif.com-optimize_(19).gif?raw=true)
    

- **Set up the Governance Structure:**
    - This is just the break point which is informing you that in next steps you will decide the Governance structure of the DAO.
    - Governance structure is about defining the structure of your DAO.
    - For example, defining how the voting system will work in the DAO, how to ensure transparency, and fairness for everyone in the DAO, so that everyone’s know what’s going on in the DAO and what decisions are made.
    - We can also choose here what types of proposals the Expert Panels can decide on. Our “Metaschool OGs” Panel shall have both options: voting on general topics, and also being able to save their own “Expert Parameters” on the blockchain which only they can change.
    - Keep the options selected here and move to the next section by clicking on the “Next” button.
    
    ![Frame 3560364 (18).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(18).webp)
    

- **Set Checks and Balances**:
    - This option allows you to set Veto power to already defined roles.
    - If you do not want to give such power to any user, you can just continue.
    - We are not setting it up here, by choosing the “No, continue” option.
    
    ![Frame 3560364 (19).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(19).webp)
    

- **Customize the veto for some proposals**:
    - If you have not added any members with Veto power, you can continue with “No Veto”.
    - But if you want one of your Expert Panels to have a veto, you can set it here.
    - For now, we will allow the “Metaschool OGs” Panel to have a veto on “Constitution Vote” decisions, but not on anything else.
    - The Constitution Vote can be used to change the Settings of the DAO, like voting durations or the majority needed for a vote to be “passed”.
    - Select “No Veto” everywhere, but “Metaschool OGs” for Constitution Votes.
    
    ![ezgif.com-optimize (20).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/ezgif.com-optimize_(20).gif?raw=true)
    

- **Add a DAO Treasury**:
    - A DAO is like a special club where lots of people come together to make decisions and do cool things.
    - If they want, they can put money in a big pot called the treasury to use for important projects.
    - This treasury could be a smart contract that the members can vote on for spending the money, but it could also be Gnosis Safe or just a wallet of one of the members.
    - Here, you can add the address of your DAO Treasury if you already have one. It will then be transparently set as a DAO Parameter for everyone to see.
    - We will later show you how to add something like a treasury module to the DAO to manage it with everyone together.
    - So, for now, let’s continue without a treasury.
    
    ![Frame 3560364 (20).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(20).webp)
    

- **Does your DAO need a Constitution?**:
    - The constitution of the DAO is a document that represents the complete structure of the DAO, who is a member, which members have which role (remember the Expert Panel we created), who has how much voting power, etc.
    - If you want to specify a constitution for DAO from the start just select the option, else continue by clicking in “Next” button.
    - You can always add a constitution later by voting, and because the focus of this tutorial is on creating a DAO and not a constitution, we will continue without it for now.
    
    ![Frame 3560364 (21).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(21).webp)
    

Phew! Now we are done with specifying all the requirements for our DAO and we did not write even a single piece of code. And our DAO now can do way more than the the one we wrote earlier. How cool and easy it is!

Once you are done specifying all nitty gritty details of your DAO, the Q DAO Factory will show you the summary of your DAO details. 

- Click on Submit. After clicking, Q will run transactions for each components to deploy them separately.
- Make sure to select “Regular Deploy” and approve all transactions by clicking “Confirm” when MetaMask prompts pops up to ensure full functionality of your DAO.
- If nothing seems to happen, but you see a small “1” in your Metamask icon, open the add-on and confirm the pending transactions.
    
    
    ![Screen Recording 2023-08-08 at 1.00.04 PM.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Screen_Recording_2023-08-08_at_1.00.04_PM.gif?raw=true)
    
- Before moving on, let’s copy the DAO Registry address and paste it in our HardHat project `.env` file in the following format.

```
DAO_REGISTRY_ADDRESS = "YOUR-DAO-REGISTRY-ADDRESS
```

- After approving all transactions, you will see a window similar to below. Click on “Go to DAO Dashboard” to view your dashboard that you can use to manage your DAO.

![Frame 3560364 (22).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(22).webp)

- After clicking on “Go to DAO Dashboard”, you will see a window similar to below. Here, you can mint your DAO Token, and create and vote on proposals.

![Frame 3560364 (23).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/4.%20Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(23).webp)

## That’s a wrap

And that's a wrap! You've just learned how to use the amazing Q Factory tool to create your very own DAO. Whether you're building the next big decentralized organization or just experimenting with blockchain technology, this tool can make the process easy, fun, and less time-consuming. So go forth and create, innovate, and decentralize! 

If you want to check out the Metaschool DAO we just created, you can find it here on [testnet](https://hq.q-dao.tools/0x611B1aaf2086afcFEf7F7b44090b384BB5b5f033).

**Assignment**: Share the screenshot of your DAO that you created using Q DAO Factory.

**Assignment description**: Do share with us.