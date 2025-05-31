# FastAPI Project Setup Scripts
This repository provides shell scripts to quickly set up FastAPI projects.

Available script:
- `quickFastAPI.sh` — Quickly sets up a basic FastAPI project.

<!-- - `small.sh` — A minimal FastAPI project
- `medium.sh` — A medium-sized FastAPI project with routers, utils, and tests
- `large.sh` — A large-scale FastAPI project with modular architecture -->

---

## Prerequisites

Make sure you have the following installed on your system:

- Python 3.12+
- Bash shell
- uv pip (Customized Python package installer, compatible with standard pip commands)

---

## Usage

### 1. Clone this repository or download the shell scripts

```bash
git clone https://github.com/testkun08080/FastAPI-QuickSetup.git
cd FastAPI-QuickSetup
```

Or download the script directly:

> [!NOTE]
> To download the files, right-click the link and select “Save Link As” or a similar option in your browser.

[Download quickFastAPI.sh](https://raw.githubusercontent.com/testkun08080/FastAPI-QuickSetup/main/quickFastAPI.sh)  

<!-- [Download small.sh](https://raw.githubusercontent.com/testkun08080/FastAPI-QuickSetup/main/small.sh)  
[Download medium.sh](https://raw.githubusercontent.com/testkun08080/FastAPI-QuickSetup/main/medium.sh)  
[Download large.sh](https://raw.githubusercontent.com/testkun08080/FastAPI-QuickSetup/main/large.sh)   -->

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

### 3. Build and run the application with Docker
1. Make the Docker setup script executable and run it:
    ```bash
    chmod +x setup_docker.sh
    ./setup_docker.sh
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

## License

This project is licensed under the MIT License.  
See the [LICENSE](./LICENSE) file for more details.
