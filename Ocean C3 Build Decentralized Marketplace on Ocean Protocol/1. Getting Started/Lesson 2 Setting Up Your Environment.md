# Setting Up Your Environment

Welcome back, ocean explorers! 🌊 Are you ready to plunge into the world of the Ocean? This lesson will guide you through the basic setup and prepare you for coding. Let’s go!

## Setting Up Your Environment

Let's get our hands dirty with some setup! We'll be using Node.js and nvm (Node Version Manager) to ensure a smooth development experience.

![Frame3560408-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%202%20Setting%20Up%20Your%20Environment/Frame3560408-ezgif.com-jpg-to-webp-converter.webp)

1. **Node.js & npm:** Node Js is the engine that powers your JavaScript code, even outside of a web browser. This is super important for blockchain development because it allows you to create and execute code that will interact with the Ocean network directly from your computer. npm is your trusty package manager. It's like a shopping cart for code libraries, making it easy to install and manage all the software components your project needs.
    - **Download & Install Node.js:** Head over to [nodejs.org](https://nodejs.org/) and grab the installer for your operating system (macOS, or Linux). The installer will also include npm. Just follow the on-screen instructions. If you're not sure which one to choose, npm is a great starting point.
    - **Verify Success:** Open your terminal (or command prompt) and type the following commands:
        
        ```bash
        node -v
        npm -v
        ```
        
    
    You should see version numbers for both Node.js and your package manager printed out. If you do, congrats! You've successfully installed Node.js and your package manager.
    
    Make sure you use the 18+ version of the node.
    
2. **Visual Studio Code (VSCode):** This is our code editor of choice. It's a free, powerful tool that makes writing Solidity code (the language for smart contracts) a breeze. It's got a clean interface, tons of customization options, and a huge library of extensions to help you code like a pro.
    - **Download & Install:** Grab it from [code.visualstudio.com](https://code.visualstudio.com/) and follow the simple installation instructions.
3. **Git:** Git is a version control system that lets you track changes to your code, collaborate with others, and revert to previous versions if needed. It's like a time machine for your code!
    - **Download & Install:** Grab it from the official website: [git-scm.com](https://git-scm.com/) and follow the instructions.
4. **Git CLI:** It allows you to connect with git via the terminal, so let’s install it too. You can follow the steps given [here](https://github.com/cli/cli). Once you have installed the Git CLI, let me tell you how you can configure your terminal with it.
    1. Open your terminal.
    2. Run `gh --version` to ensure that you have installed the Git CLI successfully.
    3. Run `gh auth login --web` in your terminal and follow the steps given below:
        1. First, it will ask for your preferred protocol for Git operations. I chose HTTPS, you can choose any.
        2. Second, it will ask you to Authenticate Git with your GitHub credentials, and type `Y`.
        3. Third, you will be able to see a code on your terminal. Copy it.
        4. Then, press Enter. It will open a window in your browser.
        5. Paste the code you copied and authorize your git. You might need to enter your GitHub password if you have yet to log in.
        6. Do not close this terminal!

Awesome, you are all set!! Good job!

## Wrap Up

Congratulations on taking your first steps into the world of Ocean! We've set up your development environment. You're now equipped with the tools to start building your own marketplace. Let’s set up your project in the next lesson without further ado.