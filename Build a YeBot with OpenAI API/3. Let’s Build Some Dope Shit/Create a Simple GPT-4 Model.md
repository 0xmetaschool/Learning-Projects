# Create a Simple GPT-4 Model

Yo, listen up, we're about to create a simple GPT-4 model on MindsDB. 

## Create simple GPT-4 model

It's easy, just head to MindsDB editor and enter this code in the editor:

```
CREATE MODEL mindsdb.gpt_bot
PREDICT response
USING
engine = 'openai',
max_tokens = 300,
-- api_key = '**your openai key**',
model_name = 'gpt-4',
prompt_template = 'respond to {{text}} by {{author_username}}'
```

Replace the API key with your key and try running the code and view the output.

### Explanation

Now let us explain the code line by line:

- `CREATE MODEL mindsdb.gpt_bot`: This line sets up a new MindsDB model called `gpt_bot`.
- `PREDICT response`: This line tells the model that we want it to predict a response based on a prompt.
- `USING engine = 'openai'`: This line specifies that we're using the OpenAI engine for the model.
- `api_key = 'your openai key'`: This line gives the model access to OpenAI APIs using your API key.
- `model_name = 'gpt-4'`: This line tells the model to use the GPT-4 architecture for predictions.
- `prompt_template = 'respond to {{text}} by {{author_username}}'`: This line specifies the format of the prompt we want to provide to the model. In this case, we want it to respond to a certain text by a particular author.

### Output

Let’s look at what is the output of the above code.

![Running Simple GPT-4 Model.gif](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20YeBot%20with%20OpenAI%20API/3.%20Let%E2%80%99s%20Build%20Some%20Dope%20Shit/Create%20a%20Simple%20GPT-4%20Model%20492b4760fb32466a8d50a15230f651c9/Running_Simple_GPT-4_Model.gif)

## Generate response

Now that we've created the model, let's generate some responses using it. Open a new MindsDB tab and run this code:

```
SELECT response from mindsdb.gpt_bot
WHERE author_username = "someuser"
AND text="Hi, how are you?";
```

Just replace "Hi, how are you?" with your own prompt and run the code.

## Output

Let’s look at what is the output of the above code.

![Running simple GPT-4 model generation code.gif](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20YeBot%20with%20OpenAI%20API/3.%20Let%E2%80%99s%20Build%20Some%20Dope%20Shit/Create%20a%20Simple%20GPT-4%20Model%20492b4760fb32466a8d50a15230f651c9/Running_simple_GPT-4_model_generation_code.gif)
