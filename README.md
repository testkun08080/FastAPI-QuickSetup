# クイック FastAPI

日本語 | [English](README_EN.md)

このリポジトリは、FastAPI プロジェクトを素早くセットアップするためのシェルスクリプトを提供しています。
とにかくちゃちゃっと試したい人は是非。

スクリプト:
- `quickFastAPI.sh` — 基本的な FastAPI プロジェクトをチャチャっとセットアップします。
- `setup_docker.sh` — Docker 用のイメージ作成から、起動までを行います。

---

## 前提条件

システムに以下がインストールされていることを確認してください:

- Python 3.12 以上
- uv pip (インストールは[こちら](https://docs.astral.sh/uv/getting-started/installation/))
  
Docker上で起動するには:
- Dcoker (インストールは[こちら](https://github.com/docker/docker-install))
  
---

## 使い方

### 1. このリポジトリをクローンするか、シェルスクリプトをダウンロードする

```bash
git clone https://github.com/testkun08080/FastAPI-QuickSetup.git
cd FastAPI-QuickSetup
```

または以下スクリプトを直接ダウンロードしてください:

> [!NOTE]
> ファイルをダウンロードするには、リンクを右クリックして「名前を付けてリンク先を保存」などのオプションを選択してください。

[quickFastAPI.sh をダウンロード](https://raw.githubusercontent.com/testkun08080/FastAPI-QuickSetup/main/quickFastAPI.sh)  
[setupDocker.sh をダウンロード](https://raw.githubusercontent.com/testkun08080/FastAPI-QuickSetup/main/setupDocker.sh)  

### 2. シェルスクリプトを実行
1. スクリプトを実行して、ローカル環境に FastAPI プロジェクトをセットアップします:
    ```bash
    ./quickFastAPI.sh
    ```
2. ターミナルでプロジェクト名を入力するように求められます:
    ```bash
    Setting up a FastAPI project...
    Enter the project name: <PROJECT_NAME>
    ```
3. FastAPI サーバーをすぐに起動するかどうか尋ねられます:
    ```bash
    Would you like to start the FastAPI server now? (y/n): 
    ```
4. 後で手動でサーバーを起動するには、以下のコマンドを使用します:
    ```bash
    cd <PROJECT_NAME>
    ./run.sh
    ```
5. アプリケーションがローカルで起動したら、以下の URL をブラウザで開いてアクセスします:
   http://localhost:8000

### 3. Docker でアプリケーションをビルド・実行
1. Docker セットアップスクリプトに実行権限を付与し、実行:
    ```bash
    chmod +x setupDocker.sh
    ./setupDocker.sh
    ```
2. プロンプトが表示されたら、Docker ビルドに使用するディレクトリを番号で選択:
    ```bash
    Select a directory from the list below:
    1) <PROJECT_NAME>/
    ```
3. セットアップが正常に完了すると、次のようなメッセージが表示されます:
    ```bash
    Docker setup complete!
    Your FastAPI application is now running at: http://localhost:8000
    ```
---
## ライセンス

このプロジェクトは MIT ライセンスの下で提供されています。  
詳細は [LICENSE](./LICENSE) ファイルをご覧ください。
