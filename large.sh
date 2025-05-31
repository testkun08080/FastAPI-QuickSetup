#!/bin/bash

set -e
echo "Setting up a large FastAPI project..."

# Enter project name
echo "Enter the project name:"
read -r PROJECT_NAME

mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

# Set up virtual environment
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate
uv pip install --upgrade pip

# Install main packages
uv pip install fastapi uvicorn sqlalchemy alembic pytest

# Create directories
mkdir -p app/routers app/services app/models app/utils tests scripts docs
touch app/__init__.py tests/__init__.py

# Create files
cat << EOF > app/main.py
from fastapi import FastAPI
from app.routers import user_router

app = FastAPI()

app.include_router(user_router.router)

@app.get("/")
def read_root():
    return {"message": "Hello, Large FastAPI Project!"}
EOF

cat << EOF > app/routers/__init__.py
# routers package initializer
EOF

cat << EOF > app/routers/user_router.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/users")
def get_users():
    return {"users": ["user1", "user2"]}
EOF

cat << EOF > app/services/user_service.py
def get_user_list():
    return ["user1", "user2"]
EOF

cat << EOF > app/models/user_model.py
from pydantic import BaseModel

class User(BaseModel):
    id: int
    name: str
EOF

cat << EOF > app/utils/helpers.py
def helper_func():
    return "This is a helper function"
EOF

cat << EOF > app/config.py
import os
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./test.db")
EOF

cat << EOF > tests/test_user.py
def test_get_users():
    assert 2 == len(["user1", "user2"])
EOF

cat << EOF > scripts/deploy.sh
#!/bin/bash
echo "Deploy script placeholder"
EOF
chmod +x scripts/deploy.sh

touch .env
cat << EOF > .gitignore
venv
__pycache__
*.pyc
.env
EOF

cat << EOF > README.md
# $PROJECT_NAME

Large scale FastAPI project.
EOF

uv pip freeze > requirements.txt

cat << EOF > run.sh
source venv/bin/activate
uvicorn app.main:app --reload
EOF
chmod +x run.sh

# Final message
echo "Project Directory Structure"
echo "├── $PROJECT_NAME/           # Project root directory"
echo "│   ├── app/                 # Application folder"
echo "│   │   ├── main.py          # Entry point"
echo "│   │   ├── routers/         # API routers"
echo "│   │   │   ├── __init__.py"
echo "│   │   │   └── user_router.py"
echo "│   │   ├── services/        # Business logic"
echo "│   │   │   └── user_service.py"
echo "│   │   ├── models/          # Data models"
echo "│   │   │   └── user_model.py"
echo "│   │   ├── utils/           # Utility functions"
echo "│   │   │   └── helpers.py"
echo "│   │   └── config.py        # Configuration file"
echo "│   ├── tests/               # Test cases"
echo "│   │   ├── __init__.py"
echo "│   │   └── test_user.py"
echo "│   ├── scripts/             # Deployment scripts"
echo "│   │   └── deploy.sh"
echo "│   ├── docs/                # Documentation"
echo "│   │   └── architecture.md"
echo "│   ├── .env                 # Environment variables"
echo "│   ├── .gitignore           # Git ignore file"
echo "│   ├── README.md            # Project description"
echo "│   ├── requirements.txt     # Python dependencies"
echo "│   ├── run.sh               # Script to run FastAPI"
echo "│   └── venv/                # Virtual environment"

echo ""
echo "$PROJECT_NAME setup complete!"

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