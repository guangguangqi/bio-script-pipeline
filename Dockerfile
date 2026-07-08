# Dockerfile
FROM python:3.10-slim

WORKDIR /app

# 1. Copy your python script into the container
COPY count_bases.py /app/count_bases.py

# 2. FIX: Copy your test data folder directly into the container as well
COPY data/ /app/data/

# Set the entrypoint to execute the script
ENTRYPOINT ["python", "/app/count_bases.py"]

