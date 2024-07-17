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