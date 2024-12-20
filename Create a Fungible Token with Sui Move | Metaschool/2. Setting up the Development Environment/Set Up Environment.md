# Set Up Environment

Welcome back!  So you completed revising Move on Sui. Well, in this lesson, you're going to learn how to set up the environment for running your code. Ready for another round of exhilarating learning? Let's dive right in!

**Note:** We assume that you have already installed the Sui and Rust in your system in the last course of the Sui course path.

## Check your version

Open your favorite terminal. Let’s check your Sui installation version.

```
sui --version
```

**Note:** If you face errors while installing Sui please make sure to follow all the steps in the lesson **Deploy Your First Sui Contract**.

## Create your Sui folder

The first step is to initialize a workspace environment. This will contain the basic files for running any Move file. You can create the workspace using the following command; I have named mine `metaschool`:

```
sui move new metaschool
```

Navigate to the `sources/` directory. Create a new Move file. I am naming it `pepe.move`. You can name the Move file with whatever coin name you want it to be. It could be Mango, Luffy, or even Pikachu. 😃

This is what my directory looks like now:

![Frame 3560370 (13).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_sui_c3/L2_Set%20Up%20Environment/Frame_3560370_(13).webp?raw=true)

## Check your wallet

You can view the current active address using the following command:

```
sui client active-address
```

If you do not have an active address, follow the steps given below:

1. Run the following command to create your Sui account:
    
    ```
    sui client new-address ed25519
    ```
    
    It will generate the output something like this:
    
    ![deploy-5.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_sui_c3/L2_Set%20Up%20Environment/deploy-5.webp?raw=true)
    
- **Important**: Save the recovery phrase, it is important to have it to import your wallet.
1. Replace `[YOUR_ADDRESS]` in the command below with the address you received after running the last command and run it.
    
    ```
    sui client switch --address [YOUR_ADDRESS]
    ```
    
2. Head over to the [Sui Devnet faucet discord channel](https://discord.com/channels/916379725201563759/971488439931392130) and paste “!faucet [YOUR_ADDRESS]” to receive 10 SUI tokens.

## Wrap up

In this lesson, you set up your environment. Now, we are ready to write the code of the fungible token.