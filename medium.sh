#!/bin/bash

set -e

echo "Setting up a medium FastAPI project..."

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
mkdir -p app/routers
touch app/routers/__init__.py

cat << EOF > app/main.py
from fastapi import FastAPI
from app.routers import items

app = FastAPI()

app.include_router(items.router)
EOF

cat << EOF > app/routers/items.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/items")
def get_items():
    return [{"item_id": "1", "name": "Sample Item"}]
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