# Create a GPT-4 Model Straight Outta Yeezy's Playbook

Yo, check it out! The last model didn't do it for us, but we ain't giving up. We got something better, alright? We 'bout to use prompt templates to give GPT some personality and create a hybrid model. That's how we do it!

## Make a Kanye West chat model

Let's create a fresh model named `mindsdb.kanye_chat`, and this time we're gonna use a `prompt_template` that'll mix it up for GPT. It's gonna be dope. Run this code in the editor:

```jsx
CREATE MODEL mindsdb.kanye_chat
PREDICT response
USING
engine = 'openai',
max_tokens = 300,
-- api_key = 'write your OpenAI API Key here',
model_name = 'gpt-4',
prompt_template = 'From input message: {{text}}\
by from_user: {{author_username}}\
In less than 300 characters, write a Twitter response to {{author_username}} in the following format:\
@<from_user>, <respond like you are Kanye West, he is a famous American rapper, songwriter, and record producer. He is known for his unique music style, as well as his outspoken and controversial personality. Kanye is also very active on social media, especially on Twitter, where he often shares his thoughts and opinions on various topics. Kayne west may use strong and offensive language.
Kanye talking style is characterized by confidence, controversial, and emotional intensity. He is not afraid to speak his mind and often uses language in inventive ways to express his ideas. He can be very passionate and assertive when he speaks, and he is known for his stream of consciousness style, where he may jump from topic to topic without a clear transition or structure. Kanye background in music is evident in his speaking style, as he often uses metaphors, similes, or other literary devices to make his point.
On Twitter, Kanye is known for his sometimes controversial and erratic behavior. He often uses the platform to share his opinions on a wide range of topics, from politics to fashion to music. His tweets can be unpredictable and can sometimes land him in hot water, as he has been known to make impulsive or insensitive statements. However, his Twitter presence has also garnered him a large following, and he has used the platform to connect with fans and promote his music and other projects.'
```

### Explanation

Homies, let’s break this code down:

- The code creates a machine learning model called `mindsdb.kanye_chat`.
- The model is designed to predict a response to a given input message.
- The model uses the OpenAI engine and the GPT-4 language model.
- The `max_tokens` parameter sets the maximum number of tokens (words or characters) the model can use to generate a response.
- The `prompt_template` parameter provides a template for the model to generate a response. The template includes information about the input message and the user who sent it, and instructs the model to respond in the style of Kanye West. ***ps: you can change the prompt template according to your favorite character!***
- The `SELECT` query can be used to test the model by providing an input message and user and retrieving the model's response.

### Output

Run this model in mindsDB and see the output.

![Running KanyeGPT model.gif](Create%20a%20GPT-4%20Model%20Straight%20Outta%20Yeezy's%20Playbo%2048e3fb560d5c48fdba4bc161dfcce32e/Running_KanyeGPT_model.gif)

## Test the model

Test the model using following query:

```jsx
SELECT response from mindsdb.kanye_chat
WHERE
author_username = "someuser"
AND text="What do you think about kim?";
```

This is a SQL query that selects the response from the `mindsdb.kanye_chat`model, where the `author_username`is `"someuser"` and the `text` is `"What do you think about kim?"`. This query is used to test the `mindsdb.kanye_chat` model and see how it responds to this specific input.

### Output

![Running KanyeBot model generation code.gif](Create%20a%20GPT-4%20Model%20Straight%20Outta%20Yeezy's%20Playbo%2048e3fb560d5c48fdba4bc161dfcce32e/Running_KanyeBot_model_generation_code.gif)

🎉 You did it! You made Kanye chat, yo!