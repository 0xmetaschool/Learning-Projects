# Connect this Yeezy to a NextJS app

Yo, listen up! We 'bout to make some moves and get connected to NextJS App using Python Flask. 

## What is NextJS?

Next.js is a super cool framework for building web apps, and it's perfect for building dope projects like a Kanye West AI bot using OpenAI API. Let me break it down for you real quick:

- Next.js is a React-based framework for building web applications.
- It's a server-side rendering framework, which means it can generate HTML on the server before it's sent to the client.
- It uses automatic code splitting and lazy loading, which means your app loads faster and is more performant.
- It has built-in support for SEO optimization, so your app can be easily discovered by search engines.
- It's flexible and customizable, so you can build your app exactly the way you want it.

## So, why use Next.js for building a YeAI bot?

Here are a few reasons:

- It's perfect for building complex apps that require dynamic data and frequent updates, like our YeAI bot that's constantly learning and evolving.
- It's super fast and efficient, which is important when you're dealing with large amounts of data and processing power, which our GPT model will be using to give us responses.
- It's easy to use and has a ton of awesome features that will make building your AI bot a breeze.
- It's super fun and exciting to work with, especially when you're building something as cool as a Kanye West AI bot!

> **Note:** If you have not installed NodeJs in your system, head over to [https://nodejs.org/en/download](https://nodejs.org/en/download) and install it.
> 

Let’s get started and build dope stuff!

## Create a NextJS app for the frontend

First, we will now create a NextJS frontend, run this command in your terminal to create your NextJS app.

```jsx
npx create-next-app kanye-ai
```

 Use arrow button from your keyboard to select appropriate option.

- Select **No** for: Would you like to use TypeScript with this project?
- Select **No** for: Would you like to use ESLint with this project?
- Select **No** for: Would you like to use Tailwind CSS with this project?
- Select **Yes** for: Would you like to use `src/` directory with this project?
- Select **No** for: Would you like to use experimental `app/` directory with this project?
- Select **No** for: Would you like to use experimental `app/` directory with this project?
- Press Enter: What import alias would you like configured?

Let’s see this happening live.

![run nps command.gif](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20YeBot%20with%20OpenAI%20API/3.%20Let%E2%80%99s%20Build%20Some%20Dope%20Shit/Connect%20this%20Yeezy%20to%20a%20NextJS%20app%2080b6a5a75f174da0bfa594412d04afc6/run_nps_command.gif)

### Files structure

After creating the app, open VS code using the command `code .` The file structure will look like this:

![Untitled](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20YeBot%20with%20OpenAI%20API/3.%20Let%E2%80%99s%20Build%20Some%20Dope%20Shit/Connect%20this%20Yeezy%20to%20a%20NextJS%20app%2080b6a5a75f174da0bfa594412d04afc6/Untitled.png)

### Install axios first

Before moving forward, let’s run the following command in your terminal to install `axios` library:

```python
npm install axios
```

## Code

Now replace the index.js under `kanye-ai/src/pages/index.js` with this code:

```jsx
import React, { useState } from "react";
import Head from "next/head";
import axios from "axios";

function iMessage() {
  const [userInput, setUserInput] = useState("");
  const [messages, setMessages] = useState([]);
  const [kanyeTyping, setKanyeTyping] = useState(false);

  const handleChange = (event) => {
    setUserInput(event.target.value);
  };
  console.log(messages)
  const handleSubmit = async (event) => {
    event.preventDefault();
    const newMessage = { user: true, text: userInput };
    setMessages([...messages, newMessage, { user: false, text: "loading" }]);
    setKanyeTyping(true);
    axios.post('http://localhost:8080/bot', {
        message: userInput
    }, {
        headers: {
            'Content-Type': 'application/json',
        },
        withCredentials: true
    }).then((response) => {
        console.log(response);
        // Update messages and setKanyeTyping to false when you receive the response
        const botResponse = { user: false, text: response.data.results[0].response };
        setMessages([...messages, newMessage, botResponse]);
        setKanyeTyping(false);
    }).catch((error) => {
        console.error(error);
        // Update messages and setKanyeTyping to false when you receive an error
        const botResponse = { user: false, text: "Oops! Something went wrong." };
        setMessages([...messages, newMessage, botResponse]);
        setKanyeTyping(false);
    });
    setUserInput("");
    setKanyeTyping(true);
  };
  

  return (
    <>
        <Head>
            <title>
                Kanye West Chatbot - Metaschool
            </title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
        </Head>
        <div className="chat-container">
            <div className="header">                
                <i className="fa fa-chevron-left back-button"></i>
                <div className="contact-info">
                    <img
                        className="profile-image"
                        src="https://imageio.forbes.com/specials-images/imageserve/5ed00f17d4a99d0006d2e738/0x0.jpg?format=jpg&crop=4666,4663,x154,y651,safe&height=416&width=416&fit=bounds"
                        alt="Profile"
                    />
                    <h2 className="name">YeGPT</h2>
                </div>
                <i className="fa fa-video-camera video-icon"></i>
            </div>
            <div className="chat-window">
                <p className="chat-bot-header">Powered by <a className="ref-link" href="http://metaschool.so/" target="_blank" rel="noopener noreferrer">metaschool 🔮</a></p>
                {messages.map((message, index) => (
                    <div key={index} className="message-container">
                        {message.user ? (
                        <>
                            <div className="user-message message">
                                <div className="message-text">{message.text}</div>
                            </div>
                            <img
                                className="profile-image user-image"
                                src={'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png'}
                                alt="User Profile"
                            />
                        </>
                        ) : (
                        <>
                            <img
                                className="profile-image bot-image"
                                src='https://imageio.forbes.com/specials-images/imageserve/5ed00f17d4a99d0006d2e738/0x0.jpg?format=jpg&crop=4666,4663,x154,y651,safe&height=416&width=416&fit=bounds'
                                alt="Bot Profile"
                            />
                            {message.text === 'loading' ? <img className="typing-bubble" src='https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExODg3ZjFlNzQ1Mzc1ZTFlNTMyZTVjODIzMDYyODUwNDQ0ZDY3ZmU5YyZjdD1z/3tLfKrc4pLWiTkAAph/giphy.gif' /> : <div className="bot-message message">
                                <div className="message-text">{message.text}</div>
                            </div>}
                        </>
                        )}
                    </div>
                ))}
            </div>
            <form className="form" onSubmit={handleSubmit}>
                <input
                    type="text"
                    placeholder="Type your message here..."
                    value={userInput}
                    onChange={handleChange}
                    disabled={kanyeTyping}
                />
                <button type="submit">
                    <i className="fa fa-paper-plane" aria-hidden="true"></i>
                </button>
            </form>
        </div>
    </>
  );
}

export default iMessage;
```

### Explanation

Here's a breakdown of the key elements in the code:

1. `import React, { useState } from "react";`: This line imports the necessary modules from React, including the `useState` hook, which allows the component to manage its state.
2. `const [userInput, setUserInput] = useState("");`: This line declares a state variable `userInput` and a function `setUserInput` to update its value using the `useState` hook. The initial value of `userInput` is set to an empty string.
3. `const [messages, setMessages] = useState([]);`: This line declares a state variable `messages` and a function `setMessages` to update its value using the `useState` hook. The initial value of `messages` is set to an empty array.
4. `const [kanyeTyping, setKanyeTyping] = useState(false);`: This line declares a state variable `kanyeTyping` and a function `setKanyeTyping` to update its value using the `useState` hook. The initial value of `kanyeTyping` is set to `false`.
5. `const handleChange = (event) => { ... }`: This is an event handler function that is called when the value of the input field changes. It uses `setUserInput` to update the value of `userInput` state variable with the new value of the input field.
6. `const handleSubmit = async (event) => { ... }`: This is an event handler function that is called when the form is submitted. It prevents the default form submission behavior, sends a request to the backend API using `axios.post` to interact with the chatbot, and updates the `messages` state variable with the response from the backend API.
7. The `return` statement renders the UI of the chat window using JSX (JavaScript XML) syntax, which is a syntax extension for writing XML-like code in JavaScript. It includes HTML elements, CSS classes, and dynamic values from the state variables `userInput`, `messages`, and `kanyeTyping` to display the chatbot conversation interface.
8. The component is exported as the default export at the end of the code, which allows it to be imported and used in other parts of the application.

## Add stylesheet to your NextJS app

Now, let’s add stylesheet to our NextJS app, replace this code with your `globals.css` code under `kanye-ai/src/style/globals.css`

```jsx
/* chatbot */
.chat-bot-header{
  font-size: 16px;
  text-align: center;
  font-weight: 500;
  font-family: 'Source Sans Pro', sans-serif;
  color: #6e6f70;
  margin-top: 2px !important;
  margin-bottom: 2px Im !important;
}

.chat-container {
  width: 100%;
  max-width: 600px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 80vh;
  margin-top: 50px;
  border: 2px solid black;
  border-radius: 20px;
}

.chat-window {
  background-color: #f5f5f5;
  border-radius: 10px;
  padding: 10px;
  height: 70vh;
  overflow-y: scroll;
}

.message-container {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  margin-bottom: 10px;
}

.user-message {
  background-color: #007aff;
  color: #fff;
  border-radius: 10px;
  padding: 10px;
  margin-left: auto;
  display: flex;
  flex-direction: row;
  justify-content: flex-end;
  align-items: center;
  max-width: 70%;
}

.bot-message {
  background-color: #fff;
  color: #000;
  border-radius: 10px;
  padding: 10px;
  margin-right: auto;
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
  max-width: 70%;
}

.message-text {
  font-family: 'Helvetica', 'Arial', sans-serif;
}

.profile-image {
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.user-image {
  margin-left: 10px;
}

.form {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  margin: 10px;
}

.form input[type="text"] {
  flex: 1;
  padding: 10px;
  border-radius: 25px;
  font-size: 16px;
  background-color: #fff;
}

.form button[type="submit"] {
  background-color: #007aff;
  color: #fff;
  border: none;
  outline: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  margin-left: 10px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.typing-bubble{
  width: 50px;
}

.header {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  /* background-color: #fff; */
}

.contact-info {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.name {
  font-family: 'Helvetica', 'Arial', sans-serif;
  font-size: 16px;
  font-weight: 500;
  margin-top: 2px;
  margin-bottom: 2px;
}

.back-button {
  font-size: 24px;
  color: #007aff;
}

.video-icon {
  font-size: 24px;
  color: #007aff;
}

.ref-link{
  color: #C53AAE;
  text-decoration: none;
  font-weight: 500;
}

.bot-image{
  margin-right: 10px;
}
```

### Stylesheet explanation

The given CSS code represents the styling for a chatbot user interface. Let's break it down:

1. `.chat-bot-header`: This represents the header of the chatbot, which includes properties such as font size, text alignment, font weight, font family, and color.
2. `.chat-container`: This represents the container that holds the entire chatbot interface. It has properties for width, maximum width, margin, display, flex direction, height, margin top, border, and border radius.
3. `.chat-window`: This represents the chat window where the messages between the user and the bot are displayed. It includes properties such as background color, border radius, padding, height, and overflow-y for scroll functionality.
4. `.message-container`: This represents the container for individual messages within the chat window. It has properties for display, flex direction, justify content, and margin bottom.
5. `.user-message` and `.bot-message`: These represent the style for user and bot messages respectively. They include properties such as background color, color, border radius, padding, margin left/right, display, flex direction, justify content, align items, and max width.
6. `.profile-image` and `.user-image`: These represent the style for profile images of the bot and user respectively. They include properties such as width, height, border radius, and margin right/left.
7. `.form`: This represents the form element for user input. It includes properties for display, flex direction, justify content, align items, and margin.
8. `.form input[type="text"]`: This represents the input field for user text input. It includes properties for flex, padding, border radius, font size, and background color.
9. `.form button[type="submit"]`: This represents the submit button within the form. It includes properties for background color, color, border, outline, border radius, width, height, margin left, display, justify content, and align items.
10. `.typing-bubble`: This represents a typing indicator bubble, which could be used to indicate that the bot is typing a response. It includes properties for width.
11. `.header`: This represents the header section of the chatbot, which includes properties for display, flex direction, justify content, align items, and padding.
12. `.contact-info`: This represents the contact information section within the header. It includes properties for display, flex direction, and align items.
13. `.name`: This represents the name or title within the contact information section. It includes properties for font family, font size, font weight, and margin top.
14. `.back-button` and `.video-icon`: These represent styles for back button and video icon within the header respectively. They include properties for font size and color.
15. `.ref-link`: This represents a reference link style, which includes properties for color, text decoration, and font weight.
