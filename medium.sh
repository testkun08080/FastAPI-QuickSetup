#!/bin/bash

set -e
echo "Setting up a medium-sized FastAPI project..."

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
pip install --upgrade pip

# Installing necessary libraries
pip install fastapi uvicorn pytest

# Making the app directory structure
mkdir -p app/routers app/utils app/tests
touch app/__init__.py app/routers/__init__.py app/utils/__init__.py app/tests/__init__.py

# Main application file
cat << EOF > app/main.py
from fastapi import FastAPI
from app.routers import sample_router

app = FastAPI()

app.include_router(sample_router.router)

@app.get("/")
def read_root():
    return {"message": "Hello, Medium FastAPI Project!"}
EOF

# Sample router file
cat << EOF > app/routers/sample_router.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/items")
def read_items():
    return {"items": ["item1", "item2"]}
EOF

# Sample utility file
cat << EOF > app/utils/sample_util.py
def example_function():
    return "This is a sample utility function"
EOF

# Sample test file
cat << EOF > app/tests/test_sample.py
def test_example():
    assert 1 + 1 == 2
EOF

# Additional files
touch .env .gitignore README.md
echo "venv" > .gitignore
echo "__pycache__" >> .gitignore
echo "*.pyc" >> .gitignore
pip freeze > requirements.txt

# Run script
cat << EOF > run.sh
source venv/bin/activate
uvicorn app.main:app --reload
EOF
chmod +x run.sh

# Final message with directory structure
echo ""
echo "Project Directory Structure"
echo "├── $PROJECT_NAME/           # Project root directory"
echo "│   ├── app/                 # Application folder"
echo "│   │   ├── main.py          # Entry point"
echo "│   │   ├── routers/         # API routers"
echo "│   │   │   ├── __init__.py"
echo "│   │   │   └── sample_router.py"
echo "│   │   ├── utils/           # Utility functions"
echo "│   │   │   ├── __init__.py"
echo "│   │   │   └── sample_util.py"
echo "│   │   └── __init__.py"
echo "│   ├── tests/               # Test cases"
echo "│   │   ├── __init__.py"
echo "│   │   └── test_sample.py"
echo "│   ├── .env                 # Environment variables"
echo "│   ├── .gitignore           # Git ignore file"
echo "│   ├── README.md            # Project description"
echo "│   ├── requirements.txt     # Python dependencies"
echo "│   └── run.sh               # Script to run FastAPI"
echo "│   └── venv/                # Virtual environment"

echo ""
echo "$PROJECT_NAME medium project setup complete!"

echo ""
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