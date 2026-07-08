# Use a lightweight official Python image
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy your python script into the container
#COPY count_bases.py .

COPY count_bases.py /app/count_bases.py

# CHANGE: Force the container to always execute our script from /app
ENTRYPOINT ["python", "/app/count_bases.py"]


# Run the script when the container starts
#ENTRYPOINT ["python"]

