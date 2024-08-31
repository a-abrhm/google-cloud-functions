# Use the official Node.js image from the Docker Hub
FROM node:20-alpine

# Create and change to the app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (or yarn.lock) to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Specify the command to run your function (adjust if needed for your environment)
CMD [ "npm", "start" ]
