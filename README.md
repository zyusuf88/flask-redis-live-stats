
<h1 align="center">
  <br>
  <img alt="Static Badge" src="https://img.shields.io/badge/%20Redis-Multi--Container%20Application-red">



<h4 align="center"> Multi Container Application using Flask and Redis.</h4>


### Flask-Redis Visitor Counter

This project demonstrates a simple multi-container application using Flask and Redis. The Flask application increments and retrieves a visitor count from Redis, and everything is managed using Docker Compose.




- [What is Flask?](#what-is-flask)
- [What is Redis?](#what-is-redis)
  - [Project Overview](#project-overview)
  - [Multi-Container Application](#multi-container-application)
  - [Benefits of Using Multi-Container Setups](#benefits-of-using-multi-container-setups)
  - [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Endpoints](#endpoints)
- [Notes](#notes)
- [Files](#files)
- [Application Structure](#application-structure)
  - [`app.py`](#apppy)
  - [docker-compose.yml](#docker-composeyml)
  - [Dockerfile](#dockerfile)
- [Commands](#commands)
- [Conclusion](#conclusion)


Welcome to the Flask-Redis Visitor Counter project! This project showcases a simple multi-container application using Flask and Redis, all managed by Docker Compose.

## What is Flask?

[Flask](https://flask.palletsprojects.com/) is a lightweight web framework for Python. It’s designed with simplicity and flexibility in mind, making it an excellent choice for small to medium-sized web applications. Flask provides the essentials to get a web server up and running without the overhead of more extensive frameworks, allowing developers to add extensions and components as needed.

## What is Redis?

[Redis](https://redis.io/) is an open-source, in-memory data structure store, which can be used as a database, cache, and message broker. It’s known for its **high performance and support** for various data structures like strings, hashes, lists, sets, and more. Redis stores data in memory, which makes data retrieval extremely fast, making it perfect for applications that require quick access to data.

![image](https://github.com/user-attachments/assets/e253b8cc-7a30-49e5-9d29-544f5517781f)

### Project Overview

In this project, we have three main components:

1. **Flask Web Application**: A simple web server built with Flask that serves two endpoints:
   - `/`: Displays a welcome message.
   - `/count`: Increments and displays the visitor count stored in Redis.

2. **Redis Database**: A fast, in-memory key-value store used to keep track of the visitor count.
3. **Docker Compose**: Manages the multi-container application, ensuring that the Flask application and Redis database run in separate, isolated containers. Docker Compose simplifies the process of setting up, running, and scaling the application.


### Multi-Container Application

A multi-container application uses multiple Docker containers to separate different components of the application. In this project, we use two containers:

> [!NOTE]  
> **Flask Application Container**: Runs the Flask web application. <br>
> **Redis Container**: Runs the Redis database.


### Benefits of Using Multi-Container Setups

- **Separation of Concerns**: Each component runs in its own container, making it easier to manage and maintain the application. The web application and the database are decoupled, allowing them to be developed, tested, and scaled independently.
- **Scalability**: Containers can be scaled individually based on demand. For instance, you can scale the Redis container independently of the Flask container if you need more database capacity.
- **Isolation**: Each container runs in its own isolated environment, ensuring that dependencies and configurations do not conflict with each other.
- **Portability**: Docker containers encapsulate all necessary dependencies, making it easy to move the application across different environments (development, staging, production) without worrying about inconsistencies.

### Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop) installed on your machine.
- [Docker Compose](https://docs.docker.com/compose/install/) installed on your machine.


## Usage

1. Start the application:
    ```bash
    docker-compose up
    ```

2. Open your browser and go to `http://localhost:5000` to see the welcome message.
   
 ![Screenshot 2024-07-18 145557](https://github.com/user-attachments/assets/ddd92895-1b8a-4f01-bdda-425a2beea1c7)

3. Navigate to `http://localhost:5000/count` to see the visit count increment each time you refresh the page.
   
https://github.com/user-attachments/assets/b77f1411-f9a2-4fda-9017-29fee787fbd8

## Endpoints

- `/`: Displays a welcome message.
- `/count`: Increments and displays the visitor count stored in Redis.


> [!TIP]
>  **Stopping the application:** To stop the application, press `Ctrl+C` in the terminal where `docker-compose up` is running, then run: `docker-compose down`


## Notes

- The flask-app service depends on the redis service. Docker Compose ensures that the redis service is started before the flask-app service.
- The Redis client in the Flask application is configured to connect to the Redis service by the service name redis as specified in the docker-compose.yml.


- **Ensure Docker is running:** Make sure Docker is running on your machine before executing `docker-compose up`.
- **Port conflicts:** Ensure that ports `5000` and `6379` are not being used by other applications on your machine to avoid conflicts.
  
## Files
- **app.py:** The main Flask application.
- **docker-compose.yml:** Docker Compose configuration file to link multiple containers.
- **Dockerfile:** Instructions to build the Docker image for the Flask application.
- **requirements.txt:** Python dependencies required for the Flask application.


## Application Structure

### `app.py`

```python
from flask import Flask
import redis
```
- `from flask import Flask`: Imports the Flask class from the Flask module to create a Flask application instance.
- `import redis`: Imports the Redis client library to interact with the Redis database.
  
```python 
app = Flask(__name__)
client = redis.Redis(host='redis', port=6379)
```
- app = Flask(__name__): Creates an instance of the Flask class. The __name__ argument is used to determine the root path for the application.
- `client = redis.Redis(host='redis', port=6379)`: Creates a Redis client instance that connects to the Redis server. The host is set to 'redis' (which will be the name of the Redis service in Docker Compose), and the port is set to 6379 (the default Redis port).

```python
@app.route('/')
def welcome():
    return "Welcome to my App!"
```
- `@app.route('/')`: Defines a route for the root URL (/). When this URL is accessed, the following function will be executed.
- `def welcome()`: Defines a function that will be called when the root URL is accessed.
- `return "Welcome to my App!"`: The function returns a welcome message to be displayed on the web page.
  
``` python
@app.route('/count')
def count():
    count = client.incr('visitor_count')
    return f'Visitor count: {count}'
``` 
- `@app.route('/count')`: Defines a route for the /count URL. When this URL is accessed, the following function will be executed.
- `def count()`: Defines a function that will be called when the /count URL is accessed.
- `count = client.incr('visitor_count')`: Increments the value of the visitor_count key in Redis by 1 and stores the
new value in the count variable. If the key does not exist, it is created and set to 1.
- `return f'Visitor count: {count}'`: The function returns a message displaying the current visitor count.
- 
``` 
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

```
- `if __name__ == '__main__':`: Checks if the script is being run directly . If it is, the following block of code is executed.
- ` app.run(host='0.0.0.0', port=5000)`: Starts the Flask application and makes it accessible on all network interfaces (0.0.0.0) on port 5000.


### docker-compose.yml

- The docker-compose file sets up the services for the application. It links multiple containers together so they can communicate with each other:

```
services:
  web:
    build: .
    ports:
      - "5000:5000"
    depends_on:
      - redis
  redis:
    image: "redis:alpine"
    expose:
      - "6379"
```

### Dockerfile
- The Dockerfile contains instructions to build the Docker image for the Flask application
```
# this is your base image
FROM python:3.10

# we set the working dir in yourr container
# WORKDIR /usr/src/App
WORKDIR /app


# copying reqs file to your container so you can install the app reqs 
COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

# copy your app code 
COPY . .

# expose/open up the port on your container so you can access your app 
EXPOSE 5000

# running app in container
CMD ["python", "app.py"]
``` 
  
- **FROM `python:3.9-slim:** This line specifies the base image for our Docker image. We're using the official Python 3.10 slim image from Docker Hub.

- **WORKDIR /app:** This sets the working directory inside the container to `/app`. All subsequent commands will be run from this directory. This helps keep our container organized and makes it easier to understand where files are located.

- **COPY requirements.txt requirements.txt:** This line copies the requirements.txt file from our local machine into the container. The requirements.txt file contains a list of Python dependencies needed for our Flask application.

- **RUN pip install -r requirements.txt:** This command installs the Python dependencies listed in the requirements.txt file. By using RUN, these dependencies are installed during the build process of the Docker image, ensuring that they are available when the container starts.

- **COPY . .:** This line copies the rest of the application code from our local machine into the container. The `.` refers to the current directory on the host machine, and the second `.` refers to the working directory inside the container.

- **EXPOSE 5000:** This instruction informs Docker that the container will listen on port 5000 at runtime. While this does not actually publish the port (which is done with docker run -p or in the docker-compose.yml file), it serves as documentation for users of the image.

- **CMD ["python", "app.py"]:** This command specifies the default command to run when the container starts. In this case, it runs the Flask application by executing python app.py. 
  
> [!NOTE]  
> **There can only be one CMD instruction in a Dockerfile. If multiple CMD instructions are specified, only the last one will take effect.**

## Commands

`docker-compose up --build` 

- This command will:
    - Build the Docker image for the Flask application.
    - Start the Flask application container.
    - Start the Redis container.
  
 `docker-compose down`
 
- This command will:
    -  Stop the application

## Conclusion
This project demonstrates how to set up a simple multi-container application using Flask and Redis, managed with Docker Compose. By using Docker, we achieve a clean separation of concerns, scalability, and portability, making our application easier to manage and deploy across different environments.