# Dockerfile
FROM python:3.10-slim

WORKDIR /app

# Copy your python script into the container
COPY count_bases.py /app/count_bases.py

# Copy your test data folder directly into the container
COPY data/ /app/data/

# Set the entrypoint to execute the script
ENTRYPOINT ["python", "/app/count_bases.py"]

