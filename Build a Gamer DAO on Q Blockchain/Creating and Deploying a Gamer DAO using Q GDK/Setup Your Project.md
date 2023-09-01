# Setup Your Project

Greetings folks! You have been doing so awesome till now we discussed about understanding the concepts, and implementing them. 

Well, in the next steps, we will be creating our own token and then use the Q DAO Factory to for building a DAO for our token holders. Then we will show you how you can make use of all your developer power to add an additional AirDrop Module to your DAO which all your token holders can use together! 

So what are you waiting for? Let’s dive in!

## Prerequisites

First, we need a few installations so make sure you have the following on your machine:

- A code editor (we are using [Install Visual Studio](https://code.visualstudio.com/download))
- [Install Node.js](https://nodejs.org/en)

## Download boilerplate project

To save you some work, we created a npm project with hardhat configuration files. You can download the basic project by cloning the repo from [here](https://github.com/0xmetaschool/Q-boilerplate-code).

Now open a terminal in the main folder, Q-boilerplate-code-main,  and run the following command to install all dependencies:

```
npm install --force
npm install --save-dev hardhat --force
```

## Update `.env` file

To deploy scripts on the blockchain, you will need to use a private key. To do this, you can fetch your private key from one of your accounts in Metamask (we recommend creating a new account for this). To get the private key:

- Click on your account.
- Click on “Account details”.
- Click on “Show Private Key”.
- Enter your Metamask wallet password.
- Copy the private key shown.
    
    ![Frame 3560364 (11).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Setup%20Your%20Project/Frame_3560364_(11).gif?raw=true)
    

Now navigate to `.env` in your main folder (Q-boilerplate-code) with the following content. Replace “ENTER_YOUR_KEY” with the private key of your wallet that you copied.

```
PRIVATE_KEY="ENTER_YOUR_KEY"
```

- This `.env` will be added to `.gitignore`, so we accidentally don’t push our sensitive information to Github.

## That’s a wrap

Phew! You are all set to start your project. Next, we will start adding the code to it. First of all, we will create a token that will be a native token for our DAO. So let’s move to the next steps.
