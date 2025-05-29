#!/bin/bash

set -e

echo "Setting up a large FastAPI project..."

# プロジェクト名入力
echo "Enter the project name:"
read -r PROJECT_NAME

# プロジェクトディレクトリ作成と移動
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

# 仮想環境のセットアップ
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip

# FastAPIとUvicornのインストール
pip install fastapi uvicorn

# ディレクトリとファイルの作成
mkdir -p app/routers app/models app/schemas app/services app/tests
touch app/routers/__init__.py app/models/__init__.py app/schemas/__init__.py app/services/__init__.py app/tests/__init__.py

cat << EOF > app/main.py
from fastapi import FastAPI
from app.routers import users

app = FastAPI()

app.include_router(users.router)
EOF

cat << EOF > app/routers/users.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/users")
def get_users():
    return [{"user_id": "1", "username": "example"}]
EOF

cat << EOF > app/schemas/user.py
from pydantic import BaseModel

class User(BaseModel):
    id: int
    username: str
EOF

cat << EOF > app/tests/test_main.py
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello, FastAPI!"}
EOF

# requirements.txtの作成
pip freeze > requirements.txt

# 実行スクリプト作成
cat <<EOF > run.sh
source venv/bin/activate
uvicorn app.main:app --reload
EOF
chmod +x run.sh

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