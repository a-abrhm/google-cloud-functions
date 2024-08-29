# Use the official Python image as a base
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create and set the working directory
WORKDIR /usr/src/app

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY main.py .

# Expose the port on which the server will run
EXPOSE 8080

# Run the Functions Framework server
CMD ["functions-framework", "--target=cloud_function_2", "--port=8080"]
