# 🚀 Set Up the Frontend Project Like a Pro!

Yo, Web3 wizard! You've crushed it so far, and now it's time for the grand finale—connecting your dApp to the frontend. This is where your masterpiece comes to life. Let’s get cooking! 🍳🔥



## 🏗️ Setting Up Your Project

Crack open your terminal and run these magic spells:

```sh
git clone https://github.com/0xmetaschool/one-piece-frontend-boilerplate.git
cd one-piece-frontend-boilerplate
npm install
```

Now, create a `.env` file in the `one-piece-frontend-boilerplate` directory and add the secret ingredients:

```sh
REACT_APP_CONTRACT_ADDRESS=<your-contract-address>
REACT_APP_SUBGRAPH_URL=<your-subgraph-url>
```

🚀 Replace `<your-contract-address>` with your deployed contract address. Boom, first step done!



## 🔍 Creating a Subgraph Like a Boss

We’re diving into **The Graph** to make your dApp super smooth. Here’s how to do it:

- Go to [Graph Studio](https://thegraph.com/studio/).
- Connect MetaMask and sign the transaction.
- Verify your email to unlock the next level.

![Graph Studio Setup](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Set%20Up%20the%20Frontend%20Project/Screen_Recording_2024-03-11_at_5.07.02_PM.webp?raw=true)

- Click **Create a Subgraph**, give it a cool name, and hit **Create**.

![Subgraph Creation](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Set%20Up%20the%20Frontend%20Project/Screen_Recording_2024-03-11_at_5.08.25_PM.webp?raw=true)

- Follow the instructions and let’s roll! 🎬



## 🛠️ Initialize & Deploy Your Subgraph

First, install the Graph CLI:

```sh
npm install -g @graphprotocol/graph-cli
```

Next, initialize your subgraph:

```sh
graph init --studio one-piece
```

### Follow the prompts:

✅ **Protocol?** Select `ethereum`.

✅ **Network?** Choose `Arbitrum Sepolia`.
![](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/new_images/graph.webp?raw=true)
![](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/new_images/graph1.webp?raw=true)

✅ **Contract Address?** Paste your deployed contract address.

✅ **Start Block?** Just hit `Enter`.

✅ **Contract Name?** Use `OnePieceMint` (or whatever yours is called).

✅ **Index Events?** Select `Y`.

✅ **Continue?** Select `N`.

💡 Your setup should look something like this:

![](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/new_images/graph2.webp?raw=true)

Now, authenticate with The Graph:

```sh
graph auth --studio <your-auth-key>
```

Move into your subgraph directory:

```sh
cd one-piece
```

Build & deploy your subgraph:

```sh
graph codegen && graph build
graph deploy --studio one-piece
```
![](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/new_images/graph3.webp?raw=true)

When asked for a version, type `v0.0.1` (or increment it if updating).

![](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/new_images/graph4.webp?raw=true)

Once deployed, copy the subgraph URL and update your `.env` file:

```sh
REACT_APP_SUBGRAPH_URL=<your-deployed-subgraph-url>
```



## 🎉 Run Your dApp and Watch the Magic Happen

Ready for the final step? Fire up your dApp:

```sh
cd ../
npm start
```

Your dApp is ALIVE! 🧙‍♂️✨ Time to interact and show off your Web3 wizardry.

![Interact with dApp](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Set%20Up%20the%20Frontend%20Project/interact.webp?raw=true)



## 🎊 The Final Wrap-Up

BOOM! 💥 You’ve just:

✅ Set up your frontend

✅ Created a subgraph

✅ Connected everything together


Your dApp is now fully functional, and you’re officially a Web3 champion. 🏆

Now tell me—who’s your favorite One Piece character? Mine’s **Zoro**. No debate! 🔥⚔️
