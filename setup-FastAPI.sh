#!/bin/bash

# Get the project name from the argument, default to "fastapi_project"
PROJECT_NAME=${1:-fastapi_project}

# Create the base directory
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME || exit

# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Add gitignore file
cat <<EOF > .gitignore
*__pycache__
venv
EOF

# Install required packages
pip install --upgrade pip
pip install fastapi uvicorn[standard] pydantic

# Create the app directory structure
mkdir -p app/{api,core,models,schemas,services,utils,tests,static,templates}
touch app/__init__.py
touch app/api/{__init__.py,v1.py}
touch app/core/{__init__.py,config.py,security.py}
touch app/models/{__init__.py,base.py}
touch app/schemas/__init__.py
touch app/services/__init__.py
touch app/utils/__init__.py
touch app/static/.gitkeep
touch app/templates/.gitkeep
touch tests/{__init__.py,test_main.py, conftest.py}


# Main application file
cat <<EOF > app/main.py
from fastapi import FastAPI
from app.api.v1 import router as api_router

app = FastAPI()

app.include_router(api_router, prefix="/api/v1")
EOF

# Router file
cat <<EOF > app/api/v1.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/")
async def read_root():
    return {"message": "Welcome to the FastAPI app!"}
EOF

# Configuration file
cat <<EOF > app/core/config.py
from pydantic import BaseSettings

class Settings(BaseSettings):
    app_name: str = "FastAPI App"
    debug: bool = True

    class Config:
        env_file = ".env"

settings = Settings()
EOF

# README file
cat <<EOF > README.md
# $PROJECT_NAME

## Description
A FastAPI project with a scalable directory structure.

## Directory Structure
\`\`\`
$PROJECT_NAME/
├── app/
│   ├── api/          # API router
│   ├── core/         # Configuration and security
│   ├── models/       # ORM models
│   ├── schemas/      # Pydantic schemas
│   ├── services/     # Business logic
│   ├── utils/        # Utility functions
│   ├── tests/        # Test scripts
│   ├── static/       # Static files
│   ├── templates/    # HTML templates
│   └── main.py       # Application entry point
├── venv/             # Virtual environment
├── .env              # Environment variables file
├── .gitignoe         # Git ignore file
├── README.md         # Project description
└── requirements.txt  # Required Python libraries
\`\`\`

## Installation
\`\`\`bash
source venv/bin/activate
pip install -r requirements.txt
\`\`\`

## Usage
\`\`\`bash
uvicorn app.main:app --reload
\`\`\`
EOF

# Create the environment variables file
touch .env

# Generate the list of required packages
pip freeze > requirements.txt

echo "Project structure for '$PROJECT_NAME' created successfully!"