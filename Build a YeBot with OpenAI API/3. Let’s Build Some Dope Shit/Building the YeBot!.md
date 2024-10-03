# Building the YeBot!

Now, let’s dive into the dope world of the YeAI Bot Project. This project is all about creating a Kanye West AI bot that can chat with you and answer your questions in Kanye West style. It's gonna be a blast!

### Key Features of YeBot

Check out some of the key features of the YeAI Bot Project:

- Understanding natural language input so you can talk to it like a real person.
- Use of the amazing openAI GPT-4 model to generate responses that sound real.
- Personalizing responses based on your interactions and data, so it feels like you're chatting with a real Kanye West.
- Integrate the model with NextJS and run the server using Flask.

## Let's Get It Started: Code & Prompts

We’ll be using code and prompts to build our YeBot, with the OpenAI engine as the backbone of our chatbot. We’ll set up our development environment and use the OpenAI API key that we’ve already generated for this purpose. To build the frontend, we’ll be using NextJS which will allow us to create an interactive and dynamic user interface for our Kanye West AI chatbot.

**Don’t Worry**! We will explain everything one-by-one. So, let’s buckle up to learn and build!

## So, why use Next.js for building a YeAI bot?

Next.js is a super cool framework for building web apps, and it's perfect for building dope projects like a Kanye West AI bot using OpenAI API. Let me break it down for you real quick:

- It's perfect for building complex apps that require dynamic data and frequent updates, like our YeAI bot that's constantly learning and evolving.
- It's super fast and efficient, which is important when you're dealing with large amounts of data and processing power, which our GPT model will be using to give us responses.
- It's easy to use and has a ton of awesome features that will make building your AI bot a breeze.
- It's super fun and exciting to work with, especially when you're building something as cool as a Kanye West AI bot!

> **Note:** If you have not installed NodeJs in your system, head over to [https://nodejs.org/en/download](https://nodejs.org/en/download) and install it.
> 

Let’s get started and build dope stuff!


- **`npm init -y`**: Quickly initializes a new Node.js project by creating a `package.json` file with default settings.
- **`npm install axios`**: Installs the `axios` library for making HTTP requests and adds it as a dependency in `package.json`.

## Getting started with Node.js
Run this command in your terminal to initializes a new Node.js project by creating a `package.json` file with default settings.

`npm init -y`

Now run this command to install the `axios` library for making HTTP requests and adds it as a dependency in `package.json`. 

`npm install axios`

We need 'axios' to make HTTPS requests to communicate with external services like APIs over the internet. It ensures that the data being exchanged is encrypted which protects it from interception or tampering. For our YeBot, HTTPS requests are used to send user input to OpenAI's API and receive a response securely.

## Code

Now create a new file `chatbot.js` and paste this code:

```
const axios = require('axios');
const dotenv = require('dotenv');

dotenv.config();  

async function getKanyeResponse(userMessage) {
  const apiKey = process.env.OPENAI_API_KEY;    
  
  try {
    const response = await axios.post('https://api.openai.com/v1/chat/completions', {
      model: 'gpt-3.5-turbo',
      messages: [
        {
          role: 'system',
          content: 'Respond as if you are Kanye West, the iconic rapper and producer known for his bold, passionate, and often controversial statements, characterized by a confident, stream-of-consciousness style, inventive language, and a mix of emotional intensity and unpredictable tweets.'
        },
        {
          role: 'user',
          content: userMessage,
        },
      ],
    }, {
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json',
      },
    });

    const botResponse = response.data.choices[0]?.message?.content || 'No response from bot';
    console.log("Kanye Bot:", botResponse);
  } catch (error) {
    console.error('Error:', error);
  }
}

// Call the function with a user message
getKanyeResponse('What do you think about your latest album?');
```

### Explanation

Here's a breakdown of the key elements in the Node.js file:

1. `dotenv.config()`: This loads environment variables from a .env file into process.env, making it easier to store sensitive data like the OpenAI API key.

2. `async function getKanyeResponse(userMessage)`: Defines an asynchronous function that takes in the `userMessage` (the message sent by the user) and sends it to the OpenAI API to generate a Kanye-like response.

3. `process.env.OPENAI_API_KEY`: Retrieves the OpenAI API key stored in the .env file. This API key is used to authenticate requests to OpenAI.

4. `axios.post()`: This sends a POST request to the OpenAI API's `/chat/completions` endpoint. It provides a chat-based conversation with:

- model: The GPT model to be used (`gpt-3.5-turbo`).
- messages: A conversation format where the system sets up Kanye's tone, and the user's message is passed.

5. Response handling: It extracts the response text from OpenAI's API, logs it to the console, and defaults to "No response from bot" if no message is received.

6. Error handling: Catches and logs any errors that occur during the API request process.

## Create a .env file

Create a new file by the name `.env` and paste this:

`OPENAI_API_KEY=<you-API-key>` 

Be sure to replace the placeholder (`<you-API-key>`) with the API key you generateed in the previous chapter.

### But why do we need a .env file?

By storing the API key in a `.env` file and preventing it from being hard-coded in the main code, we are reducing the risk of accidentally exposing it in public repositories or version control systems like Git. It's good practice to store any sensitive information in a .env file and access it from there.

## Let's run the code

Run this command in your terminal:

`node chatbot.js`

Boom! There it is. Just like that. Magic, no cap.
