# Build DAO Using the Q DAO Factory

Hey folks, welcome back! So far you have learned all about the Q blockchain and DAOs. You have also created a DAO using your own code and the Remix tool which took all your energy and brain. But don’t worry! In this section, we will solve just that- so you don’t have to put all of your energy and time to create a DAO but do it with ease. Today we will learn about the Q DAO Factory. And then we will dive straight into using the DAO Factory tool for creating a DAO using easy peasy steps.

## Q DAO Factory

Using the Q DAO Factory, users can create their own DAO with specific governance mechanisms, veto rights, and other features. It provides a framework for establishing rules and voting systems that enable the community members or token holders to participate in decision-making processes within the organization.

## Build a DAO using the Q DAO Factory

Follow along to build a DAO in easy steps.

- **Head over to the Q DAO Factory:** First of all, head over to this website: [https://factory.q-dao.tools/](https://factory.q-dao.tools/). The following page will appear.
    
    ![Frame 3560339 (23).png](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(23).jpg?raw=true)
    

- **Switch network and connect your wallet:**
    - Click on “Testnet” button to switch to the Q Testnet network from the Mainnet network.
    - Then connect to MetaMask wallet by clicking on “Connect wallet” button. Please do make sure that your MetaMask network is the Q Testnet network that we added in the last section in last section.
        
        ![connect-wallet GIF.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/connect-wallet_GIF.gif?raw=true)
        

- **Name your DAO:**
    - Step 1 to creating a DAO is naming your DAO and stating the purpose of why are you creating the DAO.
    - Fill out the following fields and move to the next step.
    
    ![Frame 3560364 (15).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(15).jpg?raw=true)
    

- **Define who is part of your DAO:** Here, you need to define the token for your DAO.
    - In the last lesson remember we copied our contract address after deploying our own token. Select “Use an existing Token” and paste the token address here.
    - But as you can see, it's also possible to create a new token in the DAO factory, without deploying it manually as we just did.
    - The token we added will be used as a native token for your DAO.
    - The tokens will be used for voting on proposals within the DAO. Every token will count as one vote. So a DAO Member with 10 tokens will have 10 votes.
    
    ![Frame 3560364 (16).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(16).jpg?raw=true)
    

- **Enable representatives**:
    - In step 3, you can select the “Enable Representatives” option.
    - Enabling the representatives option will help present your DAO to the world via DAO members.
    - In the back, this creates the option for the DAO members to elect one or more members to represent the DAO. For now, we don’t need this.
    - You can always add such functions to your DAO later within your DAO Constitution. But more to that later.
    - For now, we can leave it un-selected and move to the next option.
    
    ![Frame 3560364 (17).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(17).jpg?raw=true)
    

- **Add Expert or Expert Panel:**
    - Expert Panels are sometimes also called “roles” or” sub-DAOs”.
    - An expert panel can be **one or more people** which are appointed by the DAO. That means the DAO members can vote on who shall be in an expert panel.
    - Expert Panels can have their own proposals and decisions in the DAO.
    - You can use Expert panels for structuring your DAO, or if there are decisions that not everyone cares about.
    - Here we create one Expert Panel, the “Metaschool OGs”, and their purpose shall be to support the Metaschool DAO community.
    - You can add the Expert Panel of your choice.
    
    ![Frame 3560364 (14).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(14).gif?raw=true)
    

- **Set up the Governance Structure:**
    - This is just the break point which is informing you that in next steps you will decide the Governance structure of the DAO.
    - Governance structure is about defining the structure of your DAO.
    - For example defining how the voting system will work in the DAO, how to ensure transparency and fairness for everyone in the DAO, so that everyone’s know what’s going on in the DAO and what decisions are made.
    - We can also choose here what types of proposals the Expert Panels can decide on. Our “Metaschool OGs” Panel shall have both options: voting on general topics, and also being able to save their own “Expert Parameters” on the blockchain which only they can change.
    - Keep the options selected here and move to the next section by clicking on the “Next” button.
    
    ![Frame 3560364 (18).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(18).jpg?raw=true)
    

- **Set Checks and Balances**:
    - This option allows you to set Veto power to already defined roles.
    - If you do not want to give such power to any user, you can just continue.
    - We are not setting it up here, by choosing the “No, continue” option.
    
    ![Frame 3560364 (19).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(19).jpg?raw=true)
    

- **Customize the veto for some proposals**:
    - If you have not added any members with Veto power, you can continue with “No Veto”.
    - But if you want one of your Expert Panels to have a veto, you can set it here.
    - For now, we will allow the “Metaschool OGs” Panel to have a veto on “Constitution Vote” decisions, but not on anything else.
    - The Constitution Vote can be used to change the Settings of the DAO, like voting durations or the majority needed for a vote to be “passed”.
    - Select “No Veto” everywhere, but “Metaschool OGs” for Constitution Votes.
    
    ![Frame 3560364 (15).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(15).gif?raw=true)
    

- **Add a DAO Treasury**:
    - A DAO is like a special club where lots of people come together to make decisions and do cool things.
    - If they want, they can put money in a big pot called the treasury to use for important projects.
    - This treasury could be a smart contract that the members can vote on for spending the money, but it could also be Gnosis Safe or just a wallet of one of the members.
    - Here you can add the address of your DAO Treasury if you already have one. It will then be transparently set as a DAO Parameter for everyone to see.
    - We will later show you how to add something like a treasury module to the DAO to manage it with everyone together.
    - So, for now, let’s continue without a treasury.
    
    ![Frame 3560364 (20).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(20).jpg?raw=true)
    

- **Does your DAO need a Constitution?**:
    - The constitution of the DAO is a document that represents the complete structure of the DAO, who is a member, which members have which role (remember the Expert Panel we created), who has how much voting power, etc.
    - If you want to specify a constitution for DAO from the start just select the option, else Continue.
    - You can always add a constitution later by voting, and because the focus of this tutorial is on creating a DAO and not a constitution, we will continue without it for now.
    
    ![Frame 3560364 (21).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(21).jpg?raw=true)
    

Phew! Now we are done with specifying all the requirements for our DAO and we did not write even a single piece of code. And our DAO now can do way more than the the one we wrote earlier. How cool and easy it is!

Once you are done specifying all nitty gritty details of your DAO, the Q DAO Factory will show you the summary of your DAO details. 

- Click on Submit. After clicking, Q will run transactions for each components to deploy them separately. Make sure to select “Regular Deploy” and approve all transactions by clicking “Confirm” when MetaMask prompts pops up to ensure full functionality of your DAO.
- If nothing seems to happen, but you see a small “1” in your Metamask icon, open the add-on and confirm the pending transactions.
    
    
    ![Screen Recording 2023-08-08 at 1.00.04 PM.gif](Build%20DAO%20Using%20the%20Q%20DAO%20Factory%20af87f3c1d4b94ed7a85d34c7f289a0bf/Screen_Recording_2023-08-08_at_1.00.04_PM.gif)
    

- After approving all transactions, you will see a window similar to below. Click on “Go to DAO Dashboard” to view your dashboard that you can use to manage your DAO.
    
    ![Frame 3560364 (22).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Screen_Recording_2023-08-08_at_1.00.04_PM.gif?raw=true)
    

- Before moving on, let’s copy the DAO Registry address and paste it in our HardHat project `.env` file in the following format.

```
DAO_REGISTRY_ADDRESS = "YOUR-DAO-REGISTRY-ADDRESS"
```

- After clicking on “Go to DAO Dashboard”, you will see a window similar to below. Here you can mint your DAO Token, and create and vote on proposals.
    
    ![Frame 3560364 (23).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Build%20DAO%20Using%20the%20Q%20DAO%20Factory/Frame_3560364_(23).jpg?raw=true)
    

## That’s a wrap

And that's a wrap! You've just learned how to use the amazing Q Factory tool to create your very own DAO. Whether you're building the next big decentralized organization or just experimenting with blockchain technology, this tool can make the process easy, fun, and less time-consuming. So go forth and create, innovate, and decentralize! 

If you want to check out the Metaschool DAO we just created, you can find it here on mainnet and here on [testnet](https://hq.q-dao.tools/0x611B1aaf2086afcFEf7F7b44090b384BB5b5f033).
