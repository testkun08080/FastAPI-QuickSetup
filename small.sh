#!/bin/bash

set -e
echo "Setting up a small FastAPI project..."

# Input for project name
echo "Enter the project name:"
read -r PROJECT_NAME

# Making the project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

# Setup environment
echo "Setting up and activating virtual environment..."
python3 -m venv venv
source venv/bin/activate
uv pip install --upgrade pip

# Installing
uv pip install fastapi uvicorn

# Making the app directory and main.py file
mkdir -p app
touch app/__init__.py

cat << EOF > app/main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI!"}
EOF

# Making the .env file
touch .env
cat << EOF > .env
#Here you can add environment variables
# For example:
# PROJECT_NAME=$PROJECT_NAME
EOF


# Making the .gitignore file
touch .gitignore
cat << EOF > .gitignore
venv
__pycache__
*.pyc
EOF

# Making the README.md file
touch README.md
cat << EOF > README.md
# $PROJECT_NAME
EOF

# Making the requirements.txt file
uv pip freeze > requirements.txt

# Making the run.sh file
cat <<EOF > run.sh
source venv/bin/activate
uvicorn app.main:app --reload
EOF
chmod +x run.sh

# Final message
echo "Project Directory Structure"
echo "├── $PROJECT_NAME/     # Project root directory"
echo "│   └── app/           # Application folder"
echo "│     └──main.py       # Entry point"
echo "│   ├── .gitignore     # Git ignore file"
echo "│   ├── README.md      # Project description"
echo "│   ├── requirements.txt # Python dependencies"
echo "│   ├── .env           # Environment variables"   
echo "│   ├── run.sh         # Script to run FastAPI"
echo "│   └──venv/           # Virtual environment"

echo "$PROJECT_NAME setup complete!"

echo "To start the server, run one of the following commands:"
echo "  1. cd $PROJECT_NAME"
echo "  2. ./run.sh"

# Prompt the user to start the FastAPI server
read -p "Would you like to start the FastAPI server now? (y/n): " YorN

if [[ "$YorN" =~ ^[Yy]$ ]]; then
    echo "Starting the FastAPI server..."
    uvicorn app.main:app --reload
else
    echo "Setup is complete. You can start the server later with the commands mentioned above."
fi