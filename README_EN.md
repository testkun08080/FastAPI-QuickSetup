# FastAPI Project Setup Scripts

[日本語](README.md) | English

This repository provides shell scripts to quickly set up FastAPI projects.

Available script:
- `quickFastAPI.sh` — Quickly sets up a basic FastAPI project.
- `setupDocker.sh` — Builds a Docker image and starts the container for your FastAPI project.
---

## Prerequisites

Make sure you have the following installed on your system:

- Python 3.12
- uv pip ([Install page](https://docs.astral.sh/uv/getting-started/installation/))

If you want to run the app on Docker:
- Dcoker ([Install page](https://github.com/docker/docker-install))

---

## Usage

### 1. Clone this repository or download the shell scripts

```bash
git clone https://github.com/testkun08080/FastAPI-QuickSetup.git
cd FastAPI-QuickSetup
```

Or download the scripts directly:

> [!NOTE]
> To download the files, right-click the link and select “Save Link As” or a similar option in your browser.

[Download quickFastAPI.sh](https://raw.githubusercontent.com/testkun08080/FastAPI-QuickSetup/main/quickFastAPI.sh) 
[Download setupDocker.sh](https://raw.githubusercontent.com/testkun08080/FastAPI-QuickSetup/main/setupDocker.sh)  

### 2. Run the shell script
1. Execute the script to set up a FastAPI project in your local environment:
    ```bash
    ./quickFastAPI.sh
    ```
2. When prompted, enter a project name in the terminal:
    ```bash
    Setting up a FastAPI project...
    Enter the project name: <PROJECT_NAME>
    ```
3. The script will ask if you want to start the FastAPI server immediately:
    ```bash
    Would you like to start the FastAPI server now? (y/n): 
    ```
4. To start the server manually later, use the following commands:
     ```bash
    cd <PROJECT_NAME>
    ./run.sh
    ```
5. Once the application is running locally, open the following URL in your browser to access it:
   http://localhost:8000


### 3. Build and run the application with Docker
1. Make the Docker setup script executable and run it:
    ```bash
    chmod +x setupDocker.sh
    ./setupDocker.sh
    ```
2. When prompted, select the directory you want to use for the Docker build by entering the corresponding number:
    ```bash
    Select a directory from the list below:
    1) <PROJECT_NAME>/
    ```
3. If the setup completes successfully, you will see a message like this:
    ```bash
    Docker setup complete!
    Your FastAPI application is now running at: http://localhost:8000
    ```
    http://localhost:8000
---
## License

This project is licensed under the MIT License.  
See the [LICENSE](./LICENSE) file for more details.
