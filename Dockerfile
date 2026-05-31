FROM python:3.11-slim
WORKDIR /app
COPY /src/api/ .
# Update OS packages and install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip setuptools wheel

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt
RUN mkdir -p models/trained
COPY models/trained/*.pkl models/trained/

EXPOSE 8020

CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8020" ]