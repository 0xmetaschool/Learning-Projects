# Create a Local Python Server

This server will be responsible for fetching data from the MindsDB and create an API using Python Flask. This server will handle the POST request from the NextJS app and will return the response.

## What is Flask?

Let me introduce you to Flask, a super cool Python web framework that's perfect for creating AI-powered applications. Here's the deal:

- Flask is a lightweight, open-source web framework that's used for building web applications in Python.
- It's easy to use and has a ton of features that make it perfect for building AI-powered apps.
- Flask is great for integrating with third-party libraries, which is perfect for fetching data from MindsDB for your AI bot.
- It's super flexible and customizable, so you can build your app exactly the way you want it.

## Why use Flask for building an AI-powered YeGPT?

Here are a few reasons:

- It's easy to integrate with MindsDB, which is where you'll be fetching your data for your AI bot.
- Flask has a ton of libraries and extensions that make it easy to add features to your app, like authentication and security.
- It's super fun and exciting to work with, especially when you're building something as cool as a YeAI bot!

Not that we have covered the boring part, let’s dive into creating the server.

## Create [`server.py`](http://server.py) file in your NextJS app

Create a file called `server.py` under `kanye-ai` root directory and paste this code:

```
import json
from sqlalchemy import create_engine
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app, origins='http://localhost:3000', supports_credentials=True)  # Set CORS headers for all routes

@app.route('/bot', methods=['POST'])
def kanye_bot():
    try:
        # Set CORS headers for the response
        headers = {
            'Access-Control-Allow-Origin': 'http://localhost:3000',
            'Access-Control-Allow-Methods': 'POST',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Credentials': 'true'
        }

        # Get the request data
        request_json = request.get_json()
        message = request_json['message']

        # mindsdb is a MySQL db so these are the credentials
        user = '<replace with your mindsdb email>'  
        password = '<replace with your mindsdb password>' 
        host = 'cloud.mindsdb.com'
        port = 3306
        database = 'mindsdb'

        # initializing the db connection
        def get_connection(user, password, host, port, database):
            return create_engine(
                url="mysql+pymysql://{0}:{1}@{2}:{3}/{4}".format(user, password, host, port, database)
            )

        try:
            engine = get_connection(user, password, host, port, database)
            print(f"Connection to {host} for user {user} created successfully.")
        except Exception as ex:
            print("Connection could not be made due to the following error: \n", ex)

        # Run the query
        with engine.connect() as eng:
            query = eng.execute(f"SELECT response from mindsdb.kanye_chat WHERE text= '{message}';")
            results = []
            for row in query:
                row_dict = dict(row)
                results.append(row_dict)

            # Create a dictionary to store the results
            result_dict = {'results': results}

            # Convert the dictionary to a JSON format
            json_result = json.dumps(result_dict, ensure_ascii=False)

            # Return the response with CORS headers
            return (json_result, 200, headers)
    except Exception as ex:
        # Handle any errors that may occur during processing
        # Return an error response if needed
        return jsonify({'error': str(ex)}), 500

if __name__ == '__main__':
    app.run(host='localhost', port=8080)
```

### Code explanation

This is a Flask web application that serves as an API for a chatbot that interacts with MySQL database. Here is a high-level overview of what the code does:

1. Import necessary modules: 
    1. `json` for JSON manipulation,
    2.  `create_engine` from SQLAlchemy for database connection, 
    3. `Flask` for web application framework, 
    4. `request` and `jsonify` from Flask for handling HTTP requests and responses, and 
    5. `CORS` from `flask_cors` for handling Cross-Origin Resource Sharing (CORS) headers.
2. Create a Flask web application instance with the name `app`.
3. Set CORS headers for the application to allow cross-origin requests from `http://localhost:3000` with credentials support, which allows the chatbot API to be accessed from a web application running on `http://localhost:3000` without any CORS restrictions.
4. Define a route `/bot` that handles `POST` requests. This is the endpoint that the chatbot API will listen to for receiving user messages.
5. Inside the `kanye_bot` function, first, the CORS headers for the response are set in the `headers` dictionary. These headers specify the allowed origin, allowed methods, allowed headers, and support for credentials in the response.
6. Get the request data from the HTTP request payload as JSON using `request.get_json()` function. The user's message is extracted from the request payload.
7. Define the MySQL database credentials (user, password, host, port, and database) for connecting to a MindsDB database.
8. Define a function `get_connection` that takes the database credentials as arguments and returns a SQLAlchemy database engine object for connecting to the MindsDB database.
9. Try to create a database engine using the `get_connection` function and store it in the `engine` variable. If the connection is successful, a success message is printed to the console. If the connection fails, an error message is printed.
10. Run a SQL query to fetch the response from the `mindsdb.kanye_chat` table where the `text` column matches the user's message. The fetched rows are converted into dictionaries and appended to the `results` list.
11. Create a dictionary `result_dict` to store the `results` list with a key `'results'` for JSON formatting.
12. Convert the `result_dict` dictionary to a JSON format using `json.dumps()` function with `ensure_ascii=False` argument to preserve non-ASCII characters.
13. Return the JSON response with the CORS headers and a `200` HTTP status code indicating a successful response.
14. If any exceptions occur during processing, catch them and return an error response with a `500` HTTP status code and an error message in the response body.
15. Finally, if the script is run directly (not imported as a module), start the Flask application to run on `http://localhost` with port `8080` using `app.run()` function.

> **Note:** Do remember to replace `'<replace with your mindsdb email>'` and `'<replace with your mindsdb password>'` with your email and password.
> 

## Let’s install the dependencies now

Create a file called `requirement.txt` under the root folder of `kanye-ai` folder and paste this:

```
sqlalchemy==1.4.47
flask-cors
flask
pymysql==1.0.3
```

Now in your terminal run the following command:

```
 pip install -r requirement.txt
```

> **Note:** We assume that you have already installed Python 3.8 in your system.
> 

Let’s see this happening live:

![run pip command.gif](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20YeBot%20with%20OpenAI%20API/3.%20Let%E2%80%99s%20Build%20Some%20Dope%20Shit/Create%20a%20Local%20Python%20Server%20da134c5573004ef2b821c9f5ce89c5c0/run_pip_command.gif)

🎉 Congratulation, you have successfully created a local API server!

## Let’s run this server

To run this server just run this command in your terminal.

```
python3 server.py

```

> **Note:** Make sure your terminal is opened in the root directory `kanye-ai` for the commands to work.
>

Let’s see this happening live:

![running server.gif](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20YeBot%20with%20OpenAI%20API/3.%20Let%E2%80%99s%20Build%20Some%20Dope%20Shit/Create%20a%20Local%20Python%20Server%20da134c5573004ef2b821c9f5ce89c5c0/running_server.gif)

and voila your server is ready to respond to the NextJS frontend requests.

We will use this URL in our `index.js` file in `[axios.post](http://axios.post)` function. We can do this like this:

![Untitled](https://github.com/0xmetaschool/Learning-Projects/raw/main/Build%20a%20YeBot%20with%20OpenAI%20API/3.%20Let%E2%80%99s%20Build%20Some%20Dope%20Shit/Create%20a%20Local%20Python%20Server%20da134c5573004ef2b821c9f5ce89c5c0/Untitled.png)
