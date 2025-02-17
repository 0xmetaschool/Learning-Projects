# Setting Up the Dev Wizard

Welcome back, people! In our last lesson, we explored the features of a Lending dApp.

Now, it’s time to set up our development environment. We’ll cover the tools you need, install dependencies like Rust and Docker, set up a local environment, configure your IDE, and connect to the MANTRA Testnet. If you’re hearing about these tools like Docker for the first time, don’t worry! We’ll guide you through each step to set them up and use them. This will be a valuable new skill set to add to your arsenal.

## The Pre-requisites

A core component that we need to set up is `mantrachaind`, the command-line interface (cli) tool to interact with MANTRA Chain. 

### For Windows users :

`mantrachaind` prebuilt binaries are available for Linux and Mac based systems for the time being, So you’ll need to setup [WSL](https://learn.microsoft.com/en-us/windows/wsl/) to get it working over on Windows machines . Open your terminal as Administrator and run following command.

```powershell
wsl --install
```

This command will enable the features necessary to run WSL and install the Ubuntu distribution of Linux. Restart your machine and open WSL as admin for the initialization and you’ll all good to go. Please ensure that all steps are being followed in the WSL Environment. You can access WSL by running the following command in the terminal.

```jsx
wsl
```

## The Toolset

1. **Go**: We will require Go version v1.18 or higher to work with `mantrachaind`. You can easily set it up by following the [official documentation](https://golang.org/doc/install) or Run the following commands according to your OS.
    - Windows WSL and Linux Users :
    
    ```bash
    sudo apt update
    sudo apt install -y wget tar
    wget https://golang.org/dl/go1.22.5.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
    source ~/.profile
    ```
    
    - MacOS Users:
    
    ```bash
    brew update && brew install go
    echo 'export export GOPATH=$HOME/go' >> ~/.zshrc
    echo 'export GOROOT="$(brew --prefix golang)/libexec"' >> ~/.zshrc
    echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.zshrc
    source ~/.zshrc
    ```
    
2. **Rust**: We already discussed that Rust is important, as it’s the primary language for `CosmWasm` development. Run the following command to setup [rustup](https://rustup.rs/) on your system.
    - Windows Users :
    Download and execute **rustup-init.exe** from [rustup.rs](https://rustup.rs/) or [rust-lang.org](https://www.rust-lang.org/tools/install). If requested, manually download and install Microsoft C++ Build Tools, from [https://visualstudio.microsoft.com/visual-cpp-build-tools/](https://visualstudio.microsoft.com/visual-cpp-build-tools/) . Continue running **rustup-init.exe**, and proceed with the installation.
    - Linux or MacOS Users :
        
        ```powershell
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source $HOME/.cargo/env
        ```
        
        ![Lesson%203%20Setting%20Up%20the%20Dev%20Wizard%2014194c6fe10f816381b4d981c2edf4d1/23.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/23.webp?raw=true)
        
        After setting up Rust and Cargo (which manages and builds Rust code), you'll need two important tools:
        
        - `cargo-generate` is a project template tool - it's like a blueprint copier that helps you start new projects quickly by using pre-made project layouts.
        - `cargo-run-script` is a task runner - it helps you create and run quick commands for your project, just like how you can create shortcuts for common tasks in Node.js projects.
        
        To install these tools, run:
        
        ```jsx
        cargo install cargo-generate --features vendored-openssl
        cargo install cargo-run-script
        ```
        
        ![002.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/002.webp?raw=true)
        
3. **IDE:** We will need an code editor that supports Rust. [VSCode](https://code.visualstudio.com/) is a good option together with the [Rust Analyzer plugin](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer). Alternatively, another great option is [RustRover](https://www.jetbrains.com/rust/), Jetbrains’ IDE specifically designed for Rust development.
4. **Docker:** Docker is essential for setting up and running applications in isolated environments. You can install Docker by following the instructions on the [official Docker website](https://www.docker.com/) for your respective operating system. 
    - Windows Users: Activate the WSL integration in Docker Desktop settings.
5. **Git:** Git is a version control system that lets you track changes to your code, collaborate with others, and revert to previous versions if needed. It's like a time machine for your code!
    - **Download & Install:** Grab it from the official website: [git-scm.com](https://git-scm.com/) and follow the instructions.
6. **GitHub CLI:** The GitHub CLI allows you to interact with GitHub from the command line. This tool is not mandatory but it’s good to have. Follow these steps to set it up:
    - Install GitHub CLI by following the instructions from [here](https://github.com/cli/cli).
    - **Open your terminal**: Launch your preferred terminal application.
    - **Verify GitHub CLI installation**: Run `gh --version` to ensure you have successfully installed the GitHub CLI.
    - **Authenticate with GitHub**:
        - Run `gh auth login --web` in your terminal.
        - Choose your preferred protocol for Git operations (e.g., HTTPS).
        - Authenticate Git with your GitHub credentials by typing `Y`.
        - Copy the code displayed in your terminal.
        - Press Enter to open a browser window.
        - Paste the code and authorize Git by entering your GitHub password.
        
        **⚠️ Important**: Keep the terminal window open throughout the process.
        
    
    ![Lesson%203%20Setting%20Up%20the%20Dev%20Wizard%2014194c6fe10f816381b4d981c2edf4d1/20.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/20.webp?raw=true)
    

**You did it!** Awesome, you are all set!! Good job! You have successfully installed Git and set up the GitHub CLI. You're now ready to move on to the next steps in the tutorial. Keep going!

## Installing WebAssembly target

Before you start developing smart contracts, we will need to ensure that we have the `wasm32` target installed. This target allows Rust to compile code to WebAssembly (WASM), which is necessary for deploying smart contracts on MANTRA Blockchain.

Follow these steps to set it up:

1. **Update Rust and Add the WASM32 Target**:
    
    ```bash
    rustup update stable
    rustup target add wasm32-unknown-unknown
    
    ```
    
2. **Verify the Target is Installed**:
    
    ```bash
    rustup target list --installed
    
    ```
    
    ![Lesson%203%20Setting%20Up%20the%20Dev%20Wizard%2014194c6fe10f816381b4d981c2edf4d1/24.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/24.webp?raw=true)
    

The `wasm32-unknown-unknown` target allows Rust to compile code to WebAssembly. "wasm32" specifies the architecture, "unknown" indicates that there is no specific vendor, and "unknown" means no specific operating system, making the application more flexible.

## mantrachaind

**`mantrachaind`** is the backbone of the CosmWasm platform for the MANTRA DuKong Chain and it will be our main tool for development. We will be using this tool for everything from initializing configurations, managing keys, running the full node, and querying the blockchain.

Let’s download the pre-built binaries from [MANTRA GitHub Repo](https://github.com/MANTRA-Chain/mantrachain/releases/) and add it to PATH by running the following commands in your terminal. The following commands will create a new folder named *MANTRA,* downloads the binaries , unzip it and finally add it our PATH.

- Windows WSL and Linux Users :

```bash
mkdir -p ~/MANTRA
cd ~/MANTRA
curl -LO https://github.com/MANTRA-Chain/mantrachain/releases/download/v1.0.0/mantrachaind-1.0.0-linux-amd64.tar.gz
tar -xzvf mantrachaind-1.0.0-linux-amd64.tar.gz
chmod +x mantrachaind
echo 'export LD_LIBRARY_PATH=~/MANTRA:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PATH=~/MANTRA:$PATH' >> ~/.bashrc
source ~/.bashrc
```

- MacOS Users :
    - CLI Tool for Intel Chips
    
    ```bash
    mkdir -p ~/MANTRA
    cd ~/MANTRA
    curl -LO https://github.com/MANTRA-Chain/mantrachain/releases/download/v1.0.0/mantrachaind-1.0.0-darwin-amd64.tar.gz
    tar -xzvf mantrachaind-1.0.0-darwin-amd64.tar.gz
    chmod +x mantrachaind
    echo 'export LD_LIBRARY_PATH=~/MANTRA:$LD_LIBRARY_PATH' >> ~/.zshrc
    echo 'export PATH=~/MANTRA:$PATH' >> ~/.zshrc
    source ~/.zshrc
    ```
    
    - CLI Tool for Silicon chips (M1, M2...)
    
    ```bash
    mkdir -p ~/MANTRA
    cd ~/MANTRA
    curl -LO https://github.com/MANTRA-Chain/mantrachain/releases/download/v1.0.0/mantrachaind-1.0.0-darwin-arm64.tar.gz
    tar -xzvf mantrachaind-1.0.0-darwin-arm64.tar.gz
    chmod +x mantrachaind
    echo 'export LD_LIBRARY_PATH=~/MANTRA:$LD_LIBRARY_PATH' >> ~/.zshrc
    echo 'export PATH=~/MANTRA:$PATH' >> ~/.zshrc
    source ~/.zshrc
    ```
    

Now if you try executing it and get the following error, **then alone** we will need to install the CosmWasm library `libwasmvm.x86_64.so` .

![Lesson%203%20Setting%20Up%20the%20Dev%20Wizard%2014194c6fe10f816381b4d981c2edf4d1/Screenshot_2024-07-29_151310.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/Screenshot_2024-07-29_151310.webp?raw=true)

If you are on a x86_64 system:

```bash
sudo wget -P /usr/lib https://github.com/CosmWasm/wasmvm/releases/download/v2.1.0/libwasmvm.x86_64.so
```

On arm64 (i.e. Apple silicon chips):

```bash
sudo wget -P /usr/lib https://github.com/CosmWasm/wasmvm/releases/download/v2.1.0/libwasmvm.aarch64.so
```

Now if we try to execute `mantrachaind` again , then we will be shown all commands that can be executed using it as shown below.

![image.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/image.webp?raw=true)

Finally we will need to install `jq` , a lightweight and flexible command-line JSON processor. It helps us to slice and filter and map and transform structured JSON data.

- Windows WSL and Linux Users :

```bash
sudo apt-get install jq
```

- MacOS Users :

```bash
brew install jq
```

With all of this out of the way, we can now quickly setup our development environment.

## Setting Up Environment Variables

Let’s dive into the setup process for `mantrachaind`. We’ll start by configuring the `mantrachaind` executable to interact with the DuKong network. This involves a few key steps: setting up environment variables, creating and managing wallets, and requesting tokens from the faucet. Each step is essential for ensuring that our development environment is correctly set up and ready for use.

### Create a Configuration File

Create a new project folder, lets say `MantraChain` and then create a file called `mantrachaind-cli.env`.

**Note:** We will use this project for learning but we'll provide you the boilerplate alongside this file in the upcoming lessons.
Now, add the following content to the `mantrachaind-cli.env` file:

- For Windows WSL / Linux Users

```bash
export CHAIN_ID="mantra-dukong-1"
export TESTNET_NAME="mantra-dukong"
export DENOM="uom"
export BECH32_HRP="wasm"
export WASMD_VERSION="v0.53.0"
export CONFIG_DIR=".mantrachaind"
export BINARY="mantrachaind"
export COSMJS_VERSION="v0.28.1"
export GENESIS_URL="https://<location-to-be-provided>/config/genesis.json"
export RPC="https://rpc.dukong.mantrachain.io:443"
export FAUCET="https://faucet.dukong.mantrachain.io"
export NODE="--node $RPC"
export TXFLAG="--node https://rpc.dukong.mantrachain.io:443 --chain-id $CHAIN_ID --gas-prices 0.01$DENOM --gas auto --gas-adjustment 1.5"
```

- For MacOS Users

```bash
export CHAIN_ID="mantra-dukong-1"
export TESTNET_NAME="mantra-dukong"
export DENOM="uom"
export BECH32_HRP="wasm"
export WASMD_VERSION="v0.53.0"
export CONFIG_DIR=".mantrachaind"
export BINARY="mantrachaind"
export COSMJS_VERSION="v0.28.1"
export GENESIS_URL="https://<location-to-be-provided>/config/genesis.json"
export RPC="<https://rpc.dukong.mantrachain.io:443>"
export FAUCET="<https://faucet.dukong.mantrachain.io>"
export NODE=(--node $RPC)
export TXFLAG=($NODE --chain-id $CHAIN_ID --gas-prices 0.01$DENOM --gas auto --gas-adjustment 1.5)
```

Save the file and then source it so as to set the environment variables by running the following command:

```bash
source mantrachaind-cli.env
```

![Screenshot 2024-10-28 143447.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/Screenshot_2024-10-28_143447.webp?raw=true)

We’ll use these environment variables later to interact with the network.

## Setup Wallet Addresses

Set up wallet addresses for storing tokens by running the following commands in your terminal.

```bash
mantrachaind keys add wallet
mantrachaind keys add wallet2
```

Running the command above will add two encrypted private keys to the `mantrachaind` keyring and display their attributes as follows:

![01.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/01.webp?raw=true)

**⚠️ Important**: Write down the mnemonic phrase in a safe place. It is the only way to recover your account and connect our wallet to Keplr.

Take note of the 12 or 24-word mnemonic phrase associated with one of your existing wallets, be it either wallet or wallet2. This phrase will be used to import the wallet into Keplr, enabling a more user-friendly experience.

## Connecting Wallet to Keplr

**Step 1: Install Keplr Wallet Extension**

Install the Keplr Wallet extension compatible with your browser from  [https://keplr.app/](https://keplr.app/) .

**Step 2: Import Existing Wallet**

Import your existing wallet by selecting "Import an existing Wallet", choosing "Use Recovery phrase or recovery key", and pasting your 12 or 24-word mnemonic phrase.

**Step 3: Set Up Wallet**

Set up your wallet by adding a name and password.

![004.a.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/004.a.webp?raw=true)

**Step 4: Add MANTRA Chain**

Visit the official MANTRA Chain Explorer: [https://explorer.mantrachain.io](https://explorer.mantrachain.io/), From here - select MANTRA-Dukong chain, The Wallet Helper Tool under TOOLS section to import the chain connection details into the Kelpr wallet. Select network as `Testnet`, chain as `MANTRA-Dukong` and choose the wallet as `Keplr`using the radio buttons. Once done click on “SUGGEST MANTRA-DUKONG TO KEPLR” Button and Approve it.

**Step 5: Configure Wallet Settings**

Now we can configure your wallet settings by navigating to "Manage Chain Visibility", searching for "MANTRA", selecting "MANTRA Dukong Testnet", and checking the box to add it to your wallet.

![004.b.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/004.b.webp?raw=true)

You have now successfully integrated Keplr with your wallet, setting the stage for seamless interactions with your dApp in upcoming lessons. This crucial step will enable you to fully leverage the capabilities of your wallet and dApp, making future development and testing a breeze.

## Requesting Tokens

You will need some tokens in your wallet address to interact with the network. To request testnet tokens:

- Head over to the [MANTRA Discord Server](https://discord.com/invite/gfks4TwAJV), Join and Verify your account.
- Navigate to `#dukong-faucet-role`Channel.
- Type `/request`.
- Enter and Submit Your Wallet Address (either wallet or wallet2).
- Receive Your Test Tokens.
- Note : Do note that if you have added funds to wallet2 then ensure to specify wallet2 when deploying the contract later in the lessons. We’ll add a reminder there as well so that you don’t miss it.

![004.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%203%20Setting%20Up%20the%20Dev%20Wizard/004.webp?raw=true)

By clicking on the “*Check them here*” hyperlink, you’ll be taken to the Dukong Mantra chain explorer, where you’ll be able to see the testnet tokens deposited in your account.

⚠️ Your Discord account age should be at least 14 days in order to be eligible for receiving the Testnet tokens.

## That’s a Wrap

Great job setting up `mantrachaind`, configuring your environment, and getting those test tokens! With everything in place, you’re now ready to take the next exciting step—deploying your very first smart contract on the Mantra Chain. Let’s get started and see what amazing things you can build!