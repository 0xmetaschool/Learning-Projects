# Set Up the Hardhat Project

Greetings folks! Great work on understanding all about the ERC404 token. You have been doing so awesome. Now, we will dive into the development and start setting up our development environment.

So what are you waiting for? Let’s start setting up our hardhat project.

## Prerequisites

First, we need a few installations. So, make sure you have the following on your machine:

- A code editor (we are using [Visual Studio](https://code.visualstudio.com/download).)
- [Install Node.js](https://nodejs.org/en/download) (Please make sure to install `v18` for this project. We are using `v18.17.1`. It is important to use the appropriate version to avoid facing errors.)
- [Install GitHub](https://github.com/git-guides/install-git)
- Install the [MetaMask Chrome extension](https://chromewebstore.google.com/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn).

## Clone the boilerplate Hardhat project

To save you some work, we created a npm project with Hardhat configuration files. Open the terminal and run the following command to clone the GitHub repository. 

```
git clone https://github.com/0xmetaschool/erc404-nftmarketplace-boilerplate.git
```

Now, run the following commands one by one to move to the repository folder and install all dependencies:

```
cd erc404-nftmarketplace-boilerplate
npm install dotenv --save --force
npm install --save-dev hardhat --force
npm install --force
```

When you install the dependencies, you will receive different warnings. Please ignore those warnings and move forward. Here is an example output of the `npm install --force` command.

![setup-1.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/2%20Prerequisites%20to%20Building%20the%20MarketPlace/1%20Set%20Up%20the%20Hardhat%20Project/struct-1.1.webp?raw=true)

**Note:** If you are planning to not use the boilerplate project and create your own Hardhat project, please make sure that you are using the same config file and copying other important files from the `contracts` folder.

## Project structure

Here’s how your complete hardhat project structure will look like.

![setup-2.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/2%20Prerequisites%20to%20Building%20the%20MarketPlace/1%20Set%20Up%20the%20Hardhat%20Project/setup-2.webp?raw=true)

## That’s a wrap

You cloned the basic boilerplate hardhat project from GitHub. Now you are ready to move onto next step of doing a few tasks that’ll help us in deployment of our dApp.