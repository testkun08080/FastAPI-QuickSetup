#!/bin/bash

set -e

echo "Setting up Docker for an existing FastAPI project..."

# List directories in the current folder
echo "Select a directory from the list below:"
select DIR in */; do
    if [ -n "$DIR" ]; then
        ROOT_FOLDER=${DIR%/} # Remove trailing slash
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

# Check if the folder exists (it should, as it's selected from the list)
if [ ! -d "$ROOT_FOLDER" ]; then
    echo "Error: The directory '$ROOT_FOLDER' does not exist."
    exit 1
fi

# Navigate to the selected project folder
cd "$ROOT_FOLDER" || exit

# Get lowercase project name
L_ROOTFOLDER=$(echo "$ROOT_FOLDER" | tr '[:upper:]' '[:lower:]')

# Generate .dockerignore
cat << EOF > .dockerignore
__pycache__
*.pyc
venv/
.git
*.gitignore
.dockerignore
Dockerfile
docker-compose.yml
*.log
*.sh
*.md
.env
EOF

# Generate Dockerfile
cat << EOF > Dockerfile
# Base image
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN uv pip install -r requirements.txt --system

# Copy application code
COPY . .

# Expose port
EXPOSE 8000

# Run FastAPI server
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
EOF


# Generate docker-compose.yml
cat << EOF > docker-compose.yml
version: "3.8"

services:
  $L_ROOTFOLDER:
    image: $L_ROOTFOLDER-app:1.0.0
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    environment:
      - DEV_MODE=true
    env_file:
      - .env
    container_name: $L_ROOTFOLDER
EOF


# Build Docker image
echo "Building Docker image..."
# docker-compose build
docker-compose build

# Start Docker containers
echo "Starting Docker containers..."
docker-compose up -d

echo "Docker setup complete!"
echo "Your FastAPI application is now running at: http://localhost:8000"